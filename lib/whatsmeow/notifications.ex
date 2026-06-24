defmodule Whatsmeow.Notifications do
  @moduledoc """
  PubSub broadcast/subscribe helpers for `Whatsmeow.Types.Events.*`.

  Sessions emit `{:whatsmeow, event_struct}` messages on the
  `Whatsmeow.PubSub` registry. Subscribers can listen to:

  * `{:device, device_id}` — events for one session
  * `:all` — every session's events. **Off by default.** At fleet scale
    (50k+ sessions) one global firehose subscriber becomes a bottleneck
    and a memory amplifier. Enable explicitly via:

        config :whatsmeow_ex, Whatsmeow.Notifications, all_topic?: true

    Useful for tests/dashboards. Never enable in tenant-facing prod.
  """

  @pubsub Whatsmeow.PubSub

  @type topic :: {:device, String.t() | :all}
  @type event :: struct()

  @doc """
  Broadcast `event` for `device_id`.

  Always publishes to the per-device topic. Also publishes to the global
  `:all` topic *if* it's been opted into via config — see the module
  docs.
  """
  @spec broadcast(String.t(), event()) :: :ok | {:error, term()}
  def broadcast(device_id, event) when is_binary(device_id) and is_struct(event) do
    message = {:whatsmeow, event}

    with :ok <- Phoenix.PubSub.broadcast(@pubsub, device_topic(device_id), message) do
      if all_topic_enabled?() do
        Phoenix.PubSub.broadcast(@pubsub, all_topic(), message)
      else
        :ok
      end
    end
  end

  @doc """
  Fire-and-forget broadcast — spawns the publish under
  `Whatsmeow.Sessions.TaskSup`. Returns `:ok` immediately.

  ## DO NOT USE for messages, receipts, or any per-chat-ordering-sensitive
  event.

  Benchmarked 2026-05-19: synchronous `broadcast/2` is ~1 µs/subscriber
  locally and `send/2` is non-blocking, so the original "broadcasts stall
  the wire loop" concern doesn't reproduce. Spawning a Task per
  broadcast actually costs ~15 µs and — critically — breaks per-subscriber
  message order, because two Tasks from different pids have no
  message-ordering guarantee to the same subscriber. A 1000-message
  bench round comes back unordered with this path.

  This function exists for the rare case where you genuinely have a
  custom slow PubSub adapter (e.g. distributed broadcast across a WAN)
  AND you don't care about ordering. For inbound WhatsApp events,
  always call `broadcast/2`.
  """
  @spec broadcast_async(String.t(), event()) :: :ok
  def broadcast_async(device_id, event) when is_binary(device_id) and is_struct(event) do
    sup = Whatsmeow.Sessions.TaskSup

    if is_pid(Process.whereis(sup)) do
      _ = Task.Supervisor.start_child(sup, fn -> broadcast(device_id, event) end)
      :ok
    else
      # Boot path / tests without the supervisor up — fall back to sync.
      _ = broadcast(device_id, event)
      :ok
    end
  end

  @doc "Whether the global `:all` firehose topic is enabled."
  @spec all_topic_enabled?() :: boolean()
  def all_topic_enabled? do
    Application.get_env(:whatsmeow_ex, __MODULE__, [])
    |> Keyword.get(:all_topic?, false)
  end

  @doc """
  Subscribe the calling process to events for one device.
  """
  @spec subscribe(String.t()) :: :ok | {:error, term()}
  def subscribe(device_id) when is_binary(device_id) do
    Phoenix.PubSub.subscribe(@pubsub, device_topic(device_id))
  end

  @doc """
  Subscribe the calling process to events from every device.
  """
  @spec subscribe_all() :: :ok | {:error, term()}
  def subscribe_all do
    Phoenix.PubSub.subscribe(@pubsub, all_topic())
  end

  @doc """
  Unsubscribe the calling process from a device's events.
  """
  @spec unsubscribe(String.t()) :: :ok
  def unsubscribe(device_id) when is_binary(device_id) do
    Phoenix.PubSub.unsubscribe(@pubsub, device_topic(device_id))
  end

  @doc "Unsubscribe from the global topic."
  @spec unsubscribe_all() :: :ok
  def unsubscribe_all do
    Phoenix.PubSub.unsubscribe(@pubsub, all_topic())
  end

  defp device_topic(device_id), do: "device:" <> device_id
  defp all_topic, do: "all"
end
