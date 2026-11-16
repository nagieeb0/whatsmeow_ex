defmodule Whatsmeow.AppState.Tables do
  @moduledoc false
  # Owns the ETS tables app-state sync needs to outlive any one caller: the
  # in-memory store (`Whatsmeow.AppState.Store.Memory`) and the time each
  # missing key was last requested from our phone (Go's
  # `cli.appStateKeyRequests`, which rate-limits a request to once a day).

  use GenServer

  @key_requests :whatsmeow_app_state_key_requests

  def start_link(_opts), do: GenServer.start_link(__MODULE__, nil, name: __MODULE__)

  @doc false
  def key_requests, do: @key_requests

  @impl true
  def init(nil) do
    for name <- [Whatsmeow.AppState.Store.Memory.table(), @key_requests] do
      :ets.new(name, [:named_table, :public, :set, read_concurrency: true])
    end

    {:ok, nil}
  end
end
