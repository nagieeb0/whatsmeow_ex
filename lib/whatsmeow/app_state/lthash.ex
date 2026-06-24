defmodule Whatsmeow.AppState.LTHash do
  @moduledoc """
  WhatsApp's LTHash — a summation-based hash that supports add/remove of
  fixed-size mutations while keeping the final hash equal to a sequential
  application of the same mutations.

  Ports `whatsmeow-main/appstate/lthash/lthash.go`. Pure Elixir — no NIFs.

  The hash is a 128-byte buffer treated as 64 little-endian u16 slots.
  Each mutation contributes 128 bytes of HKDF-SHA256 output (info=`HKDFInfo`,
  size=128) which is pointwise-added (or subtracted, for removals) into
  the accumulator modulo 2^16.

  Used to verify WhatsApp app-state-sync patches.
  """

  alias Whatsmeow.Crypto.HKDF

  @hkdf_info "WhatsApp Patch Integrity"
  @hkdf_size 128

  @doc "The standard WhatsApp app-state instance."
  @spec wa_patch_integrity() :: %{info: binary(), size: pos_integer()}
  def wa_patch_integrity, do: %{info: @hkdf_info, size: @hkdf_size}

  @doc """
  Apply a series of subtractions then additions to `base`, returning a
  new buffer. `base`, each item in `subtract` and each item in `add` are
  raw binaries; subtracts/adds are HKDF-expanded internally.
  """
  @spec subtract_then_add(binary(), [binary()], [binary()]) :: binary()
  def subtract_then_add(base, subtract, add)
      when is_binary(base) and is_list(subtract) and is_list(add) do
    base
    |> apply_each(subtract, :sub)
    |> apply_each(add, :add)
  end

  @doc "Apply a list of additions to `base`."
  @spec add(binary(), [binary()]) :: binary()
  def add(base, items), do: apply_each(base, items, :add)

  @doc "Apply a list of subtractions to `base`."
  @spec sub(binary(), [binary()]) :: binary()
  def sub(base, items), do: apply_each(base, items, :sub)

  defp apply_each(base, items, op) do
    # Memoize HKDF expansions across the patch. WhatsApp patches can
    # carry duplicate `item` values (e.g. two `set value_mac` mutations
    # for the same index) — without memoization we'd HKDF-derive each
    # 128-byte expansion twice. The cache is local to this single call;
    # it doesn't outlive `apply_each/3` so there's no cross-patch leak.
    {result, _cache} =
      Enum.reduce(items, {base, %{}}, fn item, {acc, cache} ->
        {delta, cache} =
          case Map.fetch(cache, item) do
            {:ok, d} ->
              {d, cache}

            :error ->
              d = HKDF.derive(item, <<0::256>>, @hkdf_info, @hkdf_size)
              {d, Map.put(cache, item, d)}
          end

        {pointwise(acc, delta, op), cache}
      end)

    result
  end

  @doc """
  Pointwise add or subtract `input` from `base` (treating both as
  little-endian u16 arrays, mod 2^16).
  """
  @spec pointwise(binary(), binary(), :add | :sub) :: binary()
  def pointwise(base, input, op)
      when byte_size(base) == byte_size(input) and op in [:add, :sub] do
    do_pointwise(base, input, op, <<>>)
  end

  defp do_pointwise(<<>>, <<>>, _op, acc), do: acc

  defp do_pointwise(
         <<b::little-unsigned-16, base_rest::binary>>,
         <<i::little-unsigned-16, input_rest::binary>>,
         op,
         acc
       ) do
    r =
      case op do
        :add -> Bitwise.band(b + i, 0xFFFF)
        :sub -> Bitwise.band(b - i + 0x10000, 0xFFFF)
      end

    do_pointwise(base_rest, input_rest, op, <<acc::binary, r::little-unsigned-16>>)
  end
end
