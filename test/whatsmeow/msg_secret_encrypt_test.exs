defmodule Whatsmeow.MsgSecretEncryptTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.MsgSecret

  defp triple do
    %{
      sender: "447400000000@s.whatsapp.net",
      orig_sender: "99999@s.whatsapp.net",
      orig_msg_id: "3EB0ABC123",
      orig_msg_secret: :crypto.strong_rand_bytes(32)
    }
  end

  describe "encrypt/6 + decrypt/7 round-trip" do
    test "poll_vote (AAD present)" do
      t = triple()
      plaintext = "vote-bytes"

      {ct, iv} =
        MsgSecret.encrypt(
          :poll_vote,
          t.sender,
          t.orig_msg_id,
          t.orig_sender,
          t.orig_msg_secret,
          plaintext
        )

      assert byte_size(ct) == byte_size(plaintext) + 16
      assert byte_size(iv) == 12

      assert {:ok, ^plaintext} =
               MsgSecret.decrypt(
                 :poll_vote,
                 t.sender,
                 t.orig_msg_id,
                 t.orig_sender,
                 t.orig_msg_secret,
                 ct,
                 iv
               )
    end

    test "reaction (no AAD)" do
      t = triple()
      plaintext = :crypto.strong_rand_bytes(120)

      {ct, iv} =
        MsgSecret.encrypt(
          :reaction,
          t.sender,
          t.orig_msg_id,
          t.orig_sender,
          t.orig_msg_secret,
          plaintext
        )

      assert {:ok, ^plaintext} =
               MsgSecret.decrypt(
                 :reaction,
                 t.sender,
                 t.orig_msg_id,
                 t.orig_sender,
                 t.orig_msg_secret,
                 ct,
                 iv
               )
    end

    test "comment (no AAD)" do
      t = triple()
      plaintext = "hi"

      {ct, iv} =
        MsgSecret.encrypt(
          :comment,
          t.sender,
          t.orig_msg_id,
          t.orig_sender,
          t.orig_msg_secret,
          plaintext
        )

      assert {:ok, ^plaintext} =
               MsgSecret.decrypt(
                 :comment,
                 t.sender,
                 t.orig_msg_id,
                 t.orig_sender,
                 t.orig_msg_secret,
                 ct,
                 iv
               )
    end

    test "tampered ciphertext fails" do
      t = triple()

      {ct, iv} =
        MsgSecret.encrypt(
          :reaction,
          t.sender,
          t.orig_msg_id,
          t.orig_sender,
          t.orig_msg_secret,
          "ok"
        )

      <<head, rest::binary>> = ct
      tampered = <<Bitwise.bxor(head, 1)>> <> rest

      assert {:error, :aead_auth_failed} =
               MsgSecret.decrypt(
                 :reaction,
                 t.sender,
                 t.orig_msg_id,
                 t.orig_sender,
                 t.orig_msg_secret,
                 tampered,
                 iv
               )
    end

    test "wrong secret fails decryption" do
      t = triple()

      {ct, iv} =
        MsgSecret.encrypt(
          :poll_vote,
          t.sender,
          t.orig_msg_id,
          t.orig_sender,
          t.orig_msg_secret,
          "x"
        )

      bad_secret = :crypto.strong_rand_bytes(32)

      assert {:error, :aead_auth_failed} =
               MsgSecret.decrypt(
                 :poll_vote,
                 t.sender,
                 t.orig_msg_id,
                 t.orig_sender,
                 bad_secret,
                 ct,
                 iv
               )
    end

    test "wrong AAD context fails (modification_sender)" do
      t = triple()

      {ct, iv} =
        MsgSecret.encrypt(
          :poll_vote,
          t.sender,
          t.orig_msg_id,
          t.orig_sender,
          t.orig_msg_secret,
          "x"
        )

      assert {:error, :aead_auth_failed} =
               MsgSecret.decrypt(
                 :poll_vote,
                 "different@s.whatsapp.net",
                 t.orig_msg_id,
                 t.orig_sender,
                 t.orig_msg_secret,
                 ct,
                 iv
               )
    end

    test "too-short ciphertext is rejected before AEAD" do
      t = triple()

      assert {:error, :ciphertext_too_short} =
               MsgSecret.decrypt(
                 :reaction,
                 t.sender,
                 t.orig_msg_id,
                 t.orig_sender,
                 t.orig_msg_secret,
                 <<1, 2, 3>>,
                 <<0::96>>
               )
    end
  end

  describe "hash_poll_options/1" do
    test "SHA-256 of each option" do
      hashes = MsgSecret.hash_poll_options(["yes", "no"])
      assert hashes == [:crypto.hash(:sha256, "yes"), :crypto.hash(:sha256, "no")]
    end

    test "empty list → empty result" do
      assert MsgSecret.hash_poll_options([]) == []
    end

    test "each hash is 32 bytes" do
      [h] = MsgSecret.hash_poll_options(["x"])
      assert byte_size(h) == 32
    end
  end
end
