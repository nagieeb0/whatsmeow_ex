defmodule Whatsmeow.User.DeviceCache do
  @moduledoc """
  Per-user cache of a contact's device list.

  ## Why

  Every send resolves the recipient's devices first: WhatsApp's multi-device
  protocol needs one encrypted envelope per device, so `Whatsmeow.Send` cannot
  build a stanza without knowing how many there are. That resolution is a USync
  IQ — a full network round-trip to WhatsApp's servers, on the critical path of
  every single message.

  Device lists barely change. Paying a round-trip per message to re-learn that a
  contact still has the same two devices is the single most expensive thing an
  otherwise-local send does. Mirrors Baileys' `userDevicesCache` and Go's
  equivalent lookup skip.

  ## Freshness

  Entries expire after one hour. Long enough that a burst of messages to the same
  chat costs one USync, short enough that a contact adding or removing a linked
  device self-heals without any explicit invalidation signal — WhatsApp gives us
  no reliable one. `invalidate/1` exists for when we *do* learn better: a
  `<notification type="devices">` naming that user.

  In-memory and per-node. A restart costs one USync per active conversation,
  which is not worth a database table.
  """

  use GenServer

  alias Whatsmeow.Types.JID

  @table :whatsmeow_device_cache
  @ttl_ms 60 * 60 * 1000

  # Devices the server declined to hand out a prekey bundle for. Short-lived on
  # purpose — see `no_bundle?/1`.
  @gap_table :whatsmeow_bundle_gap
  @gap_ttl_ms 15 * 60 * 1000

  # --- Supervisor entry ------------------------------------------------------

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 5_000
    }
  end

  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: Keyword.get(opts, :name, __MODULE__))
  end

  # --- Public API ------------------------------------------------------------

  @doc """
  The cached device list for `user_jid`, or `:miss` when absent or stale.

  Keyed by the JID's *user* part, so `15551234567@s.whatsapp.net` and
  `15551234567:3@s.whatsapp.net` hit the same entry — a device list belongs to a
  person, not to one of their devices.
  """
  @spec get(JID.t() | String.t()) :: {:ok, [JID.t()]} | :miss
  def get(user_jid) do
    with key when is_binary(key) <- cache_key(user_jid),
         :ok <- ensure_table(),
         [{^key, devices, stored_at}] <- :ets.lookup(@table, key) do
      if fresh?(stored_at), do: {:ok, devices}, else: :miss
    else
      _ -> :miss
    end
  rescue
    _ -> :miss
  end

  @doc "Cache `devices` as the full device list for `user_jid`."
  @spec put(JID.t() | String.t(), [JID.t()]) :: :ok
  def put(user_jid, devices) when is_list(devices) do
    with key when is_binary(key) <- cache_key(user_jid),
         :ok <- ensure_table() do
      :ets.insert(@table, {key, devices, now_ms()})
    end

    :ok
  rescue
    _ -> :ok
  end

  @doc """
  Store one USync response, splitting it per user.

  A single USync asks about several contacts and comes back as one flat device
  list, so caching it means grouping by user first.

  **An empty result is not cached.** A user the server said nothing about is
  either not on WhatsApp or the reply was incomplete — and caching "no devices"
  for an hour turns a transient blip into an hour of `:no_devices_resolved` on
  every send to that contact. Re-asking costs one USync on a path that was
  already going to fail; caching the emptiness costs delivery.
  """
  @spec put_response([JID.t()], [JID.t()]) :: :ok
  def put_response(queried, devices) when is_list(queried) and is_list(devices) do
    by_user = Enum.group_by(devices, & &1.user)

    Enum.each(queried, fn %JID{user: user} = jid ->
      case Map.get(by_user, user) do
        [_ | _] = found -> put(jid, found)
        _ -> :ok
      end
    end)

    :ok
  rescue
    _ -> :ok
  end

  @doc """
  Drop the entry for `user_jid`.

  Call this the moment we learn a device list changed — a
  `<notification type="devices">` — rather than waiting out the TTL. Encrypting
  to a device that no longer exists wastes a fanout slot; missing a device that
  now does means that device never sees the message.
  """
  @spec invalidate(JID.t() | String.t()) :: :ok
  def invalidate(user_jid) do
    with key when is_binary(key) <- cache_key(user_jid),
         :ok <- ensure_table() do
      :ets.delete(@table, key)
    end

    :ok
  rescue
    _ -> :ok
  end

  @doc "Drop everything. Used on logout and in tests."
  @spec clear() :: :ok
  def clear do
    with :ok <- ensure_table(), do: :ets.delete_all_objects(@table)
    with :ok <- ensure_gap_table(), do: :ets.delete_all_objects(@gap_table)
    :ok
  rescue
    _ -> :ok
  end

  # --- Devices with no prekey bundle -----------------------------------------

  @doc """
  Whether `ad_jid` recently answered a prekey request with nothing.

  ## Why this is worth a second table

  A companion that has been unlinked does not disappear from the account's
  device list; the server simply stops naming it in a prekey response. Every
  send to that account then opens a first-contact path for it: a Postgres
  advisory-lock transaction, then a **blocking** prekey IQ, then `:no_bundle`,
  logged and dropped. Nothing remembered the answer, so the next message paid it
  again — and because the fanout is fully drained before the stanza goes out,
  the *live* devices waited for the dead ones to finish failing.

  Fifteen minutes, not an hour. This is a negative answer, and a negative answer
  is the one you want to stop trusting quickly: a device that comes back — a
  re-link, a reinstall, a server blip — should cost at most one quarter-hour of
  silence, not a working day.

  Keyed by the **full** address including the device id, because this is a fact
  about one companion and not about the person.
  """
  @spec no_bundle?(JID.t() | String.t()) :: boolean()
  def no_bundle?(ad_jid) do
    with key when is_binary(key) <- gap_key(ad_jid),
         :ok <- ensure_gap_table(),
         [{^key, stored_at}] <- :ets.lookup(@gap_table, key) do
      now_ms() - stored_at < @gap_ttl_ms
    else
      _ -> false
    end
  rescue
    _ -> false
  end

  @doc "Remember that `ad_jid` has no prekey bundle."
  @spec note_no_bundle(JID.t() | String.t()) :: :ok
  def note_no_bundle(ad_jid) do
    with key when is_binary(key) <- gap_key(ad_jid),
         :ok <- ensure_gap_table() do
      :ets.insert(@gap_table, {key, now_ms()})
    end

    :ok
  rescue
    _ -> :ok
  end

  # --- GenServer -------------------------------------------------------------

  @impl true
  def init(_opts) do
    create_table()
    create_gap_table()
    {:ok, %{}}
  end

  # --- Helpers ---------------------------------------------------------------

  defp cache_key(%JID{user: user}) when is_binary(user) and user != "", do: user

  defp cache_key(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, %JID{} = jid} -> cache_key(jid)
      _ -> nil
    end
  end

  defp cache_key(_), do: nil

  # The *full* address, device id and all — the opposite of `cache_key/1`, and
  # deliberately so. A device list belongs to a person; a missing prekey bundle
  # belongs to one companion of theirs.
  defp gap_key(%JID{} = jid), do: JID.to_string(jid)

  defp gap_key(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, %JID{} = jid} -> gap_key(jid)
      _ -> nil
    end
  end

  defp gap_key(_), do: nil

  defp fresh?(stored_at), do: now_ms() - stored_at < @ttl_ms

  defp now_ms, do: System.monotonic_time(:millisecond)

  defp ensure_table, do: ensure(@table, &create_table/0)
  defp ensure_gap_table, do: ensure(@gap_table, &create_gap_table/0)

  defp ensure(table, create) do
    case :ets.whereis(table) do
      :undefined -> create.()
      _ -> :ok
    end

    :ok
  end

  defp create_table, do: create(@table)
  defp create_gap_table, do: create(@gap_table)

  defp create(table) do
    :ets.new(table, [
      :named_table,
      :public,
      :set,
      read_concurrency: true,
      write_concurrency: true
    ])

    :ok
  rescue
    # Lost the race with another process creating it — either way it now exists.
    ArgumentError -> :ok
  end
end
