defmodule Whatsmeow.Signal.WireDecryptTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.{AES, Curve25519}
  alias Whatsmeow.MessagePadding
  alias Whatsmeow.Signal.{Ratchet, Session, Wire, WireDecrypt, X3DH}
  alias Whatsmeow.Signal.Wire.{PreKeySignalMessage, SignalMessage}

  # Build a SignalMessage envelope the way an initiator would after
  # X3DH + first ratchet step: encrypt with the new sending chain's
  # message key, MAC with libsignal's formula.
  defp build_initiator_envelope(plaintext, sess, sender_id_pub, receiver_id_pub) do
    {next_ck, mk} = Ratchet.kdf_ck(sess.sending_ck)
    {enc_key, mac_key, iv} = Ratchet.derive_message_keys(mk)

    padded = MessagePadding.pad(plaintext)
    ct = AES.CBC.encrypt(enc_key, iv, padded)

    {our_pub, _} = sess.dh_self

    # Libsignal prepends the 0x05 DjbType byte to any X25519 public on the
    # wire. WireDecrypt strips it before the DH step.
    msg = %SignalMessage{
      ratchetKey: Wire.with_djb_type(our_pub),
      counter: sess.sending_n,
      previousCounter: sess.previous_n,
      ciphertext: ct
    }

    # encode without mac, compute mac, then re-encode with mac
    placeholder = Wire.encode_signal_message(msg, <<0::64>>)
    mac_input = binary_part(placeholder, 0, byte_size(placeholder) - 8)
    mac = Wire.compute_mac(mac_key, sender_id_pub, receiver_id_pub, mac_input)
    envelope = Wire.encode_signal_message(msg, mac)

    new_sess = %Session{sess | sending_ck: next_ck, sending_n: sess.sending_n + 1}
    {envelope, new_sess}
  end

  describe "end-to-end: initiator sends pkmsg → responder decrypts" do
    test "first PreKeySignalMessage decrypts to the original plaintext" do
      # --- Identity material on both sides ---
      {alice_id_pub, alice_id_priv} = Curve25519.generate_keypair()
      {alice_eph_pub, alice_eph_priv} = Curve25519.generate_keypair()

      {bob_id_pub, bob_id_priv} = Curve25519.generate_keypair()
      {bob_spk_pub, bob_spk_priv} = Curve25519.generate_keypair()
      {bob_opk_pub, bob_opk_priv} = Curve25519.generate_keypair()

      # --- Alice (initiator) computes X3DH and bootstraps her session ---
      rk = X3DH.initiator_agree(alice_id_priv, alice_eph_priv, bob_id_pub, bob_spk_pub, bob_opk_pub)

      # First ratchet step: Alice generates her ratchet keypair, mixes
      # DH(her_ratchet_priv, bob's signed pre-key pub) into the root.
      alice_ratchet_kp = Curve25519.generate_keypair()
      {alice_ratchet_pub, alice_ratchet_priv} = alice_ratchet_kp
      shared = Curve25519.agree(alice_ratchet_priv, bob_spk_pub)
      {new_rk, send_ck} = Ratchet.kdf_rk(rk, shared)

      alice_sess = %Session{
        dh_self: alice_ratchet_kp,
        dh_remote: bob_spk_pub,
        root_key: new_rk,
        sending_ck: send_ck,
        receiving_ck: nil,
        sending_n: 0,
        previous_n: 0
      }

      # --- Alice encrypts a message + wraps it in a PreKeySignalMessage ---
      plaintext = "hello from alice"

      {inner_envelope, _alice_sess2} =
        build_initiator_envelope(plaintext, alice_sess, alice_id_pub, bob_id_pub)

      pkmsg = %PreKeySignalMessage{
        preKeyId: 7,
        baseKey: Wire.with_djb_type(alice_eph_pub),
        identityKey: Wire.with_djb_type(alice_id_pub),
        message: inner_envelope,
        registrationId: 1234,
        signedPreKeyId: 1
      }

      wire_envelope = Wire.encode_prekey_signal_message(pkmsg)

      # --- Bob receives + decrypts ---
      assert {:ok, decoded_plain, _bob_sess, %PreKeySignalMessage{preKeyId: 7}} =
               WireDecrypt.decrypt_prekey_envelope(
                 wire_envelope,
                 bob_id_priv,
                 bob_spk_priv,
                 bob_opk_priv
               )

      assert decoded_plain == plaintext

      # Avoid unused-binding warnings.
      _ = {alice_id_pub, bob_id_pub, alice_ratchet_pub, alice_id_priv, alice_eph_priv}
      _ = {bob_opk_pub, alice_id_priv}
    end

    test "wrong identity key on receiver side fails MAC check" do
      {alice_id_pub, alice_id_priv} = Curve25519.generate_keypair()
      {alice_eph_pub, alice_eph_priv} = Curve25519.generate_keypair()
      {bob_id_pub, bob_id_priv} = Curve25519.generate_keypair()
      {bob_spk_pub, bob_spk_priv} = Curve25519.generate_keypair()

      rk = X3DH.initiator_agree(alice_id_priv, alice_eph_priv, bob_id_pub, bob_spk_pub, nil)
      alice_ratchet_kp = Curve25519.generate_keypair()
      {_, alice_ratchet_priv} = alice_ratchet_kp
      shared = Curve25519.agree(alice_ratchet_priv, bob_spk_pub)
      {new_rk, send_ck} = Ratchet.kdf_rk(rk, shared)

      alice_sess = %Session{
        dh_self: alice_ratchet_kp,
        dh_remote: bob_spk_pub,
        root_key: new_rk,
        sending_ck: send_ck,
        sending_n: 0,
        previous_n: 0
      }

      # Alice signs the MAC against bob's identity. We then ask Bob to
      # decrypt — but pretend his identity is a DIFFERENT key.
      {inner, _} = build_initiator_envelope("hello", alice_sess, alice_id_pub, bob_id_pub)

      pkmsg = %PreKeySignalMessage{
        baseKey: Wire.with_djb_type(alice_eph_pub),
        identityKey: Wire.with_djb_type(alice_id_pub),
        message: inner,
        registrationId: 1,
        signedPreKeyId: 1
      }

      envelope = Wire.encode_prekey_signal_message(pkmsg)

      # Swap bob's identity priv for a different one — MAC must fail.
      {_, wrong_bob_priv} = Curve25519.generate_keypair()

      assert {:error, :mac_mismatch} =
               WireDecrypt.decrypt_prekey_envelope(envelope, wrong_bob_priv, bob_spk_priv, nil)
    end

    test "tampered ciphertext fails padding/MAC" do
      {alice_id_pub, alice_id_priv} = Curve25519.generate_keypair()
      {alice_eph_pub, alice_eph_priv} = Curve25519.generate_keypair()
      {bob_id_pub, bob_id_priv} = Curve25519.generate_keypair()
      {bob_spk_pub, bob_spk_priv} = Curve25519.generate_keypair()

      rk = X3DH.initiator_agree(alice_id_priv, alice_eph_priv, bob_id_pub, bob_spk_pub, nil)
      alice_ratchet_kp = Curve25519.generate_keypair()
      {_, alice_ratchet_priv} = alice_ratchet_kp
      shared = Curve25519.agree(alice_ratchet_priv, bob_spk_pub)
      {new_rk, send_ck} = Ratchet.kdf_rk(rk, shared)

      alice_sess = %Session{
        dh_self: alice_ratchet_kp,
        dh_remote: bob_spk_pub,
        root_key: new_rk,
        sending_ck: send_ck,
        sending_n: 0,
        previous_n: 0
      }

      {inner, _} = build_initiator_envelope("hello", alice_sess, alice_id_pub, bob_id_pub)

      # Flip a byte in the MAC. (Last 8 bytes of `inner` are the wire MAC.)
      <<head::binary-size(byte_size(inner) - 1), last>> = inner
      tampered_inner = head <> <<Bitwise.bxor(last, 0xFF)>>

      pkmsg = %PreKeySignalMessage{
        baseKey: Wire.with_djb_type(alice_eph_pub),
        identityKey: Wire.with_djb_type(alice_id_pub),
        message: tampered_inner,
        registrationId: 1,
        signedPreKeyId: 1
      }

      envelope = Wire.encode_prekey_signal_message(pkmsg)

      assert {:error, :mac_mismatch} =
               WireDecrypt.decrypt_prekey_envelope(envelope, bob_id_priv, bob_spk_priv, nil)
    end
  end

  describe "decrypt_signal_envelope/4 — wrong-shape inputs" do
    test "bad version byte propagates :wire_decode" do
      sess = %Session{root_key: <<0::256>>, receiving_ck: <<0::256>>, receiving_n: 0}
      bogus = <<0x22>> <> :binary.copy(<<0>>, 40)

      assert {:error, {:wire_decode, {:bad_version_byte, 0x22}}} =
               WireDecrypt.decrypt_signal_envelope(bogus, sess, <<0::256>>, <<0::256>>)
    end
  end
end
