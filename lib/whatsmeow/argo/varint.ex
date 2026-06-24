defmodule Whatsmeow.Argo.Varint do
  @moduledoc """
  ULEB128 + ZigZag varint codec.

  Ports `github.com/beeper/argo-go/pkg/varint` (the subset whatsmeow
  needs). Returns Elixir integers — supports the full int64 range
  natively and arbitrary-precision values via Erlang's bignums.
  """

  @doc """
  ULEB128-encode an unsigned non-negative integer to a binary.
  """
  @spec unsigned_encode(non_neg_integer()) :: binary()
  def unsigned_encode(0), do: <<0>>

  def unsigned_encode(n) when is_integer(n) and n > 0 do
    n |> do_unsigned_encode([]) |> :erlang.iolist_to_binary()
  end

  defp do_unsigned_encode(0, acc), do: acc

  defp do_unsigned_encode(n, acc) do
    byte = Bitwise.band(n, 0x7F)
    rest = Bitwise.bsr(n, 7)

    if rest == 0 do
      [acc, byte]
    else
      do_unsigned_encode(rest, [acc, Bitwise.bor(byte, 0x80)])
    end
  end

  @doc """
  ULEB128-decode an unsigned integer from the head of `bin`. Returns
  `{value, rest}` or `{:error, reason}`.
  """
  @spec unsigned_decode(binary()) ::
          {non_neg_integer(), binary()} | {:error, atom()}
  def unsigned_decode(bin) when is_binary(bin), do: do_unsigned_decode(bin, 0, 0)

  defp do_unsigned_decode(<<>>, _acc, _shift), do: {:error, :unexpected_eof}

  defp do_unsigned_decode(<<byte, rest::binary>>, acc, shift) do
    value = Bitwise.bor(acc, Bitwise.bsl(Bitwise.band(byte, 0x7F), shift))

    if Bitwise.band(byte, 0x80) == 0 do
      {value, rest}
    else
      do_unsigned_decode(rest, value, shift + 7)
    end
  end

  @doc """
  ZigZag-encode a signed integer.
  """
  @spec zigzag_encode(integer()) :: non_neg_integer()
  def zigzag_encode(n) when is_integer(n) and n >= 0, do: n * 2
  def zigzag_encode(n) when is_integer(n) and n < 0, do: n * -2 - 1

  @doc """
  ZigZag-decode an unsigned integer.
  """
  @spec zigzag_decode(non_neg_integer()) :: integer()
  def zigzag_decode(n) when is_integer(n) and n >= 0 do
    if Bitwise.band(n, 1) == 1 do
      -div(n + 1, 2)
    else
      div(n, 2)
    end
  end

  @doc "Signed encode = ULEB128 of the ZigZag value."
  @spec signed_encode(integer()) :: binary()
  def signed_encode(n) when is_integer(n), do: n |> zigzag_encode() |> unsigned_encode()

  @doc """
  Signed decode = ULEB128 followed by ZigZag.
  """
  @spec signed_decode(binary()) :: {integer(), binary()} | {:error, atom()}
  def signed_decode(bin) when is_binary(bin) do
    case unsigned_decode(bin) do
      {value, rest} -> {zigzag_decode(value), rest}
      err -> err
    end
  end
end
