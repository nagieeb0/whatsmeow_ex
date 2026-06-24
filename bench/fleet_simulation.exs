# Fleet-scale simulation. Spawns N "agent" GenServers, each subscribed to
# its own per-device PubSub topic; then publishes N events (one per agent)
# and measures end-to-end delivery latency.
#
# This does NOT touch the network, Postgres, or Signal crypto — it isolates
# the BEAM + Phoenix.PubSub fan-out cost that a real fleet would pay on top
# of the per-session WSS work. Multiply mean × N to ground-truth your RAM
# planning for any agent framework (Jido / Ash / your own GenServer).
#
# Run:    N=10000 mix run bench/fleet_simulation.exs
#         N=50000 mix run bench/fleet_simulation.exs     # needs ~250 MB
#
# A real 100 k live-WhatsApp fleet additionally needs:
#   * 100 k TLS sockets    → +1.6–3.2 GB Mint buffers
#   * ~10 k pending IQs at steady state → trivial
#   * Postgres pool sized for `send_concurrency * active_sessions / N_nodes`
#
# So 100 k WSS sessions on one BEAM node is feasible at ~6 GB total. Use a
# distributed cluster (libcluster + Phoenix.PubSub PG2 adapter) and split
# across 2–4 nodes for headroom.

Application.ensure_all_started(:whatsmeow_ex)

defmodule Bench.Fleet do
  alias Whatsmeow.Notifications
  alias Whatsmeow.Types.Events

  defmodule Agent do
    use GenServer

    def start_link(opts), do: GenServer.start_link(__MODULE__, opts)

    def init(opts) do
      device_id = Keyword.fetch!(opts, :device_id)
      :ok = Notifications.subscribe(device_id)
      {:ok, %{device_id: device_id, count: 0, report_to: opts[:report_to]}}
    end

    def handle_info(
          {:whatsmeow, %Events.Receipt{message_ids: [t_str]}},
          %{report_to: pid} = state
        )
        when is_pid(pid) do
      sent_us = String.to_integer(t_str)
      now_us = System.monotonic_time(:microsecond)
      send(pid, {:received, now_us - sent_us})
      {:noreply, %{state | count: state.count + 1}}
    end

    def handle_info(_msg, state), do: {:noreply, state}
  end

  def percentiles(xs) do
    sorted = Enum.sort(xs)
    n = length(sorted)
    at = fn p -> Enum.at(sorted, max(0, min(n - 1, trunc(p * n))) - 1) end
    %{p50: at.(0.50), p95: at.(0.95), p99: at.(0.99), max: List.last(sorted), n: n}
  end

  def run(n) do
    IO.puts("\n=== Fleet simulation: N=#{n} agents ===\n")

    # 1) Spawn agents.
    t0 = System.monotonic_time(:millisecond)
    me = self()

    agents =
      for i <- 1..n do
        device_id = "fleet-#{i}"
        {:ok, pid} = Agent.start_link(device_id: device_id, report_to: me)
        {device_id, pid}
      end

    spawn_ms = System.monotonic_time(:millisecond) - t0

    IO.puts("  spawn: #{spawn_ms} ms  (#{Float.round(n / max(spawn_ms, 1) * 1000, 1)} agents/s)")

    Process.sleep(200)
    :erlang.garbage_collect()
    for {_id, pid} <- agents, do: :erlang.garbage_collect(pid)
    Process.sleep(100)

    # 2) Measure BEAM memory.
    total_mem =
      agents
      |> Enum.map(fn {_id, pid} ->
        :erlang.process_info(pid, :memory) |> elem(1)
      end)
      |> Enum.sum()

    IO.puts(
      "  memory: total #{Float.round(total_mem / 1024 / 1024, 1)} MB  (#{Float.round(total_mem / n / 1024, 2)} KB/agent)"
    )

    sys_mem = :erlang.memory()

    IO.puts(
      "          BEAM total #{Float.round(sys_mem[:total] / 1024 / 1024, 1)} MB  processes #{Float.round(sys_mem[:processes] / 1024 / 1024, 1)} MB  ets #{Float.round(sys_mem[:ets] / 1024 / 1024, 1)} MB"
    )

    # 3) Publish one event per agent. Each event carries a monotonic timestamp;
    #    the agent reports its delivery latency.
    publish_t0 = System.monotonic_time(:millisecond)

    for {device_id, _pid} <- agents do
      ts = System.monotonic_time(:microsecond)

      Notifications.broadcast(device_id, %Events.Receipt{
        device_id: device_id,
        type: :delivery,
        message_ids: [Integer.to_string(ts)]
      })
    end

    publish_ms = System.monotonic_time(:millisecond) - publish_t0

    IO.puts(
      "  publish: #{publish_ms} ms  (#{Float.round(n / max(publish_ms, 1) * 1000, 1)} events/s)"
    )

    # 4) Collect delivery latencies.
    latencies = collect_latencies(n, [], System.monotonic_time(:millisecond) + 30_000)

    if length(latencies) < n do
      IO.puts(
        "  WARNING: only #{length(latencies)}/#{n} latencies received (timeout) — interpret with care"
      )
    end

    p = percentiles(latencies)

    IO.puts(
      "  delivery latency  (µs):  p50=#{p.p50}  p95=#{p.p95}  p99=#{p.p99}  max=#{p.max}  (n=#{p.n})"
    )

    # 5) Extrapolation to 100 k.
    ratio = 100_000 / n

    IO.puts("\n  Extrapolation to 100 k agents (linear, no I/O):")

    IO.puts(
      "    memory: ~#{Float.round(total_mem * ratio / 1024 / 1024 / 1024, 2)} GB BEAM-side (just process struct, no sockets)"
    )

    IO.puts(
      "    spawn: ~#{Float.round(spawn_ms * ratio / 1000, 1)} s  (one-shot cost; parallelisable across nodes)"
    )

    IO.puts(
      "    publish-storm: ~#{Float.round(publish_ms * ratio / 1000, 1)} s if every agent receives an event in the same instant"
    )

    # 6) Tear down.
    for {_id, pid} <- agents, do: Process.exit(pid, :kill)
    Process.sleep(100)
    :ok
  end

  defp collect_latencies(target, acc, deadline) do
    cond do
      length(acc) >= target ->
        acc

      System.monotonic_time(:millisecond) > deadline ->
        acc

      true ->
        receive do
          {:received, lat} -> collect_latencies(target, [lat | acc], deadline)
        after
          50 -> collect_latencies(target, acc, deadline)
        end
    end
  end
end

n = String.to_integer(System.get_env("N") || "10000")
Bench.Fleet.run(n)
