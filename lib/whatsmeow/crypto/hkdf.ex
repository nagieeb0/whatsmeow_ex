defmodule Whatsmeow.Crypto.HKDF do
  @moduledoc """
  HKDF — HMAC-based Extract-and-Expand Key Derivation Function (RFC 5869).

  Built on top of `:crypto.mac/4` (no NIFs beyond OTP stdlib). Defaults to
  SHA-256, which is what Signal / WhatsApp use everywhere.

  ## Example

      iex> okm = Whatsmeow.Crypto.HKDF.derive("input key material", "salt", "info", 42)
      iex> byte_size(okm)
      42
  """

  @hash_length 32
  @hash_algo :sha256

  @doc """
  Derive `length` bytes of output keying material from `ikm` using HKDF-SHA256
  with the given `salt` and `info` strings.

  `salt` may be `nil`, in which case `length`-zero bytes are used as per
  RFC 5869 §2.2.
  """
  @spec derive(binary(), binary() | nil, binary(), pos_integer()) :: binary()
  def derive(ikm, salt, info, length)
      when is_binary(ikm) and (is_nil(salt) or is_binary(salt)) and is_binary(info) and
             is_integer(length) and length > 0 do
    salt = salt || <<0::size(@hash_length * 8)>>

    ikm
    |> extract(salt)
    |> expand(info, length)
  end

  @doc "RFC 5869 §2.2 HKDF-Extract. Returns the PRK (`@hash_length` bytes)."
  @spec extract(binary(), binary()) :: binary()
  def extract(ikm, salt) do
    :crypto.mac(:hmac, @hash_algo, salt, ikm)
  end

  @doc "RFC 5869 §2.3 HKDF-Expand of `prk` to `length` bytes with optional `info`."
  @spec expand(binary(), binary(), pos_integer()) :: binary()
  def expand(prk, info \\ <<>>, length) do
    n = div(length + @hash_length - 1, @hash_length)

    if n > 255 do
      raise ArgumentError, "HKDF expand length #{length} exceeds 255 * HashLen"
    end

    # iolist accumulator avoids the O(n²) binary copies the old
    # `acc <> t` form produced. For typical Signal HKDFs (n in 1..3)
    # the savings are small in absolute terms, but for app-state /
    # media key expansion (n up to 8) they add up.
    {okm_io, _last} =
      Enum.reduce(1..n, {[], <<>>}, fn i, {acc, prev} ->
        t = :crypto.mac(:hmac, @hash_algo, prk, [prev, info, <<i>>])
        {[acc, t], t}
      end)

    binary_part(IO.iodata_to_binary(okm_io), 0, length)
  end
end
