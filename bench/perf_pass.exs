# Micro-benches for the 2026-05-19 perf pass. Run:
#
#     mix run bench/perf_pass.exs
#
# These don't need a network or DB — they exercise the in-process paths
# that the perf pass touched (HKDF, varint, the fanout shape, lthash).
# Numbers are wall-clock on the box you run on; absolute values are
# only meaningful for the same machine. The interesting figure is the
# RATIO between "old" and "new" for each block.

defmodule Bench.PerfPass do
  alias Whatsmeow.Crypto.HKDF
  alias Whatsmeow.Argo.Varint
  alias Whatsmeow.AppState.LTHash

  # --- Old implementations (kept here only so we can A/B compare) ---------

  def old_hkdf_expand(prk, info, length) do
    n = div(length + 32 - 1, 32)

    {okm, _last} =
      Enum.reduce(1..n, {<<>>, <<>>}, fn i, {acc, prev} ->
        t = :crypto.mac(:hmac, :sha256, prk, prev <> info <> <<i>>)
        {acc <> t, t}
      end)

    binary_part(okm, 0, length)
  end

  def old_varint_encode(n) when n > 0, do: old_varint(n, <<>>)
  defp old_varint(0, acc), do: acc

  defp old_varint(n, acc) do
    byte = Bitwise.band(n, 0x7F)
    rest = Bitwise.bsr(n, 7)

    if rest == 0,
      do: <<acc::binary, byte>>,
      else: old_varint(rest, <<acc::binary, Bitwise.bor(byte, 0x80)>>)
  end

  def old_apply_each(base, items, op) do
    Enum.reduce(items, base, fn item, acc ->
      delta = HKDF.derive(item, <<0::256>>, "WhatsApp Patch Integrity", 128)
      LTHash.pointwise(acc, delta, op)
    end)
  end

  # --- Drivers -----------------------------------------------------------

  def time_us(label, iters, fun) do
    # warm
    Enum.each(1..100, fn _ -> fun.() end)

    {us, _} = :timer.tc(fn -> Enum.each(1..iters, fn _ -> fun.() end) end)
    per = us / iters
    IO.puts(:io_lib.format("~-32s  ~10.2f us/op  (~p iters)", [label, per, iters]))
    per
  end

  def run do
    IO.puts("\n=== HKDF expand (PRK=32B, info=12B, len=64B, n=2 blocks) ===")
    prk = :crypto.strong_rand_bytes(32)
    info = "WhisperGroup"

    old1 = time_us("old hkdf expand (<>)", 50_000, fn -> old_hkdf_expand(prk, info, 64) end)
    new1 = time_us("new hkdf expand (iolist)", 50_000, fn -> HKDF.expand(prk, info, 64) end)
    IO.puts(:io_lib.format("  speedup: ~.2fx", [old1 / new1]))

    IO.puts("\n=== HKDF expand (len=128B, n=4 blocks) — app-state LTHash case ===")
    old2 = time_us("old hkdf expand (<>)", 30_000, fn -> old_hkdf_expand(prk, info, 128) end)
    new2 = time_us("new hkdf expand (iolist)", 30_000, fn -> HKDF.expand(prk, info, 128) end)
    IO.puts(:io_lib.format("  speedup: ~.2fx", [old2 / new2]))

    IO.puts("\n=== Varint encode (large u64 = 8 bytes) ===")
    n = 0xDEAD_BEEF_CAFE_BABE
    old3 = time_us("old varint (<>)", 200_000, fn -> old_varint_encode(n) end)
    new3 = time_us("new varint (iolist)", 200_000, fn -> Varint.unsigned_encode(n) end)
    IO.puts(:io_lib.format("  speedup: ~.2fx", [old3 / new3]))

    IO.puts("\n=== LTHash apply_each — 50 mutations, 10 unique items (dedup wins) ===")
    base = :crypto.strong_rand_bytes(128)
    # 10 unique items, repeated 5x each
    unique = for _ <- 1..10, do: :crypto.strong_rand_bytes(64)
    items = unique |> List.duplicate(5) |> List.flatten() |> Enum.shuffle()

    old4 = time_us("old apply_each (no memo)", 200, fn -> old_apply_each(base, items, :add) end)
    new4 = time_us("new apply_each (memo)", 200, fn -> LTHash.add(base, items) end)
    IO.puts(:io_lib.format("  speedup: ~.2fx", [old4 / new4]))

    IO.puts("\n=== Fanout simulation — 50 'recipients', 5ms simulated work each ===")
    # Simulates a group-of-50 send. Each recipient = ~5 ms of "encrypt + DB"
    # (sleep+busy mixture). Compares serial Enum.map vs Task.async_stream.
    work = fn _ ->
      # 5 ms wall — half sleep (I/O-like), half crypto (CPU)
      Process.sleep(2)
      _ = :crypto.hash(:sha256, :crypto.strong_rand_bytes(8_192))
      :ok
    end

    {us_serial, _} = :timer.tc(fn -> Enum.each(1..50, work) end)

    {us_parallel, _} =
      :timer.tc(fn ->
        1..50
        |> Task.async_stream(work, max_concurrency: 8, ordered: false, timeout: 30_000)
        |> Enum.each(fn _ -> :ok end)
      end)

    IO.puts(:io_lib.format("  serial    : ~.1f ms", [us_serial / 1000]))

    IO.puts(
      :io_lib.format("  parallel/8: ~.1f ms  (speedup: ~.2fx)", [
        us_parallel / 1000,
        us_serial / us_parallel
      ])
    )

    IO.puts("\n=== Fanout — same 50 recipients but each does 20 ms (slow PreKey bundle) ===")

    work2 = fn _ ->
      Process.sleep(20)
      :ok
    end

    {us_serial2, _} = :timer.tc(fn -> Enum.each(1..50, work2) end)

    {us_parallel2, _} =
      :timer.tc(fn ->
        1..50
        |> Task.async_stream(work2, max_concurrency: 8, ordered: false, timeout: 30_000)
        |> Enum.each(fn _ -> :ok end)
      end)

    IO.puts(:io_lib.format("  serial    : ~.1f ms", [us_serial2 / 1000]))

    IO.puts(
      :io_lib.format("  parallel/8: ~.1f ms  (speedup: ~.2fx)", [
        us_parallel2 / 1000,
        us_serial2 / us_parallel2
      ])
    )
  end
end

Bench.PerfPass.run()
