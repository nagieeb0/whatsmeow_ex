defmodule Whatsmeow.Vault do
  @moduledoc """
  Application-level encryption-at-rest for a device's secret key material.

  The `whatsmeow_device` row IS a live WhatsApp account — its `noise_key`,
  `identity_key`, `adv_*` and signed-pre-key material let anyone holding them
  fully impersonate the number with no re-pairing. Storing them as plaintext
  `bytea` means a leaked backup, read replica, or SQL-injection hands over every
  customer's account. This module wraps those columns in AES-256-GCM so the
  ciphertext (not the keys) is what lands in Postgres.

  Design goals:

    * **Opt-in, zero-migration.** Encryption activates only when a 32-byte key is
      configured (`config :whatsmeow_ex, Whatsmeow.Vault, key: <<...>>` — wired
      from `WHATSMEOW_VAULT_KEY` in the host app's `runtime.exs`). With no key,
      `encrypt/1` is the identity function, so behaviour is unchanged.
    * **Backward-compatible reads.** A value that isn't our envelope — or whose
      authentication fails — is returned as-is, so pre-existing plaintext rows
      keep working and get encrypted on their next write. No re-pairing, no data
      migration.

  Envelope: `<<@magic, iv::12-bytes, tag::16-bytes, ciphertext::binary>>`.
  """

  # Envelope discriminator. Collisions with random legacy key material (~1/256)
  # are harmless: a non-envelope or auth-failing value falls through to plaintext.
  @magic 0xE7

  @doc "The configured 32-byte master key, or nil when encryption is disabled."
  @spec key() :: binary() | nil
  def key, do: Application.get_env(:whatsmeow_ex, __MODULE__, [])[:key]

  @doc "Whether encryption-at-rest is enabled (a key is configured)."
  @spec enabled?() :: boolean()
  def enabled?, do: is_binary(key())

  @doc "Encrypt with the configured key (identity when no key is set)."
  @spec encrypt(binary()) :: binary()
  def encrypt(plain) when is_binary(plain), do: encrypt(plain, key())

  @spec encrypt(binary(), binary() | nil) :: binary()
  def encrypt(plain, nil) when is_binary(plain), do: plain

  def encrypt(plain, k) when is_binary(plain) and is_binary(k) do
    iv = :crypto.strong_rand_bytes(12)
    {ct, tag} = :crypto.crypto_one_time_aead(:aes_256_gcm, k, iv, plain, <<>>, true)
    <<@magic, iv::binary, tag::binary, ct::binary>>
  end

  @doc """
  Decrypt an envelope with the configured key. Anything that isn't a valid
  envelope for the current key (legacy plaintext, wrong/rotated key) is returned
  unchanged.
  """
  @spec decrypt(binary()) :: binary()
  def decrypt(data) when is_binary(data), do: decrypt(data, key())

  @spec decrypt(binary(), binary() | nil) :: binary()
  def decrypt(<<@magic, iv::binary-size(12), tag::binary-size(16), ct::binary>> = data, k)
      when is_binary(k) do
    case :crypto.crypto_one_time_aead(:aes_256_gcm, k, iv, ct, <<>>, tag, false) do
      plain when is_binary(plain) -> plain
      _ -> data
    end
  rescue
    _ -> data
  end

  def decrypt(data, _k) when is_binary(data), do: data
end
