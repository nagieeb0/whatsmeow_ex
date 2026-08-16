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

  Falls back to the no-op `{:error, :no_store}` if no Signal store is
  started — unit tests don't run a Postgres so we keep this graceful.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.MessageInfo
  alias Whatsmeow.Signal.{GroupDecrypt, GroupSession, Lock, SenderKeyWire, Wire, WireDecrypt}
  alias Whatsmeow.Store.Schemas.Device
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
          | :no_store
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
    # Same serialisation as `decrypt_msg/3`: a pkmsg replaces the whole session
    # record, so it must not interleave with a send encrypting the old one.
    Lock.with_session(device.jid, peer_id(info), fn ->
      do_decrypt_pkmsg(envelope, device, info)
    end)
  end

  defp do_decrypt_pkmsg(envelope, %Device{} = device, %MessageInfo{} = info) do
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
           Wire.decode_prekey_signal_message(envelope) do
      Whatsmeow.Signal.Store.Adapter.load_prekey(our_jid, id)
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

    # Load, decrypt, and store are one atomic step against a concurrent encrypt
    # of the same session record — see `Whatsmeow.Signal.Lock`. Without this the
    # send path's store can land on top of ours and drop the receive chain's
    # skipped-message keys, which is what leaves a chat stuck on "Waiting for
    # this message".
    Lock.with_session(device.jid, their_id, fn ->
      do_decrypt_msg(envelope, device, info, their_id)
    end)
  end

  defp do_decrypt_msg(envelope, %Device{} = device, %MessageInfo{}, their_id) do
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
  but the write failed, or `{:error, :no_store}` if no store is configured.
  """
  @spec persist_session(String.t(), String.t(), Whatsmeow.Signal.Session.t()) ::
          :ok | {:error, term()}
  def persist_session(our_jid, their_id, session),
    do: Whatsmeow.Signal.Store.Adapter.save_session(our_jid, their_id, session)

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
      when is_binary(identity_pub) and byte_size(identity_pub) == 32,
      do: Whatsmeow.Signal.Store.Adapter.save_identity(our_jid, their_id, identity_pub)

  defp load_session(our_jid, their_id),
    do: Whatsmeow.Signal.Store.Adapter.load_session(our_jid, their_id)

  defp load_identity_pub(our_jid, their_id),
    do: Whatsmeow.Signal.Store.Adapter.load_identity(our_jid, their_id)

  # peer_id keys our persistence by the *full* JID string the message
  # came `from=`. Group messages carry `participant=...`; we key by the
  # individual sender there so the session matches the X3DH bundle.
  defp peer_id(%MessageInfo{is_group?: true, participant: %JID{} = p}), do: JID.to_string(p)
  defp peer_id(%MessageInfo{from: %JID{} = j}), do: JID.to_string(j)
  defp peer_id(_), do: ""

  # --- skmsg (group steady-state) -----------------------------------------

  defp decrypt_skmsg(envelope, %Device{} = device, %MessageInfo{} = info) do
    with %JID{} = chat_jid <- group_chat_jid(info),
         sender_id when is_binary(sender_id) <- group_sender_id(info) do
      chat_id = JID.to_string(chat_jid)

      # A sender-key record advances its chain on every decrypt, so the same
      # read-modify-write rule as 1:1 sessions applies — two messages from the
      # same group member arriving together must not both start from the same
      # chain key.
      Lock.with_sender_key(device.jid, chat_id, sender_id, fn ->
        do_decrypt_skmsg(envelope, device, chat_id, sender_id)
      end)
    else
      nil -> {:error, :no_chat}
    end
  end

  defp do_decrypt_skmsg(envelope, %Device{} = device, chat_id, sender_id) do
    with {:ok, %GroupSession{} = gs} <- load_group_session(device.jid, chat_id, sender_id),
         {:ok, plain, gs2} <- GroupDecrypt.decrypt_envelope(envelope, gs),
         _ <- persist_group_session(device.jid, chat_id, sender_id, gs2) do
      {:ok, %{plaintext: plain, enc_type: "skmsg", pkmsg: nil}}
    else
      :not_found -> {:error, :no_group_session}
      {:error, _} = err -> err
    end
  rescue
    e -> {:error, {:crash, Exception.message(e)}}
  end

  defp group_chat_jid(%MessageInfo{is_group?: true, from: %JID{} = chat}), do: chat
  defp group_chat_jid(_), do: nil

  defp group_sender_id(%MessageInfo{participant: %JID{} = p}), do: JID.to_string(p)
  defp group_sender_id(%MessageInfo{from: %JID{} = j}), do: JID.to_string(j)

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
      # Under the sender-key lock: this is a blind whole-record overwrite with a
      # fresh chain at iteration 0. Landing it in the middle of a concurrent
      # `decrypt_skmsg` read-modify-write would reset an already-advanced chain
      # and make every message after it undecryptable.
      Lock.with_sender_key(our_jid, group_id, sender_id, fn ->
        persist_group_session(our_jid, group_id, sender_id, gs)
      end)
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
  def persist_group_session(our_jid, chat_id, sender_id, %GroupSession{} = gs),
    do: Whatsmeow.Signal.Store.Adapter.save_sender_key(our_jid, chat_id, sender_id, gs)

  defp load_group_session(our_jid, chat_id, sender_id),
    do: Whatsmeow.Signal.Store.Adapter.load_sender_key(our_jid, chat_id, sender_id)
end
