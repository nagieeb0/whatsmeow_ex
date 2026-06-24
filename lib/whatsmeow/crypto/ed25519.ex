defmodule Whatsmeow.Crypto.Ed25519 do
  @moduledoc """
  Minimal pure-Elixir Ed25519 edwards-curve arithmetic, enough to support
  XEdDSA signing in `Whatsmeow.Crypto.XEdDSA`.

  We only need:

  * **Base-point scalar multiplication** (`scalar_mult_base/1`) — to derive
    `A = a·B` from a private scalar.
  * **General scalar multiplication** is not exported; double-and-add only
    appears via `scalar_mult_base/1` and `point_negate/1`.
  * **Point compression** (`compress/1`) — 32-byte little-endian `y` plus
    the parity of `x` in the top bit, per RFC 8032 §5.1.2.

  We do NOT implement point decompression here — `Whatsmeow.Crypto.XEdDSA`
  exclusively verifies via OTP's `:crypto.verify(:eddsa, …)`, which accepts
  compressed Ed25519 pubkeys directly.

  Conventions
  -----------
  * Field prime `p = 2^255 - 19`.
  * Curve constant `d = -121665 · 121666⁻¹ mod p` (twisted Edwards).
  * Group order `L = 2^252 + 27742317777372353535851937790883648493`.
  * Base point `B`: y = 4/5 mod p; x is the even root.
  * Extended Edwards coordinates `(X : Y : Z : T)` with `x = X/Z`,
    `y = Y/Z`, `T = X·Y/Z` (so `Z·T = X·Y`).

  The math here is *not* intended to be constant-time. Pair-success is
  rare (once per device lifetime) and we accept the side-channel exposure
  in exchange for readability and stdlib-only code.
  """

  import Bitwise

  @p (1 <<< 255) - 19
  @l (1 <<< 252) + 27_742_317_777_372_353_535_851_937_790_883_648_493

  # d = -121665 * 121666⁻¹ mod p — well-known Ed25519 curve constant.
  @d 37_095_705_934_669_439_343_138_083_508_754_565_189_542_113_879_843_219_016_388_785_533_085_940_283_555
  @two_d rem(2 * @d, @p)

  # Base point B (canonical Ed25519 generator).
  @b_x 15_112_221_349_535_400_772_501_151_409_588_531_511_454_012_693_041_857_206_046_113_283_949_847_762_202
  @b_y 46_316_835_694_926_478_169_428_394_003_475_163_141_307_993_866_256_225_615_783_033_603_165_251_855_960

  @typedoc "Extended Edwards point: `{X, Y, Z, T}` integers mod p."
  @type point :: {integer(), integer(), integer(), integer()}

  @doc "The Ed25519 group order L."
  @spec order() :: pos_integer()
  def order, do: @l

  @doc "The base point B in extended Edwards coordinates."
  @spec base_point() :: point()
  def base_point, do: {@b_x, @b_y, 1, rem(@b_x * @b_y, @p)}

  @doc """
  Scalar-multiply the base point B by `k`. Accepts any non-negative integer;
  reduces mod L implicitly via the double-and-add loop.

  Returns the resulting point in extended coordinates.
  """
  @spec scalar_mult_base(non_neg_integer()) :: point()
  def scalar_mult_base(k) when is_integer(k) and k >= 0 do
    scalar_mult(k, base_point())
  end

  @doc "Generic scalar multiplication via double-and-add (not constant-time)."
  @spec scalar_mult(non_neg_integer(), point()) :: point()
  def scalar_mult(0, _p), do: identity()

  def scalar_mult(k, p) when is_integer(k) and k > 0 do
    # Highest bit first.
    bits = Integer.to_string(k, 2)
    do_scalar_mult(bits, p, identity())
  end

  defp do_scalar_mult(<<>>, _p, acc), do: acc

  defp do_scalar_mult(<<bit, rest::binary>>, p, acc) do
    acc2 = double(acc)
    acc3 = if bit == ?1, do: add(acc2, p), else: acc2
    do_scalar_mult(rest, p, acc3)
  end

  @doc "Identity (neutral) point: (0, 1, 1, 0)."
  @spec identity() :: point()
  def identity, do: {0, 1, 1, 0}

  @doc """
  Compress a point to 32 bytes (little-endian y, with sign bit of x in
  the top bit of the last byte). Per RFC 8032 §5.1.2.
  """
  @spec compress(point()) :: <<_::256>>
  def compress({x_e, y_e, z_e, _t_e}) do
    z_inv = inv(z_e)
    x = mod_p(x_e * z_inv)
    y = mod_p(y_e * z_inv)

    # Sign bit = LSB of x.
    encoded = y ||| band(x, 1) <<< 255
    <<encoded::little-size(256)>>
  end

  @doc """
  Negate a point (flip the sign of x).
  """
  @spec point_negate(point()) :: point()
  def point_negate({x, y, z, t}), do: {mod_p(-x), y, z, mod_p(-t)}

  @doc """
  Returns the LSB of the affine x-coordinate ("sign bit" in RFC 8032 terms).
  """
  @spec x_sign(point()) :: 0 | 1
  def x_sign({x_e, _y_e, z_e, _t_e}) do
    band(mod_p(x_e * inv(z_e)), 1)
  end

  # --- Point operations ----------------------------------------------------

  # Extended twisted Edwards addition (a = -1 case).
  # https://eprint.iacr.org/2008/522.pdf §3.1
  @doc false
  @spec add(point(), point()) :: point()
  def add({x1, y1, z1, t1}, {x2, y2, z2, t2}) do
    a = mod_p((y1 - x1) * (y2 - x2))
    b = mod_p((y1 + x1) * (y2 + x2))
    c = mod_p(t1 * @two_d * t2)
    d = mod_p(z1 * 2 * z2)
    e = mod_p(b - a)
    f = mod_p(d - c)
    g = mod_p(d + c)
    h = mod_p(b + a)
    {mod_p(e * f), mod_p(g * h), mod_p(f * g), mod_p(e * h)}
  end

  # Extended twisted Edwards doubling (a = -1 case).
  @doc false
  @spec double(point()) :: point()
  def double({x1, y1, z1, _t1}) do
    a = mod_p(x1 * x1)
    b = mod_p(y1 * y1)
    c = mod_p(2 * z1 * z1)
    h = mod_p(a + b)
    e = mod_p(h - (x1 + y1) * (x1 + y1))
    g = mod_p(a - b)
    f = mod_p(c + g)
    {mod_p(e * f), mod_p(g * h), mod_p(f * g), mod_p(e * h)}
  end

  # --- Field helpers --------------------------------------------------------

  @doc false
  @spec mod_p(integer()) :: non_neg_integer()
  def mod_p(n) when is_integer(n) do
    r = rem(n, @p)
    if r < 0, do: r + @p, else: r
  end

  @doc false
  @spec mod_l(integer()) :: non_neg_integer()
  def mod_l(n) when is_integer(n) do
    r = rem(n, @l)
    if r < 0, do: r + @l, else: r
  end

  @doc false
  # Modular inverse: a^(p-2) mod p (Fermat's little theorem).
  @spec inv(integer()) :: non_neg_integer()
  def inv(a) when is_integer(a) do
    :crypto.mod_pow(mod_p(a), @p - 2, @p)
    |> :binary.decode_unsigned()
  end
end
