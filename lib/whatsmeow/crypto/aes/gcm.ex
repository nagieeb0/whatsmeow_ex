defmodule Whatsmeow.Crypto.AES.GCM do
  @moduledoc """
  AES-GCM authenticated encryption.

  Keys may be 128, 192, or 256 bits (16/24/32 bytes). IVs are 96 bits (12
  bytes) per NIST SP 800-38D recommendation. The authentication tag is
  always 16 bytes.

  ## Examples

      iex> key = <<0::256>>
      iex> iv  = <<0::96>>
      iex> {ct, tag} = Whatsmeow.Crypto.AES.GCM.encrypt(key, iv, "hello", "aad")
      iex> Whatsmeow.Crypto.AES.GCM.decrypt(key, iv, ct, "aad", tag)
      {:ok, "hello"}
  """

  @tag_bytes 16

  @typedoc "AES key — 16, 24, or 32 bytes."
  @type key :: binary()

  @typedoc "Recommended 12-byte IV."
  @type iv :: binary()

  @typedoc "Additional authenticated data."
  @type aad :: binary()

  @doc """
  Encrypt `plaintext` under `key` with the given 96-bit `iv`, authenticating
  `aad`. Returns `{ciphertext, tag}` where `tag` is 16 bytes.
  """
  @spec encrypt(key, iv, binary(), aad) :: {binary(), binary()}
  def encrypt(key, iv, plaintext, aad)
      when is_binary(key) and is_binary(iv) and is_binary(plaintext) and is_binary(aad) do
    cipher = cipher_for(key)

    :crypto.crypto_one_time_aead(cipher, key, iv, plaintext, aad, @tag_bytes, true)
  end

  @doc """
  Decrypt `ciphertext` and verify `tag`. Returns `{:ok, plaintext}` on
  successful authentication, `{:error, :auth_failed}` otherwise.
  """
  @spec decrypt(key, iv, binary(), aad, binary()) :: {:ok, binary()} | {:error, :auth_failed}
  def decrypt(key, iv, ciphertext, aad, tag)
      when is_binary(key) and is_binary(iv) and is_binary(ciphertext) and is_binary(aad) and
             byte_size(tag) == @tag_bytes do
    cipher = cipher_for(key)

    case :crypto.crypto_one_time_aead(cipher, key, iv, ciphertext, aad, tag, false) do
      plaintext when is_binary(plaintext) -> {:ok, plaintext}
      :error -> {:error, :auth_failed}
    end
  end

  defp cipher_for(key) when byte_size(key) == 16, do: :aes_128_gcm
  defp cipher_for(key) when byte_size(key) == 24, do: :aes_192_gcm
  defp cipher_for(key) when byte_size(key) == 32, do: :aes_256_gcm
end
