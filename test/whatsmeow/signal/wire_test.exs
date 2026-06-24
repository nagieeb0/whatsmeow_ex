defmodule Whatsmeow.Signal.WireTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Signal.Wire
  alias Whatsmeow.Signal.Wire.{PreKeySignalMessage, SignalMessage}

  describe "SignalMessage envelope" do
    test "encode/decode round-trip preserves all fields" do
      msg = %SignalMessage{
        ratchetKey: :crypto.strong_rand_bytes(32),
        counter: 7,
        previousCounter: 3,
        ciphertext: :crypto.strong_rand_bytes(120)
      }

      mac = :crypto.strong_rand_bytes(8)
      envelope = Wire.encode_signal_message(msg, mac)

      # 0x33 version + proto + 8-byte mac
      assert <<0x33, _rest::binary>> = envelope

      assert {:ok, decoded, _mac_input, ^mac} = Wire.decode_signal_message(envelope)
      assert decoded.ratchetKey == msg.ratchetKey
      assert decoded.counter == msg.counter
      assert decoded.previousCounter == msg.previousCounter
      assert decoded.ciphertext == msg.ciphertext
    end

    test "mac_input is exactly version_byte ‖ proto (no mac trailer)" do
      msg = %SignalMessage{ratchetKey: <<1::256>>, counter: 1, ciphertext: "x"}
      envelope = Wire.encode_signal_message(msg, <<0::64>>)
      {:ok, _, mac_input, _} = Wire.decode_signal_message(envelope)

      assert byte_size(mac_input) == byte_size(envelope) - 8
      assert <<0x33, _::binary>> = mac_input
    end

    test "rejects envelopes shorter than version + mac" do
      assert {:error, :envelope_too_short} = Wire.decode_signal_message(<<0x33, 1, 2, 3>>)
    end

    test "rejects wrong version byte" do
      # 0x22 = pre-v3 wire format we don't support
      bogus = <<0x22>> <> :binary.copy(<<0>>, 30)
      assert {:error, {:bad_version_byte, 0x22}} = Wire.decode_signal_message(bogus)
    end

    test "compute_mac/4 is deterministic and 8 bytes" do
      mac_key = :crypto.strong_rand_bytes(32)
      ours = :crypto.strong_rand_bytes(32)
      theirs = :crypto.strong_rand_bytes(32)
      input = <<0x33, 1, 2, 3, 4, 5>>

      m1 = Wire.compute_mac(mac_key, ours, theirs, input)
      m2 = Wire.compute_mac(mac_key, ours, theirs, input)
      assert m1 == m2
      assert byte_size(m1) == 8
    end
  end

  describe "strip_djb_type/1 + with_djb_type/1 (libsignal X25519 wire prefix)" do
    test "strip_djb_type removes the leading 0x05 byte from a 33-byte wire pubkey" do
      raw = :crypto.strong_rand_bytes(32)
      wire = <<0x05, raw::binary>>
      assert Wire.strip_djb_type(wire) == raw
    end

    test "strip_djb_type passes a bare 32-byte key through unchanged (best-effort)" do
      raw = :crypto.strong_rand_bytes(32)
      assert Wire.strip_djb_type(raw) == raw
    end

    test "strip_djb_type returns nil for malformed inputs" do
      assert Wire.strip_djb_type(<<>>) == nil
      assert Wire.strip_djb_type(<<0x05, 0, 0>>) == nil
      assert Wire.strip_djb_type(:crypto.strong_rand_bytes(40)) == nil
    end

    test "with_djb_type prepends 0x05 so output is 33 bytes" do
      raw = :crypto.strong_rand_bytes(32)
      assert <<0x05, ^raw::binary>> = Wire.with_djb_type(raw)
      assert byte_size(Wire.with_djb_type(raw)) == 33
    end

    test "round-trip: strip(with(x)) == x" do
      raw = :crypto.strong_rand_bytes(32)
      assert raw |> Wire.with_djb_type() |> Wire.strip_djb_type() == raw
    end
  end

  describe "PreKeySignalMessage envelope" do
    test "encode/decode round-trip preserves all fields" do
      inner =
        Wire.encode_signal_message(
          %SignalMessage{ratchetKey: <<1::256>>, counter: 0, ciphertext: "inner"},
          :crypto.strong_rand_bytes(8)
        )

      pkmsg = %PreKeySignalMessage{
        preKeyId: 42,
        baseKey: :crypto.strong_rand_bytes(32),
        identityKey: :crypto.strong_rand_bytes(32),
        message: inner,
        registrationId: 0xDEADBEEF,
        signedPreKeyId: 7
      }

      envelope = Wire.encode_prekey_signal_message(pkmsg)
      assert <<0x33, _rest::binary>> = envelope

      assert {:ok, decoded} = Wire.decode_prekey_signal_message(envelope)
      assert decoded.preKeyId == 42
      assert decoded.signedPreKeyId == 7
      assert decoded.registrationId == 0xDEADBEEF
      assert decoded.baseKey == pkmsg.baseKey
      assert decoded.identityKey == pkmsg.identityKey
      assert decoded.message == inner
    end

    test "tolerates missing optional one-time preKeyId field" do
      pkmsg = %PreKeySignalMessage{
        baseKey: <<1::256>>,
        identityKey: <<2::256>>,
        message: <<0x33, 0>>,
        registrationId: 1,
        signedPreKeyId: 1
        # preKeyId omitted — the wire encodes it as absent
      }

      envelope = Wire.encode_prekey_signal_message(pkmsg)
      assert {:ok, decoded} = Wire.decode_prekey_signal_message(envelope)
      assert decoded.preKeyId == nil
    end

    test "rejects empty envelope" do
      assert {:error, :envelope_too_short} = Wire.decode_prekey_signal_message(<<>>)
    end

    test "rejects wrong version byte" do
      assert {:error, {:bad_version_byte, 0x44}} =
               Wire.decode_prekey_signal_message(<<0x44, 0>>)
    end
  end
end
