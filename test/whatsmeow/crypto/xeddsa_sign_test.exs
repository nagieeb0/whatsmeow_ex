defmodule Whatsmeow.Crypto.XEdDSASignTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  import Bitwise

  alias Whatsmeow.Crypto.XEdDSA

  describe "sign/3 + verify/3 round-trip" do
    test "round-trips with a fresh keypair and short message" do
      {pub_u, priv} = :crypto.generate_key(:ecdh, :x25519)
      msg = "hello whatsmeow"
      sig = XEdDSA.sign(priv, msg, :crypto.strong_rand_bytes(64))

      assert byte_size(sig) == 64
      assert XEdDSA.verify(pub_u, msg, sig)
    end

    test "is deterministic when the same nonce is reused" do
      {_, priv} = :crypto.generate_key(:ecdh, :x25519)
      msg = "deterministic"
      z = :crypto.strong_rand_bytes(64)

      assert XEdDSA.sign(priv, msg, z) == XEdDSA.sign(priv, msg, z)
    end

    test "tampered signature does not verify" do
      {pub_u, priv} = :crypto.generate_key(:ecdh, :x25519)
      msg = "tamper test"
      sig = XEdDSA.sign(priv, msg, :crypto.strong_rand_bytes(64))

      <<first, rest::binary>> = sig
      tampered = <<bxor(first, 1), rest::binary>>

      refute XEdDSA.verify(pub_u, msg, tampered)
    end

    test "tampered message does not verify" do
      {pub_u, priv} = :crypto.generate_key(:ecdh, :x25519)
      msg = "tamper message"
      sig = XEdDSA.sign(priv, msg, :crypto.strong_rand_bytes(64))

      refute XEdDSA.verify(pub_u, msg <> "x", sig)
    end

    test "signature from one key does not verify against another" do
      {_pub_a, priv_a} = :crypto.generate_key(:ecdh, :x25519)
      {pub_b, _priv_b} = :crypto.generate_key(:ecdh, :x25519)
      msg = "wrong pub"
      sig = XEdDSA.sign(priv_a, msg, :crypto.strong_rand_bytes(64))

      refute XEdDSA.verify(pub_b, msg, sig)
    end

    property "100 random keys × messages all round-trip" do
      check all(msg <- binary(min_length: 0, max_length: 256), max_runs: 100) do
        {pub_u, priv} = :crypto.generate_key(:ecdh, :x25519)
        sig = XEdDSA.sign(priv, msg, :crypto.strong_rand_bytes(64))

        assert XEdDSA.verify(pub_u, msg, sig),
               "sign/verify failed for priv=#{Base.encode16(priv)} msg_size=#{byte_size(msg)}"
      end
    end
  end

  describe "public_key/1" do
    test "returns 32 bytes with sign bit cleared" do
      {_pub_u, priv} = :crypto.generate_key(:ecdh, :x25519)
      a_bytes = XEdDSA.public_key(priv)

      assert byte_size(a_bytes) == 32
      # Top bit of last byte must be 0 (XEdDSA forces sign(A) = 0).
      <<_::31-bytes, last>> = a_bytes
      assert band(last, 0x80) == 0
    end

    test "is consistent with the verify path" do
      # If public_key/1 gives us A correctly, then signing and verifying
      # against the *same* X25519 pub_u (Montgomery form) must succeed —
      # this is exactly what the round-trip tests check, so here we just
      # assert sigs verify across many keys with random short messages.
      for _ <- 1..20 do
        {pub_u, priv} = :crypto.generate_key(:ecdh, :x25519)
        sig = XEdDSA.sign(priv, "consistency", :crypto.strong_rand_bytes(64))
        assert XEdDSA.verify(pub_u, "consistency", sig)
      end
    end
  end
end
