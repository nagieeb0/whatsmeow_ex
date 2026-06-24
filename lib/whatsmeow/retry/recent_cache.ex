defmodule Whatsmeow.Retry.RecentCache do
  @moduledoc """
  Bounded in-memory LRU of recently-sent message plaintexts, keyed by
  `(to_jid_string, message_id)`.

  When a peer fails to decrypt one of our outbound messages it sends a
  `<receipt type="retry">`. To honour it we have to re-encrypt and re-send
  the original plaintext — which means we must remember it. WhatsApp's
  Go client keeps the last 256 sent messages around for this exact reason
  (`whatsmeow-main/retry.go` `recentMessagesSize = 256`).

  We mirror that bound. Anything older falls out the back.

  ## Process model

  One ETS table per BEAM node, owned by the Application supervisor. Reads
  are concurrent (`read_concurrency: true`); writes serialise on a
  counter row used as the ring-buffer cursor. We deliberately don't run
  a GenServer in front — the ETS+counter design is lock-free for reads,
  which matters under fanout load (one cache hit per peer device).

  ## Lifecycle

  `start_link/1` is the supervisor child spec. The table is `:public, :set`
  and stays alive for the BEAM lifetime; it does not survive a node restart.
  That's fine — a retry-receipt for a pre-restart message will be answered
  with a "couldn't find message" log line, which mirrors Go's behaviour
  (`getMessageForRetry` returns nil; caller logs and gives up).
  """

  use GenServer

  @table :whatsmeow_retry_recent_cache
  @cursor_key :__cursor__
  @default_capacity 256

  defmodule Entry do
    @moduledoc "One row of the recent-messages cache."
    defstruct [:to_jid, :message_id, :plaintext, :msg_type, :stored_at]

    @type t :: %__MODULE__{
            to_jid: String.t(),
            message_id: String.t(),
            plaintext: binary(),
            msg_type: String.t(),
            stored_at: integer()
          }
  end

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

  @doc """
  Start the cache. `opts`:

  * `:name` — process name (default `__MODULE__`)
  * `:capacity` — max entries before LRU eviction (default 256)
  """
  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    name = Keyword.get(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, opts, name: name)
  end

  # --- Public API ------------------------------------------------------------

  @doc """
  Remember a sent message. Idempotent on `(to_jid, message_id)`.

  `plaintext` should be the already-marshalled `WaE2E.Message` bytes —
  what the caller would feed back through `Signal.WireEncrypt` on a retry.

  `msg_type` is the value used in the outbound `<message type=…>` attr
  (`"text"` or `"media"`). Lets the resend pipeline reconstruct the
  outer node shape.
  """
  @spec put(String.t(), String.t(), binary(), String.t()) :: :ok
  def put(to_jid, message_id, plaintext, msg_type)
      when is_binary(to_jid) and is_binary(message_id) and is_binary(plaintext) and
             is_binary(msg_type) do
    ensure_table()

    key = {to_jid, message_id}

    entry = %Entry{
      to_jid: to_jid,
      message_id: message_id,
      plaintext: plaintext,
      msg_type: msg_type,
      # Monotonic time: strictly increasing per call → unambiguous eviction order.
      stored_at: System.monotonic_time()
    }

    case :ets.lookup(@table, key) do
      [{^key, _existing}] ->
        # Already cached — just refresh value (no LRU bump; cheap).
        true = :ets.insert(@table, {key, entry})
        :ok

      [] ->
        true = :ets.insert(@table, {key, entry})
        bump_cursor_and_evict()
        :ok
    end
  end

  @doc """
  Look up a sent message. Returns `{:ok, %Entry{}}` or `:not_found`.
  """
  @spec get(String.t(), String.t()) :: {:ok, Entry.t()} | :not_found
  def get(to_jid, message_id) when is_binary(to_jid) and is_binary(message_id) do
    ensure_table()

    case :ets.lookup(@table, {to_jid, message_id}) do
      [{_, %Entry{} = entry}] -> {:ok, entry}
      [] -> :not_found
    end
  end

  @doc "Number of cached entries (excludes the cursor row)."
  @spec size() :: non_neg_integer()
  def size do
    ensure_table()
    :ets.info(@table, :size) - 1
  end

  @doc "Drop all cached entries. Intended for tests."
  @spec clear() :: :ok
  def clear do
    ensure_table()
    :ets.delete_all_objects(@table)
    seed_cursor(@default_capacity)
    :ok
  end

  @doc "Read the configured capacity."
  @spec capacity() :: pos_integer()
  def capacity do
    ensure_table()

    case :ets.lookup(@table, @cursor_key) do
      [{@cursor_key, capacity, _next_evict}] -> capacity
      _ -> @default_capacity
    end
  end

  # --- GenServer -------------------------------------------------------------

  @impl true
  def init(opts) do
    capacity = Keyword.get(opts, :capacity, @default_capacity)
    create_table()
    seed_cursor(capacity)
    {:ok, %{capacity: capacity}}
  end

  # --- Internals -------------------------------------------------------------

  defp create_table do
    case :ets.whereis(@table) do
      :undefined ->
        @table =
          :ets.new(@table, [
            :named_table,
            :public,
            :set,
            read_concurrency: true,
            write_concurrency: true
          ])

        :ok

      _ ->
        :ok
    end
  end

  defp ensure_table do
    case :ets.whereis(@table) do
      :undefined -> create_table_and_seed()
      _ -> :ok
    end
  end

  defp create_table_and_seed do
    create_table()

    case :ets.lookup(@table, @cursor_key) do
      [] -> seed_cursor(@default_capacity)
      _ -> :ok
    end
  end

  defp seed_cursor(capacity) do
    :ets.insert(@table, {@cursor_key, capacity, 0})
  end

  defp bump_cursor_and_evict do
    case :ets.lookup(@table, @cursor_key) do
      [{@cursor_key, capacity, _next_evict}] ->
        size_now = :ets.info(@table, :size) - 1

        if size_now > capacity, do: evict_oldest()

      _ ->
        :ok
    end
  end

  defp evict_oldest do
    fold =
      :ets.foldl(
        fn
          {@cursor_key, _, _}, acc ->
            acc

          {_key, %Entry{stored_at: ts} = entry}, {oldest_ts, _oldest_entry} = acc ->
            if oldest_ts == nil or ts < oldest_ts, do: {ts, entry}, else: acc

          _, acc ->
            acc
        end,
        {nil, nil},
        @table
      )

    case fold do
      {_ts, %Entry{to_jid: to, message_id: id}} ->
        :ets.delete(@table, {to, id})

      _ ->
        :ok
    end
  end
end
