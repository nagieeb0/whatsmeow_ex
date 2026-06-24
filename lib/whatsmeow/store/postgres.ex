defmodule Whatsmeow.Store.Postgres do
  @moduledoc """
  Ecto/Postgres-backed implementation of `Whatsmeow.Store`.

  All operations run against `Whatsmeow.Repo`. The repo must be started by
  the host application (see `Whatsmeow.Application`).
  """

  @behaviour Whatsmeow.Store

  alias Whatsmeow.Crypto.{Curve25519, XEdDSA}
  alias Whatsmeow.Repo
  alias Whatsmeow.Store.Schemas

  @impl true
  def new_device(opts) do
    # X25519 keys MUST come from `Curve25519.generate_keypair/0` (which
    # calls `:crypto.generate_key(:ecdh, :x25519)`) so the returned
    # private scalar is RFC-7748 clamped. Using `:crypto.strong_rand_bytes/1`
    # here was a latent bug: ECDH clamps internally so the Noise handshake
    # still succeeds, but `XEdDSA.sign/3` assumes a pre-clamped scalar and
    # signs over the Ed25519 pub of the RAW (unclamped) scalar. The
    # `signed_pre_key_sig` then fails verification against the X25519
    # `identity_key` pub we publish — the server rejects the pair-device
    # session with `<stream:error code="500">` (ConnectFailureInternalServerError)
    # immediately after the Noise handshake. Smoke CLI never hit this
    # because it always uses `Curve25519.generate_keypair/0`.
    identity_key = Keyword.get_lazy(opts, :identity_key, &fresh_private/0)
    signed_pre_key = Keyword.get_lazy(opts, :signed_pre_key, &fresh_private/0)
    noise_key = Keyword.get_lazy(opts, :noise_key, &fresh_private/0)

    signed_pre_key_sig =
      Keyword.get_lazy(opts, :signed_pre_key_sig, fn ->
        derive_signed_pre_key_sig(identity_key, signed_pre_key)
      end)

    jid = Keyword.get_lazy(opts, :jid, fn -> "device-" <> random_id() end)
    client_id = Keyword.get(opts, :client_id, jid)

    %Schemas.Device{
      jid: jid,
      client_id: client_id,
      registration_id: Keyword.get(opts, :registration_id, :rand.uniform(4_294_967_296) - 1),
      noise_key: noise_key,
      identity_key: identity_key,
      signed_pre_key: signed_pre_key,
      signed_pre_key_id: Keyword.get(opts, :signed_pre_key_id, 1),
      signed_pre_key_sig: signed_pre_key_sig,
      adv_key: Keyword.get(opts, :adv_key, :crypto.strong_rand_bytes(32)),
      adv_details: Keyword.get(opts, :adv_details, <<>>),
      adv_account_sig: Keyword.get(opts, :adv_account_sig, :crypto.strong_rand_bytes(64)),
      adv_account_sig_key: Keyword.get(opts, :adv_account_sig_key, :crypto.strong_rand_bytes(32)),
      adv_device_sig: Keyword.get(opts, :adv_device_sig, :crypto.strong_rand_bytes(64)),
      # Per-device fingerprint persona (UA/device-props). Caller passes a random
      # one so numbers don't all look like the same client; nil falls back to
      # the app-env/default persona at payload-build time.
      persona: Keyword.get(opts, :persona)
    }
    |> Repo.insert()
  end

  defp fresh_private do
    {_pub, priv} = Curve25519.generate_keypair()
    priv
  end

  # Mirror Go's keys.KeyPair.Sign — XEdDSA over DjbType(5) ‖ spk.pub using
  # the identity key's private scalar. Random bytes here trigger
  # <stream:error code="500"> immediately after the Noise handshake.
  defp derive_signed_pre_key_sig(identity_priv, spk_priv) do
    spk_pub = Curve25519.public_for(spk_priv)
    XEdDSA.sign(identity_priv, <<5, spk_pub::binary>>)
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
  def put_identity(our_jid, their_id, identity) do
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
  def get_identity(our_jid, their_id) do
    case Repo.get_by(Schemas.IdentityKey, our_jid: our_jid, their_id: their_id) do
      nil -> {:error, :not_found}
      rec -> {:ok, rec.identity}
    end
  end

  @impl true
  def put_session(our_jid, their_id, session) do
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
  def get_session(our_jid, their_id) do
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

  defp random_id, do: Base.encode16(:crypto.strong_rand_bytes(8), case: :lower)
end
