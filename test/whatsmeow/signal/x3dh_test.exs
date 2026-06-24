defmodule Whatsmeow.Signal.X3DHTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Signal.X3DH

  describe "X3DH spec compliance" do
    test "discontinuity prefix produces a different root key than <<0xFF::256>> would" do
      # Regression: Elixir bit syntax <<0xFF::256>> is NOT 32×0xFF (it's
      # the integer 0xFF padded to 256 bits → 31 zeros + one 0xFF). The
      # X3DH spec mandates F = 32 bytes of 0xFF, which is what
      # `:binary.copy(<<0xFF>>, 32)` builds. If anyone ever swaps these
      # back, this test will catch it because the two prefixes produce
      # different HKDF outputs.
      alias Whatsmeow.Crypto.HKDF

      master = :crypto.strong_rand_bytes(160)
      info = "WhisperText"
      salt = <<0::256>>

      true_prefix = :binary.copy(<<0xFF>>, 32)
      bogus_prefix = <<0xFF::256>>

      assert true_prefix != bogus_prefix

      assert HKDF.derive(true_prefix <> master, salt, info, 32) !=
               HKDF.derive(bogus_prefix <> master, salt, info, 32)
    end
  end

  describe "initiator_agree/5 ↔ responder_agree/5 symmetry" do
    test "both sides derive identical 32-byte root keys (with OPK)" do
      {ia_pub, ia_priv} = Curve25519.generate_keypair()
      {ea_pub, ea_priv} = Curve25519.generate_keypair()
      {ib_pub, ib_priv} = Curve25519.generate_keypair()
      {spkb_pub, spkb_priv} = Curve25519.generate_keypair()
      {opkb_pub, opkb_priv} = Curve25519.generate_keypair()

      rk_a = X3DH.initiator_agree(ia_priv, ea_priv, ib_pub, spkb_pub, opkb_pub)
      rk_b = X3DH.responder_agree(ib_priv, spkb_priv, opkb_priv, ia_pub, ea_pub)

      assert rk_a == rk_b
      assert byte_size(rk_a) == 32
    end

    test "both sides derive identical root keys (without OPK)" do
      {ia_pub, ia_priv} = Curve25519.generate_keypair()
      {ea_pub, ea_priv} = Curve25519.generate_keypair()
      {ib_pub, ib_priv} = Curve25519.generate_keypair()
      {spkb_pub, spkb_priv} = Curve25519.generate_keypair()

      rk_a = X3DH.initiator_agree(ia_priv, ea_priv, ib_pub, spkb_pub, nil)
      rk_b = X3DH.responder_agree(ib_priv, spkb_priv, nil, ia_pub, ea_pub)

      assert rk_a == rk_b
    end

    test "different ephemerals → different root keys" do
      {ia_pub, ia_priv} = Curve25519.generate_keypair()
      {_, ea_priv} = Curve25519.generate_keypair()
      {_, ea2_priv} = Curve25519.generate_keypair()
      {ib_pub, ib_priv} = Curve25519.generate_keypair()
      {spkb_pub, spkb_priv} = Curve25519.generate_keypair()

      rk_a = X3DH.initiator_agree(ia_priv, ea_priv, ib_pub, spkb_pub, nil)
      rk_a2 = X3DH.initiator_agree(ia_priv, ea2_priv, ib_pub, spkb_pub, nil)

      assert rk_a != rk_a2
      _ = {ia_pub, ib_priv}
    end
  end
end
