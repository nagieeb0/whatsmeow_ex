defmodule Whatsmeow.Signal.WireEncryptTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.PreKeyBundle
  alias Whatsmeow.Signal.{Session, WireDecrypt, WireEncrypt}
  alias Whatsmeow.Signal.Wire.PreKeySignalMessage

  describe "encrypt_prekey_envelope/5 ↔ decrypt_prekey_envelope/4 (Alice → Bob)" do
    test "round-trip text plaintext through PreKeySignalMessage envelope" do
      {alice_id_pub, alice_id_priv} = Curve25519.generate_keypair()

      {bob_id_pub, bob_id_priv} = Curve25519.generate_keypair()
      {bob_spk_pub, bob_spk_priv} = Curve25519.generate_keypair()
      {bob_opk_pub, bob_opk_priv} = Curve25519.generate_keypair()

      bundle = %PreKeyBundle{
        device_id: 1,
        registration_id: 0xCAFE,
        identity_pub: bob_id_pub,
        pre_key_id: 42,
        pre_key_pub: bob_opk_pub,
        signed_pre_key_id: 1,
        signed_pre_key_pub: bob_spk_pub,
        signed_pre_key_sig: :crypto.strong_rand_bytes(64)
      }

      plaintext = "hello from alice (round-trip)"

      {:ok, envelope, _alice_sess} =
        WireEncrypt.encrypt_prekey_envelope(plaintext, alice_id_priv, 0xDEAD_BEEF, bundle)

      {:ok, decoded, _bob_sess, %PreKeySignalMessage{preKeyId: 42, signedPreKeyId: 1}} =
        WireDecrypt.decrypt_prekey_envelope(envelope, bob_id_priv, bob_spk_priv, bob_opk_priv)

      assert decoded == plaintext

      # Touch the bindings so the unused-warning hook stays quiet.
      _ = {alice_id_pub, bob_id_pub}
    end

    test "round-trip without one-time pre-key (OPK exhausted)" do
      {_, alice_id_priv} = Curve25519.generate_keypair()
      {bob_id_pub, bob_id_priv} = Curve25519.generate_keypair()
      {bob_spk_pub, bob_spk_priv} = Curve25519.generate_keypair()

      bundle = %PreKeyBundle{
        device_id: 1,
        registration_id: 7,
        identity_pub: bob_id_pub,
        pre_key_id: nil,
        pre_key_pub: nil,
        signed_pre_key_id: 1,
        signed_pre_key_pub: bob_spk_pub,
        signed_pre_key_sig: :crypto.strong_rand_bytes(64)
      }

      plaintext = "no opk"

      {:ok, envelope, _alice_sess} =
        WireEncrypt.encrypt_prekey_envelope(plaintext, alice_id_priv, 1, bundle)

      assert {:ok, ^plaintext, _bob_sess, %PreKeySignalMessage{}} =
               WireDecrypt.decrypt_prekey_envelope(envelope, bob_id_priv, bob_spk_priv, nil)
    end
  end

  describe "encrypt_signal_envelope/4 ↔ decrypt_signal_envelope/4 (steady-state)" do
    test "after first pkmsg, subsequent msg round-trips through the established session" do
      {alice_id_pub, alice_id_priv} = Curve25519.generate_keypair()
      {bob_id_pub, bob_id_priv} = Curve25519.generate_keypair()
      {bob_spk_pub, bob_spk_priv} = Curve25519.generate_keypair()

      bundle = %PreKeyBundle{
        device_id: 1,
        registration_id: 1,
        identity_pub: bob_id_pub,
        pre_key_id: nil,
        pre_key_pub: nil,
        signed_pre_key_id: 1,
        signed_pre_key_pub: bob_spk_pub,
        signed_pre_key_sig: :crypto.strong_rand_bytes(64)
      }

      # Alice sends pkmsg, Bob receives + establishes session.
      {:ok, pk_envelope, alice_sess_1} =
        WireEncrypt.encrypt_prekey_envelope("msg 1", alice_id_priv, 1, bundle)

      {:ok, "msg 1", _bob_sess_after_pkmsg, _pk} =
        WireDecrypt.decrypt_prekey_envelope(pk_envelope, bob_id_priv, bob_spk_priv, nil)

      # Alice continues with steady-state msg (same session, advanced).
      {:ok, msg_envelope, _alice_sess_2} =
        WireEncrypt.encrypt_signal_envelope("msg 2", alice_sess_1, alice_id_pub, bob_id_pub)

      # Bob needs a session that mirrors Alice's. The simplest path: have
      # Bob re-run the pkmsg pipeline to populate his side, then advance.
      # (Real Bob persists his session after the first pkmsg — covered by
      # the smoke task + Store.Postgres round-trip.)
      {:ok, "msg 1", bob_sess_mirror, _} =
        WireDecrypt.decrypt_prekey_envelope(pk_envelope, bob_id_priv, bob_spk_priv, nil)

      assert {:ok, "msg 2", _bob_sess_after_msg} =
               WireDecrypt.decrypt_signal_envelope(
                 msg_envelope,
                 bob_sess_mirror,
                 bob_id_pub,
                 alice_id_pub
               )
    end

    test "no sending chain returns {:error, :no_sending_chain}" do
      sess = %Session{root_key: <<0::256>>, sending_ck: nil}

      assert {:error, :no_sending_chain} =
               WireEncrypt.encrypt_signal_envelope("x", sess, <<0::256>>, <<0::256>>)
    end
  end
end
