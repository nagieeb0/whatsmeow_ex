defmodule Whatsmeow.AppState.Store do
  @moduledoc """
  Persistence for app-state sync: the sync keys our phone shares with us, and
  per collection the version, the 128-byte LTHash and the value MAC of every
  live index.

  Ports the two store interfaces whatsmeow's `appstate` package reads
  (`AppStateSyncKeyStore`, `AppStateStore` in `whatsmeow-main/store/store.go`)
  and their SQL (`whatsmeow-main/store/sqlstore/store.go`). Two adapters ship:

    * `Whatsmeow.AppState.Store.Postgres` (default) — the
      `whatsmeow_app_state_*` tables the schema migration already creates;
    * `Whatsmeow.AppState.Store.Memory` — ETS, for tests and for running
      without a database. Lost on restart, which is safe: version 0 means the
      next sync starts again from a snapshot, and missing keys are re-requested
      from our phone.

  Select with:

      config :whatsmeow_ex, app_state_store: Whatsmeow.AppState.Store.Memory

  Every row is keyed by our own JID (`device.jid`), as Go keys them by
  `s.JID`.

  ## One deviation from Go

  `store_patch/6` with `reset?: true` (a snapshot) first deletes the
  collection's stored mutation MACs. Go keeps them across a full sync, so an
  index removed while we were not following could leave a stale value MAC
  that a later SET then subtracts — a hash mismatch and a failed sync. A
  snapshot is the complete state, so nothing older can be a valid previous
  value.
  """

  alias Whatsmeow.AppState.Hash

  @type jid :: String.t()
  @type name :: String.t()

  @type sync_key :: %{key_data: binary(), fingerprint: binary(), timestamp: integer()}

  @doc """
  Insert a key, or replace it only when the new one is newer — Go's
  `ON CONFLICT ... WHERE excluded.timestamp > timestamp`.
  """
  @callback put_sync_key(jid(), key_id :: binary(), sync_key()) :: :ok | {:error, term()}

  @callback get_sync_key(jid(), key_id :: binary()) ::
              {:ok, sync_key()} | {:error, :not_found} | {:error, term()}

  @doc "The key id with the newest timestamp (Go's `GetLatestAppStateSyncKeyID`)."
  @callback latest_sync_key_id(jid()) :: {:ok, binary()} | {:error, :not_found} | {:error, term()}

  @doc "Stored version + hash, or `%Hash{}` (version 0, zero hash) when there is none."
  @callback get_version(jid(), name()) :: {:ok, Hash.t()} | {:error, term()}

  @callback delete_version(jid(), name()) :: :ok | {:error, term()}

  @doc "Value MAC of the newest stored SET on `index_mac`, or `nil`."
  @callback get_mutation_mac(jid(), name(), index_mac :: binary()) ::
              {:ok, binary() | nil} | {:error, term()}

  @doc """
  Persist the outcome of one applied patch or snapshot, atomically where the
  adapter can: the new version + hash, the index MACs removed, the
  `{index_mac, value_mac}` pairs added at that version.

  Go's `storeMACs`: version first, then deletes, then inserts.
  """
  @callback store_patch(
              jid(),
              name(),
              Hash.t(),
              removed :: [binary()],
              added :: [{binary(), binary()}],
              opts :: keyword()
            ) :: :ok | {:error, term()}

  @doc "The configured adapter."
  @spec impl() :: module()
  def impl,
    do: Application.get_env(:whatsmeow_ex, :app_state_store, Whatsmeow.AppState.Store.Postgres)

  @doc "True when `module` can be used right now (Postgres needs a running Repo)."
  @spec available?(module()) :: boolean()
  def available?(Whatsmeow.AppState.Store.Postgres) do
    Code.ensure_loaded?(Whatsmeow.Repo) and is_pid(Process.whereis(Whatsmeow.Repo))
  end

  def available?(module), do: Code.ensure_loaded?(module)
end
