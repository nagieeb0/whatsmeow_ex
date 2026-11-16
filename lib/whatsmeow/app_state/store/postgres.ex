defmodule Whatsmeow.AppState.Store.Postgres do
  @moduledoc """
  Postgres `Whatsmeow.AppState.Store` over the existing
  `whatsmeow_app_state_sync_keys`, `whatsmeow_app_state_version` and
  `whatsmeow_app_state_mutation_macs` tables.

  The queries are the sqlstore ones (`whatsmeow-main/store/sqlstore/store.go`):

    * key upsert only replaces a row when the incoming timestamp is *newer*, so
      a stale re-share from the phone cannot roll a key back;
    * the latest key is `ORDER BY timestamp DESC LIMIT 1`;
    * a mutation MAC is read as the highest `version` for the index, and removal
      deletes every version of it.

  Every function returns `{:error, :no_store}` when the Repo is not running and
  `{:error, {:repo, message}}` on a database error — it never raises, because the
  callers are inside a patch-apply loop that has to stop cleanly, not crash.
  """

  @behaviour Whatsmeow.AppState.Store

  import Ecto.Query

  alias Whatsmeow.Repo
  alias Whatsmeow.Store.Schemas.{AppStateMutationMAC, AppStateSyncKey, AppStateVersion}

  @zero_hash <<0::1024>>
  # 4 columns per MAC row; Postgres caps a statement at 65_535 parameters.
  @mac_chunk 5_000

  @impl true
  def put_key(our_jid, key_id, %{data: d, fingerprint: f, timestamp: ts})
      when is_binary(d) and is_binary(f) and is_integer(ts) do
    guarded(fn ->
      row = %{jid: our_jid, key_id: key_id, key_data: d, fingerprint: f, timestamp: ts}

      replace_if_newer =
        from(k in AppStateSyncKey,
          where: k.timestamp < ^ts,
          update: [set: [key_data: ^d, fingerprint: ^f, timestamp: ^ts]]
        )

      Repo.insert_all(AppStateSyncKey, [row],
        on_conflict: replace_if_newer,
        conflict_target: [:jid, :key_id]
      )

      :ok
    end)
  end

  @impl true
  def get_key(our_jid, key_id) do
    guarded(fn ->
      from(k in AppStateSyncKey,
        where: k.jid == ^our_jid and k.key_id == ^key_id,
        select: %{data: k.key_data, fingerprint: k.fingerprint, timestamp: k.timestamp}
      )
      |> Repo.one()
      |> case do
        nil -> :not_found
        key -> {:ok, key}
      end
    end)
  end

  @impl true
  def latest_key_id(our_jid) do
    guarded(fn ->
      from(k in AppStateSyncKey,
        where: k.jid == ^our_jid,
        order_by: [desc: k.timestamp],
        limit: 1,
        select: k.key_id
      )
      |> Repo.one()
      |> case do
        nil -> :none
        key_id -> {:ok, key_id}
      end
    end)
  end

  @impl true
  def get_version(our_jid, name) do
    guarded(fn ->
      from(v in AppStateVersion,
        where: v.jid == ^our_jid and v.name == ^name,
        select: {v.version, v.hash}
      )
      |> Repo.one()
      |> case do
        nil -> {:ok, 0, @zero_hash}
        {version, hash} when byte_size(hash) == 128 -> {:ok, version, hash}
        # Go: "expected hash to be 128 bytes" — refuse rather than guess.
        {_version, hash} -> {:error, {:bad_hash_length, byte_size(hash)}}
      end
    end)
  end

  @impl true
  def reset_collection(our_jid, name) do
    guarded(fn ->
      Repo.transaction(fn ->
        from(v in AppStateVersion, where: v.jid == ^our_jid and v.name == ^name)
        |> Repo.delete_all()

        from(m in AppStateMutationMAC, where: m.jid == ^our_jid and m.name == ^name)
        |> Repo.delete_all()
      end)
      |> case do
        {:ok, _} -> :ok
        {:error, reason} -> {:error, {:repo, inspect(reason)}}
      end
    end)
  end

  @impl true
  def get_mutation_mac(our_jid, name, index_mac) do
    guarded(fn ->
      from(m in AppStateMutationMAC,
        where: m.jid == ^our_jid and m.name == ^name and m.index_mac == ^index_mac,
        order_by: [desc: m.version],
        limit: 1,
        select: m.value_mac
      )
      |> Repo.one()
      |> case do
        nil -> :not_found
        value_mac -> {:ok, value_mac}
      end
    end)
  end

  @impl true
  def apply_patch_state(our_jid, name, version, hash, removed, added)
      when is_integer(version) and byte_size(hash) == 128 do
    guarded(fn ->
      Repo.transaction(fn ->
        upsert_version(our_jid, name, version, hash)
        delete_macs(our_jid, name, removed)
        insert_macs(our_jid, name, version, added)
      end)
      |> case do
        {:ok, _} -> :ok
        {:error, reason} -> {:error, {:repo, inspect(reason)}}
      end
    end)
  end

  defp upsert_version(our_jid, name, version, hash) do
    Repo.insert_all(
      AppStateVersion,
      [%{jid: our_jid, name: name, version: version, hash: hash}],
      on_conflict: {:replace, [:version, :hash]},
      conflict_target: [:jid, :name]
    )
  end

  defp delete_macs(our_jid, name, index_macs) do
    index_macs
    |> Enum.chunk_every(@mac_chunk)
    |> Enum.each(fn chunk ->
      from(m in AppStateMutationMAC,
        where: m.jid == ^our_jid and m.name == ^name and m.index_mac in ^chunk
      )
      |> Repo.delete_all()
    end)
  end

  defp insert_macs(our_jid, name, version, added) do
    added
    |> Enum.map(fn {index_mac, value_mac} ->
      %{jid: our_jid, name: name, version: version, index_mac: index_mac, value_mac: value_mac}
    end)
    # Last write wins for a duplicate (version, index) inside one batch.
    |> Enum.reverse()
    |> Enum.uniq_by(& &1.index_mac)
    |> Enum.reverse()
    |> Enum.chunk_every(@mac_chunk)
    |> Enum.each(fn chunk ->
      Repo.insert_all(AppStateMutationMAC, chunk,
        on_conflict: {:replace, [:value_mac]},
        conflict_target: [:jid, :name, :version, :index_mac]
      )
    end)
  end

  # --- internals --------------------------------------------------------------

  defp guarded(fun) do
    if is_pid(Process.whereis(Repo)) do
      try do
        fun.()
      rescue
        e -> {:error, {:repo, Exception.message(e)}}
      end
    else
      {:error, :no_store}
    end
  end
end
