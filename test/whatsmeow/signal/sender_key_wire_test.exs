defmodule Whatsmeow.Signal.SenderKeyWireTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Signal.SenderKeyWire
  alias Whatsmeow.Signal.SenderKeyWire.{SenderKeyDistributionMessage, SenderKeyMessage}

  describe "SenderKeyMessage round-trip" do
    test "encode → decode preserves fields + signature" do
      msg = %SenderKeyMessage{
        id: 0xCAFE_BABE,
        iteration: 7,
        ciphertext: :crypto.strong_rand_bytes(64)
      }

      sig = :crypto.strong_rand_bytes(64)
      env = SenderKeyWire.encode_sender_key_message(msg, sig)

      assert :binary.first(env) == 0x33

      assert {:ok, decoded, signed_input, sig_back} =
               SenderKeyWire.decode_sender_key_message(env)

      assert decoded.id == msg.id
      assert decoded.iteration == msg.iteration
      assert decoded.ciphertext == msg.ciphertext
      assert sig_back == sig
      # signed_input is exactly version_byte ‖ proto (envelope minus the 64-byte sig).
      assert byte_size(signed_input) == byte_size(env) - 64
    end

    test "short envelope is rejected" do
      assert {:error, :envelope_too_short} =
               SenderKeyWire.decode_sender_key_message(<<0x33, 0x00>>)
    end

    test "bad version byte is rejected" do
      # 65 zero bytes — long enough but wrong version.
      bad = <<0x00, 0::64*8>>
      assert {:error, {:bad_version_byte, 0x00}} = SenderKeyWire.decode_sender_key_message(bad)
    end
  end

  describe "SenderKeyDistributionMessage round-trip" do
    test "encode → decode preserves all fields" do
      dist = %SenderKeyDistributionMessage{
        id: 42,
        iteration: 0,
        chainKey: :crypto.strong_rand_bytes(32),
        signingKey: :crypto.strong_rand_bytes(33)
      }

      env = SenderKeyWire.encode_sender_key_distribution_message(dist)

      assert :binary.first(env) == 0x33

      assert {:ok, decoded} = SenderKeyWire.decode_sender_key_distribution_message(env)

      assert decoded.id == dist.id
      assert decoded.iteration == dist.iteration
      assert decoded.chainKey == dist.chainKey
      assert decoded.signingKey == dist.signingKey
    end
  end
end
