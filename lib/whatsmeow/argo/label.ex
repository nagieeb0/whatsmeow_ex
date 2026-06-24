defmodule Whatsmeow.Argo.Label do
  @moduledoc """
  Argo labels — signed ZigZag-ULEB128 integers carrying length or sentinel
  values (null / absent / error / backreference).

  Ports `github.com/beeper/argo-go/label`.
  """

  alias Whatsmeow.Argo.Varint

  @null -1
  @absent -2
  @error -3
  @lowest_reserved -3

  @true_marker 1
  @false_marker 0
  @non_null_marker 0

  @type t :: integer()
  @type kind :: :null | :absent | :error | :backref | :length

  @doc "Sentinel values, exposed for pattern-matching by callers."
  def null, do: @null
  def absent, do: @absent
  def error_marker, do: @error
  def true_marker, do: @true_marker
  def false_marker, do: @false_marker
  def non_null_marker, do: @non_null_marker

  @doc """
  Classify a raw label value into one of:
  `:null`, `:absent`, `:error`, `:backref`, or `:length`.
  """
  @spec kind(integer()) :: kind()
  def kind(@null), do: :null
  def kind(@absent), do: :absent
  def kind(@error), do: :error
  def kind(n) when is_integer(n) and n < @lowest_reserved, do: :backref
  def kind(n) when is_integer(n) and n >= 0, do: :length

  @doc "Encode a label as ZigZag-ULEB128 bytes."
  @spec encode(integer()) :: binary()
  def encode(n) when is_integer(n), do: Varint.signed_encode(n)

  @doc "Read one label from the head of `bin`."
  @spec read(binary()) :: {integer(), binary()} | {:error, atom()}
  def read(bin) when is_binary(bin), do: Varint.signed_decode(bin)

  @doc """
  Convert a backreference label to a positive (1-based) offset. Returns
  `{:error, :not_a_backref}` if the label is not in the backref range.
  """
  @spec to_offset(integer()) :: {:ok, non_neg_integer()} | {:error, :not_a_backref}
  def to_offset(n) when is_integer(n) and n < @lowest_reserved do
    {:ok, -n + @lowest_reserved}
  end

  def to_offset(_), do: {:error, :not_a_backref}
end
