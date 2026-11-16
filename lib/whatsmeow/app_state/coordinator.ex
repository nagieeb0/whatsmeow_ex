defmodule Whatsmeow.AppState.Coordinator do
  @moduledoc """
  Serialises app-state work per device, and throttles key requests.

  Two things from Go's `Client` struct live here:

    * `appStateSyncLock` — a collection's version and LTHash are read, extended
      and written back as one unit. Two overlapping fetches, or a fetch racing a
      send, would both start from the same stored state and the loser would write
      a hash the server never produced. One FIFO lock per device (`our_jid`).
    * `appStateKeyRequests` — each missing key is asked of the phone at most once
      per 24 hours; the phone answers at its own pace and re-asking in a loop is
      what gets a companion rate-limited.

  The lock is held by a *process*: if its holder dies the lock is released, and a
  waiter that gives up (timeout) is removed from the queue, so neither can wedge
  a device's app-state until restart.
  """

  use GenServer

  @request_ttl_ms 24 * 60 * 60 * 1000

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, name: Keyword.get(opts, :name, __MODULE__))
  end

  @doc """
  Run `fun` while holding the lock for `key`.

  Returns `{:ok, result}`, or `{:error, :lock_timeout}` if the lock could not be
  had within `timeout` ms, or `{:error, :coordinator_down}`. `fun` is *not* run in
  either error case. If `fun` raises, the lock is released and the error
  re-raised.
  """
  @spec with_lock(term(), (-> result), timeout()) ::
          {:ok, result} | {:error, :lock_timeout | :coordinator_down}
        when result: term()
  def with_lock(key, fun, timeout \\ 120_000) when is_function(fun, 0) do
    case acquire(key, timeout) do
      :ok ->
        try do
          {:ok, fun.()}
        after
          GenServer.cast(__MODULE__, {:release, key, self()})
        end

      {:error, _} = err ->
        err
    end
  end

  defp acquire(key, timeout) do
    GenServer.call(__MODULE__, {:acquire, key, self()}, timeout)
  catch
    :exit, {:timeout, _} ->
      # We may have been granted the lock in the instant we gave up — `:cancel`
      # releases it in that case too.
      GenServer.cast(__MODULE__, {:cancel, key, self()})
      {:error, :lock_timeout}

    :exit, {:noproc, _} ->
      {:error, :coordinator_down}
  end

  @doc """
  Of `key_ids`, those that may be requested from the phone now — i.e. not asked
  for within the last 24h — recording them as requested. Go:
  `requestMissingAppStateKeys`'s filter.
  """
  @spec claim_key_requests(term(), [binary()], integer()) :: [binary()]
  def claim_key_requests(device_key, key_ids, now_ms \\ System.os_time(:millisecond)) do
    GenServer.call(__MODULE__, {:claim, device_key, key_ids, now_ms})
  catch
    :exit, _ -> []
  end

  @doc "Whether we have asked the phone for `key_id` (any time). Go: the `isReRequest` check."
  @spec requested?(term(), binary()) :: boolean()
  def requested?(device_key, key_id) do
    GenServer.call(__MODULE__, {:requested?, device_key, key_id})
  catch
    :exit, _ -> false
  end

  @doc false
  # Test helper: forget which keys have been requested. Locks are untouched.
  def reset_requests, do: GenServer.call(__MODULE__, :reset_requests)

  # --- server -----------------------------------------------------------------

  @impl true
  def init(:ok), do: {:ok, %{locks: %{}, requests: %{}}}

  @impl true
  def handle_call({:acquire, key, pid}, from, state) do
    case state.locks do
      %{^key => lock} ->
        lock = %{lock | queue: :queue.in({pid, from}, lock.queue)}
        {:noreply, put_in(state.locks[key], lock)}

      _ ->
        {:reply, :ok, put_in(state.locks[key], grant(pid))}
    end
  end

  def handle_call({:claim, device_key, key_ids, now}, _from, state) do
    {allowed, requests} =
      Enum.reduce(Enum.uniq(key_ids), {[], state.requests}, fn id, {acc, reqs} ->
        case Map.get(reqs, {device_key, id}) do
          last when is_integer(last) and last + @request_ttl_ms > now -> {acc, reqs}
          _ -> {[id | acc], Map.put(reqs, {device_key, id}, now)}
        end
      end)

    {:reply, Enum.reverse(allowed), %{state | requests: requests}}
  end

  def handle_call(:reset_requests, _from, state), do: {:reply, :ok, %{state | requests: %{}}}

  def handle_call({:requested?, device_key, key_id}, _from, state) do
    {:reply, Map.has_key?(state.requests, {device_key, key_id}), state}
  end

  @impl true
  def handle_cast({:release, key, pid}, state), do: {:noreply, release(state, key, pid)}

  def handle_cast({:cancel, key, pid}, state) do
    state =
      case state.locks do
        %{^key => %{holder: ^pid}} ->
          release(state, key, pid)

        %{^key => lock} ->
          queue = :queue.filter(fn {p, _from} -> p != pid end, lock.queue)
          put_in(state.locks[key], %{lock | queue: queue})

        _ ->
          state
      end

    {:noreply, state}
  end

  @impl true
  def handle_info({:DOWN, ref, :process, _pid, _reason}, state) do
    case Enum.find(state.locks, fn {_k, l} -> l.ref == ref end) do
      {key, %{holder: pid}} -> {:noreply, release(state, key, pid)}
      nil -> {:noreply, state}
    end
  end

  def handle_info(_msg, state), do: {:noreply, state}

  defp grant(pid), do: %{holder: pid, ref: Process.monitor(pid), queue: :queue.new()}

  defp release(state, key, pid) do
    case state.locks do
      %{^key => %{holder: ^pid, ref: ref, queue: queue}} ->
        Process.demonitor(ref, [:flush])
        next(state, key, queue)

      _ ->
        state
    end
  end

  # Hand the lock to the next waiter that is still alive.
  defp next(state, key, queue) do
    case :queue.out(queue) do
      {:empty, _} ->
        %{state | locks: Map.delete(state.locks, key)}

      {{:value, {pid, from}}, rest} ->
        if Process.alive?(pid) do
          GenServer.reply(from, :ok)
          put_in(state.locks[key], %{grant(pid) | queue: rest})
        else
          next(state, key, rest)
        end
    end
  end
end
