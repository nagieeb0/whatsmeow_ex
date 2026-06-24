defmodule Whatsmeow.Media.HKDFCache do
  @moduledoc """
  Small ETS-backed cache for `HKDF.derive/4` expansions used by the media
  download path.

  Every inbound media item runs HKDF-SHA256 against the same media key +
  type-specific info string to derive `{iv, cipher_key, mac_key}`. For a
  burst of inbound media (image albums, history-sync rehydration) the
  same expansions are recomputed many times. This cache memoizes them
  by `{media_key, info}`; entries expire after 5 minutes idle.

  Public ETS, `:read_concurrency` on. Safe to read from any process; the
  owning GenServer only handles inserts + periodic sweeps.
  """

  use GenServer

  @table __MODULE__
  @ttl_ms 5 * 60 * 1_000
  @sweep_ms 60 * 1_000

  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @doc """
  Fetch a cached expansion. Returns `nil` if absent or expired.
  """
  @spec get(binary(), binary()) :: binary() | nil
  def get(media_key, info) when is_binary(media_key) and is_binary(info) do
    case :ets.info(@table) do
      :undefined ->
        nil

      _ ->
        case :ets.lookup(@table, {media_key, info}) do
          [{_, bytes, expires_at}] ->
            if System.monotonic_time(:millisecond) < expires_at, do: bytes, else: nil

          _ ->
            nil
        end
    end
  end

  @doc "Store `bytes` keyed by `{media_key, info}`."
  @spec put(binary(), binary(), binary()) :: :ok
  def put(media_key, info, bytes)
      when is_binary(media_key) and is_binary(info) and is_binary(bytes) do
    case :ets.info(@table) do
      :undefined ->
        :ok

      _ ->
        expires_at = System.monotonic_time(:millisecond) + @ttl_ms
        :ets.insert(@table, {{media_key, info}, bytes, expires_at})
        :ok
    end
  end

  @impl true
  def init(_opts) do
    :ets.new(@table, [:named_table, :public, :set, read_concurrency: true])
    Process.send_after(self(), :sweep, @sweep_ms)
    {:ok, %{}}
  end

  @impl true
  def handle_info(:sweep, state) do
    now = System.monotonic_time(:millisecond)

    _ =
      :ets.foldl(
        fn {key, _bytes, expires_at}, _acc ->
          if expires_at < now, do: :ets.delete(@table, key)
          :ok
        end,
        :ok,
        @table
      )

    Process.send_after(self(), :sweep, @sweep_ms)
    {:noreply, state}
  end
end
