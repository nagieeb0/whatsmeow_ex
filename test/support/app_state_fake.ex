defmodule Whatsmeow.AppStateFake do
  @moduledoc """
  A WhatsApp server's app-state endpoint, and the owner's phone writing to it,
  for driving `Whatsmeow.AppState` without a socket.

  The server keeps, per collection, the patches it has accepted and its own
  view of the LTHash and value MACs. A patch the client sends is checked the
  way another device would check it — LTHash advanced from the *server's*
  state, snapshot MAC, patch MAC, content and index MACs — before it is
  accepted, so a test that sees `:ok` knows the patch is one other devices
  would verify. A patch sent on a stale version gets a 409 carrying the
  patches the client is missing, as the real server does.

  Everything here is made up: random keys, placeholder JIDs.
  """

  alias Whatsmeow.AppState.{Decode, Encode, Hash, Keys, Patch}
  alias Whatsmeow.Binary.Node

  defstruct key_id: nil,
            key_data: nil,
            collections: %{},
            blobs: %{},
            iqs: [],
            sends: [],
            page_size: nil,
            race_on_send: nil

  @doc "Start a fake with a fresh random key."
  def start(opts \\ []) do
    key_data = Keyword.get_lazy(opts, :key_data, fn -> :crypto.strong_rand_bytes(32) end)
    key_id = Keyword.get_lazy(opts, :key_id, fn -> :crypto.strong_rand_bytes(6) end)

    {:ok, pid} =
      Agent.start_link(fn ->
        %__MODULE__{key_id: key_id, key_data: key_data, page_size: opts[:page_size]}
      end)

    pid
  end

  def get(fake), do: Agent.get(fake, & &1)
  def key_id(fake), do: get(fake).key_id

  @doc "The `AppStateSyncKeyShare` our phone would send for the fake's key."
  def key_share(fake, timestamp \\ 1) do
    %{key_id: id, key_data: data} = get(fake)

    %WAWebProtobufsE2E.AppStateSyncKeyShare{
      keys: [
        %WAWebProtobufsE2E.AppStateSyncKey{
          keyID: %WAWebProtobufsE2E.AppStateSyncKeyId{keyID: id},
          keyData: %WAWebProtobufsE2E.AppStateSyncKeyData{
            keyData: data,
            timestamp: timestamp,
            fingerprint: %WAWebProtobufsE2E.AppStateSyncKeyFingerprint{rawID: 7, currentIndex: 1}
          }
        }
      ]
    }
  end

  @doc "A `Whatsmeow.AppState.Context` wired to this fake."
  def context(fake, jid, store, test_pid \\ self()) do
    %Whatsmeow.AppState.Context{
      jid: jid,
      store: store,
      iq: fn node -> {:ok, Agent.get_and_update(fake, &respond(&1, node))} end,
      download: fn %WAServerSync.ExternalBlobReference{handle: h} ->
        case get(fake).blobs do
          %{^h => bin} -> {:ok, bin}
          _ -> {:error, :no_blob}
        end
      end,
      request_keys: fn ids -> send(test_pid, {:key_request, ids}) end
    }
  end

  @doc """
  The phone writes a patch. `specs`: `{:set, index, %SyncActionValue{}, version}`
  or `{:remove, index, version}`. `external?: true` serves the mutations as an
  external blob.
  """
  def phone_write(fake, name, specs, opts \\ []) do
    Agent.update(fake, &do_phone_write(&1, name, specs, opts))
  end

  @doc "From now on, a snapshot request gets the collection as it is now."
  def take_snapshot(fake, name) do
    Agent.update(fake, fn s ->
      c = coll(s, name)
      update_coll(s, name, %{c | snapshot: {c.state, Map.values(c.records)}})
    end)
  end

  @doc "Flip a byte in the MAC `field` of the newest patch the server holds."
  def tamper_last_patch(fake, name, field) do
    Agent.update(fake, fn s ->
      c = coll(s, name)
      [last | rest] = Enum.reverse(c.patches)
      <<b, tail::binary>> = Map.fetch!(last, field)
      last = Map.put(last, field, <<Bitwise.bxor(b, 1), tail::binary>>)
      update_coll(s, name, %{c | patches: Enum.reverse([last | rest])})
    end)
  end

  @doc "Before handling the next send, let the phone write `specs` (forces a 409)."
  def race_next_send(fake, name, specs) do
    Agent.update(fake, &%{&1 | race_on_send: {name, specs}})
  end

  @doc "The server's head for `name`: `%Hash{}`."
  def head(fake, name), do: coll(get(fake), name).state

  # --- Collections ------------------------------------------------------------

  defp coll(s, name) do
    Map.get(s.collections, name, %{
      state: Hash.new(),
      macs: %{},
      records: %{},
      patches: [],
      snapshot: nil
    })
  end

  defp update_coll(s, name, c), do: %{s | collections: Map.put(s.collections, name, c)}

  defp keys(s), do: Keys.expand(s.key_data)

  defp do_phone_write(s, name, specs, opts) do
    keys = keys(s)

    encoded =
      Enum.map(specs, fn
        {:set, index, value, version} ->
          json = Patch.index_json(index)

          content =
            %WAWebProtobufSyncAction.SyncActionData{
              index: json,
              value: %{value | timestamp: 1_700_000_000_000},
              padding: <<>>,
              version: version
            }
            |> WAWebProtobufSyncAction.SyncActionData.encode()
            |> IO.iodata_to_binary()

          Encode.encode_mutation(
            %{index_json: json, content: content, operation: :set},
            keys,
            s.key_id
          )

        {:remove, index, version} ->
          json = Patch.index_json(index)

          content =
            %WAWebProtobufSyncAction.SyncActionData{index: json, padding: <<>>, version: version}
            |> WAWebProtobufSyncAction.SyncActionData.encode()
            |> IO.iodata_to_binary()

          Encode.encode_mutation(
            %{index_json: json, content: content, operation: :remove},
            keys,
            s.key_id
          )
      end)

    mutations =
      Enum.map(encoded, fn m ->
        %WAServerSync.SyncdMutation{
          operation: if(m.operation == :set, do: :SET, else: :REMOVE),
          record: %WAServerSync.SyncdRecord{
            index: %WAServerSync.SyncdIndex{blob: m.index_mac},
            value: %WAServerSync.SyncdValue{blob: m.value_blob},
            keyID: %WAServerSync.KeyId{ID: s.key_id}
          }
        }
      end)

    c = coll(s, name)
    {:ok, state} = advance(c, mutations)
    smac = Hash.snapshot_mac(state, name, keys.snapshot_mac)

    pmac =
      Hash.patch_mac(smac, Enum.map(encoded, & &1.value_mac), state.version, name, keys.patch_mac)

    patch = %WAServerSync.SyncdPatch{
      version: %WAServerSync.SyncdVersion{version: state.version},
      mutations: mutations,
      snapshotMAC: smac,
      patchMAC: pmac,
      keyID: %WAServerSync.KeyId{ID: s.key_id}
    }

    {s, patch} =
      if Keyword.get(opts, :external?, false) do
        handle = "ext-#{System.unique_integer([:positive])}"

        blob =
          %WAServerSync.SyncdMutations{mutations: mutations}
          |> WAServerSync.SyncdMutations.encode()
          |> IO.iodata_to_binary()

        {%{s | blobs: Map.put(s.blobs, handle, blob)},
         %{patch | mutations: [], externalMutations: ext_ref(handle)}}
      else
        {s, patch}
      end

    update_coll(s, name, commit(c, state, mutations, patch))
  end

  # LTHash advanced the way a receiving device does: the previous value of an
  # index is the latest earlier SET in this patch, else what the server holds.
  defp advance(c, mutations) do
    inputs =
      Enum.map(mutations, fn m ->
        blob = m.record.value.blob

        %{
          operation: if(m.operation == :REMOVE, do: :remove, else: :set),
          value_mac: binary_part(blob, byte_size(blob) - 32, 32),
          index_mac: m.record.index.blob
        }
      end)

    tuple = List.to_tuple(inputs)

    {:ok, h, _} =
      Hash.update(c.state, inputs, fn imac, i ->
        earlier =
          (i - 1)..0//-1
          |> Enum.map(&elem(tuple, &1))
          |> Enum.find(&(&1.index_mac == imac))

        case earlier do
          %{operation: :set, value_mac: v} -> v
          %{operation: :remove} -> nil
          nil -> Map.get(c.macs, imac)
        end
      end)

    {:ok, %Hash{h | version: c.state.version + 1}}
  end

  defp commit(c, state, mutations, patch) do
    {macs, records} =
      Enum.reduce(mutations, {c.macs, c.records}, fn m, {macs, recs} ->
        imac = m.record.index.blob
        blob = m.record.value.blob

        if m.operation == :REMOVE do
          {Map.delete(macs, imac), Map.delete(recs, imac)}
        else
          {Map.put(macs, imac, binary_part(blob, byte_size(blob) - 32, 32)),
           Map.put(recs, imac, m.record)}
        end
      end)

    %{c | state: state, macs: macs, records: records, patches: c.patches ++ [patch]}
  end

  defp ext_ref(handle) do
    %WAServerSync.ExternalBlobReference{
      handle: handle,
      directPath: "/v/fake/" <> handle,
      mediaKey: :crypto.strong_rand_bytes(32)
    }
  end

  # --- IQ responder -----------------------------------------------------------

  defp respond(s, %Node{} = iq) do
    s = %{s | iqs: s.iqs ++ [iq]}
    [sync] = iq.content
    [collection] = sync.content
    name = collection.attrs["name"]

    case collection.content do
      [%Node{tag: "patch", content: bytes}] -> handle_send(s, name, collection, bytes, iq)
      _ -> handle_fetch(s, name, collection, iq)
    end
  end

  defp handle_fetch(s, name, collection, iq) do
    c = coll(s, name)

    {snapshot_node, from, s} =
      case {collection.attrs["return_snapshot"], c.snapshot} do
        {"true", {%Hash{} = st, records}} ->
          handle = "snap-#{System.unique_integer([:positive])}"

          bytes =
            %WAServerSync.SyncdSnapshot{
              version: %WAServerSync.SyncdVersion{version: st.version},
              records: records,
              mac: Hash.snapshot_mac(st, name, keys(s).snapshot_mac),
              keyID: %WAServerSync.KeyId{ID: s.key_id}
            }
            |> WAServerSync.SyncdSnapshot.encode()
            |> IO.iodata_to_binary()

          ref =
            ext_ref(handle) |> WAServerSync.ExternalBlobReference.encode() |> IO.iodata_to_binary()

          {[Node.new("snapshot", %{}, ref)], st.version,
           %{s | blobs: Map.put(s.blobs, handle, bytes)}}

        {"true", nil} ->
          {[], 0, s}

        {_, _} ->
          {[], String.to_integer(collection.attrs["version"]), s}
      end

    pending = Enum.filter(c.patches, &(&1.version.version > from))

    {served, more?} =
      case s.page_size do
        n when is_integer(n) and length(pending) > n -> {Enum.take(pending, n), true}
        _ -> {pending, false}
      end

    attrs = %{"name" => name, "version" => Integer.to_string(c.state.version)}
    attrs = if more?, do: Map.put(attrs, "has_more_patches", "true"), else: attrs

    {result(iq, Node.new("collection", attrs, snapshot_node ++ [patches_node(served)])), s}
  end

  defp handle_send(s, name, collection, bytes, iq) do
    s =
      case s.race_on_send do
        {^name, specs} -> do_phone_write(%{s | race_on_send: nil}, name, specs, [])
        _ -> s
      end

    c = coll(s, name)
    sent_version = String.to_integer(collection.attrs["version"])
    patch = WAServerSync.SyncdPatch.decode(bytes)

    cond do
      sent_version != c.state.version ->
        missing = Enum.filter(c.patches, &(&1.version.version > sent_version))
        s = %{s | sends: s.sends ++ [{:conflict, patch}]}
        # An integer attribute, as the binary decoder can produce.
        {result(iq, error_collection(name, 409, "conflict", [patches_node(missing)])), s}

      (reason = verify_as_other_device(s, c, name, patch)) != :ok ->
        s = %{s | sends: s.sends ++ [{:rejected, reason, patch}]}
        {result(iq, error_collection(name, "400", inspect(reason), [])), s}

      true ->
        {:ok, state} = advance(c, patch.mutations)
        stamped = %{patch | version: %WAServerSync.SyncdVersion{version: state.version}}
        s = update_coll(s, name, commit(c, state, patch.mutations, stamped))
        s = %{s | sends: s.sends ++ [{:accepted, stamped}]}

        {result(
           iq,
           Node.new(
             "collection",
             %{"name" => name, "version" => Integer.to_string(state.version)},
             nil
           )
         ), s}
    end
  end

  defp verify_as_other_device(s, c, name, patch) do
    keys = keys(s)
    {:ok, state} = advance(c, patch.mutations)

    value_macs =
      Enum.map(
        patch.mutations,
        &binary_part(&1.record.value.blob, byte_size(&1.record.value.blob) - 32, 32)
      )

    with true <- patch.keyID."ID" == s.key_id || :unknown_key,
         :ok <- Decode.verify_snapshot_mac(state, name, keys.snapshot_mac, patch.snapshotMAC),
         :ok <-
           Decode.verify_patch_mac(
             patch.snapshotMAC,
             value_macs,
             state.version,
             name,
             keys.patch_mac,
             patch.patchMAC
           ) do
      Enum.find_value(patch.mutations, :ok, &mutation_error(&1, keys))
    end
  end

  defp mutation_error(m, keys) do
    case verify_mutation(m, keys) do
      :ok -> nil
      err -> err
    end
  end

  defp verify_mutation(m, keys) do
    enc = %{
      operation: if(m.operation == :REMOVE, do: :remove, else: :set),
      value_blob: m.record.value.blob,
      index_mac: m.record.index.blob,
      key_id: m.record.keyID."ID"
    }

    with {:ok, %{plaintext: plain}} <- Decode.decode_mutation(enc, keys, true) do
      data = WAWebProtobufSyncAction.SyncActionData.decode(plain)
      Decode.verify_index_mac(data.index, m.record.index.blob, keys)
    end
  end

  defp patches_node(patches) do
    Node.new(
      "patches",
      %{},
      Enum.map(patches, fn p ->
        Node.new("patch", %{}, p |> WAServerSync.SyncdPatch.encode() |> IO.iodata_to_binary())
      end)
    )
  end

  defp error_collection(name, code, text, children) do
    Node.new(
      "collection",
      %{"name" => name, "type" => "error"},
      [Node.new("error", %{"code" => code, "text" => text}, nil) | children]
    )
  end

  defp result(iq, collection) do
    Node.new("iq", %{"id" => iq.attrs["id"], "type" => "result", "from" => "s.whatsapp.net"}, [
      Node.new("sync", %{}, [collection])
    ])
  end
end
