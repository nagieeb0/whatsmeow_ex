defmodule Whatsmeow.Crypto.AES.CBCTest do
  use ExUnit.Case, async: true

  import Bitwise, only: [bxor: 2]

  alias Whatsmeow.Crypto.AES.CBC

  describe "round-trip with PKCS#7 padding" do
    for size <- [16, 24, 32] do
      test "AES-#{size * 8}-CBC round-trips arbitrary-length plaintext" do
        key = :crypto.strong_rand_bytes(unquote(size))
        iv = :crypto.strong_rand_bytes(16)

        for len <- [0, 1, 15, 16, 17, 31, 32, 33, 100] do
          plaintext = :crypto.strong_rand_bytes(len)
          ct = CBC.encrypt(key, iv, plaintext)
          assert {:ok, ^plaintext} = CBC.decrypt(key, iv, ct)
        end
      end
    end
  end

  describe "padding errors" do
    test "decrypt/3 returns :bad_padding on a forged trailing byte" do
      key = <<1::256>>
      iv = <<0::128>>
      ct = CBC.encrypt(key, iv, "hello, world")

      # Flip the last byte of the last ciphertext block. CBC propagates the
      # change into the plaintext of that block — so the padding byte will be
      # invalid with high probability.
      <<head::binary-size(byte_size(ct) - 1), last>> = ct
      tampered = head <> <<bxor(last, 0xFF)>>

      assert {:error, :bad_padding} = CBC.decrypt(key, iv, tampered)
    end
  end
end
