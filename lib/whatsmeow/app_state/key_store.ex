defmodule Whatsmeow.AppState.KeyStore do
  @moduledoc """
  The app-state sync keys our phone shares with us.

  Every app-state patch and snapshot is encrypted and MACed under a key the
  primary device generates and hands to each linked device in an
  `AppStateSyncKeyShare` protocol message. Ports the storing half of Go's
  `handleAppStateSyncKeyShare` (`whatsmeow-main/message.go`) and the
  lookups `getAppStateKey` / `GetLatestAppStateSyncKeyID`.

  Keys are only accepted from our own account — `Whatsmeow.Session` checks
  `is_from_me?` before handing a share here, as Go gates the whole
  protocol-message handler on `info.IsFromMe`.

  All functions take our own JID (`device.jid`) and, optionally,
  `store: module` (default `Whatsmeow.AppState.Store.impl/0`).
  """

  alias Whatsmeow.AppState.Store

  @doc """
  Store every key in a share. A key already held with a newer or equal
  timestamp is kept. Returns the key ids that were in the share.

  As Go does, the fingerprint is stored marshalled (empty when absent).
  """
  @spec put_key_share(String.t(), WAWebProtobufsE2E.AppStateSyncKeyShare.t(), keyword()) ::
          {:ok, [binary()]} | {:error, term()}
  def put_key_share(our_jid, %WAWebProtobufsE2E.AppStateSyncKeyShare{keys: keys}, opts \\ [])
      when is_binary(our_jid) do
    with {:ok, store} <- store(opts) do
      (keys || [])
      |> Enum.reduce_while({:ok, []}, fn key, {:ok, ids} ->
        case put_key(store, our_jid, key) do
          {:ok, id} -> {:cont, {:ok, [id | ids]}}
          :skip -> {:cont, {:ok, ids}}
          {:error, _} = err -> {:halt, err}
        end
      end)
      |> case do
        {:ok, ids} -> {:ok, Enum.reverse(ids)}
        err -> err
      end
    end
  end

  defp put_key(store, our_jid, %WAWebProtobufsE2E.AppStateSyncKey{} = key) do
    case key do
      %{keyID: %{keyID: id}, keyData: %WAWebProtobufsE2E.AppStateSyncKeyData{} = data}
      when is_binary(id) and id != "" ->
        fingerprint =
          case data.fingerprint do
            nil ->
              <<>>

            fp ->
              fp |> WAWebProtobufsE2E.AppStateSyncKeyFingerprint.encode() |> IO.iodata_to_binary()
          end

        record = %{
          key_data: data.keyData || <<>>,
          fingerprint: fingerprint,
          timestamp: data.timestamp || 0
        }

        case store.put_sync_key(our_jid, id, record) do
          :ok -> {:ok, id}
          {:error, _} = err -> err
        end

      _ ->
        :skip
    end
  end

  @doc "The stored key for `key_id`, or `{:error, :key_not_found}`."
  @spec get_key(String.t(), binary(), keyword()) ::
          {:ok, Store.sync_key()} | {:error, :key_not_found} | {:error, term()}
  def get_key(our_jid, key_id, opts \\ []) when is_binary(our_jid) and is_binary(key_id) do
    with {:ok, store} <- store(opts) do
      case store.get_sync_key(our_jid, key_id) do
        {:ok, _} = ok -> ok
        {:error, :not_found} -> {:error, :key_not_found}
        {:error, _} = err -> err
      end
    end
  end

  @doc """
  The id of the newest key (by its timestamp) — the one Go encrypts outgoing
  patches under. `{:error, :no_keys}` when the phone has shared none yet.
  """
  @spec latest_key_id(String.t(), keyword()) ::
          {:ok, binary()} | {:error, :no_keys} | {:error, term()}
  def latest_key_id(our_jid, opts \\ []) when is_binary(our_jid) do
    with {:ok, store} <- store(opts) do
      case store.latest_sync_key_id(our_jid) do
        {:ok, _} = ok -> ok
        {:error, :not_found} -> {:error, :no_keys}
        {:error, _} = err -> err
      end
    end
  end

  defp store(opts) do
    store = Keyword.get_lazy(opts, :store, &Store.impl/0)
    if Store.available?(store), do: {:ok, store}, else: {:error, :no_store}
  end
end
