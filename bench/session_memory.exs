# Measure idle-session memory footprint without going over the network.
#
# Spins up N `Whatsmeow.Session` processes in :idle state (no transport
# connect — just the GenServer + struct + supervisor accounting), then
# samples `:erlang.process_info(pid, [:memory, :heap_size, :total_heap_size,
# :message_queue_len])` and reports min / mean / p95 / max.
#
# Run:
#
#     N=1000 mix run bench/session_memory.exs
#
# Tips:
#
# * Run twice — the first run includes module load + Phoenix.PubSub warmup;
#   the second is steady-state.
# * Multiply mean × 50_000 to estimate session RAM at fleet scale. That
#   number does NOT include TLS socket buffers (sessions here are :idle —
#   no socket). Production figures should be 16–32 KB higher per session.

n = String.to_integer(System.get_env("N") || "1000")

IO.puts("[bench] spawning #{n} idle sessions…")

t0 = System.monotonic_time(:millisecond)

pids =
  for i <- 1..n do
    device_id = "bench-#{i}-#{System.unique_integer([:positive])}"
    {:ok, pid} = Whatsmeow.Session.start_link(device_id: device_id)
    pid
  end

spawn_ms = System.monotonic_time(:millisecond) - t0
IO.puts("[bench] spawned in #{spawn_ms} ms (#{Float.round(n / spawn_ms * 1000, 1)} sessions/s)")

# Let processes settle + GC.
Process.sleep(200)
:erlang.garbage_collect()
for pid <- pids, do: :erlang.garbage_collect(pid)
Process.sleep(50)

samples =
  for pid <- pids do
    info =
      :erlang.process_info(pid, [
        :memory,
        :heap_size,
        :total_heap_size,
        :message_queue_len
      ])

    Keyword.get(info, :memory, 0)
  end

stats = fn xs ->
  sorted = Enum.sort(xs)
  count = length(sorted)
  sum = Enum.sum(sorted)

  %{
    count: count,
    min: Enum.at(sorted, 0),
    mean: div(sum, max(count, 1)),
    p50: Enum.at(sorted, div(count, 2)),
    p95: Enum.at(sorted, max(div(count * 95, 100) - 1, 0)),
    max: Enum.at(sorted, count - 1),
    total: sum
  }
end

s = stats.(samples)

format_bytes = fn b ->
  cond do
    b >= 1_048_576 -> "#{Float.round(b / 1_048_576, 2)} MB"
    b >= 1024 -> "#{Float.round(b / 1024, 1)} KB"
    true -> "#{b} B"
  end
end

IO.puts("""

[bench] idle-session memory (BEAM process accounting only, no TLS socket):

  count: #{s.count}
    min: #{format_bytes.(s.min)}
   mean: #{format_bytes.(s.mean)}
    p50: #{format_bytes.(s.p50)}
    p95: #{format_bytes.(s.p95)}
    max: #{format_bytes.(s.max)}
  total: #{format_bytes.(s.total)}

[bench] projected RAM at 50k sessions (BEAM only):
  mean × 50_000 = #{format_bytes.(s.mean * 50_000)}

[bench] add ~16–32 KB/session for a live TLS socket + Mint buffers in production.
""")

IO.puts("[bench] cleaning up…")

for pid <- pids do
  if Process.alive?(pid), do: Whatsmeow.Session.stop(pid)
end
