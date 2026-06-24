# Bench the receive-side hot paths the perf pass touched:
#   1. Phoenix.PubSub broadcast cost (sync), per subscriber count
#   2. broadcast vs broadcast_async wall-clock on the publisher
#   3. Ordering check: does broadcast_async preserve per-device order?
#   4. Wire-loop "blocked-time" under a slow subscriber, sync vs async
#
# Run:    mix run bench/recv_path.exs

Application.ensure_all_started(:whatsmeow_ex)

defmodule Bench.Recv do
  alias Whatsmeow.Notifications

  def time_us(label, fun) do
    {us, ret} = :timer.tc(fun)
    padded = String.pad_trailing(label, 48)
    IO.puts("#{padded}  #{us} us")
    {us, ret}
  end

  def fast_sub(device_id, parent) do
    spawn(fn ->
      :ok = Notifications.subscribe(device_id)
      send(parent, {:ready, self()})
      loop_count(0)
    end)
  end

  defp loop_count(n) do
    receive do
      {:get_count, from} -> send(from, {:count, n})
      _ -> loop_count(n + 1)
    end
  end

  def slow_sub(device_id, parent, sleep_ms) do
    spawn(fn ->
      :ok = Notifications.subscribe(device_id)
      send(parent, {:ready, self()})
      slow_loop(sleep_ms)
    end)
  end

  defp slow_loop(sleep_ms) do
    receive do
      _ ->
        Process.sleep(sleep_ms)
        slow_loop(sleep_ms)
    end
  end

  def run do
    device = "bench-recv-#{:erlang.unique_integer([:positive])}"
    evt = %Whatsmeow.Types.Events.Receipt{device_id: device, type: :delivery, message_ids: ["x"]}

    IO.puts("\n=== 1) broadcast cost vs number of subscribers (sync) ===")

    for n_subs <- [1, 10, 100, 1_000] do
      subs =
        for _ <- 1..n_subs do
          pid = fast_sub(device, self())

          receive do
            {:ready, ^pid} -> pid
          after
            1_000 -> raise "sub didn't start"
          end
        end

      {us, _} =
        time_us("  sync broadcast → #{n_subs} subs", fn -> Notifications.broadcast(device, evt) end)

      IO.puts(:io_lib.format("    per-subscriber: ~.2f us", [us / n_subs]))

      Enum.each(subs, &Process.exit(&1, :kill))
      Process.sleep(20)
    end

    IO.puts("\n=== 2) sync vs async broadcast — publisher's return time ===")
    pid = fast_sub(device, self())

    receive do
      {:ready, ^pid} -> :ok
    after
      1_000 -> raise :no_ready
    end

    iters = 10_000

    {us_sync, _} =
      :timer.tc(fn ->
        Enum.each(1..iters, fn _ -> Notifications.broadcast(device, evt) end)
      end)

    {us_async, _} =
      :timer.tc(fn ->
        Enum.each(1..iters, fn _ -> Notifications.broadcast_async(device, evt) end)
      end)

    IO.puts(:io_lib.format("  sync   ~.2f us/op", [us_sync / iters]))

    IO.puts(
      :io_lib.format("  async  ~.2f us/op  (publisher returns this fast)", [us_async / iters])
    )

    Process.exit(pid, :kill)
    Process.sleep(50)

    IO.puts("\n=== 3) Ordering: does async preserve per-device order at one subscriber? ===")
    me = self()

    receiver =
      spawn(fn ->
        :ok = Notifications.subscribe(device)
        send(me, {:ready, self()})
        collect(me, [])
      end)

    receive do
      {:ready, ^receiver} -> :ok
    after
      1_000 -> raise :no_ready
    end

    n = 1_000

    Enum.each(1..n, fn i ->
      Notifications.broadcast_async(device, %Whatsmeow.Types.Events.Receipt{
        device_id: device,
        type: :delivery,
        message_ids: [Integer.to_string(i)]
      })
    end)

    # Let all tasks drain.
    Process.sleep(500)
    send(receiver, :report)

    received =
      receive do
        {:received, list} -> Enum.reverse(list)
      after
        2_000 -> raise :no_report
      end

    seqs = Enum.map(received, fn %{message_ids: [s]} -> String.to_integer(s) end)
    in_order = seqs == Enum.sort(seqs)
    IO.puts("  delivered #{length(seqs)}/#{n} msgs, in-order? #{in_order}")

    if not in_order do
      diffs =
        seqs
        |> Enum.with_index()
        |> Enum.filter(fn {s, i} -> s != i + 1 end)
        |> Enum.take(5)

      IO.puts("  first 5 mismatches (got, expected): #{inspect(diffs)}")
    end

    Process.exit(receiver, :kill)
    Process.sleep(50)

    IO.puts("\n=== 4) Wire-loop blocked-time with a slow subscriber (200 ms/msg) ===")
    slow = slow_sub(device, self(), 200)

    receive do
      {:ready, ^slow} -> :ok
    after
      1_000 -> raise :no_ready
    end

    # Sync: publisher blocks for ~each subscriber's send/2 enqueue. send/2 itself
    # doesn't block on mailbox draining — so this should still be fast. The
    # observable effect is the subscriber's BACKPRESSURE on the publisher only
    # if the mailbox fills. We measure publisher return time.
    {us1, _} =
      time_us("  sync   broadcast (slow sub up)", fn -> Notifications.broadcast(device, evt) end)

    {us2, _} =
      time_us("  async  broadcast (slow sub up)", fn ->
        Notifications.broadcast_async(device, evt)
      end)

    IO.puts(
      :io_lib.format("  delta: sync=~p us  async=~p us  (ratio ~.2fx)", [
        us1,
        us2,
        us1 / max(us2, 1)
      ])
    )

    Process.exit(slow, :kill)
    :ok
  end

  defp collect(parent, acc) do
    receive do
      {:whatsmeow, evt} -> collect(parent, [evt | acc])
      :report -> send(parent, {:received, acc})
    end
  end
end

Bench.Recv.run()
