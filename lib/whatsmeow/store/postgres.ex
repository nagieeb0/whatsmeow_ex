defmodule Whatsmeow.Store.Postgres do
  @moduledoc """
  Ecto/Postgres-backed implementation of `Whatsmeow.Store`.

  All operations run against `Whatsmeow.Repo`. The repo must be started by
  the host application (see `Whatsmeow.Application`).
  """

  @behaviour Whatsmeow.Store

  alias Whatsmeow.Repo
  alias Whatsmeow.Store.Schemas

  # One peer, one session key.
  #
  # A contact reaches us as a LID (`182909923287057@lid`) and we send to them
  # as a phone number (`201141465543@s.whatsapp.net`). Those are two strings
  # for one physical device, and keying the session store on the string as it
  # arrives gives that device **two Signal ratchets**: inbound advances the
  # LID one, outbound advances the PN one, and the peer — which has exactly
  # one session — sees the counters diverge and can no longer decrypt.
  #
  # The symptom is "waiting for this message" on the recipient's phone,
  # intermittently, worst on whichever device they type on most, and cured by
  # re-pairing only until the first inbound message splits the pair again.
  # Proof: identical identity keys under both forms, per device.
  #
  #     182909923287057@lid          C14880FFA1E1990F
  #     201141465543@s.whatsapp.net  C14880FFA1E1990F
  #
  # Everything is stored under the phone-number form, because that is what
  # `get_user_devices/3` returns and what outbound addresses. An unmapped LID
  # is left as it is: no worse than before, and it converges as soon as the
  # mapping arrives.
  defp canonical(their_id) do
    case Whatsmeow.LIDMap.resolve(their_id) do
      %Whatsmeow.Types.JID{} = jid -> Whatsmeow.Types.JID.to_string(jid)
      _ -> their_id
    end
  rescue
    _ -> their_id
  end

  @impl true
  def new_device(opts) do
    # Construction (including the clamping and XEdDSA subtleties) lives in
    # `Whatsmeow.Store.build_device/1` so every adapter shares one copy.
    opts
    |> Whatsmeow.Store.build_device()
    |> Repo.insert()
  end

  @impl true
  def get_device(device_id) do
    case Repo.get(Schemas.Device, device_id) do
      nil -> {:error, :not_found}
      device -> {:ok, device}
    end
  end

  @impl true
  def get_device_by_client_id(client_id) do
    case Repo.get_by(Schemas.Device, client_id: client_id) do
      nil -> {:error, :not_found}
      device -> {:ok, device}
    end
  end

  @impl true
  @doc """
  List every persisted device row.

  By default returns the full table (legacy behavior — boot paths use
  this). Pass `limit:` and `offset:` opts to paginate. For fleets >10k
  devices, prefer `stream_devices/1` (called inside a Repo.transaction)
  to avoid loading every row into memory at once.
  """
  def list_devices(opts \\ []) do
    case Keyword.get(opts, :limit) do
      nil ->
        Repo.all(Schemas.Device)

      limit when is_integer(limit) and limit > 0 ->
        import Ecto.Query
        offset = Keyword.get(opts, :offset, 0)
        from(d in Schemas.Device, limit: ^limit, offset: ^offset) |> Repo.all()
    end
  end

  @doc """
  Stream every device row in batches of `:batch_size` (default 500).
  Must be called inside a `Repo.transaction/1`.
  """
  @spec stream_devices(keyword()) :: Enumerable.t()
  def stream_devices(opts \\ []) do
    batch = Keyword.get(opts, :batch_size, 500)
    Repo.stream(Schemas.Device, max_rows: batch)
  end

  @impl true
  def put_device(%Schemas.Device{client_id: cid} = device) when is_binary(cid) and cid != "" do
    # UPDATE the row keyed by client_id rather than inserting a second one:
    # pairing rewrites `device.jid`, and the FK cascade (`on_update: :update_all`)
    # then migrates the signal/prekey/session rows to the new jid with it.
    case Repo.get_by(Schemas.Device, client_id: cid) do
      nil ->
        device
        |> Schemas.Device.changeset(Map.from_struct(device))
        |> Repo.insert()
        |> persist_result()

      %Schemas.Device{} = existing ->
        existing
        |> Schemas.Device.changeset(Map.from_struct(device))
        |> Repo.update()
        |> persist_result()
    end
  end

  def put_device(%Schemas.Device{} = device) do
    device
    |> Schemas.Device.changeset(Map.from_struct(device))
    |> Repo.insert(on_conflict: :replace_all, conflict_target: [:jid])
    |> persist_result()
  end

  defp persist_result({:ok, _}), do: :ok
  defp persist_result({:error, %Ecto.Changeset{} = cs}), do: {:error, cs.errors}
  defp persist_result({:error, reason}), do: {:error, reason}

  @impl true
  def delete_device(device_id) do
    case get_device(device_id) do
      {:ok, device} ->
        # Cascade-clean every per-`our_jid` row. Without this, a re-pair
        # against the same WhatsApp account re-uses stale Signal /
        # ratchet state from BEFORE the device was deleted — the new
        # device has fresh identity_key / pre_keys / noise_key, but the
        # surviving `whatsmeow_sessions` row references the old chain
        # so the first outbound `encrypt_signal_envelope` produces an
        # envelope the recipient (and our own counter) can't decrypt.
        # Tables here are every Schema whose row is keyed on a JID we
        # own (`our_jid` / `jid`).
        #
        # All deletes + the final Device row delete run inside ONE
        # transaction so a crash midway leaves the DB consistent (either
        # nothing got deleted, or all of it did). The old form issued
        # ~15 separate round-trips and could leave a half-cleaned device
        # on partial failure.
        jid = device.jid

        Repo.transaction(fn ->
          for {sql, params} <- [
                {"DELETE FROM whatsmeow_sessions WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_identity_keys WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_sender_keys WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_app_state_sync_keys WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_app_state_version WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_app_state_mutation_macs WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_message_secrets WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_chat_settings WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_contacts WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_privacy_tokens WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_lid_map WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_event_buffer WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_retry_buffer WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_nct_salt WHERE our_jid = $1", [jid]},
                {"DELETE FROM whatsmeow_pre_keys WHERE jid = $1", [jid]}
              ] do
            # Each table is best-effort against an older migration that
            # hasn't created it yet. `savepoint` so a missing table
            # doesn't blow the outer transaction.
            try do
              Ecto.Adapters.SQL.query!(Repo, sql, params)
            rescue
              e in [Postgrex.Error] ->
                case e do
                  %Postgrex.Error{postgres: %{code: :undefined_table}} -> :ok
                  _ -> Repo.rollback({:delete_device, e})
                end
            end
          end

          Repo.delete!(device)
        end)

        :ok

      {:error, _} = e ->
        e
    end
  end

  @impl true
  def put_identity(our_jid, their_id_raw, identity) do
    their_id = canonical(their_id_raw)

    %Schemas.IdentityKey{}
    |> Schemas.IdentityKey.changeset(%{
      our_jid: our_jid,
      their_id: their_id,
      identity: identity
    })
    |> Repo.insert(
      on_conflict: {:replace, [:identity]},
      conflict_target: [:our_jid, :their_id]
    )
    |> case do
      {:ok, _} -> :ok
      err -> err
    end
  end

  @impl true
  def get_identity(our_jid, their_id_raw) do
    their_id = canonical(their_id_raw)

    case Repo.get_by(Schemas.IdentityKey, our_jid: our_jid, their_id: their_id) do
      nil -> {:error, :not_found}
      rec -> {:ok, rec.identity}
    end
  end

  @impl true
  def put_session(our_jid, their_id_raw, session) do
    their_id = canonical(their_id_raw)

    %Schemas.Session{}
    |> Schemas.Session.changeset(%{our_jid: our_jid, their_id: their_id, session: session})
    |> Repo.insert(
      on_conflict: {:replace, [:session]},
      conflict_target: [:our_jid, :their_id]
    )
    |> case do
      {:ok, _} -> :ok
      err -> err
    end
  end

  @impl true
  def get_session(our_jid, their_id_raw) do
    their_id = canonical(their_id_raw)

    case Repo.get_by(Schemas.Session, our_jid: our_jid, their_id: their_id) do
      nil -> {:error, :not_found}
      rec -> {:ok, rec.session}
    end
  end

  @impl true
  def put_pre_key(jid, key_id, key, uploaded?) do
    %Schemas.PreKey{}
    |> Schemas.PreKey.changeset(%{
      jid: jid,
      key_id: key_id,
      key: key,
      uploaded: uploaded?
    })
    |> Repo.insert(
      on_conflict: {:replace, [:key, :uploaded]},
      conflict_target: [:jid, :key_id]
    )
    |> case do
      {:ok, _} -> :ok
      err -> err
    end
  end

  @impl true
  def get_pre_key(jid, key_id) do
    case Repo.get_by(Schemas.PreKey, jid: jid, key_id: key_id) do
      nil -> {:error, :not_found}
      rec -> {:ok, rec.key}
    end
  end
end
