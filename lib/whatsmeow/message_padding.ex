defmodule Whatsmeow.MessagePadding do
  @moduledoc """
  Pre-encryption padding for WhatsApp E2E messages.

  Direct port of `padMessage` / `unpadMessage` from
  `whatsmeow-main/message.go:631-651`. The algorithm:

  * Generate one random byte; mask the low nibble (`pad & 0xF`). If zero,
    bump it to `0xF` so we always pad at least one byte.
  * Append that byte `N` times where `N` is the low-nibble value.
  * Unpad: read the last byte as the count, verify all trailing bytes
    are equal, strip them.

  This matters because Signal session ciphertext is unauthenticated at
  the protobuf level (the HMAC is over the wire envelope, not the
  cleartext), so consistent padding gives a fixed shape and prevents
  trivial chosen-ciphertext distinguishers.
  """

  @doc """
  Append PKCS-7-like padding with a random 1-15 byte length. Returns the
  padded binary.
  """
  @spec pad(binary()) :: binary()
  def pad(plaintext) when is_binary(plaintext) do
    <<r>> = :crypto.strong_rand_bytes(1)
    pad = Bitwise.band(r, 0xF)
    pad = if pad == 0, do: 0xF, else: pad
    plaintext <> :binary.copy(<<pad>>, pad)
  end

  @doc """
  Strip the padding written by `pad/1`. For `v == 3` (Armadillo) returns
  the input unchanged — Armadillo messages aren't padded.

  Returns `{:error, :empty}` on empty input and `{:error, :bad_padding}`
  if the trailing-byte invariant fails (corruption or wrong version).
  """
  @spec unpad(binary(), non_neg_integer()) :: {:ok, binary()} | {:error, atom()}
  def unpad(<<>>, _version), do: {:error, :empty}
  def unpad(bin, 3), do: {:ok, bin}

  def unpad(bin, _version) when is_binary(bin) do
    last = :binary.last(bin)
    expected = :binary.copy(<<last>>, last)

    if last > 0 and last <= byte_size(bin) and
         binary_part(bin, byte_size(bin) - last, last) == expected do
      {:ok, binary_part(bin, 0, byte_size(bin) - last)}
    else
      {:error, :bad_padding}
    end
  end
end
