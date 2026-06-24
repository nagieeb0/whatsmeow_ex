defmodule Whatsmeow.Signal.SenderKeyWire do
  @moduledoc """
  libsignal-wire codec for `SenderKeyMessage` and
  `SenderKeyDistributionMessage` — the protobuf envelopes carried inside
  a WhatsApp `<enc type="skmsg">` (group chats).

  Port of [libsignal-protocol-java's WhisperTextProtocol.proto](https://github.com/signalapp/libsignal-protocol-java/blob/master/protobuf/WhisperTextProtocol.proto)
  for the group-cipher half. Mirrors the existing `Whatsmeow.Signal.Wire`
  module for 1:1 messages.

  ## Wire shape

  Same `0x33` version-byte prefix as 1:1; `SenderKeyMessage` carries a
  trailing 64-byte Ed25519/XEdDSA signature instead of an HMAC:

      SenderKeyMessage:
        <version_byte=0x33> ‖ protobuf ‖ signature[64]

      SenderKeyDistributionMessage:
        <version_byte=0x33> ‖ protobuf

  The signature is over `version_byte ‖ protobuf` and is verified
  against the sender's `signingKey` (carried in the matching
  distribution message).

  ## Pipeline (decode-side)

  1. Receive `<enc type="skmsg">` envelope in a `<message>` from a
     group JID. Strip version byte, split signature.
  2. Look up the `%SenderKeyState{}` for `(our_jid, group_jid, sender_jid)`
     in `whatsmeow_sender_keys`. Verify the signature against the
     stored `signingKeyPub`.
  3. Advance the chain key to `iteration`, derive message key, AES-CBC
     decrypt. The first message for a new (sender, group) pair must
     have been preceded by a `<enc type="msg">` carrying a
     `senderKeyDistributionMessage` inside — that's what seeds the
     SenderKeyState.

  Today this module ships the wire codec + skeleton; the ratchet math
  + signature verification live in follow-up work (see
  `Whatsmeow.Signal.GroupCipher` for the home-grown variant we already
  have, which will be retrofitted to this wire format).
  """

  @signal_version_byte 0x33

  defmodule SenderKeyMessage do
    @moduledoc "Protobuf envelope for a group message — `WhisperTextProtocol.SenderKeyMessage`."
    use Protobuf, syntax: :proto2

    field(:id, 1, optional: true, type: :uint32)
    field(:iteration, 2, optional: true, type: :uint32)
    field(:ciphertext, 3, optional: true, type: :bytes)
  end

  defmodule SenderKeyDistributionMessage do
    @moduledoc "Protobuf envelope for a sender-key handoff — `WhisperTextProtocol.SenderKeyDistributionMessage`."
    use Protobuf, syntax: :proto2

    field(:id, 1, optional: true, type: :uint32)
    field(:iteration, 2, optional: true, type: :uint32)
    field(:chainKey, 3, optional: true, type: :bytes)
    field(:signingKey, 4, optional: true, type: :bytes)
  end

  @doc "The single-byte protocol-version prefix used on every Signal envelope."
  @spec version_byte() :: 0x33
  def version_byte, do: @signal_version_byte

  # --- SenderKeyMessage envelope ------------------------------------------

  @doc """
  Decode a `<enc type="skmsg">` envelope: `<<0x33>> || proto || sig[64]`.

  Returns `{:ok, %SenderKeyMessage{}, signed_input, signature}` so the
  caller can run `XEdDSA.verify/3` against the sender's signing pub.
  """
  @spec decode_sender_key_message(binary()) ::
          {:ok, SenderKeyMessage.t(), signed_input :: binary(), signature :: <<_::512>>}
          | {:error, atom()}
  def decode_sender_key_message(envelope) when is_binary(envelope) do
    cond do
      byte_size(envelope) < 1 + 64 ->
        {:error, :envelope_too_short}

      :binary.first(envelope) != @signal_version_byte ->
        {:error, {:bad_version_byte, :binary.first(envelope)}}

      true ->
        sig = binary_part(envelope, byte_size(envelope) - 64, 64)
        signed_input = binary_part(envelope, 0, byte_size(envelope) - 64)
        proto = binary_part(envelope, 1, byte_size(envelope) - 1 - 64)

        case safe_decode(SenderKeyMessage, proto) do
          {:ok, msg} -> {:ok, msg, signed_input, sig}
          err -> err
        end
    end
  end

  @doc """
  Encode a `%SenderKeyMessage{}` into the wire envelope, taking the
  caller-computed 64-byte XEdDSA signature.
  """
  @spec encode_sender_key_message(SenderKeyMessage.t(), <<_::512>>) :: binary()
  def encode_sender_key_message(%SenderKeyMessage{} = msg, signature)
      when byte_size(signature) == 64 do
    proto = IO.iodata_to_binary(SenderKeyMessage.encode(msg))
    <<@signal_version_byte>> <> proto <> signature
  end

  # --- SenderKeyDistributionMessage envelope ------------------------------

  @doc """
  Decode a `<enc>` carrying a `senderKeyDistributionMessage` proto.

  Distribution messages are sent as part of the inner WaE2E.Message
  (field `senderKeyDistributionMessage`) — they don't get their own
  `<enc type>`, but the inner proto bytes use the same `0x33`-prefixed
  envelope as everything else.
  """
  @spec decode_sender_key_distribution_message(binary()) ::
          {:ok, SenderKeyDistributionMessage.t()} | {:error, atom()}
  def decode_sender_key_distribution_message(envelope) when is_binary(envelope) do
    cond do
      byte_size(envelope) < 1 ->
        {:error, :envelope_too_short}

      :binary.first(envelope) != @signal_version_byte ->
        {:error, {:bad_version_byte, :binary.first(envelope)}}

      true ->
        proto = binary_part(envelope, 1, byte_size(envelope) - 1)
        safe_decode(SenderKeyDistributionMessage, proto)
    end
  end

  @doc "Encode a `%SenderKeyDistributionMessage{}` envelope (no signature)."
  @spec encode_sender_key_distribution_message(SenderKeyDistributionMessage.t()) :: binary()
  def encode_sender_key_distribution_message(%SenderKeyDistributionMessage{} = msg) do
    proto = IO.iodata_to_binary(SenderKeyDistributionMessage.encode(msg))
    <<@signal_version_byte>> <> proto
  end

  # --- internals ----------------------------------------------------------

  defp safe_decode(mod, bin) do
    {:ok, mod.decode(bin)}
  rescue
    e -> {:error, {:proto_decode, Exception.message(e)}}
  end
end
