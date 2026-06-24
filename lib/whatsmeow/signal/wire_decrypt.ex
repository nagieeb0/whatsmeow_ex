defmodule Whatsmeow.Signal.WireDecrypt do
  @moduledoc """
  libsignal-wire-compatible decrypt pipeline.

  The existing `Whatsmeow.Signal.SessionCipher.decrypt/2` works against
  a home-grown ciphertext shape that's perfect for internal round-trip
  tests but **not** byte-compatible with what WhatsApp / libsignal
  actually sends on the wire. The two differ in:

    * **Envelope** — libsignal wraps the AES-CBC ciphertext in a
      protobuf (`%SignalMessage{ratchetKey, counter, previousCounter,
      ciphertext}`) prefixed by a version byte.
    * **MAC scope** — libsignal HMACs over
      `sender_identity_pub ‖ receiver_identity_pub ‖ version_byte ‖ proto`
      using the message MAC key. The internal SessionCipher MACs over
      `ratchet_pub ‖ counter ‖ body`.

  This module bridges the gap: it parses the wire envelope, reuses the
  existing Ratchet primitives for key derivation, and verifies MAC with
  libsignal's formula. The plaintext goes through
  `Whatsmeow.MessagePadding.unpad/2` before being returned, so callers
  get the bare `WaE2E.Message` protobuf bytes ready to decode.

  ## Entry points

    * `decrypt_signal_envelope/4` — for the steady-state `<enc type="msg">`
      case (session already established).
    * `decrypt_prekey_envelope/4` — for the first-contact
      `<enc type="pkmsg">` case. Performs responder X3DH, initialises a
      new responder session, then recursively decrypts the inner
      SignalMessage.

  Mirrors libsignal-protocol-java's `SessionCipher.decrypt` and
  `PreKeySignalMessage` handling.
  """

  alias Whatsmeow.Crypto.{AES, Curve25519}
  alias Whatsmeow.MessagePadding
  alias Whatsmeow.Signal.{Ratchet, Session, SessionCipher, Wire, X3DH}
  alias Whatsmeow.Signal.Wire.{PreKeySignalMessage, SignalMessage}

  @typedoc "Reasons decrypt may fail. Wrap-style errors (`{:wire_decode, _}`) propagate the underlying cause."
  @type error ::
          :no_receiving_chain
          | :mac_mismatch
          | :bad_padding
          | :missing_prekey
          | :empty
          | {:wire_decode, term()}
          | {:aes, term()}

  @doc """
  Decrypt an `<enc type="msg">` envelope.

  Required inputs:

    * `envelope` — raw bytes from the `<enc>` element content.
    * `session` — `%Whatsmeow.Signal.Session{}` already established with
      this peer.
    * `our_identity_pub` — 32-byte X25519 public key of this device.
    * `their_identity_pub` — 32-byte X25519 public key of the sender.

  Returns `{:ok, plaintext, new_session}` on success. The plaintext is
  unpadded — feed it directly to `WAWebProtobufsE2E.Message.decode/1`.
  """
  @spec decrypt_signal_envelope(binary(), Session.t(), <<_::256>>, <<_::256>>) ::
          {:ok, binary(), Session.t()} | {:error, error()}
  def decrypt_signal_envelope(envelope, %Session{} = sess, our_id_pub, their_id_pub)
      when byte_size(our_id_pub) == 32 and byte_size(their_id_pub) == 32 do
    with {:ok, %SignalMessage{} = msg, mac_input, mac} <-
           wrap_wire_error(Wire.decode_signal_message(envelope)),
         ratchet_pub when not is_nil(ratchet_pub) <- Wire.strip_djb_type(msg.ratchetKey || <<>>),
         msg_no_djb = %SignalMessage{msg | ratchetKey: ratchet_pub},
         sess <- ratchet_step_if_needed(sess, msg_no_djb),
         {:ok, sess, message_key} <- pull_message_key(sess, msg.counter) do
      verify_and_decrypt(sess, message_key, mac, mac_input, msg_no_djb, our_id_pub, their_id_pub)
    else
      nil -> {:error, :bad_ratchet_key}
      err -> err
    end
  end

  @doc """
  Decrypt an `<enc type="pkmsg">` envelope: the first message from a
  peer we've never seen before.

  Steps:

    1. Decode the PreKeySignalMessage envelope.
    2. Run responder X3DH: derive root key from our identity / signed
       pre-key / (optional) one-time pre-key and the sender's identity +
       baseKey.
    3. Initialise a responder `%Session{}` with our signed pre-key
       keypair as `dh_self`.
    4. Recursively decrypt the inner `pkmsg.message` (which is itself a
       full SignalMessage envelope) via `decrypt_signal_envelope/4`.

  `our_one_time_prekey_priv` is `nil` when the sender didn't reference
  an OPK (rare; happens when the server's OPK pool ran dry).
  """
  @spec decrypt_prekey_envelope(
          envelope :: binary(),
          our_identity_priv :: <<_::256>>,
          our_signed_prekey_priv :: <<_::256>>,
          our_one_time_prekey_priv :: <<_::256>> | nil
        ) :: {:ok, binary(), Session.t(), PreKeySignalMessage.t()} | {:error, error()}
  def decrypt_prekey_envelope(envelope, id_priv, spk_priv, opk_priv)
      when byte_size(id_priv) == 32 and byte_size(spk_priv) == 32 do
    with {:ok, %PreKeySignalMessage{} = pkmsg} <-
           wrap_wire_error(Wire.decode_prekey_signal_message(envelope)),
         their_id_pub when not is_nil(their_id_pub) <-
           Wire.strip_djb_type(pkmsg.identityKey || <<>>),
         their_base_pub when not is_nil(their_base_pub) <-
           Wire.strip_djb_type(pkmsg.baseKey || <<>>),
         inner_envelope when is_binary(inner_envelope) <- pkmsg.message,
         root_key <- X3DH.responder_agree(id_priv, spk_priv, opk_priv, their_id_pub, their_base_pub),
         spk_pub <- Curve25519.public_for(spk_priv),
         our_id_pub <- Curve25519.public_for(id_priv),
         sess <- Session.init_responder(root_key, {spk_pub, spk_priv}),
         {:ok, plain, sess} <-
           decrypt_signal_envelope(inner_envelope, sess, our_id_pub, their_id_pub) do
      {:ok, plain, sess, pkmsg}
    else
      nil -> {:error, :missing_prekey}
      err -> err
    end
  end

  # --- internals -----------------------------------------------------------

  # Build the home-grown `ct` shape `SessionCipher.maybe_dh_ratchet_pub`
  # expects from a parsed SignalMessage so we can reuse the ratchet step
  # without duplicating it.
  defp ratchet_step_if_needed(sess, %SignalMessage{ratchetKey: rpub, counter: counter}) do
    SessionCipher.maybe_dh_ratchet_pub(sess, %{ratchet_pub: rpub, counter: counter})
  end

  defp pull_message_key(%Session{receiving_ck: nil}, _counter), do: {:error, :no_receiving_chain}

  defp pull_message_key(%Session{} = sess, counter) when is_integer(counter) do
    cached_key = {sess.dh_remote, counter}

    case Map.fetch(sess.skipped_keys, cached_key) do
      {:ok, mk} ->
        sess = %Session{sess | skipped_keys: Map.delete(sess.skipped_keys, cached_key)}
        {:ok, sess, mk}

      :error ->
        sess2 = SessionCipher.skip_message_keys_pub(sess, counter)
        {next_ck, mk} = Ratchet.kdf_ck(sess2.receiving_ck)
        sess3 = %{sess2 | receiving_ck: next_ck, receiving_n: sess2.receiving_n + 1}
        {:ok, sess3, mk}
    end
  end

  defp verify_and_decrypt(
         %Session{} = sess,
         message_key,
         mac,
         mac_input,
         msg,
         our_id_pub,
         their_id_pub
       ) do
    {enc_key, mac_key, iv} = Ratchet.derive_message_keys(message_key)
    expected = Wire.compute_mac(mac_key, their_id_pub, our_id_pub, mac_input)

    if not :crypto.hash_equals(expected, mac) do
      {:error, :mac_mismatch}
    else
      case AES.CBC.decrypt(enc_key, iv, msg.ciphertext) do
        {:ok, padded} ->
          case MessagePadding.unpad(padded, 2) do
            # Any inbound that decrypts successfully on this session proves
            # the peer has a working session with us — stop wrapping our
            # outbound as `pkmsg`. Mirrors libsignal-java
            # `SessionState.clearUnacknowledgedPreKeyMessage`. Higher
            # layers (e.g. `Whatsmeow.Signal.Decrypt`) persist the
            # returned session; clearing here means every wire-level
            # decrypt success is authoritative, regardless of caller.
            #
            # `Map.put/3` (not struct-update `%{sess | ...}`) so the
            # clear is safe against `%Session{}` records persisted
            # before this field existed — those legacy structs lack the
            # `:pending_pre_key` key and the `%{m | k: v}` form raises
            # KeyError, which on the inbound path silently downgrades
            # every decrypt to `UndecryptableMessage`.
            {:ok, plain} -> {:ok, plain, Map.put(sess, :pending_pre_key, nil)}
            {:error, reason} -> {:error, reason}
          end

        err ->
          {:error, {:aes, err}}
      end
    end
  end

  defp wrap_wire_error({:ok, _} = ok), do: ok
  defp wrap_wire_error({:ok, _, _, _} = ok), do: ok
  defp wrap_wire_error({:error, reason}), do: {:error, {:wire_decode, reason}}
end
