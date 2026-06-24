defmodule Whatsmeow.Crypto.ChaCha20Poly1305Test do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.ChaCha20Poly1305

  describe "RFC 7539 §2.8.2 sample AEAD encryption" do
    @plaintext Base.decode16!(
                 "4C616469657320616E642047656E746C656D656E206F662074686520636C617373206F66202739393A" <>
                   "20496620492063" <>
                   "6F756C64206F6666657220796F75206F6E6C79206F6E652074697020666F7220746865206675747572" <>
                   "652C2073756E73637265656E20776F756C642062652069742E"
               )
    @aad Base.decode16!("50515253C0C1C2C3C4C5C6C7")
    @key Base.decode16!("808182838485868788898A8B8C8D8E8F909192939495969798999A9B9C9D9E9F")
    @iv Base.decode16!("070000004041424344454647")
    @ciphertext Base.decode16!(
                  "D31A8D34648E60DB7B86AFBC53EF7EC2A4ADED51296E08FEA9E2B5A736EE62D63DBEA45E8CA9671282FAFB69DA92728B1A71DE0A9E060B2905D6A5B67ECD3B3692DDBD7F2D778B8C9803AEE328091B58FAB324E4FAD675945585808B4831D7BC3FF4DEF08E4B7A9DE576D26586CEC64B6116"
                )
    @auth_tag Base.decode16!("1AE10B594F09E26A7E902ECBD0600691")

    test "encrypt/4 produces the documented ciphertext + tag" do
      assert {@ciphertext, @auth_tag} = ChaCha20Poly1305.encrypt(@key, @iv, @plaintext, @aad)
    end

    test "decrypt/5 recovers the plaintext" do
      assert {:ok, @plaintext} = ChaCha20Poly1305.decrypt(@key, @iv, @ciphertext, @aad, @auth_tag)
    end

    test "decrypt/5 fails on tampered ciphertext" do
      tampered = <<255, binary_part(@ciphertext, 1, byte_size(@ciphertext) - 1)::binary>>
      assert {:error, :auth_failed} = ChaCha20Poly1305.decrypt(@key, @iv, tampered, @aad, @auth_tag)
    end

    test "decrypt/5 fails on tampered tag" do
      bad_tag = <<255, binary_part(@auth_tag, 1, 15)::binary>>

      assert {:error, :auth_failed} =
               ChaCha20Poly1305.decrypt(@key, @iv, @ciphertext, @aad, bad_tag)
    end
  end
end
