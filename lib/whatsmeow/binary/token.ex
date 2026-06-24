defmodule Whatsmeow.Binary.Token do
  @moduledoc """
  WhatsApp binary-XML token tables, loaded at compile time from
  `priv/binary/tokens.json`. Regenerate that file with:

      mix whatsmeow.gen.tokens

  The data file is a faithful extraction of `whatsmeow-main/binary/token/token.go`.

  Two tables exist:

  * **Single-byte tokens** — 236 strings, each addressable by a single byte
    (0–235). Empty-string slots (index 0) are sentinel and never appear on
    the wire.
  * **Double-byte tokens** — 4 dictionaries × 256 strings, addressed by
    `(dict_index, byte_index)`.

  This module exposes constant-time lookups in both directions:
  `at_single/1`, `at_double/2`, `single_index/1`, `double_index/1`,
  `dict_version/0`.
  """

  @external_resource Path.join(["priv", "binary", "tokens.json"])

  @tokens @external_resource
          |> File.read!()
          |> Jason.decode!()

  @single @tokens["single"]
  @double @tokens["double"]
  @dict_version @tokens["dict_version"]

  @single_count length(@single)
  @double_dicts length(@double)

  @doc "Negotiated dictionary version sent in the WAConnHeader."
  @spec dict_version() :: integer()
  def dict_version, do: @dict_version

  @doc "Total number of single-byte tokens."
  @spec single_count() :: pos_integer()
  def single_count, do: @single_count

  @doc "Number of double-byte dictionaries (always 4)."
  @spec double_dict_count() :: pos_integer()
  def double_dict_count, do: @double_dicts

  # --- Index → string -------------------------------------------------------

  @doc "Get the single-byte token at `index`. Returns `:error` if out of bounds."
  @spec at_single(non_neg_integer()) :: {:ok, String.t()} | :error
  for {token, index} <- Enum.with_index(@single) do
    def at_single(unquote(index)), do: {:ok, unquote(token)}
  end

  def at_single(_), do: :error

  @doc "Get the double-byte token `(dict, index)`. Returns `:error` if out of bounds."
  @spec at_double(0..3, 0..255) :: {:ok, String.t()} | :error
  for {dict, dict_idx} <- Enum.with_index(@double) do
    for {token, index} <- Enum.with_index(dict) do
      def at_double(unquote(dict_idx), unquote(index)), do: {:ok, unquote(token)}
    end
  end

  def at_double(_, _), do: :error

  # --- String → index -------------------------------------------------------

  @doc """
  Look up a single-byte index for the given string. Returns `{:ok, byte}` if
  the string is in the table, `:error` otherwise.
  """
  @spec single_index(String.t()) :: {:ok, byte()} | :error
  for {token, index} <- Enum.with_index(@single), token != "" do
    def single_index(unquote(token)), do: {:ok, unquote(index)}
  end

  def single_index(_), do: :error

  @doc """
  Look up a double-byte index for the given string. Returns
  `{:ok, dict_byte, index_byte}` if found, `:error` otherwise.
  """
  @spec double_index(String.t()) :: {:ok, byte(), byte()} | :error
  for {dict, dict_idx} <- Enum.with_index(@double) do
    for {token, index} <- Enum.with_index(dict) do
      def double_index(unquote(token)), do: {:ok, unquote(dict_idx), unquote(index)}
    end
  end

  def double_index(_), do: :error
end
