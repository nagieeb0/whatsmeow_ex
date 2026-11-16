defmodule Whatsmeow.AppState.CoordinatorTest do
  @moduledoc """
  The per-device lock and the key-request throttle.

  The lock is what stops two app-state operations on one device both starting from
  the same stored hash; the properties that matter beyond mutual exclusion are the
  ones that keep a device from being wedged: a dead holder releases, a timed-out
  waiter leaves the queue, a raising critical section releases.
  """
  use ExUnit.Case, async: false

  alias Whatsmeow.AppState.Coordinator

  setup do
    Coordinator.reset_requests()
    %{key: {:dev, System.unique_integer([:positive])}}
  end

  test "runs the function and returns its value", %{key: key} do
    assert {:ok, 42} = Coordinator.with_lock(key, fn -> 42 end)
  end

  test "mutual exclusion: concurrent holders of one key never overlap", %{key: key} do
    {:ok, counter} = Agent.start_link(fn -> %{in: 0, max: 0} end)

    tasks =
      for _ <- 1..8 do
        Task.async(fn ->
          Coordinator.with_lock(key, fn ->
            Agent.update(counter, fn s -> %{s | in: s.in + 1, max: max(s.max, s.in + 1)} end)
            Process.sleep(10)
            Agent.update(counter, fn s -> %{s | in: s.in - 1} end)
          end)
        end)
      end

    assert Enum.all?(Task.await_many(tasks, 10_000), &match?({:ok, _}, &1))
    assert %{max: 1} = Agent.get(counter, & &1)
  end

  test "different keys do not block each other", %{key: key} do
    parent = self()

    holder =
      Task.async(fn ->
        Coordinator.with_lock(key, fn ->
          send(parent, :holding)
          receive do: (:go -> :ok)
        end)
      end)

    assert_receive :holding
    assert {:ok, :other} = Coordinator.with_lock({:other, key}, fn -> :other end, 1_000)
    send(holder.pid, :go)
    Task.await(holder)
  end

  test "waiters are served in arrival order", %{key: key} do
    parent = self()

    holder =
      Task.async(fn ->
        Coordinator.with_lock(key, fn ->
          send(parent, :holding)
          receive do: (:go -> :ok)
        end)
      end)

    assert_receive :holding

    waiters =
      for n <- 1..4 do
        t = Task.async(fn -> Coordinator.with_lock(key, fn -> send(parent, {:ran, n}) end) end)
        # make sure waiter n is queued before n+1 starts
        Process.sleep(20)
        t
      end

    send(holder.pid, :go)
    Task.await(holder)
    Task.await_many(waiters)

    # `receive` takes the first matching message in mailbox order, so this reads the
    # order in which the waiters actually ran.
    order =
      for _ <- 1..4 do
        receive do
          {:ran, n} -> n
        after
          1_000 -> flunk("waiter never ran")
        end
      end

    assert order == [1, 2, 3, 4]
  end

  test "a waiter that times out is removed; the function is NOT run; the holder is unaffected", %{
    key: key
  } do
    parent = self()

    holder =
      Task.async(fn ->
        Coordinator.with_lock(key, fn ->
          send(parent, :holding)
          receive do: (:go -> :done)
        end)
      end)

    assert_receive :holding

    assert {:error, :lock_timeout} =
             Coordinator.with_lock(key, fn -> send(parent, :should_not_run) end, 50)

    refute_receive :should_not_run, 100

    send(holder.pid, :go)
    assert {:ok, :done} = Task.await(holder)

    # And the lock is free again — the abandoned waiter did not inherit and leak it.
    assert {:ok, :free} = Coordinator.with_lock(key, fn -> :free end, 1_000)
  end

  test "a holder that dies releases the lock", %{key: key} do
    parent = self()

    {:ok, pid} =
      Task.start(fn ->
        Coordinator.with_lock(key, fn ->
          send(parent, :holding)
          Process.sleep(:infinity)
        end)
      end)

    assert_receive :holding
    ref = Process.monitor(pid)
    Process.exit(pid, :kill)
    assert_receive {:DOWN, ^ref, _, _, _}

    assert {:ok, :ok} = Coordinator.with_lock(key, fn -> :ok end, 2_000)
  end

  test "a raising critical section releases and re-raises", %{key: key} do
    assert_raise RuntimeError, "boom", fn -> Coordinator.with_lock(key, fn -> raise "boom" end) end
    assert {:ok, :after} = Coordinator.with_lock(key, fn -> :after end, 1_000)
  end

  describe "key request throttle" do
    test "a key is claimed once, then not again within 24h", %{key: key} do
      t0 = 1_000_000
      assert [<<1>>, <<2>>] = Coordinator.claim_key_requests(key, [<<1>>, <<2>>, <<1>>], t0)
      assert [] = Coordinator.claim_key_requests(key, [<<1>>, <<2>>], t0 + 1_000)
      assert [<<3>>] = Coordinator.claim_key_requests(key, [<<1>>, <<3>>], t0 + 1_000)
    end

    test "…and again after 24h", %{key: key} do
      t0 = 1_000_000
      [<<1>>] = Coordinator.claim_key_requests(key, [<<1>>], t0)
      assert [] = Coordinator.claim_key_requests(key, [<<1>>], t0 + 24 * 3_600_000 - 1)
      assert [<<1>>] = Coordinator.claim_key_requests(key, [<<1>>], t0 + 24 * 3_600_000 + 1)
    end

    test "per device", %{key: key} do
      assert [<<1>>] = Coordinator.claim_key_requests(key, [<<1>>])
      assert [<<1>>] = Coordinator.claim_key_requests({:other, key}, [<<1>>])
    end

    test "requested?/2 reflects claims", %{key: key} do
      refute Coordinator.requested?(key, <<7>>)
      Coordinator.claim_key_requests(key, [<<7>>])
      assert Coordinator.requested?(key, <<7>>)
    end
  end
end
