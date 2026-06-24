defmodule Whatsmeow.Crypto.AES.GCMTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.AES.GCM

  describe "NIST SP 800-38D Appendix B Test Case 16 (AES-256-GCM, 96-bit IV, AAD)" do
    @key Base.decode16!("FEFFE9928665731C6D6A8F9467308308FEFFE9928665731C6D6A8F9467308308")
    @iv Base.decode16!("CAFEBABEFACEDBADDECAF888")
    @plaintext Base.decode16!(
                 "D9313225F88406E5A55909C5AFF5269A86A7A9531534F7DA2E4C303D8A318A72" <>
                   "1C3C0C95956809532FCF0E2449A6B525B16AEDF5AA0DE657BA637B39"
               )
    @aad Base.decode16!("FEEDFACEDEADBEEFFEEDFACEDEADBEEFABADDAD2")
    @ciphertext Base.decode16!(
                  "522DC1F099567D07F47F37A32A84427D643A8CDCBFE5C0C97598A2BD2555D1AA" <>
                    "8CB08E48590DBB3DA7B08B1056828838C5F61E6393BA7A0ABCC9F662"
                )
    @auth_tag Base.decode16!("76FC6ECE0F4E1768CDDF8853BB2D551B")

    test "encrypt/4 produces the documented ciphertext + tag" do
      assert {@ciphertext, @auth_tag} = GCM.encrypt(@key, @iv, @plaintext, @aad)
    end

    test "decrypt/5 recovers the plaintext" do
      assert {:ok, @plaintext} = GCM.decrypt(@key, @iv, @ciphertext, @aad, @auth_tag)
    end
  end

  describe "round-trip across key sizes" do
    for size <- [16, 24, 32] do
      test "AES-#{size * 8}-GCM round-trips" do
        key = :crypto.strong_rand_bytes(unquote(size))
        iv = :crypto.strong_rand_bytes(12)
        plaintext = "the quick brown fox jumps over the lazy dog"
        aad = "context"

        {ct, tag} = GCM.encrypt(key, iv, plaintext, aad)
        assert {:ok, ^plaintext} = GCM.decrypt(key, iv, ct, aad, tag)
      end
    end
  end

  describe "auth failure" do
    test "decrypt/5 returns :auth_failed when the tag is tampered" do
      key = <<1::256>>
      iv = <<2::96>>
      {ct, tag} = GCM.encrypt(key, iv, "secret", "aad")
      bad_tag = :crypto.exor(tag, <<1, 0::120>>)

      assert {:error, :auth_failed} = GCM.decrypt(key, iv, ct, "aad", bad_tag)
    end
  end
end
