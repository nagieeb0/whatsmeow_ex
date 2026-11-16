defmodule Whatsmeow.AppState.Store.Memory do
  @moduledoc """
  ETS-backed `Whatsmeow.AppState.Store`: for tests, and for running without a
  database.

  Nothing survives a restart. That is safe rather than wrong: with no stored
  version the next sync starts from a snapshot, and a missing key is
  requested again from our phone. Until the phone answers, sends are refused.

  The table is owned by `Whatsmeow.AppState.Tables`, started by the
  application.
  """

  @behaviour Whatsmeow.AppState.Store

  alias Whatsmeow.AppState.Hash

  @table :whatsmeow_app_state_memory

  @doc false
  def table, do: @table

  @impl true
  def put_sync_key(jid, key_id, %{timestamp: ts} = key) do
    case :ets.lookup(@table, {:key, jid, key_id}) do
      [{_, %{timestamp: old}}] when old >= ts ->
        :ok

      _ ->
        :ets.insert(
          @table,
          {{:key, jid, key_id}, Map.take(key, [:key_data, :fingerprint, :timestamp])}
        )
    end

    :ok
  end

  @impl true
  def get_sync_key(jid, key_id) do
    case :ets.lookup(@table, {:key, jid, key_id}) do
      [{_, key}] -> {:ok, key}
      [] -> {:error, :not_found}
    end
  end

  @impl true
  def latest_sync_key_id(jid) do
    @table
    |> :ets.match({{:key, jid, :"$1"}, %{timestamp: :"$2"}})
    |> Enum.max_by(fn [_id, ts] -> ts end, fn -> nil end)
    |> case do
      [id, _ts] -> {:ok, id}
      nil -> {:error, :not_found}
    end
  end

  @impl true
  def get_version(jid, name) do
    case :ets.lookup(@table, {:version, jid, name}) do
      [{_, %Hash{} = state}] -> {:ok, state}
      [] -> {:ok, Hash.new()}
    end
  end

  @impl true
  def delete_version(jid, name) do
    :ets.delete(@table, {:version, jid, name})
    :ok
  end

  @impl true
  def get_mutation_mac(jid, name, index_mac) do
    case :ets.lookup(@table, {:mac, jid, name, index_mac}) do
      [{_, {_version, value_mac}}] -> {:ok, value_mac}
      [] -> {:ok, nil}
    end
  end

  @impl true
  def store_patch(jid, name, %Hash{version: version} = state, removed, added, opts) do
    if Keyword.get(opts, :reset?, false) do
      :ets.match_delete(@table, {{:mac, jid, name, :_}, :_})
    end

    :ets.insert(@table, {{:version, jid, name}, state})
    Enum.each(removed, &:ets.delete(@table, {:mac, jid, name, &1}))

    # Postgres keeps a row per version and reads the newest; keeping only the
    # newest here answers every lookup the same way.
    Enum.each(added, fn {index_mac, value_mac} ->
      :ets.insert(@table, {{:mac, jid, name, index_mac}, {version, value_mac}})
    end)

    :ok
  end
end
