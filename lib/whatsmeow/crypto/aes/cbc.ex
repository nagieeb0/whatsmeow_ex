defmodule Whatsmeow.Crypto.AES.CBC do
  @moduledoc """
  AES-CBC encryption with PKCS#7 padding.

  Used by WhatsApp for media payload encryption and the older app-state
  mutation envelope. NOT authenticated on its own — callers MUST pair this
  with an HMAC (the upstream Go code does the same).

  Keys may be 128/192/256 bits. IVs are 16 bytes.
  """

  @typedoc "AES key — 16, 24, or 32 bytes."
  @type key :: binary()

  @typedoc "16-byte IV."
  @type iv :: binary()

  @block 16

  @doc "Encrypt `plaintext` under `key` with `iv`, PKCS#7-padded."
  @spec encrypt(key, iv, binary()) :: binary()
  def encrypt(key, iv, plaintext)
      when is_binary(key) and byte_size(iv) == @block and is_binary(plaintext) do
    padded = pkcs7_pad(plaintext, @block)
    :crypto.crypto_one_time(cipher_for(key), key, iv, padded, true)
  end

  @doc "Decrypt and strip PKCS#7 padding. `{:error, :bad_padding}` on malformed input."
  @spec decrypt(key, iv, binary()) :: {:ok, binary()} | {:error, :bad_padding}
  def decrypt(key, iv, ciphertext)
      when is_binary(key) and byte_size(iv) == @block and is_binary(ciphertext) and
             rem(byte_size(ciphertext), @block) == 0 do
    padded = :crypto.crypto_one_time(cipher_for(key), key, iv, ciphertext, false)
    pkcs7_unpad(padded, @block)
  end

  defp cipher_for(key) when byte_size(key) == 16, do: :aes_128_cbc
  defp cipher_for(key) when byte_size(key) == 24, do: :aes_192_cbc
  defp cipher_for(key) when byte_size(key) == 32, do: :aes_256_cbc

  defp pkcs7_pad(bin, block) do
    pad_len = block - rem(byte_size(bin), block)
    bin <> :binary.copy(<<pad_len>>, pad_len)
  end

  defp pkcs7_unpad(<<>>, _block), do: {:error, :bad_padding}

  defp pkcs7_unpad(bin, block) do
    pad_len = :binary.last(bin)

    cond do
      pad_len == 0 or pad_len > block ->
        {:error, :bad_padding}

      byte_size(bin) < pad_len ->
        {:error, :bad_padding}

      true ->
        unpadded_size = byte_size(bin) - pad_len
        <<unpadded::binary-size(^unpadded_size), tail::binary>> = bin

        if tail == :binary.copy(<<pad_len>>, pad_len) do
          {:ok, unpadded}
        else
          {:error, :bad_padding}
        end
    end
  end
end
