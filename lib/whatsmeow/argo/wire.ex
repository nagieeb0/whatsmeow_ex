defmodule Whatsmeow.Argo.Wire do
  @moduledoc """
  Argo wire types — the schema vocabulary against which Argo payloads
  are encoded and decoded.

  Ports the type tags from `github.com/beeper/argo-go/wire`.

  Wire types are represented as tagged tuples for cheap structural
  matching:

      :string                                # StringType
      :boolean
      :varint                                # signed varint
      :float64
      :bytes
      :path
      {:fixed, len}                          # FixedType (fixed-length bytes)
      {:nullable, inner_type}
      {:array, inner_type}
      {:block, key :: binary, inner_type, dedupe :: boolean}
      {:record, [{name, omittable, inner_type}, ...]}
      :desc                                  # self-describing value
      :extensions
  """

  @type t ::
          :string
          | :boolean
          | :varint
          | :float64
          | :bytes
          | :path
          | {:fixed, pos_integer()}
          | {:nullable, t()}
          | {:array, t()}
          | {:block, binary(), t(), boolean()}
          | {:record, [{binary(), boolean(), t()}]}
          | :desc
          | :extensions

  @primitive [:string, :boolean, :varint, :float64, :bytes, :path]

  @doc """
  Returns the type's canonical key string, matching the Go upstream
  `GetTypeKey/0`.
  """
  @spec type_key(t()) :: String.t()
  def type_key(:string), do: "STRING"
  def type_key(:boolean), do: "BOOLEAN"
  def type_key(:varint), do: "VARINT"
  def type_key(:float64), do: "FLOAT64"
  def type_key(:bytes), do: "BYTES"
  def type_key(:path), do: "PATH"
  def type_key({:fixed, _}), do: "FIXED"
  def type_key({:block, _, _, _}), do: "BLOCK"
  def type_key({:nullable, _}), do: "NULLABLE"
  def type_key({:array, _}), do: "ARRAY"
  def type_key({:record, _}), do: "RECORD"
  def type_key(:desc), do: "DESC"
  def type_key(:extensions), do: "EXTENSIONS"

  @doc "Returns true if the wire type is a primitive."
  @spec primitive?(t()) :: boolean()
  def primitive?(t), do: t in @primitive

  @doc "List of primitive wire-type tags."
  @spec primitives() :: [t()]
  def primitives, do: @primitive
end
