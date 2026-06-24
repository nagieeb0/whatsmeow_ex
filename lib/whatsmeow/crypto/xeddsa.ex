defmodule Whatsmeow.Crypto.XEdDSA do
  @moduledoc """
  XEdDSA signing + verification over Curve25519 keys.

  Signal's XEdDSA scheme (https://signal.org/docs/specifications/xeddsa/)
  lets an X25519 key be used as an Ed25519 signing key. WhatsApp uses this
  for:

  * the server's Noise certificate chain (`waCert.CertChain`)
  * the ADV signed-device-identity payload during QR pairing
  * Signal signed-pre-key signatures

  ## Verify

  1. Take the peer's Montgomery u-coordinate (32 bytes, little-endian).
  2. Convert to Ed25519 y-coordinate via the birational map
     `y = (u - 1) / (u + 1) mod p`, with `p = 2^255 - 19`.
  3. Encode the Ed25519 public key as 32 bytes little-endian of `y`,
     with the sign bit (MSB of byte 31) cleared.
  4. Standard Ed25519 verify (`:crypto.verify(:eddsa, :sha512, …)`).

  ## Sign

  Per the Signal XEdDSA spec §3.3:

  1. Convert the Montgomery scalar `k` (an X25519 private key, already
     clamped per RFC 7748) to a *normalized* Ed25519 keypair `(a, A)`:
     compute `E = k·B` on the Ed25519 curve, and if `sign(E.x) = 1`,
     replace `(k, E)` with `(−k mod L, −E)` so that `A` always has
     sign bit 0.
  2. Derive a 512-bit nonce `r = SHA-512(0xFE‖0xFF×31 ‖ a ‖ M ‖ Z) mod L`
     where `Z` is 64 random bytes. The `0xFE‖0xFF×31` prefix domain-
     separates the XEdDSA hash from Ed25519's hash families.
  3. Compute `R = r·B`, then the standard Ed25519 challenge
     `h = SHA-512(R ‖ A ‖ M) mod L`.
  4. The signature is `R ‖ (r + h·a mod L)` — 64 bytes total.

  The pure-Elixir Edwards arithmetic used here lives in
  `Whatsmeow.Crypto.Ed25519`.
  """

  import Bitwise

  alias Whatsmeow.Crypto.Ed25519

  # Curve25519 field prime: 2^255 - 19
  @p (1 <<< 255) - 19

  # XEdDSA hash1 prefix: 0xFE followed by 31 × 0xFF (32 bytes total).
  @hash1_prefix <<0xFE, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
                  0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF>>

  @doc """
  Verify an XEdDSA signature `sig` (64 bytes) over `message` using the
  Curve25519 public key `pub_u` (32 bytes, Montgomery u-coordinate, little-endian).

  Returns `true` on success, `false` on auth failure.
  """
  @spec verify(binary(), binary(), binary()) :: boolean()
  def verify(pub_u, message, sig)
      when byte_size(pub_u) == 32 and byte_size(sig) == 64 and is_binary(message) do
    case montgomery_pub_to_ed25519(pub_u) do
      {:ok, ed_pub} ->
        :crypto.verify(:eddsa, :sha512, message, sig, [ed_pub, :ed25519])

      :error ->
        false
    end
  rescue
    _ -> false
  end

  def verify(_, _, _), do: false

  @doc false
  # Convert a Curve25519 Montgomery u-coordinate to an Ed25519 compressed
  # public key (32 bytes, little-endian y || sign-bit=0). Returns `:error`
  # for the degenerate case u = -1 mod p (which makes the denominator zero).
  @spec montgomery_pub_to_ed25519(binary()) :: {:ok, binary()} | :error
  def montgomery_pub_to_ed25519(<<u_bin::binary-size(32)>>) do
    u = :binary.decode_unsigned(u_bin, :little)
    # Per RFC 7748: ignore the high bit on input.
    u = u &&& (1 <<< 255) - 1

    denom = u + 1

    cond do
      rem(denom, @p) == 0 -> :error
      true -> {:ok, encode_y_le((u - 1) * inv_mod_p(denom, @p))}
    end
  end

  defp encode_y_le(y_int) do
    y = mod_p(y_int)
    # Standard Ed25519 compressed: low 255 bits = y, top bit = x sign (0 here).
    <<y::little-size(256)>>
  end

  defp mod_p(n) when is_integer(n) do
    r = rem(n, @p)
    if r < 0, do: r + @p, else: r
  end

  # Modular inverse via Fermat's little theorem: a^(p-2) mod p.
  defp inv_mod_p(a, p) when is_integer(a) and is_integer(p) do
    :crypto.mod_pow(mod_p(a), p - 2, p)
    |> :binary.decode_unsigned()
  end

  # --- Sign ----------------------------------------------------------------

  @doc """
  Sign `message` with the 32-byte Curve25519 private key `priv`, returning
  a 64-byte XEdDSA signature.

  `nonce` is 64 random bytes (`Z` in the Signal spec). When `nil` (the
  default) it is drawn from `:crypto.strong_rand_bytes/1`. Pass an explicit
  value only in tests where determinism matters.
  """
  @spec sign(binary(), binary(), binary() | nil) :: <<_::512>>
  def sign(priv, message, nonce \\ nil)

  def sign(<<priv_bin::binary-size(32)>>, message, nonce) when is_binary(message) do
    z = nonce || :crypto.strong_rand_bytes(64)
    do_sign(priv_bin, message, z)
  end

  defp do_sign(priv_bin, message, z) when byte_size(z) == 64 do
    # Decode the X25519 scalar (already clamped by RFC 7748 when generated
    # by :crypto.generate_key/2). Treat as little-endian integer.
    k = :binary.decode_unsigned(priv_bin, :little)

    {a, a_compressed} = calculate_xed_keypair(k)
    a_bytes = <<a::little-size(256)>>

    # Hash1: r = SHA-512(prefix ‖ a ‖ M ‖ Z) mod L
    r_hash = :crypto.hash(:sha512, [@hash1_prefix, a_bytes, message, z])
    r = :binary.decode_unsigned(r_hash, :little) |> Ed25519.mod_l()

    big_r_point = Ed25519.scalar_mult_base(r)
    big_r = Ed25519.compress(big_r_point)

    # Standard Ed25519 challenge: h = SHA-512(R ‖ A ‖ M) mod L
    h_hash = :crypto.hash(:sha512, [big_r, a_compressed, message])
    h = :binary.decode_unsigned(h_hash, :little) |> Ed25519.mod_l()

    s = Ed25519.mod_l(r + h * a)

    <<big_r::binary, s::little-size(256)>>
  end

  @doc """
  Derive the XEdDSA-normalized Ed25519 public key for an X25519 private
  scalar (32 bytes, little-endian, RFC 7748-clamped).

  Returns the 32-byte compressed pubkey with sign bit forced to 0.
  Useful for tests and debugging.
  """
  @spec public_key(binary()) :: <<_::256>>
  def public_key(<<priv_bin::binary-size(32)>>) do
    k = :binary.decode_unsigned(priv_bin, :little)
    {_a, a_compressed} = calculate_xed_keypair(k)
    a_compressed
  end

  # Returns `{a_int, A_compressed_bytes}` where `a_int` is the scalar that
  # produces `A` with sign bit 0. If `k·B` already has sign bit 0, returns
  # `(k, encode(k·B))`. Otherwise returns `(L − k, encode(−k·B))`.
  defp calculate_xed_keypair(k) do
    e = Ed25519.scalar_mult_base(k)

    if Ed25519.x_sign(e) == 0 do
      {k, Ed25519.compress(e)}
    else
      a = Ed25519.mod_l(-k)
      neg_e = Ed25519.point_negate(e)
      {a, Ed25519.compress(neg_e)}
    end
  end
end
