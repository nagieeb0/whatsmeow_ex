defmodule Whatsmeow.KeysTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Keys
  alias Whatsmeow.Keys.{KeyPair, PreKey}

  describe "generate_keypair/0" do
    test "returns a KeyPair with 32-byte public and private fields" do
      kp = Keys.generate_keypair()
      assert %KeyPair{public: pub, private: priv} = kp
      assert byte_size(pub) == 32
      assert byte_size(priv) == 32
    end
  end

  describe "keypair_from_private/1" do
    test "reconstructs the same public key" do
      %KeyPair{public: pub, private: priv} = Keys.generate_keypair()
      reconstructed = Keys.keypair_from_private(priv)
      assert reconstructed.public == pub
      assert reconstructed.private == priv
    end
  end

  describe "generate_pre_key/1" do
    test "returns a PreKey with given id, no signature" do
      assert %PreKey{id: 7, key_pair: %KeyPair{}, signature: nil} = Keys.generate_pre_key(7)
    end
  end

  describe "generate_signed_pre_key/2" do
    test "attaches a 64-byte signature derived from identity private" do
      identity = Keys.generate_keypair()
      spk = Keys.generate_signed_pre_key(identity, 1)
      assert %PreKey{id: 1, key_pair: %KeyPair{}, signature: sig} = spk
      assert byte_size(sig) == 64
    end
  end
end
