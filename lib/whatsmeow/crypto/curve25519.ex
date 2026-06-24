defmodule Whatsmeow.Crypto.Curve25519 do
  @moduledoc """
  X25519 ECDH wrappers (RFC 7748).

  Uses `:crypto.generate_key/2` and `:crypto.compute_key/4` with the
  `:ecdh` / `:x25519` parameter pair — fully supported by OTP 22+.

  Keys are 32-byte binaries in canonical little-endian form.
  """

  @typedoc "32-byte X25519 private scalar."
  @type private_key :: <<_::256>>

  @typedoc "32-byte X25519 public key."
  @type public_key :: <<_::256>>

  @doc "Generate a fresh X25519 keypair: `{public, private}` — both 32 bytes."
  @spec generate_keypair() :: {public_key, private_key}
  def generate_keypair do
    {pub, priv} = :crypto.generate_key(:ecdh, :x25519)
    {pub, priv}
  end

  @doc """
  Compute the shared secret between our `private` key and the peer's `public`
  key. Returns a 32-byte shared secret.
  """
  @spec agree(private_key, public_key) :: binary()
  def agree(private, public)
      when byte_size(private) == 32 and byte_size(public) == 32 do
    :crypto.compute_key(:ecdh, public, private, :x25519)
  end

  @doc """
  Derive the public key for an existing private scalar — used when the
  private key is loaded from storage.
  """
  @spec public_for(private_key) :: public_key
  def public_for(private) when byte_size(private) == 32 do
    {pub, ^private} = :crypto.generate_key(:ecdh, :x25519, private)
    pub
  end
end
