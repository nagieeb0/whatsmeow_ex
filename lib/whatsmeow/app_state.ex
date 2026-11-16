defmodule Whatsmeow.AppState do
  @moduledoc """
  App-state sync for a linked device: keep each collection's verified state,
  and send patches — archive a chat, mark it read — the way the phone and
  every other linked device expect them.

  Ports, from `whatsmeow-main/appstate.go` and `message.go`:

    * `fetch_app_state/3` — `fetchAppState`: a snapshot when nothing is
      stored, then patches until `has_more_patches` is false, each verified
      and persisted by `Whatsmeow.AppState.Processor`;
    * `send_patch/3` — `sendAppState`: encode on top of the stored state,
      `<iq xmlns="w:sync:app:state" type="set">`, on a 409 conflict apply
      the patches the server returns and retry once, then re-fetch;
    * `handle_key_share/3` — `handleAppStateSyncKeyShare`: store the keys,
      then sync each collection that has never been synced;
    * missing keys are requested from our own devices with an
      `APP_STATE_SYNC_KEY_REQUEST` peer message (`requestAppStateKeys`),
      at most once a day per key, as Go does.

  ## Safety: what is refused

  A patch is a write to the owner's account that every one of their devices
  applies. A patch encoded on a wrong LTHash or version is rejected, and a
  patch with bad MACs fails app-state sync on the devices that receive it. So
  `send_patch/3`:

    * **first syncs the collection** (`fetch_app_state/3`) and refuses with
      `{:error, {:not_synced, reason}}` unless every snapshot and patch up to
      the server's head verified — snapshot MAC, patch MACs, content and
      index MACs;
    * refuses with `{:error, :no_app_state_keys}` when the phone has shared no
      key, and never creates keys of its own (Go does not either);
    * never sends from a state that has not been stored after verification.

  ## Not ported

  Go turns applied mutations into events (`events.Archive`, `events.Mute`,
  contacts into its contact store …). Here they are verified and their MACs
  stored, which is all sending needs; no events are dispatched and no chat
  settings are written. App-state recovery (`handleAppStateRecovery`) is not
  ported either.

  ## Concurrency

  Everything that reads and writes one account's stored state runs under a
  per-account lock (Go's `appStateSyncLock`, held here across a whole send
  too, so a sync cannot interleave between encoding and storing).
  """

  require Logger

  alias Whatsmeow.AppState.{Encode, Hash, Keys, KeyStore, Patch, Processor, Store, Sync, Tables}
  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Media.{Download, Refresh, TaskSup}
  alias Whatsmeow.{Send, Session}

  @server_jid "s.whatsapp.net"
  @key_request_interval_ms 24 * 60 * 60 * 1000

  defmodule Context do
    @moduledoc """
    What app-state sync needs from a session, as functions — so the protocol
    can be driven without a socket.

      * `:jid` — our own JID (`device.jid`), the key of every stored row
      * `:store` — a `Whatsmeow.AppState.Store` adapter
      * `:iq` — `fn %Node{} -> {:ok, %Node{}} | {:error, term} end`
      * `:download` — `fn %WAServerSync.ExternalBlobReference{} -> {:ok, binary} | {:error, term} end`
      * `:request_keys` — `fn [key_id] -> any end`, sends the key request
      * `:device_id` — for log metadata only
    """
    @enforce_keys [:jid, :store, :iq, :download, :request_keys]
    defstruct [:jid, :store, :iq, :download, :request_keys, :device_id]

    @type t :: %__MODULE__{
            jid: String.t(),
            store: module(),
            iq: (Node.t() -> {:ok, Node.t()} | {:error, term()}),
            download: (struct() -> {:ok, binary()} | {:error, term()}),
            request_keys: ([binary()] -> any()),
            device_id: String.t() | nil
          }
  end

  @type session :: pid() | String.t() | Context.t()

  # --- Public API -------------------------------------------------------------

  @doc """
  Archive (`true`) or unarchive (`false`) the 1:1 chat with
  `<phone_digits>@s.whatsapp.net`.

  Archiving also unpins the chat, as Go's `BuildArchive` does. The message
  range is "now" with no message key — Go allows both to be empty.

  `session` is what the rest of the API takes: the session's device id (its
  registered name) or pid. Returns `:ok` once the server accepted the patch
  and the collection re-synced; otherwise `{:error, reason}` and nothing was
  changed on the account.
  """
  @spec archive_chat(session(), String.t(), boolean()) :: :ok | {:error, term()}
  def archive_chat(session, phone_digits, archive?) when is_boolean(archive?) do
    with {:ok, jid} <- user_jid(phone_digits) do
      send_patch(session, Patch.build_archive(jid, archive?))
    end
  end

  @doc """
  Mark the 1:1 chat with `<phone_digits>@s.whatsapp.net` read (`true`) or
  unread (`false`). Same arguments and results as `archive_chat/3`.
  """
  @spec mark_chat_as_read(session(), String.t(), boolean()) :: :ok | {:error, term()}
  def mark_chat_as_read(session, phone_digits, read?) when is_boolean(read?) do
    with {:ok, jid} <- user_jid(phone_digits) do
      send_patch(session, Patch.build_mark_chat_as_read(jid, read?))
    end
  end

  @doc """
  Send `patch` — Go's `SendAppState`, behind the checks in the moduledoc.

  Options: `:timeout` per IQ (default 30 s), `:ivs` (tests).
  """
  @spec send_patch(session(), Patch.t(), keyword()) :: :ok | {:error, term()}
  def send_patch(session, %Patch{type: name} = patch, opts \\ []) do
    with {:ok, ctx} <- context(session, opts),
         true <- name in Keys.all_patch_names() || {:error, {:unknown_collection, name}} do
      with_lock(ctx, fn -> synced_send(ctx, patch, opts) end)
    end
  end

  defp synced_send(ctx, %Patch{type: name} = patch, opts) do
    case do_fetch(ctx, name, []) do
      {:ok, _state} -> do_send(ctx, patch, true, opts)
      {:error, reason} -> {:error, {:not_synced, reason}}
    end
  end

  @doc """
  Bring collection `name` up to the server's head, verifying everything —
  Go's `FetchAppState`.

  Options: `full_sync?: true` drops the stored version first (re-sync from a
  snapshot); `only_if_not_synced?: true` does nothing when a version is
  stored. Returns the verified state.
  """
  @spec fetch_app_state(session(), String.t(), keyword()) :: {:ok, Hash.t()} | {:error, term()}
  def fetch_app_state(session, name, opts \\ []) when is_binary(name) do
    with {:ok, ctx} <- context(session, opts) do
      with_lock(ctx, fn -> do_fetch(ctx, name, opts) end)
    end
  end

  @doc """
  Store the keys in an `AppStateSyncKeyShare` from our own phone, then sync
  every collection — only those never synced, unless a key in the share
  answers a request we made (Go's `onlyResyncIfNotSynced`).

  The caller must have checked the share came from our own account.
  """
  @spec handle_key_share(session(), WAWebProtobufsE2E.AppStateSyncKeyShare.t(), keyword()) ::
          :ok | {:error, term()}
  def handle_key_share(session, %WAWebProtobufsE2E.AppStateSyncKeyShare{} = share, opts \\ []) do
    with {:ok, ctx} <- context(session, opts),
         {:ok, ids} <- KeyStore.put_key_share(ctx.jid, share, store: ctx.store) do
      Logger.debug("[whatsmeow] #{log_id(ctx)}stored #{length(ids)} app state keys")
      re_request? = Enum.any?(ids, &requested?(ctx.jid, &1))
      Enum.each(Keys.all_patch_names(), &sync_after_share(ctx, &1, re_request?))
    end
  end

  defp sync_after_share(ctx, name, re_request?) do
    case fetch_app_state(ctx, name, only_if_not_synced?: not re_request?) do
      {:ok, _} ->
        :ok

      {:error, reason} ->
        Logger.warning(
          "[whatsmeow] #{log_id(ctx)}app state #{name} sync failed: #{inspect(reason)}"
        )
    end
  end

  defp log_id(%{device_id: id}) when is_binary(id), do: "[#{id}] "
  defp log_id(_), do: ""

  @doc """
  Build the `Context` for a live session. Production code does not need
  this; it is public so a host can drive `fetch_app_state/3` etc. with its
  own functions.
  """
  @spec context(session(), keyword()) :: {:ok, Context.t()} | {:error, term()}
  def context(%Context{} = ctx, _opts), do: {:ok, ctx}

  def context(server, opts) when is_pid(server) or is_binary(server) do
    timeout = Keyword.get(opts, :timeout, 30_000)
    store = Keyword.get_lazy(opts, :store, &Store.impl/0)

    with {:ok, %{jid: jid}} when is_binary(jid) and jid != "" <-
           Session.get_device(server),
         true <- Store.available?(store) || {:error, :no_store} do
      {:ok,
       %Context{
         jid: jid,
         store: store,
         device_id: if(is_binary(server), do: server, else: nil),
         iq: fn node -> Session.send_iq(server, node, timeout) end,
         download: fn ref -> download_blob(server, ref) end,
         request_keys: fn ids -> send_key_request(server, ids) end
       }}
    else
      {:ok, _device} -> {:error, :not_paired}
      {:error, _} = err -> err
    end
  catch
    :exit, reason -> {:error, {:session_unavailable, reason}}
  end

  @doc "The `APP_STATE_SYNC_KEY_REQUEST` peer message for `key_ids`."
  @spec build_key_request([binary()]) :: WAWebProtobufsE2E.Message.t()
  def build_key_request(key_ids) when is_list(key_ids) do
    %WAWebProtobufsE2E.Message{
      protocolMessage: %WAWebProtobufsE2E.ProtocolMessage{
        type: :APP_STATE_SYNC_KEY_REQUEST,
        appStateSyncKeyRequest: %WAWebProtobufsE2E.AppStateSyncKeyRequest{
          keyIDs: Enum.map(key_ids, &%WAWebProtobufsE2E.AppStateSyncKeyId{keyID: &1})
        }
      }
    }
  end

  # --- Fetch loop -------------------------------------------------------------

  defp do_fetch(ctx, name, opts) do
    full? = Keyword.get(opts, :full_sync?, false)

    with :ok <- if(full?, do: ctx.store.delete_version(ctx.jid, name), else: :ok),
         {:ok, %Hash{} = state} <- ctx.store.get_version(ctx.jid, name) do
      full? = full? or state.version == 0

      if not full? and Keyword.get(opts, :only_if_not_synced?, false) do
        {:ok, state}
      else
        fetch_loop(ctx, name, state, full?)
      end
    end
  end

  defp fetch_loop(ctx, name, state, want_snapshot?) do
    with {:ok, resp} <- iq(ctx, Sync.build_fetch_patches_iq(name, state.version, want_snapshot?)),
         {:ok, list} <- Sync.parse_patch_list(resp, ctx.download),
         :ok <- check_snapshot(list, state, want_snapshot?),
         {:ok, new_state} <- apply_patches(ctx, name, state, list) do
      cond do
        not list.has_more_patches? ->
          {:ok, new_state}

        # Go loops on has_more_patches alone; a server that says "more" while
        # handing us nothing new would spin it forever.
        new_state.version <= state.version ->
          {:error, {:no_progress, state.version}}

        true ->
          fetch_loop(ctx, name, new_state, false)
      end
    end
  end

  defp check_snapshot(%{snapshot: nil}, _state, _wanted?), do: :ok
  defp check_snapshot(_list, _state, false), do: {:error, :unexpected_snapshot}

  defp check_snapshot(_list, %Hash{} = state, true) do
    if state == Hash.new(), do: :ok, else: {:error, {:snapshot_on_non_empty_state, state.version}}
  end

  defp apply_patches(ctx, name, state, list) do
    case Processor.decode_patches(Map.from_struct(ctx), %{list | name: name}, state, true) do
      {:ok, _mutations, new_state} ->
        {:ok, new_state}

      {:error, {:key_not_found, _}} = err ->
        request_missing_keys(ctx, list)
        err

      {:error, _} = err ->
        err
    end
  end

  # --- Send -------------------------------------------------------------------

  defp do_send(ctx, %Patch{type: name} = patch, allow_retry?, opts) do
    with {:ok, state} <- ctx.store.get_version(ctx.jid, name),
         {:ok, key_id} <- latest_key(ctx),
         {:ok, %{key_data: key_data}} <- KeyStore.get_key(ctx.jid, key_id, store: ctx.store),
         {:ok, %{patch: bytes}} <-
           Encode.encode_syncd_patch(
             patch,
             Keys.expand(key_data),
             key_id,
             state,
             fn index_mac, _i -> stored_mac!(ctx, name, index_mac) end,
             Keyword.take(opts, [:ivs])
           ),
         {:ok, resp} <- iq(ctx, build_send_iq(name, state.version, bytes)),
         {:ok, collection} <- response_collection(resp) do
      if Node.attr(collection, "type") == "error",
        do: handle_send_error(ctx, patch, state, collection, allow_retry?, opts),
        else: resync_after_send(ctx, name)
    end
  catch
    {:store_error, reason} -> {:error, {:store, reason}}
  end

  # Go's sendAppState ends with fetchAppState: our own patch comes back
  # from the server and is verified like any other before it is stored.
  defp resync_after_send(ctx, name) do
    case do_fetch(ctx, name, []) do
      {:ok, _} -> :ok
      {:error, reason} -> {:error, {:resync_failed, reason}}
    end
  end

  defp handle_send_error(ctx, %Patch{type: name} = patch, state, collection, allow_retry?, opts) do
    error = Node.get_child(collection, "error")
    code = error && Node.attr(error, "code")
    reason = {:app_state_update_failed, name, code, error && Node.attr(error, "text")}

    if code == "409" and allow_retry? do
      Logger.warning("[whatsmeow] #{log_id(ctx)}app state #{name} conflict, applying and retrying")

      with {:ok, list} <- Sync.parse_collection(collection, ctx.download),
           :ok <- check_snapshot(list, state, state == Hash.new()),
           {:ok, _} <- apply_patches(ctx, name, state, list) do
        do_send(ctx, patch, false, opts)
      else
        {:error, also} -> {:error, {reason, {:conflict_apply_failed, also}}}
      end
    else
      {:error, reason}
    end
  end

  defp build_send_iq(name, version, bytes) do
    Node.new(
      "iq",
      %{
        "id" => Whatsmeow.IQ.generate_id(),
        "to" => @server_jid,
        "type" => "set",
        "xmlns" => "w:sync:app:state"
      },
      [
        Node.new("sync", %{}, [
          Node.new(
            "collection",
            %{
              "name" => name,
              "version" => Integer.to_string(version),
              "return_snapshot" => "false"
            },
            [Node.new("patch", %{}, bytes)]
          )
        ])
      ]
    )
  end

  defp response_collection(resp) do
    with %Node{} = sync <- Node.get_child(resp, "sync"),
         %Node{} = collection <- Node.get_child(sync, "collection") do
      {:ok, collection}
    else
      _ -> {:error, {:missing_element, "collection"}}
    end
  end

  defp latest_key(ctx) do
    case KeyStore.latest_key_id(ctx.jid, store: ctx.store) do
      {:ok, _} = ok -> ok
      {:error, :no_keys} -> {:error, :no_app_state_keys}
      {:error, _} = err -> err
    end
  end

  defp stored_mac!(ctx, name, index_mac) do
    case ctx.store.get_mutation_mac(ctx.jid, name, index_mac) do
      {:ok, mac} -> mac
      {:error, reason} -> throw({:store_error, reason})
    end
  end

  # Go's sendIQ turns `<iq type="error">` into an error; `Session.send_iq/3`
  # hands back whichever came.
  defp iq(ctx, node) do
    case ctx.iq.(node) do
      {:ok, %Node{} = resp} ->
        if Node.attr(resp, "type") == "error" do
          err = Node.get_child(resp, "error")
          {:error, {:iq_error, err && Node.attr(err, "code"), err && Node.attr(err, "text")}}
        else
          {:ok, resp}
        end

      {:error, _} = err ->
        err
    end
  end

  # --- Key requests -----------------------------------------------------------

  defp request_missing_keys(ctx, list) do
    now = System.monotonic_time(:millisecond)

    due =
      ctx
      |> Map.from_struct()
      |> Processor.missing_key_ids(list)
      |> Enum.filter(fn id ->
        case :ets.lookup(key_requests(), {ctx.jid, id}) do
          [{_, at}] when now - at < @key_request_interval_ms -> false
          _ -> :ets.insert(key_requests(), {{ctx.jid, id}, now})
        end
      end)

    if due != [] do
      Logger.info(
        "[whatsmeow] #{log_id(ctx)}requesting app state keys #{inspect(Enum.map(due, &Base.encode16/1))}"
      )

      ctx.request_keys.(due)
    end

    :ok
  end

  defp requested?(jid, key_id), do: :ets.member(key_requests(), {jid, key_id})

  defp key_requests, do: Tables.key_requests()

  defp send_key_request(server, ids) do
    Task.Supervisor.start_child(TaskSup, fn ->
      case Send.send_peer_message(server, build_key_request(ids)) do
        {:ok, _id} ->
          :ok

        {:error, reason} ->
          Logger.warning("[whatsmeow] app state key request failed: #{inspect(reason)}")
      end
    end)
  end

  # --- Blobs ------------------------------------------------------------------

  defp download_blob(server, %WAServerSync.ExternalBlobReference{} = ref) do
    descriptor = %{
      kind: :app_state,
      direct_path: ref.directPath,
      media_key: ref.mediaKey,
      file_sha256: ref.fileSHA256,
      file_enc_sha256: ref.fileEncSHA256,
      file_length: ref.fileSizeBytes
    }

    with true <-
           (is_binary(ref.mediaKey) and byte_size(ref.mediaKey) == 32) || {:error, :bad_media_key},
         {:ok, conn} <- Refresh.refresh(server) do
      Download.fetch_and_decrypt(descriptor, media_conn: conn)
    end
  end

  # --- Helpers ----------------------------------------------------------------

  defp user_jid(digits) when is_binary(digits) do
    if digits =~ ~r/\A[0-9]{5,20}\z/,
      do: {:ok, digits <> "@" <> @server_jid},
      else: {:error, :invalid_phone}
  end

  defp user_jid(_), do: {:error, :invalid_phone}

  defp with_lock(%Context{jid: jid}, fun) do
    :global.trans({{__MODULE__, jid}, self()}, fun, [node()])
  end
end
