defmodule Whatsmeow.Signal.Decrypt do
  @moduledoc """
  Glue between `Whatsmeow.Signal.WireDecrypt` (pure libsignal-wire crypto)
  and the persistence layer.

  Given an `<enc>` child node and a `%Device{}`, this module:

    1. Picks the right wire envelope (`pkmsg` first-contact vs `msg`
       steady-state).
    2. For `pkmsg` — runs responder X3DH from the device's signed
       pre-key, decrypts the inner `SignalMessage`, persists the freshly
       minted `%Signal.Session{}` keyed by `(our_jid, their_id)`, and
       stashes the sender's identity public key.
    3. For `msg` — loads the persisted session + stashed identity pub,
       decrypts, persists the advanced session.

  Returns `{:ok, plaintext, %{enc_type, pkmsg | nil}}` on success or
  `{:error, reason}` if any step failed. The caller (Session GenServer
  or smoke task) handles the surrounding stanza handling — ack,
  delivery receipt, broadcasting `%Events.Message{}`, etc.

  Falls back to the no-op `{:error, :no_repo}` if `Whatsmeow.Repo` isn't
  started — unit tests don't run a Postgres so we keep this graceful.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.MessageInfo
  alias Whatsmeow.Signal.{GroupDecrypt, GroupSession, SenderKeyWire, Wire, WireDecrypt}
  alias Whatsmeow.Store.Schemas.{Device, IdentityKey}
  alias Whatsmeow.Types.JID

  @type result :: %{
          plaintext: binary(),
          enc_type: String.t(),
          pkmsg: Whatsmeow.Signal.Wire.PreKeySignalMessage.t() | nil
        }

  @typedoc "Reasons decrypt may fail."
  @type error ::
          :no_enc
          | :no_repo
          | :no_session
          | :no_identity_pub
          | :no_group_session
          | :no_chat
          | :no_sender
          | WireDecrypt.error()
          | GroupDecrypt.error()

  @doc """
  Try to decrypt the first usable `<enc>` child of `msg_node`.

  Prefers `pkmsg` (first-contact 1:1) → `msg` (steady-state 1:1) →
  `skmsg` (group). On successful 1:1 decrypt we also peek inside the
  inner `WaE2E.Message` for a `senderKeyDistributionMessage` and seed
  the matching `whatsmeow_sender_keys` row — that's what makes the
  *next* `skmsg` from the same sender/group decryptable.
  """
  @spec decrypt_message_node(Node.t(), Device.t(), MessageInfo.t()) ::
          {:ok, result()} | {:error, error()}
  def decrypt_message_node(%Node{tag: "message"} = msg, %Device{} = device, %MessageInfo{} = info) do
    enc_children = Node.get_children(msg, "enc")
    pkmsg = Enum.find(enc_children, &(Node.attr(&1, "type") == "pkmsg"))
    msg_enc = Enum.find(enc_children, &(Node.attr(&1, "type") == "msg"))
    skmsg = Enum.find(enc_children, &(Node.attr(&1, "type") == "skmsg"))

    cond do
      pkmsg && is_binary(pkmsg.content) ->
        decrypt_pkmsg(pkmsg.content, device, info)
        |> maybe_seed_sender_key(device, info)

      msg_enc && is_binary(msg_enc.content) ->
        decrypt_msg(msg_enc.content, device, info)
        |> maybe_seed_sender_key(device, info)

      skmsg && is_binary(skmsg.content) ->
        decrypt_skmsg(skmsg.content, device, info)

      true ->
        {:error, :no_enc}
    end
  end

  # --- pkmsg (first-contact) ----------------------------------------------

  defp decrypt_pkmsg(envelope, %Device{} = device, %MessageInfo{} = info) do
    # Peek the envelope to find the `preKeyId` the peer used in X3DH.
    # Modern WhatsApp always picks one of our uploaded OPKs — when we
    # do X3DH responder without that OPK's private half, the derived
    # root_key is wrong and the inner SignalMessage MAC fails with
    # `:mac_mismatch`. The bug was that we hardcoded `nil` here, so
    # every fresh pkmsg from a peer that grabbed one of our 812 OPKs
    # failed to decrypt — exactly the symptom the user saw on every
    # message after re-pair. Mirrors what Go does in
    # `whatsmeow.handleEncryptedMessage` + `Store.PreKeys.GenOnePreKey`.
    opk_priv = lookup_opk_priv(envelope, device.jid)

    case WireDecrypt.decrypt_prekey_envelope(
           envelope,
           device.identity_key,
           device.signed_pre_key,
           opk_priv
         ) do
      {:ok, plain, session, pkmsg_struct} ->
        their_id = peer_id(info)
        # Any inbound from the peer means we have proof the session is
        # established on their side; clear `pending_pre_key` so our next
        # outbound stops wrapping as pkmsg and ships as bare msg.
        # Mirrors libsignal-java `SessionState.clearUnacknowledgedPreKeyMessage`.
        # `Map.put/3` — see WireDecrypt for the legacy-record reasoning.
        _ = persist_session(device.jid, their_id, Map.put(session, :pending_pre_key, nil))

        _ =
          stash_identity_pub(
            device.jid,
            their_id,
            Wire.strip_djb_type(pkmsg_struct.identityKey || <<>>)
          )

        {:ok, %{plaintext: plain, enc_type: "pkmsg", pkmsg: pkmsg_struct}}

      {:error, _} = err ->
        err
    end
  rescue
    e -> {:error, {:crash, Exception.message(e)}}
  end

  # Read the `preKeyId` field from the pkmsg envelope and load the
  # matching one-time-prekey private key from `whatsmeow_pre_keys`.
  # Returns `nil` if the envelope can't be parsed, the peer didn't
  # reference an OPK (rare — happens when our pool ran dry), or the
  # row was already consumed. `nil` propagates to
  # `decrypt_prekey_envelope` which falls back to SPK-only X3DH —
  # works for legacy peers, fails (`:mac_mismatch`) for modern peers
  # that always pick an OPK.
  defp lookup_opk_priv(envelope, our_jid) when is_binary(our_jid) do
    with {:ok, %Wire.PreKeySignalMessage{preKeyId: id}} when is_integer(id) <-
           Wire.decode_prekey_signal_message(envelope),
         true <- repo_up?() do
      case Whatsmeow.Repo.get_by(Whatsmeow.Store.Schemas.PreKey, jid: our_jid, key_id: id) do
        %Whatsmeow.Store.Schemas.PreKey{key: priv} when is_binary(priv) and byte_size(priv) == 32 ->
          priv

        _ ->
          nil
      end
    else
      _ -> nil
    end
  rescue
    _ -> nil
  end

  defp lookup_opk_priv(_, _), do: nil

  # --- msg (steady-state) -------------------------------------------------

  defp decrypt_msg(envelope, %Device{} = device, %MessageInfo{} = info) do
    their_id = peer_id(info)

    with {:ok, sess} <- load_session(device.jid, their_id),
         their_id_pub when is_binary(their_id_pub) and byte_size(their_id_pub) == 32 <-
           load_identity_pub(device.jid, their_id) do
      our_id_pub = Curve25519.public_for(device.identity_key)

      case WireDecrypt.decrypt_signal_envelope(envelope, sess, our_id_pub, their_id_pub) do
        {:ok, plain, new_sess} ->
          # Steady-state inbound from the peer — they have a working
          # session with us, so we can stop wrapping outbound as pkmsg.
          # Mirrors libsignal-java
          # `SessionState.clearUnacknowledgedPreKeyMessage`.
          # `Map.put/3` — see WireDecrypt for the legacy-record reasoning.
          _ = persist_session(device.jid, their_id, Map.put(new_sess, :pending_pre_key, nil))
          {:ok, %{plaintext: plain, enc_type: "msg", pkmsg: nil}}

        {:error, _} = err ->
          err
      end
    else
      :not_found -> {:error, :no_session}
      nil -> {:error, :no_identity_pub}
      {:error, _} = err -> err
    end
  rescue
    e -> {:error, {:crash, Exception.message(e)}}
  end

  # --- Repo-aware persistence (graceful no-ops in test contexts) ----------

  @doc """
  Persist (or replace) the Signal session for `(our_jid, their_id)`.

  Returns `:ok` on success, `{:error, reason}` if Postgres is reachable
  but the write failed, or `{:error, :no_repo}` if the repo isn't up.
  """
  @spec persist_session(String.t(), String.t(), Whatsmeow.Signal.Session.t()) ::
          :ok | {:error, term()}
  def persist_session(our_jid, their_id, session) do
    if repo_up?() do
      Whatsmeow.Signal.Store.Postgres.put(our_jid, their_id, session)
    else
      {:error, :no_repo}
    end
  end

  @doc """
  Persist (or replace) a peer's 32-byte identity public key.

  No-ops on a `nil` or empty key — pkmsg envelopes from peers running
  older clients may omit the field; we just skip the upsert.
  """
  @spec stash_identity_pub(String.t(), String.t(), binary() | nil) ::
          :ok | :skipped | {:error, term()}
  def stash_identity_pub(_our_jid, _their_id, nil), do: :skipped
  def stash_identity_pub(_our_jid, _their_id, <<>>), do: :skipped

  def stash_identity_pub(our_jid, their_id, identity_pub)
      when is_binary(identity_pub) and byte_size(identity_pub) == 32 do
    if repo_up?() do
      %IdentityKey{}
      |> IdentityKey.changeset(%{
        our_jid: our_jid,
        their_id: their_id,
        identity: identity_pub
      })
      |> Whatsmeow.Repo.insert(
        on_conflict: {:replace, [:identity]},
        conflict_target: [:our_jid, :their_id]
      )
      |> case do
        {:ok, _} -> :ok
        {:error, _} = err -> err
      end
    else
      {:error, :no_repo}
    end
  end

  defp load_session(our_jid, their_id) do
    if repo_up?() do
      Whatsmeow.Signal.Store.Postgres.get(our_jid, their_id)
    else
      :not_found
    end
  end

  defp load_identity_pub(our_jid, their_id) do
    if repo_up?() do
      case Whatsmeow.Repo.get_by(IdentityKey, our_jid: our_jid, their_id: their_id) do
        %IdentityKey{identity: id_pub}
        when is_binary(id_pub) and byte_size(id_pub) == 32 ->
          id_pub

        _ ->
          nil
      end
    else
      nil
    end
  rescue
    _ -> nil
  end

  defp repo_up? do
    Code.ensure_loaded?(Whatsmeow.Repo) and is_pid(Process.whereis(Whatsmeow.Repo))
  end

  # peer_id keys our persistence by the *full* JID string the message
  # came `from=`. Group messages carry `participant=...`; we key by the
  # individual sender there so the session matches the X3DH bundle.
  defp peer_id(%MessageInfo{is_group?: true, participant: %JID{} = p}), do: JID.to_string(p)
  defp peer_id(%MessageInfo{from: %JID{} = j}), do: JID.to_string(j)
  defp peer_id(_), do: ""

  # --- skmsg (group steady-state) -----------------------------------------

  defp decrypt_skmsg(envelope, %Device{} = device, %MessageInfo{} = info) do
    with %JID{} = chat_jid <- group_chat_jid(info),
         sender_id when is_binary(sender_id) <- group_sender_id(info),
         chat_id = JID.to_string(chat_jid),
         {:ok, %GroupSession{} = gs} <- load_group_session(device.jid, chat_id, sender_id),
         {:ok, plain, gs2} <- GroupDecrypt.decrypt_envelope(envelope, gs),
         _ <- persist_group_session(device.jid, chat_id, sender_id, gs2) do
      {:ok, %{plaintext: plain, enc_type: "skmsg", pkmsg: nil}}
    else
      :not_found -> {:error, :no_group_session}
      nil -> {:error, :no_chat}
      {:error, _} = err -> err
    end
  rescue
    e -> {:error, {:crash, Exception.message(e)}}
  end

  defp group_chat_jid(%MessageInfo{is_group?: true, from: %JID{} = chat}), do: chat
  defp group_chat_jid(_), do: nil

  defp group_sender_id(%MessageInfo{participant: %JID{} = p}), do: JID.to_string(p)
  defp group_sender_id(%MessageInfo{from: %JID{} = j}), do: JID.to_string(j)
  defp group_sender_id(_), do: nil

  # --- SenderKeyDistributionMessage seeding (called after pkmsg/msg) ------

  # Peek inside a successfully-decrypted plaintext for a senderKeyDistributionMessage,
  # decode it, and persist a fresh %GroupSession{} keyed by (our_jid, group_id, sender_id).
  # Failures are swallowed — SKDM seeding is best-effort and the 1:1 message
  # itself is already valid.
  defp maybe_seed_sender_key({:ok, %{plaintext: plain} = result}, %Device{} = device, info) do
    _ = try_seed_sender_key(plain, device, info)
    {:ok, result}
  end

  defp maybe_seed_sender_key(other, _device, _info), do: other

  defp try_seed_sender_key(plaintext, %Device{} = device, %MessageInfo{} = info) do
    case safe_decode_e2e(plaintext) do
      {:ok, %WAWebProtobufsE2E.Message{} = e2e} ->
        unwrapped = unwrap_e2e(e2e)

        case unwrapped.senderKeyDistributionMessage do
          %WAWebProtobufsE2E.SenderKeyDistributionMessage{
            groupID: group_id,
            axolotlSenderKeyDistributionMessage: axolotl
          }
          when is_binary(group_id) and is_binary(axolotl) and byte_size(axolotl) > 0 ->
            seed_sender_key_from_axolotl(device, info, group_id, axolotl)

          _ ->
            :no_skdm
        end

      _ ->
        :decode_failed
    end
  rescue
    _ -> :crash
  end

  defp seed_sender_key_from_axolotl(%Device{jid: our_jid}, %MessageInfo{} = info, group_id, axolotl) do
    with {:ok, sdkm} <- SenderKeyWire.decode_sender_key_distribution_message(axolotl),
         {:ok, %GroupSession{} = gs} <- GroupSession.from_distribution(sdkm),
         sender_id when is_binary(sender_id) <- peer_id_for_skdm(info) do
      persist_group_session(our_jid, group_id, sender_id, gs)
    else
      _ -> :error
    end
  end

  defp peer_id_for_skdm(%MessageInfo{is_group?: true, participant: %JID{} = p}),
    do: JID.to_string(p)

  defp peer_id_for_skdm(%MessageInfo{from: %JID{} = j}), do: JID.to_string(j)
  defp peer_id_for_skdm(_), do: nil

  defp safe_decode_e2e(plaintext) do
    {:ok, WAWebProtobufsE2E.Message.decode(plaintext)}
  rescue
    e -> {:error, {:proto_decode, Exception.message(e)}}
  end

  # Mirror MessageBuilder.unwrap/1 — peek through ephemeral / view-once /
  # deviceSent wrappers to find the inner message that carries the SKDM.
  defp unwrap_e2e(%WAWebProtobufsE2E.Message{ephemeralMessage: %{message: inner}})
       when not is_nil(inner),
       do: unwrap_e2e(inner)

  defp unwrap_e2e(%WAWebProtobufsE2E.Message{viewOnceMessage: %{message: inner}})
       when not is_nil(inner),
       do: unwrap_e2e(inner)

  defp unwrap_e2e(%WAWebProtobufsE2E.Message{viewOnceMessageV2: %{message: inner}})
       when not is_nil(inner),
       do: unwrap_e2e(inner)

  defp unwrap_e2e(%WAWebProtobufsE2E.Message{viewOnceMessageV2Extension: %{message: inner}})
       when not is_nil(inner),
       do: unwrap_e2e(inner)

  defp unwrap_e2e(%WAWebProtobufsE2E.Message{deviceSentMessage: %{message: inner}})
       when not is_nil(inner),
       do: unwrap_e2e(inner)

  defp unwrap_e2e(%WAWebProtobufsE2E.Message{} = msg), do: msg
  defp unwrap_e2e(other), do: other

  # --- GroupSession persistence (graceful no-ops in test contexts) --------

  @doc """
  Persist (or replace) a Signal group session for
  `(our_jid, chat_id, sender_id)`. Returns the same shape as
  `persist_session/3`.
  """
  @spec persist_group_session(String.t(), String.t(), String.t(), GroupSession.t()) ::
          :ok | {:error, term()}
  def persist_group_session(our_jid, chat_id, sender_id, %GroupSession{} = gs) do
    if repo_up?() do
      Whatsmeow.Signal.GroupSession.Store.Postgres.put(our_jid, chat_id, sender_id, gs)
    else
      {:error, :no_repo}
    end
  end

  defp load_group_session(our_jid, chat_id, sender_id) do
    if repo_up?() do
      Whatsmeow.Signal.GroupSession.Store.Postgres.get(our_jid, chat_id, sender_id)
    else
      :not_found
    end
  end
end
