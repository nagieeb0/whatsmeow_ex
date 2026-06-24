defmodule Whatsmeow.Signal.Ratchet do
  @moduledoc """
  Signal Protocol Double Ratchet key derivation functions.

  Two KDF chains operate alongside each other:

  * **Root chain.** Advanced once per DH key exchange. Input: current root
    key + new DH shared secret. Output: new root key + initial chain key.
  * **Symmetric chain.** Advanced once per message. Input: current chain
    key. Output: next chain key + message key.

  This module is pure — no state, no I/O. Callers (`Whatsmeow.Signal.Session`
  + `Whatsmeow.Signal.SessionCipher`) sequence the chains.

  Reference: https://signal.org/docs/specifications/doubleratchet/
  """

  alias Whatsmeow.Crypto.HKDF

  @rk_info "WhisperRatchet"
  @msg_keys_info "WhisperMessageKeys"

  @doc """
  KDF_RK — advance the root chain.

  Input: 32-byte root key `rk`, 32-byte DH shared secret.
  Output: `{new_root_key, new_chain_key}` (both 32 bytes).
  """
  @spec kdf_rk(binary(), binary()) :: {binary(), binary()}
  def kdf_rk(rk, dh_out) when byte_size(rk) == 32 and byte_size(dh_out) == 32 do
    okm = HKDF.derive(dh_out, rk, @rk_info, 64)
    <<new_rk::binary-size(32), new_ck::binary-size(32)>> = okm
    {new_rk, new_ck}
  end

  @doc """
  KDF_CK — advance the symmetric chain.

  Input: 32-byte chain key `ck`.
  Output: `{next_ck, message_key}` (32 bytes each).

  Canonical Signal: `message_key = HMAC(ck, 0x01)`, `next_ck = HMAC(ck, 0x02)`.
  """
  @spec kdf_ck(binary()) :: {binary(), binary()}
  def kdf_ck(ck) when byte_size(ck) == 32 do
    message_key = :crypto.mac(:hmac, :sha256, ck, <<0x01>>)
    next_ck = :crypto.mac(:hmac, :sha256, ck, <<0x02>>)
    {next_ck, message_key}
  end

  @doc """
  Derive `{enc_key, mac_key, iv}` from a 32-byte message key using HKDF.

  Standard Signal layout:
    * 32 bytes encryption key (AES-256)
    * 32 bytes MAC key (HMAC-SHA256)
    * 16 bytes IV
  """
  @spec derive_message_keys(binary()) :: {binary(), binary(), binary()}
  def derive_message_keys(message_key) when byte_size(message_key) == 32 do
    okm = HKDF.derive(message_key, <<0::256>>, @msg_keys_info, 80)
    <<enc_key::binary-size(32), mac_key::binary-size(32), iv::binary-size(16)>> = okm
    {enc_key, mac_key, iv}
  end
end
