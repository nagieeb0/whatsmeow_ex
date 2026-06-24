defmodule Whatsmeow.Signal.Wire do
  @moduledoc """
  Wire-format codec for libsignal's `SignalMessage` and
  `PreKeySignalMessage` — the protobuf envelopes carried inside a
  WhatsApp `<enc>` element.

  Direct port of [libsignal-protocol-java's WhisperTextProtocol.proto](https://github.com/signalapp/libsignal-protocol-java/blob/master/protobuf/WhisperTextProtocol.proto)
  using the `:protobuf` DSL.

  ## Wire shape

  Both envelopes prefix the protobuf bytes with a version byte. The
  high nibble is the current protocol version (3) and the low nibble is
  the minimum supported by the sender (3), giving `0x33`.

      SignalMessage:        <version_byte=0x33> || protobuf || mac[0..7]
      PreKeySignalMessage:  <version_byte=0x33> || protobuf

  The 8-byte truncated HMAC-SHA256 on `SignalMessage` is over:

      mac_key || sender_identity_pub || receiver_identity_pub
        || version_byte || protobuf

  The MAC key is the same `mk` derived for the ratchet message (see
  `Whatsmeow.Signal.Ratchet.derive_message_keys/1`). `PreKeySignalMessage`
  has no outer MAC — its `message` field carries a fully-MAC'd
  `SignalMessage` envelope.
  """

  @signal_version_byte 0x33

  defmodule SignalMessage do
    @moduledoc "Protobuf envelope for a Double Ratchet message — `WhisperTextProtocol.SignalMessage`."
    use Protobuf, syntax: :proto2

    field(:ratchetKey, 1, optional: true, type: :bytes)
    field(:counter, 2, optional: true, type: :uint32)
    field(:previousCounter, 3, optional: true, type: :uint32)
    field(:ciphertext, 4, optional: true, type: :bytes)
  end

  defmodule PreKeySignalMessage do
    @moduledoc "Protobuf envelope for an X3DH-bootstrap message — `WhisperTextProtocol.PreKeySignalMessage`."
    use Protobuf, syntax: :proto2

    field(:preKeyId, 1, optional: true, type: :uint32)
    field(:baseKey, 2, optional: true, type: :bytes)
    field(:identityKey, 3, optional: true, type: :bytes)
    field(:message, 4, optional: true, type: :bytes)
    field(:registrationId, 5, optional: true, type: :uint32)
    field(:signedPreKeyId, 6, optional: true, type: :uint32)
  end

  @doc "The single-byte protocol-version prefix used on every Signal envelope."
  @spec version_byte() :: 0x33
  def version_byte, do: @signal_version_byte

  @djb_type 0x05

  @doc """
  Strip the leading `0x05` `DjbType` byte that libsignal prepends to every
  X25519 public key on the wire (`PreKeySignalMessage.{identityKey,baseKey}`
  and `SignalMessage.ratchetKey` all carry it).

  Returns the raw 32-byte X25519 public key, or `nil` if the input is
  neither the expected `<<0x05, key::32>>` nor a bare 32-byte key.

  Mirrors libsignal-protocol-java's `Curve.decodePoint`.
  """
  @spec strip_djb_type(binary()) :: <<_::256>> | nil
  def strip_djb_type(<<@djb_type, key::binary-size(32)>>), do: key
  def strip_djb_type(<<key::binary-size(32)>>), do: key
  def strip_djb_type(_), do: nil

  @doc "Prepend the `0x05` DjbType byte for outbound wire encoding."
  @spec with_djb_type(<<_::256>>) :: <<_::264>>
  def with_djb_type(<<key::binary-size(32)>>), do: <<@djb_type, key::binary>>

  # --- SignalMessage envelope ----------------------------------------------

  @doc """
  Decode a SignalMessage envelope: `<<0x33>> || proto || mac[8]`.

  Returns `{:ok, %SignalMessage{}, mac_input}` where `mac_input` is the
  contiguous `<<0x33>> || proto` payload — feed it to the MAC verifier
  alongside the sender + receiver identity keys.
  """
  @spec decode_signal_message(binary()) ::
          {:ok, SignalMessage.t(), mac_input :: binary(), mac :: binary()}
          | {:error, atom()}
  def decode_signal_message(envelope) when is_binary(envelope) do
    cond do
      byte_size(envelope) < 1 + 8 ->
        {:error, :envelope_too_short}

      :binary.first(envelope) != @signal_version_byte ->
        {:error, {:bad_version_byte, :binary.first(envelope)}}

      true ->
        mac = binary_part(envelope, byte_size(envelope) - 8, 8)
        mac_input = binary_part(envelope, 0, byte_size(envelope) - 8)
        proto = binary_part(envelope, 1, byte_size(envelope) - 1 - 8)

        case safe_decode(SignalMessage, proto) do
          {:ok, msg} -> {:ok, msg, mac_input, mac}
          err -> err
        end
    end
  end

  @doc """
  Encode a `%SignalMessage{}` into the wire envelope, taking the
  caller-computed 8-byte HMAC.
  """
  @spec encode_signal_message(SignalMessage.t(), <<_::64>>) :: binary()
  def encode_signal_message(%SignalMessage{} = msg, mac) when byte_size(mac) == 8 do
    proto = IO.iodata_to_binary(SignalMessage.encode(msg))
    <<@signal_version_byte>> <> proto <> mac
  end

  @doc """
  Compute the 8-byte truncated HMAC-SHA256 over

      mac_key ‖ DJB(sender_id_pub) ‖ DJB(receiver_id_pub) ‖ version_byte ‖ proto

  where `DJB(k) = 0x05 ‖ k` — libsignal serializes every X25519 public key
  with the leading DjbType byte before feeding it into the MAC.
  `mac_input` is the wire envelope minus the trailing 8-byte mac.

  Pass **raw 32-byte** identity keys (the form we store on the Device
  row); the function adds the DjbType prefix internally so calls stay
  symmetric with how we manage keys everywhere else.

  Mirrors libsignal-protocol-java's `SignalMessage.getMac`.
  """
  @spec compute_mac(<<_::256>>, <<_::256>>, <<_::256>>, binary()) :: <<_::64>>
  def compute_mac(mac_key, sender_identity_pub, receiver_identity_pub, mac_input)
      when byte_size(mac_key) == 32 and byte_size(sender_identity_pub) == 32 and
             byte_size(receiver_identity_pub) == 32 and is_binary(mac_input) do
    :crypto.mac(
      :hmac,
      :sha256,
      mac_key,
      [
        with_djb_type(sender_identity_pub),
        with_djb_type(receiver_identity_pub),
        mac_input
      ]
    )
    |> :binary.part(0, 8)
  end

  # --- PreKeySignalMessage envelope ----------------------------------------

  @doc """
  Decode a PreKeySignalMessage envelope: `<<0x33>> || proto`. The inner
  `:message` field is itself a fully-MAC'd `SignalMessage` envelope ready
  for `decode_signal_message/1`.
  """
  @spec decode_prekey_signal_message(binary()) :: {:ok, PreKeySignalMessage.t()} | {:error, atom()}
  def decode_prekey_signal_message(envelope) when is_binary(envelope) do
    cond do
      byte_size(envelope) < 1 ->
        {:error, :envelope_too_short}

      :binary.first(envelope) != @signal_version_byte ->
        {:error, {:bad_version_byte, :binary.first(envelope)}}

      true ->
        proto = binary_part(envelope, 1, byte_size(envelope) - 1)
        safe_decode(PreKeySignalMessage, proto)
    end
  end

  @doc "Encode a `%PreKeySignalMessage{}` (no outer MAC — inner `:message` already has one)."
  @spec encode_prekey_signal_message(PreKeySignalMessage.t()) :: binary()
  def encode_prekey_signal_message(%PreKeySignalMessage{} = msg) do
    proto = IO.iodata_to_binary(PreKeySignalMessage.encode(msg))
    <<@signal_version_byte>> <> proto
  end

  # --- internals -----------------------------------------------------------

  defp safe_decode(mod, bin) do
    {:ok, mod.decode(bin)}
  rescue
    e -> {:error, {:proto_decode, Exception.message(e)}}
  end
end
