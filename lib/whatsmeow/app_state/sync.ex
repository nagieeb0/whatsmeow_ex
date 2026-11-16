defmodule Whatsmeow.AppState.Sync do
  @moduledoc """
  App-state sync over the `w:sync:app:state` IQ namespace: fetch a collection's
  snapshot/patches, verify and persist them, and send our own patches.

  Ports `FetchAppState` / `fetchAppState`, `applyAppStatePatches`,
  `ParsePatchList`, `requestMissingAppStateKeys` and `SendAppState` /
  `sendAppState` from `whatsmeow-main/appstate.go`, plus the parsing half of
  `appstate/decode.go`.

  ## The two entry points

    * `fetch/3` — bring a collection up to date. Never sends anything that
      changes state; it only reads from the server.
    * `send_patch/3` — send a `Whatsmeow.AppState.Patch`, then re-fetch the
      collection so our stored version/hash/MACs include the patch we just sent.

  Both hold the per-device `Whatsmeow.AppState.Coordinator` lock for their whole
  duration.

  ## How a send goes, and what can go wrong

    1. read the stored version + LTHash (a never-synced collection is fetched
       first — sending against version 0 when the server is further along can only
       conflict);
    2. encode under the newest key (`Whatsmeow.AppState.Processor.encode_patch/3`);
    3. **self-check**: decode the encoded patch back through the verifying path and
       compare — a patch that does not verify is never sent;
    4. `<iq type="set" xmlns="w:sync:app:state">` with the version we are
       extending;
    5. a `409` means the server is ahead of us: apply the patches it returns, then
       retry **once** from the new state. Any other error is returned as is;
    6. on success, re-fetch from our old version: the server hands our own patch
       back, which re-verifies it and advances local state.

  ## Errors

  Everything is `{:error, reason}`; nothing raises. Notable reasons:

    * `:no_app_state_keys` — the phone never shared a sync key with this device
      (or the keys were lost). Nothing can be sent until it does.
    * `{:key_not_found, key_id}` — a patch needs a key we do not have. A request
      for it has been sent to the phone (at most once per key per 24h); retry
      once the phone has answered.
    * `{:rejected, %{code: code, text: text}}` — the server refused the patch.
    * `{:resync_failed, reason}` — the patch **was accepted** but re-reading the
      collection failed. Do not blindly resend.
    * `{:self_check_failed, reason}` — our own patch did not verify; nothing was
      sent. This is a bug, not a condition to retry.
    * `:lock_timeout` — another app-state operation on this device is stuck.
  """

  require Logger

  alias Whatsmeow.AppState.{Coordinator, Hash, KeyShare, Patch, PatchList, Processor}
  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Media.{Download, Refresh}
  alias Whatsmeow.Session
  alias Whatsmeow.Types.JID

  alias WAServerSync.{ExternalBlobReference, SyncdMutations, SyncdPatch, SyncdSnapshot}

  @namespace "w:sync:app:state"
  @default_timeout 30_000

  # Go syncs all five on a key share. regular_low is where archive and
  # markChatAsRead live; the others carry contacts (potentially thousands) and
  # settings this library has no use for, so they are opt-in.
  @default_collections ["regular_low"]

  @patch_names ~w(critical_block critical_unblock_low regular_low regular_high regular)

  @type ctx :: %{
          our_jid: String.t(),
          processor: Processor.t(),
          send_iq: (Node.t() -> {:ok, Node.t()} | {:error, term()}),
          download: (ExternalBlobReference.t() -> {:ok, binary()} | {:error, term()}),
          request_keys: ([binary()] -> term()),
          collections: [String.t()]
        }

  @doc "All collection names WhatsApp defines."
  @spec patch_names() :: [String.t()]
  def patch_names, do: @patch_names

  @doc "The collections synced when the phone shares keys (`config :whatsmeow_ex, :app_state_collections`)."
  @spec default_collections() :: [String.t()]
  def default_collections do
    Application.get_env(:whatsmeow_ex, :app_state_collections, @default_collections)
  end

  # --- public API --------------------------------------------------------------

  @doc """
  Bring `name` up to date with the server. Go: `FetchAppState`.

  Options:

    * `:full_sync` — drop the stored version and re-fetch everything (default `false`)
    * `:only_if_not_synced` — do nothing if we already have a version (default `false`)
    * `:timeout` — per-IQ timeout, ms

  and the injection points documented on `context/2`.

  Returns `{:ok, %Whatsmeow.AppState.Hash{}}` — the collection's state afterwards.
  """
  @spec fetch(pid() | String.t() | nil, String.t(), keyword()) ::
          {:ok, Hash.t()} | {:error, term()}
  def fetch(session, name, opts \\ []) when is_binary(name) do
    with {:ok, ctx} <- context(session, opts) do
      locked(ctx, opts, fn ->
        do_fetch(
          ctx,
          name,
          Keyword.get(opts, :full_sync, false),
          Keyword.get(opts, :only_if_not_synced, false)
        )
      end)
    end
  end

  @doc """
  Send `patch`, then re-fetch its collection. Go: `SendAppState`.

  Returns `{:ok, %Hash{}}` with the collection's state after the resync; its
  `version` is the patch's new version.
  """
  @spec send_patch(pid() | String.t() | nil, Patch.t(), keyword()) ::
          {:ok, Hash.t()} | {:error, term()}
  def send_patch(session, %Patch{} = patch, opts \\ []) do
    with {:ok, ctx} <- context(session, opts) do
      locked(ctx, opts, fn -> do_send(ctx, patch, true) end)
    end
  end

  # --- context -----------------------------------------------------------------

  @doc """
  Build the operation context. Every outward edge can be overridden, which is
  how the tests run the conflict path against a fake server with no network:

    * `:our_jid` — skip the session lookup
    * `:store` — a `Whatsmeow.AppState.Store` module
    * `:send_iq` — `(%Node{} -> {:ok, %Node{}} | {:error, _})`
    * `:download` — `(%ExternalBlobReference{} -> {:ok, binary} | {:error, _})`
    * `:request_keys` — `([key_id] -> any)`, called for key ids to ask the phone for
    * `:collections` — what to sync after a key share
  """
  @spec context(pid() | String.t() | nil, keyword()) :: {:ok, ctx()} | {:error, term()}
  def context(session, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    with {:ok, our_jid} <- our_jid(session, opts) do
      {:ok,
       %{
         our_jid: our_jid,
         processor: Processor.new(our_jid, Keyword.take(opts, [:store])),
         send_iq:
           Keyword.get_lazy(opts, :send_iq, fn ->
             fn iq -> Session.send_iq(session, iq, timeout) end
           end),
         download: Keyword.get_lazy(opts, :download, fn -> default_download(session) end),
         request_keys:
           Keyword.get_lazy(opts, :request_keys, fn ->
             fn ids -> KeyShare.request_keys_async(session, ids) end
           end),
         collections: Keyword.get_lazy(opts, :collections, &default_collections/0)
       }}
    end
  end

  defp our_jid(session, opts) do
    case Keyword.fetch(opts, :our_jid) do
      {:ok, jid} when is_binary(jid) and jid != "" ->
        {:ok, jid}

      _ ->
        case session && Session.get_device(session) do
          {:ok, %{jid: jid}} when is_binary(jid) and jid != "" -> {:ok, jid}
          _ -> {:error, :no_device}
        end
    end
  catch
    :exit, _ -> {:error, :session_unavailable}
  end

  defp locked(ctx, opts, fun) do
    case Coordinator.with_lock(ctx.our_jid, fun, Keyword.get(opts, :lock_timeout, 120_000)) do
      {:ok, result} -> result
      {:error, _} = err -> err
    end
  end

  # --- fetch -------------------------------------------------------------------

  @doc false
  @spec do_fetch(ctx(), String.t(), boolean(), boolean()) :: {:ok, Hash.t()} | {:error, term()}
  def do_fetch(ctx, name, full_sync?, only_if_not_synced?) do
    store = ctx.processor.store
    jid = ctx.our_jid

    with :ok <- maybe_reset(store, jid, name, full_sync?),
         {:ok, version, hash} <- store_version(store.get_version(jid, name)) do
      state = %Hash{version: version, hash: hash}

      cond do
        # Never synced: we are about to take a snapshot, which is the whole
        # collection. Start from nothing — including MACs a previous life of this
        # collection may have left (see `Store.reset_collection/2`).
        version == 0 ->
          snapshot_sync(ctx, name, state)

        only_if_not_synced? ->
          {:ok, state}

        true ->
          fetch_loop(ctx, name, state, false)
      end
    end
  end

  defp snapshot_sync(ctx, name, state) do
    with :ok <- store_unit(ctx.processor.store.reset_collection(ctx.our_jid, name)) do
      fetch_loop(ctx, name, state, true)
    end
  end

  defp maybe_reset(_store, _jid, _name, false), do: :ok
  defp maybe_reset(store, jid, name, true), do: store_unit(store.reset_collection(jid, name))

  defp fetch_loop(ctx, name, %Hash{} = state, want_snapshot?) do
    with {:ok, list} <- fetch_patches(ctx, name, state.version, want_snapshot?),
         :ok <- check_snapshot(list, state, want_snapshot?),
         {:ok, new_state} <- apply_patches(ctx, name, state, list) do
      cond do
        not list.has_more_patches? ->
          {:ok, new_state}

        # A server that keeps saying "more" without advancing would loop us
        # forever (Go would); stop and say so.
        new_state.version == state.version and is_nil(list.snapshot) ->
          {:error, {:no_progress, name, state.version}}

        true ->
          fetch_loop(ctx, name, new_state, false)
      end
    end
  end

  defp check_snapshot(%PatchList{snapshot: nil}, _state, _wanted), do: :ok

  defp check_snapshot(%PatchList{name: name}, _state, false),
    do: {:error, {:unexpected_snapshot, name}}

  defp check_snapshot(%PatchList{name: name}, %Hash{} = state, true) do
    if state.version == 0 and state.hash == <<0::1024>>,
      do: :ok,
      else: {:error, {:snapshot_over_nonempty_state, name, state.version}}
  end

  # Go: applyAppStatePatches
  defp apply_patches(ctx, name, state, %PatchList{} = list) do
    case Processor.decode_patches(ctx.processor, list, state, true) do
      {:ok, mutations, new_state} ->
        Logger.debug(
          "[whatsmeow] app-state #{name}: v#{state.version} -> v#{new_state.version} (#{length(mutations)} mutations)"
        )

        {:ok, new_state}

      {:error, {:key_not_found, _} = reason} ->
        request_missing_keys(ctx, list)
        {:error, reason}

      {:error, reason} ->
        Logger.warning("[whatsmeow] app-state #{name}: failed to apply patches: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # Go: requestMissingAppStateKeys — each key at most once per 24h.
  defp request_missing_keys(ctx, list) do
    ids =
      ctx.processor
      |> Processor.missing_key_ids(list)
      |> then(&Coordinator.claim_key_requests(ctx.our_jid, &1))

    if ids != [], do: ctx.request_keys.(ids)
    :ok
  end

  defp fetch_patches(ctx, name, from_version, snapshot?) do
    iq = build_fetch_patches_iq(name, from_version, snapshot?)

    with {:ok, resp} <- iq_result(ctx.send_iq.(iq)),
         {:ok, collection} <- collection_of(resp) do
      parse_collection(collection, name, ctx.download)
    end
  end

  # --- send --------------------------------------------------------------------

  defp do_send(ctx, %Patch{type: name} = patch, allow_retry?) do
    store = ctx.processor.store
    jid = ctx.our_jid

    with {:ok, _} <- ensure_synced(ctx, name),
         {:ok, version, hash} <- store_version(store.get_version(jid, name)),
         state = %Hash{version: version, hash: hash},
         {:ok, enc} <- Processor.encode_patch(ctx.processor, patch, state),
         :ok <- self_check(ctx, patch, enc, state),
         {:ok, resp} <- iq_result(ctx.send_iq.(build_send_patch_iq(name, version, enc.bytes))),
         {:ok, collection} <- collection_of(resp) do
      case collection_error(collection) do
        nil ->
          resync_after_send(ctx, name)

        %{code: 409} = error when allow_retry? ->
          Logger.warning(
            "[whatsmeow] app-state #{name}: version conflict (409) at v#{version}, applying server patches and retrying once"
          )

          resolve_conflict(ctx, patch, name, state, collection, error)

        error ->
          {:error, {:rejected, error}}
      end
    end
  end

  # A collection we have never synced is fetched before we extend it: the
  # server is almost certainly ahead of version 0, and a patch against 0 can
  # only conflict. (Go sends against whatever is stored.) Already-synced
  # collections are left alone — a stale one is what the 409 path is for.
  defp ensure_synced(ctx, name), do: do_fetch(ctx, name, false, true)

  defp resolve_conflict(ctx, patch, name, state, collection, error) do
    with {:ok, list} <- parse_collection(collection, name, ctx.download),
         {:ok, _state} <- catch_up(ctx, name, state, list) do
      do_send(ctx, patch, false)
    else
      {:error, reason} -> {:error, {:conflict_resync_failed, reason, error}}
    end
  end

  # Bring local state level with the server using what its 409 carried.
  #
  #   * patches only: apply them (verified like any other), and if the server says
  #     there are more than it sent, keep reading — retrying while still behind
  #     would spend our one retry on a guaranteed second conflict;
  #   * a snapshot: the server is too far ahead to send patches. Applying a whole
  #     snapshot on top of non-empty state cannot verify, so discard local state and
  #     re-read the collection from scratch.
  defp catch_up(ctx, name, _state, %PatchList{snapshot: %SyncdSnapshot{}}),
    do: do_fetch(ctx, name, true, false)

  defp catch_up(ctx, name, state, %PatchList{} = list) do
    with {:ok, new_state} <- apply_patches(ctx, name, state, list) do
      if list.has_more_patches?, do: do_fetch(ctx, name, false, false), else: {:ok, new_state}
    end
  end

  # The patch is on the server. Re-read so our version/hash/MACs include it; a
  # failure here must not read as "the send failed".
  defp resync_after_send(ctx, name) do
    case do_fetch(ctx, name, false, false) do
      {:ok, %Hash{} = state} -> {:ok, state}
      {:error, reason} -> {:error, {:resync_failed, reason}}
    end
  end

  # Decode what we just encoded through the verifying path. The server cannot
  # check MACs (it has no keys), so this is the only gate between a bug and the
  # user's phone.
  defp self_check(ctx, %Patch{} = patch, enc, %Hash{} = state) do
    expected_indexes = Enum.map(patch.mutations, & &1.index)

    case Processor.dry_decode(ctx.processor, patch.type, enc.bytes, state.version + 1, state) do
      {:ok, mutations, new_state} ->
        cond do
          new_state.hash != enc.state.hash or new_state.version != enc.state.version ->
            {:error, {:self_check_failed, :state_mismatch}}

          Enum.map(mutations, & &1.index) != expected_indexes ->
            {:error, {:self_check_failed, :index_mismatch}}

          Enum.any?(mutations, &(&1.operation != :set)) ->
            {:error, {:self_check_failed, :operation_mismatch}}

          true ->
            :ok
        end

      {:error, reason} ->
        {:error, {:self_check_failed, reason}}
    end
  end

  # --- IQ builders -------------------------------------------------------------

  @doc """
  `<iq xmlns="w:sync:app:state" type="set" to="s.whatsapp.net"><sync><collection
  name= return_snapshot= [version=]/></sync></iq>`. Go: `fetchAppStatePatches`.

  `version` is sent only when not asking for a snapshot.
  """
  @spec build_fetch_patches_iq(String.t(), non_neg_integer(), boolean(), keyword()) :: Node.t()
  def build_fetch_patches_iq(name, from_version, return_snapshot?, opts \\ [])
      when is_binary(name) and is_integer(from_version) and from_version >= 0 and
             is_boolean(return_snapshot?) do
    attrs = %{"name" => name, "return_snapshot" => to_string(return_snapshot?)}

    attrs =
      if return_snapshot?,
        do: attrs,
        else: Map.put(attrs, "version", Integer.to_string(from_version))

    sync_iq(Node.new("collection", attrs, nil), opts)
  end

  @doc """
  The send IQ: same envelope, `<collection name= version= return_snapshot="false">`
  holding a `<patch>` whose content is the serialized `SyncdPatch`.
  `version` is the version we are *extending* (before the patch). Go: `sendAppState`.
  """
  @spec build_send_patch_iq(String.t(), non_neg_integer(), binary(), keyword()) :: Node.t()
  def build_send_patch_iq(name, version, patch_bytes, opts \\ [])
      when is_binary(name) and is_integer(version) and is_binary(patch_bytes) do
    attrs = %{
      "name" => name,
      "version" => Integer.to_string(version),
      "return_snapshot" => "false"
    }

    sync_iq(Node.new("collection", attrs, [Node.new("patch", %{}, patch_bytes)]), opts)
  end

  defp sync_iq(collection, opts) do
    Node.new(
      "iq",
      %{
        "id" => Keyword.get(opts, :id) || IQ.generate_id(),
        # A typed JID, not the string "s.whatsapp.net" — see `Whatsmeow.IQ`.
        "to" => %JID{user: "", server: JID.default_user_server()},
        "type" => "set",
        "xmlns" => @namespace
      },
      [Node.new("sync", %{}, [collection])]
    )
  end

  # --- response parsing --------------------------------------------------------

  # Error IQs are delivered like any other response; the caller checks the type.
  defp iq_result({:ok, %Node{} = resp}) do
    if Node.attr(resp, "type") == "error" do
      error = Node.get_child(resp, "error")

      {:error,
       {:iq_error,
        %{
          code: parse_int(error && Node.attr(error, "code")),
          text: error && Node.attr(error, "text")
        }}}
    else
      {:ok, resp}
    end
  end

  defp iq_result({:error, _} = err), do: err
  defp iq_result(other), do: {:error, {:unexpected_iq_result, other}}

  defp collection_of(%Node{} = resp) do
    with %Node{} = sync <- Node.get_child(resp, "sync"),
         %Node{} = collection <- Node.get_child(sync, "collection") do
      {:ok, collection}
    else
      _ -> {:error, {:missing_element, "collection"}}
    end
  end

  # `<collection type="error"><error code="409" .../></collection>` — an error
  # nested in an otherwise successful IQ.
  defp collection_error(%Node{} = collection) do
    if Node.attr(collection, "type") == "error" do
      error = Node.get_child(collection, "error")

      %{
        code: parse_int(error && Node.attr(error, "code")),
        text: error && Node.attr(error, "text")
      }
    end
  end

  @doc """
  Parse a `<collection>` into a `%PatchList{}`, downloading any external blobs
  through `download`. Go: `ParsePatchList`.

  `expected_name` guards against applying one collection's patches under
  another's name — the name feeds the MACs, so a mismatch would corrupt state
  rather than fail loudly.
  """
  @spec parse_collection(
          Node.t(),
          String.t(),
          (ExternalBlobReference.t() ->
             {:ok, binary()} | {:error, term()})
          | nil
        ) ::
          {:ok, PatchList.t()} | {:error, term()}
  def parse_collection(%Node{} = collection, expected_name, download) do
    name = Node.attr(collection, "name") || expected_name

    with :ok <- check_name(name, expected_name),
         {:ok, snapshot} <- parse_snapshot(Node.get_child(collection, "snapshot"), download),
         {:ok, patches} <- parse_patches(Node.get_child(collection, "patches"), download) do
      {:ok,
       %PatchList{
         name: name,
         has_more_patches?: truthy?(Node.attr(collection, "has_more_patches")),
         patches: patches,
         snapshot: snapshot
       }}
    end
  end

  defp check_name(name, name), do: :ok
  defp check_name(got, expected), do: {:error, {:unexpected_collection, got, expected}}

  defp parse_snapshot(nil, _download), do: {:ok, nil}

  defp parse_snapshot(%Node{content: raw}, download) when is_binary(raw) do
    with {:ok, %ExternalBlobReference{} = ref} <-
           decode_proto(ExternalBlobReference, raw, :snapshot),
         {:ok, blob} <- download_blob(download, ref),
         {:ok, %SyncdSnapshot{} = snapshot} <- decode_proto(SyncdSnapshot, blob, :snapshot) do
      {:ok, snapshot}
    end
  end

  # A <snapshot/> with no bytes: Go treats it as absent.
  defp parse_snapshot(%Node{}, _download), do: {:ok, nil}

  defp parse_patches(nil, _download), do: {:ok, []}

  defp parse_patches(%Node{} = patches_node, download) do
    patches_node
    |> Node.children()
    |> Enum.filter(&(&1.tag == "patch" and is_binary(&1.content)))
    |> Enum.with_index(1)
    |> Enum.reduce_while({:ok, []}, fn {%Node{content: raw}, n}, {:ok, acc} ->
      with {:ok, %SyncdPatch{} = patch} <- decode_proto(SyncdPatch, raw, {:patch, n}),
           {:ok, patch} <- inline_external(patch, download) do
        {:cont, {:ok, [patch | acc]}}
      else
        {:error, _} = err -> {:halt, err}
      end
    end)
    |> case do
      {:ok, list} -> {:ok, Enum.reverse(list)}
      err -> err
    end
  end

  defp inline_external(
         %SyncdPatch{externalMutations: %ExternalBlobReference{} = ref} = patch,
         download
       )
       when is_function(download, 1) do
    with {:ok, blob} <- download_blob(download, ref),
         {:ok, %SyncdMutations{mutations: [_ | _] = mutations}} <-
           decode_proto(SyncdMutations, blob, :external_mutations) do
      {:ok, %{patch | mutations: mutations}}
    else
      {:ok, %SyncdMutations{}} -> {:error, :no_mutations_in_download}
      {:error, _} = err -> err
    end
  end

  defp inline_external(patch, _download), do: {:ok, patch}

  defp download_blob(download, ref) when is_function(download, 1) do
    case download.(ref) do
      {:ok, blob} when is_binary(blob) -> {:ok, blob}
      {:error, reason} -> {:error, {:download_failed, reason}}
      other -> {:error, {:download_failed, other}}
    end
  end

  defp download_blob(_download, _ref), do: {:error, {:download_failed, :no_downloader}}

  defp decode_proto(mod, bin, what) do
    {:ok, mod.decode(bin)}
  rescue
    e -> {:error, {:invalid_protobuf, what, Exception.message(e)}}
  end

  # --- external blobs ----------------------------------------------------------

  # Go: `cli.Download` on an ExternalBlobReference — the "md-app-state" media type.
  defp default_download(session) do
    fn %ExternalBlobReference{} = ref ->
      with {:ok, conn} <- Refresh.refresh(session) do
        Download.fetch_and_decrypt(
          %{
            kind: :app_state,
            direct_path: ref.directPath,
            media_key: ref.mediaKey,
            file_sha256: ref.fileSHA256,
            file_enc_sha256: ref.fileEncSHA256
          },
          media_conn: conn,
          max_bytes: 256 * 1024 * 1024
        )
      end
    end
  end

  # --- small helpers -----------------------------------------------------------

  # Store results, normalised. One helper per shape so each returns exactly
  # `:ok | {:error, _}` or `{:ok, version, hash} | {:error, _}` — a store's `{:error, r}`
  # is the only thing that can fall out of a `with`.
  defp store_unit(:ok), do: :ok
  defp store_unit({:error, reason}), do: {:error, {:store, reason}}

  defp store_version({:ok, version, hash}), do: {:ok, version, hash}
  defp store_version({:error, reason}), do: {:error, {:store, reason}}

  defp truthy?(v) when v in [true, "true", "1", 1], do: true
  defp truthy?(_), do: false

  defp parse_int(nil), do: nil
  defp parse_int(i) when is_integer(i), do: i

  defp parse_int(s) when is_binary(s) do
    case Integer.parse(s) do
      {i, ""} -> i
      _ -> nil
    end
  end
end
