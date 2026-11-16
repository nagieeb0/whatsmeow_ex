defmodule Whatsmeow.AppState.Store.Memory do
  @moduledoc """
  In-memory `Whatsmeow.AppState.Store`.

  For tests and fakes — nothing survives a restart, which for app-state means a
  full resync and a fresh key request to the phone. Not for production.

  Mirrors the sqlstore semantics rather than simplifying them: a SET for an
  index that already has a MAC *adds* a row at the new version (it does not
  replace), reads return the highest version, and a removal deletes every
  version of the index. Getting this wrong would let a test pass that Postgres
  would fail.
  """

  use Agent

  @behaviour Whatsmeow.AppState.Store

  @zero_hash <<0::1024>>

  def start_link(opts \\ []) do
    Agent.start_link(fn -> empty() end, name: Keyword.get(opts, :name, __MODULE__))
  end

  def child_spec(opts) do
    %{id: Keyword.get(opts, :name, __MODULE__), start: {__MODULE__, :start_link, [opts]}}
  end

  @doc "Drop everything. Test convenience."
  def reset, do: Agent.update(__MODULE__, fn _ -> empty() end)

  defp empty, do: %{keys: %{}, versions: %{}, macs: %{}}

  @impl true
  def put_key(our_jid, key_id, %{data: d, fingerprint: f, timestamp: ts} = key)
      when is_binary(d) and is_binary(f) and is_integer(ts) do
    # sqlstore: ON CONFLICT DO UPDATE ... WHERE excluded.timestamp > existing.timestamp
    Agent.update(__MODULE__, fn st ->
      case Map.fetch(st.keys, {our_jid, key_id}) do
        {:ok, %{timestamp: old}} when old >= ts -> st
        _ -> put_in(st, [:keys, {our_jid, key_id}], key)
      end
    end)
  end

  @impl true
  def get_key(our_jid, key_id) do
    case Agent.get(__MODULE__, &Map.get(&1.keys, {our_jid, key_id})) do
      nil -> :not_found
      key -> {:ok, key}
    end
  end

  @impl true
  def latest_key_id(our_jid) do
    Agent.get(__MODULE__, fn st ->
      st.keys
      |> Enum.filter(fn {{jid, _}, _} -> jid == our_jid end)
      |> Enum.max_by(fn {_, k} -> k.timestamp end, fn -> nil end)
      |> case do
        nil -> :none
        {{_, key_id}, _} -> {:ok, key_id}
      end
    end)
  end

  @impl true
  def get_version(our_jid, name) do
    {v, h} = Agent.get(__MODULE__, &Map.get(&1.versions, {our_jid, name}, {0, @zero_hash}))
    {:ok, v, h}
  end

  @impl true
  def reset_collection(our_jid, name) do
    Agent.update(__MODULE__, fn st ->
      %{
        st
        | versions: Map.delete(st.versions, {our_jid, name}),
          macs: Map.delete(st.macs, {our_jid, name})
      }
    end)
  end

  @impl true
  def get_mutation_mac(our_jid, name, index_mac) do
    Agent.get(__MODULE__, fn st ->
      case st.macs |> Map.get({our_jid, name}, %{}) |> Map.get(index_mac) do
        nil -> :not_found
        by_version when map_size(by_version) == 0 -> :not_found
        by_version -> {:ok, by_version |> Enum.max_by(fn {v, _} -> v end) |> elem(1)}
      end
    end)
  end

  @impl true
  def apply_patch_state(our_jid, name, version, hash, removed, added)
      when byte_size(hash) == 128 do
    Agent.update(__MODULE__, fn st ->
      macs = Map.get(st.macs, {our_jid, name}, %{})
      macs = Map.drop(macs, removed)

      macs =
        Enum.reduce(added, macs, fn {index_mac, value_mac}, acc ->
          Map.update(acc, index_mac, %{version => value_mac}, &Map.put(&1, version, value_mac))
        end)

      st
      |> put_in([:versions, {our_jid, name}], {version, hash})
      |> put_in([:macs, {our_jid, name}], macs)
    end)
  end

  @doc "Test helper: every `{index_mac, value_mac}` currently stored for a collection (newest version)."
  def dump_macs(our_jid, name) do
    Agent.get(__MODULE__, fn st ->
      st.macs
      |> Map.get({our_jid, name}, %{})
      |> Map.new(fn {i, by_v} -> {i, by_v |> Enum.max_by(&elem(&1, 0)) |> elem(1)} end)
    end)
  end
end
