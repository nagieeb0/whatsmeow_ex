defmodule Whatsmeow.AppState.Store.Postgres do
  @moduledoc """
  `Whatsmeow.AppState.Store` on the `whatsmeow_app_state_sync_keys`,
  `whatsmeow_app_state_version` and `whatsmeow_app_state_mutation_macs`
  tables.

  The SQL is Go's (`whatsmeow-main/store/sqlstore/store.go`), statement for
  statement, except that `store_patch/6` runs its writes in one transaction.
  """

  @behaviour Whatsmeow.AppState.Store

  alias Ecto.Adapters.SQL
  alias Whatsmeow.AppState.Hash
  alias Whatsmeow.Repo

  # Go's `mutationBatchSize`: a snapshot can carry thousands of records and
  # Postgres caps a statement at 65535 parameters.
  @mutation_batch_size 400

  @impl true
  def put_sync_key(jid, key_id, %{key_data: data, fingerprint: fp, timestamp: ts}) do
    """
    INSERT INTO whatsmeow_app_state_sync_keys (jid, key_id, key_data, timestamp, fingerprint)
    VALUES ($1, $2, $3, $4, $5)
    ON CONFLICT (jid, key_id) DO UPDATE
      SET key_data=excluded.key_data, timestamp=excluded.timestamp, fingerprint=excluded.fingerprint
      WHERE excluded.timestamp > whatsmeow_app_state_sync_keys.timestamp
    """
    |> exec([jid, key_id, data, ts, fp])
  end

  @impl true
  def get_sync_key(jid, key_id) do
    case query(
           "SELECT key_data, timestamp, fingerprint FROM whatsmeow_app_state_sync_keys WHERE jid=$1 AND key_id=$2",
           [jid, key_id]
         ) do
      {:ok, %{rows: [[data, ts, fp]]}} -> {:ok, %{key_data: data, timestamp: ts, fingerprint: fp}}
      {:ok, %{rows: []}} -> {:error, :not_found}
      {:error, _} = err -> err
    end
  end

  @impl true
  def latest_sync_key_id(jid) do
    case query(
           "SELECT key_id FROM whatsmeow_app_state_sync_keys WHERE jid=$1 ORDER BY timestamp DESC LIMIT 1",
           [jid]
         ) do
      {:ok, %{rows: [[key_id]]}} -> {:ok, key_id}
      {:ok, %{rows: []}} -> {:error, :not_found}
      {:error, _} = err -> err
    end
  end

  @impl true
  def get_version(jid, name) do
    case query("SELECT version, hash FROM whatsmeow_app_state_version WHERE jid=$1 AND name=$2", [
           jid,
           name
         ]) do
      {:ok, %{rows: []}} ->
        {:ok, Hash.new()}

      {:ok, %{rows: [[version, hash]]}} when byte_size(hash) != 128 ->
        {:error, {:invalid_hash_length, version, byte_size(hash)}}

      # Go refuses a stored version 0 the same way: it can only be corruption.
      {:ok, %{rows: [[0, _hash]]}} ->
        {:error, {:invalid_saved_version, name}}

      {:ok, %{rows: [[version, hash]]}} ->
        {:ok, %Hash{version: version, hash: hash}}

      {:error, _} = err ->
        err
    end
  end

  @impl true
  def delete_version(jid, name) do
    exec("DELETE FROM whatsmeow_app_state_version WHERE jid=$1 AND name=$2", [jid, name])
  end

  @impl true
  def get_mutation_mac(jid, name, index_mac) do
    case query(
           "SELECT value_mac FROM whatsmeow_app_state_mutation_macs " <>
             "WHERE jid=$1 AND name=$2 AND index_mac=$3 ORDER BY version DESC LIMIT 1",
           [jid, name, index_mac]
         ) do
      {:ok, %{rows: [[mac]]}} -> {:ok, mac}
      {:ok, %{rows: []}} -> {:ok, nil}
      {:error, _} = err -> err
    end
  end

  @impl true
  def store_patch(jid, name, %Hash{version: version, hash: hash}, removed, added, opts) do
    Repo.transaction(fn ->
      with :ok <- maybe_reset(jid, name, Keyword.get(opts, :reset?, false)),
           :ok <- put_version(jid, name, version, hash),
           :ok <- delete_macs(jid, name, removed),
           :ok <- put_macs(jid, name, version, added) do
        :ok
      else
        {:error, reason} -> Repo.rollback(reason)
      end
    end)
    |> case do
      {:ok, :ok} -> :ok
      {:error, _} = err -> err
    end
  end

  defp maybe_reset(_jid, _name, false), do: :ok

  defp maybe_reset(jid, name, true) do
    exec("DELETE FROM whatsmeow_app_state_mutation_macs WHERE jid=$1 AND name=$2", [jid, name])
  end

  defp put_version(jid, name, version, hash) do
    """
    INSERT INTO whatsmeow_app_state_version (jid, name, version, hash) VALUES ($1, $2, $3, $4)
    ON CONFLICT (jid, name) DO UPDATE SET version=excluded.version, hash=excluded.hash
    """
    |> exec([jid, name, version, hash])
  end

  defp delete_macs(_jid, _name, []), do: :ok

  defp delete_macs(jid, name, index_macs) do
    exec(
      "DELETE FROM whatsmeow_app_state_mutation_macs WHERE jid=$1 AND name=$2 AND index_mac=ANY($3::bytea[])",
      [jid, name, index_macs]
    )
  end

  defp put_macs(_jid, _name, _version, []), do: :ok

  defp put_macs(jid, name, version, added) do
    added
    # Two SETs on one index in one patch share (jid, name, version, index_mac);
    # the later one is the live value. Go would fail the insert on the primary
    # key; keeping the last is the state the LTHash describes.
    |> Enum.reverse()
    |> Enum.uniq_by(&elem(&1, 0))
    |> Enum.reverse()
    |> Enum.chunk_every(@mutation_batch_size)
    |> Enum.reduce_while(:ok, fn chunk, :ok ->
      {parts, params} =
        chunk
        |> Enum.with_index()
        |> Enum.map_reduce([], fn {{index_mac, value_mac}, i}, acc ->
          {"($1, $2, $3, $#{4 + i * 2}, $#{5 + i * 2})", [value_mac, index_mac | acc]}
        end)

      sql =
        "INSERT INTO whatsmeow_app_state_mutation_macs (jid, name, version, index_mac, value_mac) VALUES " <>
          Enum.join(parts, ",") <>
          " ON CONFLICT (jid, name, version, index_mac) DO UPDATE SET value_mac=excluded.value_mac"

      case exec(sql, [jid, name, version | Enum.reverse(params)]) do
        :ok -> {:cont, :ok}
        err -> {:halt, err}
      end
    end)
  end

  defp exec(sql, params) do
    case query(sql, params) do
      {:ok, _} -> :ok
      {:error, _} = err -> err
    end
  end

  defp query(sql, params), do: SQL.query(Repo, sql, params)
end
