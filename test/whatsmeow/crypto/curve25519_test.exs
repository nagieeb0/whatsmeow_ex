defmodule Whatsmeow.Crypto.Curve25519Test do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.Curve25519

  describe "RFC 7748 §6.1 X25519 test vectors" do
    # Alice and Bob from the RFC.
    @alice_priv Base.decode16!("77076D0A7318A57D3C16C17251B26645DF4C2F87EBC0992AB177FBA51DB92C2A")
    @alice_pub Base.decode16!("8520F0098930A754748B7DDCB43EF75A0DBF3A0D26381AF4EBA4A98EAA9B4E6A")
    @bob_priv Base.decode16!("5DAB087E624A8A4B79E17F8B83800EE66F3BB1292618B6FD1C2F8B27FF88E0EB")
    @bob_pub Base.decode16!("DE9EDB7D7B7DC1B4D35B61C2ECE435373F8343C85B78674DADFC7E146F882B4F")
    @shared Base.decode16!("4A5D9D5BA4CE2DE1728E3BF480350F25E07E21C947D19E3376F09B3C1E161742")

    test "public_for/1 derives Alice's public from Alice's private" do
      assert Curve25519.public_for(@alice_priv) == @alice_pub
    end

    test "public_for/1 derives Bob's public from Bob's private" do
      assert Curve25519.public_for(@bob_priv) == @bob_pub
    end

    test "agree/2 produces the shared secret from Alice's side" do
      assert Curve25519.agree(@alice_priv, @bob_pub) == @shared
    end

    test "agree/2 produces the shared secret from Bob's side" do
      assert Curve25519.agree(@bob_priv, @alice_pub) == @shared
    end
  end

  describe "generate_keypair/0" do
    test "returns 32-byte public and private keys" do
      {pub, priv} = Curve25519.generate_keypair()
      assert byte_size(pub) == 32
      assert byte_size(priv) == 32
    end

    test "two parties can agree on a shared secret" do
      {a_pub, a_priv} = Curve25519.generate_keypair()
      {b_pub, b_priv} = Curve25519.generate_keypair()

      assert Curve25519.agree(a_priv, b_pub) == Curve25519.agree(b_priv, a_pub)
    end
  end
end
