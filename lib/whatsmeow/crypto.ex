defmodule Whatsmeow.Crypto do
  @moduledoc """
  Thin Elixir wrappers around Erlang's `:crypto` for the primitives whatsmeow
  needs: AES-GCM, AES-CBC, HKDF-SHA256, X25519 (Curve25519 ECDH), and
  ChaCha20-Poly1305.

  This module re-exports the primitive sub-modules so callers can write
  `Whatsmeow.Crypto.aes_gcm_encrypt/4` without remembering the deeper
  namespace. The implementations live in `Whatsmeow.Crypto.*` per concern.

  No NIFs are used beyond Erlang's stdlib `:crypto` (which is part of OTP).
  """

  alias Whatsmeow.Crypto.{AES, ChaCha20Poly1305, Curve25519, HKDF}

  @doc "Encrypt with AES-GCM. See `Whatsmeow.Crypto.AES.GCM.encrypt/4`."
  defdelegate aes_gcm_encrypt(key, iv, plaintext, aad), to: AES.GCM, as: :encrypt

  @doc "Decrypt with AES-GCM. See `Whatsmeow.Crypto.AES.GCM.decrypt/5`."
  defdelegate aes_gcm_decrypt(key, iv, ciphertext, aad, tag), to: AES.GCM, as: :decrypt

  @doc "HKDF-SHA256 extract+expand. See `Whatsmeow.Crypto.HKDF.derive/4`."
  defdelegate hkdf(ikm, salt, info, length), to: HKDF, as: :derive

  @doc "X25519 keypair generation. See `Whatsmeow.Crypto.Curve25519.generate_keypair/0`."
  defdelegate generate_x25519_keypair, to: Curve25519, as: :generate_keypair

  @doc "X25519 shared-secret agreement. See `Whatsmeow.Crypto.Curve25519.agree/2`."
  defdelegate x25519_agree(my_priv, their_pub), to: Curve25519, as: :agree

  @doc "ChaCha20-Poly1305 encrypt. See `Whatsmeow.Crypto.ChaCha20Poly1305.encrypt/4`."
  defdelegate chacha_encrypt(key, iv, plaintext, aad), to: ChaCha20Poly1305, as: :encrypt

  @doc "ChaCha20-Poly1305 decrypt. See `Whatsmeow.Crypto.ChaCha20Poly1305.decrypt/5`."
  defdelegate chacha_decrypt(key, iv, ciphertext, aad, tag), to: ChaCha20Poly1305, as: :decrypt
end
