defmodule Whatsmeow.AppState.Store do
  @moduledoc """
  Persistence behaviour for app-state sync: the keys the primary phone shared,
  each collection's version + LTHash, and the per-index value MACs.

  Ports the three Go interfaces `store.AppStateSyncKeyStore`,
  `store.AppStateStore` and the sqlstore queries behind them
  (`whatsmeow-main/store/sqlstore/store.go`, "app state" section).

  Every callback is keyed by `our_jid` — the device's own JID string, exactly as
  stored on the device row — because the same database holds many accounts.

  Select the implementation with

      config :whatsmeow_ex, app_state_store: Whatsmeow.AppState.Store.Postgres

  (the default). Like the rest of app-state, it needs the Repo: the DETS adapters
  cover the Signal layer only. Without a store the public API returns an error
  tuple rather than raising.

  ## Why `apply_patch_state/6` is one callback

  Go's `storeMACs` does three separate writes — the new version, the removed
  MACs, the added MACs. A crash between them leaves a version that has advanced
  past MACs it never recorded, and the *next* patch then computes its LTHash
  against a base that no longer matches the server's. Done in one transaction
  the collection is either at the old version or the new one, never between.
  """

  @type our_jid :: String.t()
  @type collection :: String.t()
  @type key_id :: binary()
  @type sync_key :: %{
          required(:data) => binary(),
          required(:fingerprint) => binary(),
          required(:timestamp) => integer()
        }
  @type hash :: <<_::1024>>

  @callback put_key(our_jid, key_id, sync_key) :: :ok | {:error, term()}

  @doc "`:not_found` is a normal answer (a key we were never sent); `{:error, _}` is a store failure."
  @callback get_key(our_jid, key_id) :: {:ok, sync_key} | :not_found | {:error, term()}

  @doc "The id of the key with the newest timestamp — the one new patches are encrypted with."
  @callback latest_key_id(our_jid) :: {:ok, key_id} | :none | {:error, term()}

  @doc "`{:ok, 0, <<0::1024>>}` for a collection we have never synced."
  @callback get_version(our_jid, collection) ::
              {:ok, non_neg_integer(), hash} | {:error, term()}

  @doc """
  Forget everything about a collection: its version, hash **and every mutation
  MAC**. Called before taking a snapshot, which replaces the collection wholesale.

  Go's `DeleteAppStateVersion` removes only the version row. Leaving the MACs is
  a trap: a MAC for an index that is *not* in the new snapshot stays behind, and
  the first later patch that touches that index subtracts a value the server's
  hash never contained — after which no patch for the collection verifies again.
  (It is also what a device delete leaves behind, see the note in
  `Whatsmeow.Store.Postgres.delete_device/1`.)
  """
  @callback reset_collection(our_jid, collection) :: :ok | {:error, term()}

  @doc "Value MAC of the newest SET for `index_mac` in `collection`, if any."
  @callback get_mutation_mac(our_jid, collection, index_mac :: binary()) ::
              {:ok, binary()} | :not_found | {:error, term()}

  @doc """
  Atomically record one applied patch or snapshot: set the collection to
  `version`/`hash`, delete every MAC for the `removed` index MACs, then insert
  `added` `{index_mac, value_mac}` pairs at `version`.
  """
  @callback apply_patch_state(
              our_jid,
              collection,
              version :: non_neg_integer(),
              hash,
              removed :: [binary()],
              added :: [{binary(), binary()}]
            ) :: :ok | {:error, term()}

  @doc "The configured implementation."
  @spec impl() :: module()
  def impl,
    do: Application.get_env(:whatsmeow_ex, :app_state_store, Whatsmeow.AppState.Store.Postgres)
end
