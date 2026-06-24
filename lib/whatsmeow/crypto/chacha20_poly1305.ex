defmodule Whatsmeow.Crypto.ChaCha20Poly1305 do
  @moduledoc """
  ChaCha20-Poly1305 AEAD (RFC 7539 / 8439).

  Used by the Noise XX handshake in the WhatsApp transport. Keys are 32
  bytes, IVs are 12 bytes, tags are 16 bytes.
  """

  @tag_bytes 16

  @typedoc "32-byte key."
  @type key :: <<_::256>>

  @typedoc "12-byte IV / nonce."
  @type iv :: <<_::96>>

  @doc """
  Encrypt `plaintext` under `key` with `iv`, authenticating `aad`.
  Returns `{ciphertext, tag}`.
  """
  @spec encrypt(key, iv, binary(), binary()) :: {binary(), binary()}
  def encrypt(key, iv, plaintext, aad)
      when byte_size(key) == 32 and byte_size(iv) == 12 and is_binary(plaintext) and
             is_binary(aad) do
    :crypto.crypto_one_time_aead(
      :chacha20_poly1305,
      key,
      iv,
      plaintext,
      aad,
      @tag_bytes,
      true
    )
  end

  @doc """
  Decrypt and verify. Returns `{:ok, plaintext}` on auth success,
  `{:error, :auth_failed}` otherwise.
  """
  @spec decrypt(key, iv, binary(), binary(), binary()) ::
          {:ok, binary()} | {:error, :auth_failed}
  def decrypt(key, iv, ciphertext, aad, tag)
      when byte_size(key) == 32 and byte_size(iv) == 12 and is_binary(ciphertext) and
             is_binary(aad) and byte_size(tag) == @tag_bytes do
    case :crypto.crypto_one_time_aead(:chacha20_poly1305, key, iv, ciphertext, aad, tag, false) do
      plaintext when is_binary(plaintext) -> {:ok, plaintext}
      :error -> {:error, :auth_failed}
    end
  end
end
