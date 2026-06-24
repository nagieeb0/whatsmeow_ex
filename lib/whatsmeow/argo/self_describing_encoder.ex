defmodule Whatsmeow.Argo.SelfDescribingEncoder do
  @moduledoc """
  Self-describing Argo encoder — the inverse of
  `Whatsmeow.Argo.SelfDescribing`.

  Accepts the standard Elixir value vocabulary (nil/bool/int/float/binary
  /list/map with binary keys) and emits the self-describing Argo wire
  bytes.
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

  @doc """
  Encode a value into self-describing Argo bytes.

  Note: Elixir does not differentiate between strings and byte arrays
  out-of-the-box. Plain UTF-8 binaries are emitted as STRING. To force
  the BYTES marker, wrap with `{:bytes, binary}`.
  """
  @spec encode(term()) :: binary()
  def encode(nil), do: Label.encode(@marker_null)
  def encode(false), do: Label.encode(@marker_false)
  def encode(true), do: Label.encode(@marker_true)

  def encode(n) when is_integer(n) do
    Label.encode(@marker_int) <> Label.encode(n)
  end

  def encode(f) when is_float(f) do
    Label.encode(@marker_float) <> <<f::little-float-64>>
  end

  def encode({:bytes, b}) when is_binary(b) do
    Label.encode(@marker_bytes) <> Label.encode(byte_size(b)) <> b
  end

  def encode(b) when is_binary(b) do
    if String.valid?(b) do
      Label.encode(@marker_string) <> Label.encode(byte_size(b)) <> b
    else
      Label.encode(@marker_bytes) <> Label.encode(byte_size(b)) <> b
    end
  end

  def encode(list) when is_list(list) do
    body = list |> Enum.map(&encode/1) |> IO.iodata_to_binary()
    Label.encode(@marker_list) <> Label.encode(length(list)) <> body
  end

  def encode(map) when is_map(map) do
    pairs = Enum.to_list(map)

    body =
      pairs
      |> Enum.map(fn {k, v} ->
        k_bin = key_to_binary(k)
        Label.encode(byte_size(k_bin)) <> k_bin <> encode(v)
      end)
      |> IO.iodata_to_binary()

    Label.encode(@marker_object) <> Label.encode(length(pairs)) <> body
  end

  defp key_to_binary(k) when is_binary(k), do: k
  defp key_to_binary(k) when is_atom(k), do: Atom.to_string(k)
end
