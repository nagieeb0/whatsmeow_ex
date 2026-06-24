defmodule Whatsmeow.Signal.GroupDecryptTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Signal.{GroupDecrypt, GroupSession, SenderKeyWire}
  alias Whatsmeow.Signal.SenderKeyWire.SenderKeyDistributionMessage

  describe "GroupSession.from_distribution/1" do
    test "seeds receive-side session from a sender's SKDM" do
      sender = GroupSession.new(0x1234)
      dist = GroupSession.to_distribution(sender)

      assert {:ok, %GroupSession{} = receiver} = GroupSession.from_distribution(dist)
      assert receiver.id == sender.id
      assert receiver.chain_key == sender.chain_key
      assert receiver.iteration == sender.iteration
      assert receiver.signing_pub == sender.signing_pub
      # Receive-side never carries the private signing key.
      assert receiver.signing_priv == nil
    end

    test "rejects an SKDM with a missing signing key" do
      assert {:error, :bad_signing_key} =
               GroupSession.from_distribution(%SenderKeyDistributionMessage{
                 id: 1,
                 iteration: 0,
                 chainKey: :crypto.strong_rand_bytes(32),
                 signingKey: nil
               })
    end

    test "rejects an SKDM with the wrong-sized chain key" do
      assert {:error, :bad_chain_key} =
               GroupSession.from_distribution(%SenderKeyDistributionMessage{
                 id: 1,
                 iteration: 0,
                 chainKey: :crypto.strong_rand_bytes(31),
                 signingKey: Whatsmeow.Signal.Wire.with_djb_type(:crypto.strong_rand_bytes(32))
               })
    end
  end

  describe "encrypt → decrypt round-trip" do
    test "single message decrypts to the original plaintext" do
      sender = GroupSession.new(7)
      {:ok, receiver} = GroupSession.from_distribution(GroupSession.to_distribution(sender))

      {envelope, _sender2} = GroupDecrypt.encrypt_envelope(sender, "hello group")

      assert {:ok, "hello group", %GroupSession{iteration: 1}} =
               GroupDecrypt.decrypt_envelope(envelope, receiver)
    end

    test "multi-message in-order delivery advances iteration" do
      sender = GroupSession.new(42)
      {:ok, receiver} = GroupSession.from_distribution(GroupSession.to_distribution(sender))

      {env1, sender} = GroupDecrypt.encrypt_envelope(sender, "msg-1")
      {env2, sender} = GroupDecrypt.encrypt_envelope(sender, "msg-2")
      {env3, _sender} = GroupDecrypt.encrypt_envelope(sender, "msg-3")

      assert {:ok, "msg-1", receiver} = GroupDecrypt.decrypt_envelope(env1, receiver)
      assert receiver.iteration == 1
      assert {:ok, "msg-2", receiver} = GroupDecrypt.decrypt_envelope(env2, receiver)
      assert receiver.iteration == 2
      assert {:ok, "msg-3", receiver} = GroupDecrypt.decrypt_envelope(env3, receiver)
      assert receiver.iteration == 3
    end

    test "out-of-order delivery uses the skipped-key cache" do
      sender = GroupSession.new(99)
      {:ok, receiver} = GroupSession.from_distribution(GroupSession.to_distribution(sender))

      {env1, sender} = GroupDecrypt.encrypt_envelope(sender, "one")
      {env2, sender} = GroupDecrypt.encrypt_envelope(sender, "two")
      {env3, _sender} = GroupDecrypt.encrypt_envelope(sender, "three")

      # Arrive 3rd first → 1st → 2nd. Receiver must cache the skipped keys.
      assert {:ok, "three", receiver} = GroupDecrypt.decrypt_envelope(env3, receiver)
      # Iteration leaped to 3 internally; both intermediate keys are cached.
      assert map_size(receiver.skipped_keys) == 2

      assert {:ok, "one", receiver} = GroupDecrypt.decrypt_envelope(env1, receiver)
      assert {:ok, "two", receiver} = GroupDecrypt.decrypt_envelope(env2, receiver)
      assert map_size(receiver.skipped_keys) == 0
    end

    test "replay of the same envelope fails" do
      sender = GroupSession.new(11)
      {:ok, receiver} = GroupSession.from_distribution(GroupSession.to_distribution(sender))
      {envelope, _sender} = GroupDecrypt.encrypt_envelope(sender, "once")

      assert {:ok, "once", receiver} = GroupDecrypt.decrypt_envelope(envelope, receiver)

      assert {:error, :duplicate_message} =
               GroupDecrypt.decrypt_envelope(envelope, receiver)
    end
  end

  describe "signature verification" do
    test "a tampered trailing signature fails the verify check" do
      sender = GroupSession.new(5)
      {:ok, receiver} = GroupSession.from_distribution(GroupSession.to_distribution(sender))

      {envelope, _sender2} = GroupDecrypt.encrypt_envelope(sender, "trusted payload")

      # Flip one bit inside the trailing 64-byte signature. The proto still
      # decodes, but XEdDSA.verify must reject.
      sig_offset = byte_size(envelope) - 64
      <<head::binary-size(sig_offset), first_sig_byte, rest::binary>> = envelope
      tampered = head <> <<Bitwise.bxor(first_sig_byte, 0x01)>> <> rest

      assert {:error, :bad_signature} = GroupDecrypt.decrypt_envelope(tampered, receiver)
    end

    test "envelope signed with a different key fails verify" do
      sender = GroupSession.new(5)
      # Receiver was seeded from a *different* sender, so the signing pub
      # won't match.
      other_sender = GroupSession.new(5)
      {:ok, receiver} = GroupSession.from_distribution(GroupSession.to_distribution(other_sender))
      {envelope, _} = GroupDecrypt.encrypt_envelope(sender, "wrong signer")

      assert {:error, :bad_signature} = GroupDecrypt.decrypt_envelope(envelope, receiver)
    end
  end

  describe "wire envelope shape" do
    test "envelope is exactly version_byte || proto || 64-byte sig" do
      sender = GroupSession.new(1)
      {envelope, _} = GroupDecrypt.encrypt_envelope(sender, "x")

      assert :binary.first(envelope) == SenderKeyWire.version_byte()
      assert byte_size(envelope) > 1 + 64
    end

    test "distribution-message wire prefixes signing key with 0x05" do
      sender = GroupSession.new(2)
      dist = GroupSession.to_distribution(sender)

      assert <<0x05, raw_pub::binary-size(32)>> = dist.signingKey
      assert raw_pub == sender.signing_pub
    end
  end

  describe "Curve25519 keypair sanity" do
    test "to_distribution / from_distribution preserves XEdDSA verify chain" do
      # Generate explicitly so we can prove the signing key derives the same
      # signing pub on both sides.
      {pub, priv} = Curve25519.generate_keypair()
      assert byte_size(pub) == 32
      assert byte_size(priv) == 32

      gs = %GroupSession{
        id: 0,
        chain_key: :crypto.strong_rand_bytes(32),
        iteration: 0,
        signing_pub: pub,
        signing_priv: priv,
        skipped_keys: %{}
      }

      {env, _gs2} = GroupDecrypt.encrypt_envelope(gs, "verify me")

      {:ok, recv} = GroupSession.from_distribution(GroupSession.to_distribution(gs))
      assert {:ok, "verify me", _} = GroupDecrypt.decrypt_envelope(env, recv)
    end
  end
end
