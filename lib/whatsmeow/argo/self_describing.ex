defmodule Whatsmeow.Argo.SelfDescribing do
  @moduledoc """
  Self-describing Argo decoder.

  Ports the `readSelfDescribing/3` path from
  `github.com/beeper/argo-go/codec/decoder.go`.

  Self-describing values carry an inline type marker (one Argo label)
  followed by the value bytes. The markers are:

      -1 → null
       0 → false
       1 → true
       2 → object   (length-prefixed [(label, key, value)*])
       3 → list     (length-prefixed [value*])
       4 → string   (length-prefixed UTF-8 bytes)
       5 → bytes    (length-prefixed raw bytes)
       6 → int      (ZigZag-ULEB128)
       7 → float    (IEEE 754 little-endian 8 bytes)

  This is the format Argo emits when the message header sets the
  self-describing flag — common for WhatsApp newsletter / Argo query
  responses.
  """

  alias Whatsmeow.Argo.Label

  @marker_null Label.null()
  @marker_false Label.false_marker()
  @marker_true Label.true_marker()
  @marker_object 2
  @marker_list 3
  @marker_string 4
  @marker_bytes 5
  @marker_int 6
  @marker_float 7

  @type value ::
          nil
          | boolean()
          | integer()
          | float()
          | String.t()
          | binary()
          | [value()]
          | %{optional(String.t()) => value()}

  @doc """
  Decode one self-describing value from the head of `bin`. Returns
  `{:ok, value, rest}` or `{:error, reason}`.
  """
  @spec decode(binary()) :: {:ok, value(), binary()} | {:error, atom()}
  def decode(bin) when is_binary(bin) do
    case Label.read(bin) do
      {marker, rest} -> decode_marker(marker, rest)
      err -> err
    end
  end

  defp decode_marker(@marker_null, rest), do: {:ok, nil, rest}
  defp decode_marker(@marker_false, rest), do: {:ok, false, rest}
  defp decode_marker(@marker_true, rest), do: {:ok, true, rest}

  defp decode_marker(@marker_string, bin) do
    with {len, rest} <- Label.read(bin),
         {:ok, str} <- take(rest, len) do
      <<value::binary-size(^len), tail::binary>> = str
      {:ok, value, tail}
    end
  end

  defp decode_marker(@marker_bytes, bin) do
    with {len, rest} <- Label.read(bin),
         {:ok, raw} <- take(rest, len) do
      <<value::binary-size(^len), tail::binary>> = raw
      {:ok, value, tail}
    end
  end

  defp decode_marker(@marker_int, bin) do
    case Label.read(bin) do
      {value, rest} -> {:ok, value, rest}
      err -> err
    end
  end

  defp decode_marker(@marker_float, <<f::little-float-64, rest::binary>>) do
    {:ok, f, rest}
  end

  defp decode_marker(@marker_float, _), do: {:error, :unexpected_eof}

  defp decode_marker(@marker_list, bin) do
    case Label.read(bin) do
      {len, rest} when is_integer(len) and len >= 0 -> decode_list(rest, len, [])
      err -> err
    end
  end

  defp decode_marker(@marker_object, bin) do
    case Label.read(bin) do
      {len, rest} when is_integer(len) and len >= 0 -> decode_object(rest, len, %{})
      err -> err
    end
  end

  defp decode_marker(other, _), do: {:error, {:unknown_marker, other}}

  defp decode_list(rest, 0, acc), do: {:ok, Enum.reverse(acc), rest}

  defp decode_list(bin, remaining, acc) do
    case decode(bin) do
      {:ok, v, rest} -> decode_list(rest, remaining - 1, [v | acc])
      err -> err
    end
  end

  defp decode_object(rest, 0, acc), do: {:ok, acc, rest}

  defp decode_object(bin, remaining, acc) do
    with {key_len, after_keylen} <- Label.read(bin),
         {:ok, with_key} <- take(after_keylen, key_len),
         <<key::binary-size(^key_len), after_key::binary>> = with_key,
         {:ok, value, rest} <- decode(after_key) do
      decode_object(rest, remaining - 1, Map.put(acc, key, value))
    end
  end

  defp take(bin, n) when byte_size(bin) >= n, do: {:ok, bin}
  defp take(_, _), do: {:error, :unexpected_eof}
end
