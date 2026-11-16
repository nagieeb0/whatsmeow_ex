defmodule Whatsmeow.AppState.KeyShare do
  @moduledoc """
  Receiving and requesting app-state sync keys.

  App-state is end-to-end encrypted under keys that live on the primary phone. A
  linked device cannot invent them ("creating app state keys is not yet
  supported", as Go puts it): the phone has to *share* them, which it does with
  an `AppStateSyncKeyShare` protocol message shortly after linking, and again
  whenever a device asks with an `AppStateSyncKeyRequest`.

  Ports `handleAppStateSyncKeyShare` and `requestAppStateKeys` from
  `whatsmeow-main/appstate.go` / `message.go`.

  ## Who may share keys

  Only our own account. The caller (`Whatsmeow.Session`) drops a key share unless
  the message is from us, as Go gates the whole protocol-message handler on
  `info.IsFromMe`. Without that gate any contact could send us a "key" and have it
  become the newest one — the one every patch we send is then encrypted under.

  ## A device paired before this existed

  Its key share was dropped when it arrived, so it has no keys. The first
  `Whatsmeow.archive_chat/3` fetches the collection, finds the snapshot is
  encrypted under a key we lack, and asks the phone for it (once per key per 24h).
  That call returns `{:error, {:key_not_found, key_id}}`; when the phone answers,
  this module stores the key and syncs, and a retry then succeeds. The phone must
  be online, and may decline.
  """

  require Logger

  alias Whatsmeow.AppState.{Coordinator, Sync}

  alias WAWebProtobufsE2E.{
    AppStateSyncKeyFingerprint,
    AppStateSyncKeyId,
    AppStateSyncKeyRequest,
    AppStateSyncKeyShare,
    Message,
    ProtocolMessage
  }

  @doc """
  The key share inside a decrypted message, if — and only if — we should act on
  it: the message must be from our own account (`from_me?`).

  This is the security gate. A stored key becomes the newest one, which every
  patch we send is encrypted under; a share from any other sender would let them
  choose it. Go gates the whole protocol-message handler the same way
  (`info.IsFromMe`).
  """
  @spec extract(Message.t() | term(), boolean()) :: AppStateSyncKeyShare.t() | nil
  def extract(
        %Message{
          protocolMessage: %ProtocolMessage{appStateSyncKeyShare: %AppStateSyncKeyShare{} = share}
        },
        true
      ),
      do: share

  def extract(_message, _from_me?), do: nil

  @doc """
  Store the keys in `share`, then sync the configured collections. Go:
  `handleAppStateSyncKeyShare`.

  If any shared key is one we asked for, this is the answer to a request and a
  sync is forced; otherwise collections we already have are left alone
  (`only_if_not_synced`) — the phone re-shares keys now and then and that alone
  is no reason to re-read everything.

  `opts` are the `Whatsmeow.AppState.Sync.context/2` injection points.
  """
  @spec handle_share(pid() | String.t() | nil, AppStateSyncKeyShare.t(), keyword()) ::
          :ok | {:error, term()}
  def handle_share(session, %AppStateSyncKeyShare{} = share, opts \\ []) do
    with {:ok, ctx} <- Sync.context(session, opts) do
      keys = share.keys || []
      Logger.debug("[whatsmeow] app-state: got #{length(keys)} sync key(s)")

      re_request? =
        keys
        |> Enum.map(&key_id_of/1)
        |> Enum.any?(&(&1 && Coordinator.requested?(ctx.our_jid, &1)))

      Enum.each(keys, &store_key(ctx, &1))

      Enum.each(ctx.collections, &sync_collection(session, &1, not re_request?, opts))

      :ok
    end
  catch
    :exit, reason -> {:error, {:exit, reason}}
  end

  defp sync_collection(session, name, only_if_not_synced?, opts) do
    case Sync.fetch(session, name, Keyword.put(opts, :only_if_not_synced, only_if_not_synced?)) do
      {:ok, _state} ->
        :ok

      {:error, reason} ->
        Logger.warning("[whatsmeow] app-state: initial fetch of #{name} failed: #{inspect(reason)}")
    end
  end

  @doc """
  `handle_share/3` in a supervised task, logging any failure. This is what the
  receive loop calls: the sync does IQs and a blob download, which the loop must
  not wait for.
  """
  @spec handle_share_async(pid() | String.t(), AppStateSyncKeyShare.t(), term()) :: :ok
  def handle_share_async(session, %AppStateSyncKeyShare{} = share, device_id) do
    _ =
      Task.Supervisor.start_child(Whatsmeow.Sessions.TaskSup, fn ->
        case handle_share(session, share) do
          :ok ->
            :ok

          {:error, reason} ->
            Logger.warning(
              "[whatsmeow] app-state key share not handled (device #{inspect(device_id)}): " <>
                inspect(reason)
            )
        end
      end)

    :ok
  end

  # Go stores whatever it is given; a key with no id or no data can only ever
  # derive a wrong key, and if it carried a high timestamp it would become the
  # newest key and poison every patch we encrypt. Skip those.
  defp store_key(ctx, key) do
    key_id = key_id_of(key)
    data = key_data_of(key)

    if is_binary(key_id) and key_id != <<>> and is_binary(data) and data != <<>> do
      record = %{
        data: data,
        fingerprint: fingerprint_of(key),
        timestamp: (key.keyData && key.keyData.timestamp) || 0
      }

      case ctx.processor.store.put_key(ctx.our_jid, key_id, record) do
        :ok ->
          Logger.debug(
            "[whatsmeow] app-state: stored sync key #{Base.encode16(key_id)} (ts #{record.timestamp})"
          )

        {:error, reason} ->
          Logger.error(
            "[whatsmeow] app-state: failed to store sync key #{Base.encode16(key_id)}: #{inspect(reason)}"
          )
      end
    else
      Logger.warning("[whatsmeow] app-state: ignoring a sync key with no id or no data")
    end
  end

  defp key_id_of(%{keyID: %{keyID: id}}) when is_binary(id), do: id
  defp key_id_of(_), do: nil

  defp key_data_of(%{keyData: %{keyData: data}}) when is_binary(data), do: data
  defp key_data_of(_), do: nil

  # Go stores `proto.Marshal(fingerprint)`; an absent fingerprint marshals to nothing.
  defp fingerprint_of(%{keyData: %{fingerprint: %AppStateSyncKeyFingerprint{} = fp}}),
    do: fp |> AppStateSyncKeyFingerprint.encode() |> IO.iodata_to_binary()

  defp fingerprint_of(_), do: <<>>

  # --- requesting ---------------------------------------------------------------

  @doc "The peer message asking the phone for these keys. Go: `requestAppStateKeys`."
  @spec build_key_request([binary()]) :: Message.t()
  def build_key_request(key_ids) when is_list(key_ids) do
    %Message{
      protocolMessage: %ProtocolMessage{
        type: :APP_STATE_SYNC_KEY_REQUEST,
        appStateSyncKeyRequest: %AppStateSyncKeyRequest{
          keyIDs: Enum.map(key_ids, &%AppStateSyncKeyId{keyID: &1})
        }
      }
    }
  end

  @doc "Send the request now. `:noop` for an empty list."
  @spec request_keys(pid() | String.t(), [binary()]) :: {:ok, String.t()} | :noop | {:error, term()}
  def request_keys(_session, []), do: :noop

  def request_keys(session, key_ids) do
    Logger.info(
      "[whatsmeow] app-state: asking the phone for sync key(s) #{Enum.map_join(key_ids, ", ", &Base.encode16/1)}"
    )

    Whatsmeow.Send.send_peer_message(session, build_key_request(key_ids))
  end

  @doc """
  Send the request without blocking the caller. The caller is typically holding
  the app-state lock, and a peer message needs a device lookup and possibly a
  prekey fetch — seconds that should not be added to every failed sync. Go does the
  same (`go cli.requestMissingAppStateKeys`).
  """
  @spec request_keys_async(pid() | String.t(), [binary()]) :: :ok
  def request_keys_async(session, key_ids) do
    _ =
      Task.Supervisor.start_child(Whatsmeow.Sessions.TaskSup, fn ->
        case request_keys(session, key_ids) do
          {:error, reason} ->
            Logger.warning("[whatsmeow] app-state: failed to send key request: #{inspect(reason)}")

          _ ->
            :ok
        end
      end)

    :ok
  end
end
