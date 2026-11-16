defmodule Whatsmeow.Test.AppStateFake do
  @moduledoc """
  A fake WhatsApp server for one app-state collection, plus the "phone" behind it.

  Faithful in the one way that matters: **the server never checks MACs** — it has
  no keys, exactly like the real one — so it accepts and forwards any patch whose
  version matches. The *phone* is a second, independent
  `Whatsmeow.AppState.Processor` with its own store that decodes every patch the
  server forwards with full MAC verification; any failure lands in
  `phone_errors/1`. A test that sends a patch and then asserts `phone_errors == []`
  has shown the patch is acceptable to a verifying peer, not merely that our
  encoder agrees with our decoder.

  The server:

    * answers fetches with a snapshot (always an external blob, as on the wire) or
      the patches after the client's version, optionally in `chunk`-sized pages
      with `has_more_patches`;
    * accepts a sent patch iff the IQ's `version` equals its own, stamping the next
      version on it; otherwise answers `<collection type="error"><error
      code="409"/>` carrying the patches the client lacks;
    * can be told to refuse (`reject_next/2`), to claim a conflict that is not there
      (`conflicts/2`), or to run a callback just before the next send is handled
      (`before_next_send/2`) — the way to make the phone change something in the
      middle of a send.

  The Agent is only a state box: all logic runs in the calling process, so a
  callback may call back into this module freely.
  """

  alias Whatsmeow.AppState.{Hash, Keys, Patch, PatchList, Processor}
  alias Whatsmeow.AppState.Store.Memory
  alias Whatsmeow.Binary.Node

  alias WAServerSync.{
    ExternalBlobReference,
    KeyId,
    SyncdMutations,
    SyncdPatch,
    SyncdSnapshot,
    SyncdVersion
  }

  @phone_jid "phone@s.whatsapp.net"
  @name "regular_low"

  def phone_jid, do: @phone_jid
  def name, do: @name

  @doc """
  Start a server whose phone holds `key_data` under `key_id`. Options: `:chunk`
  (max patches per fetch page), `:external_patches` (ship patch mutations as
  external blobs). The phone's key is put in the (global) memory store.
  """
  def start(key_id, key_data, opts \\ []) do
    {:ok, agent} =
      Agent.start_link(fn ->
        %{
          key_id: key_id,
          key_data: key_data,
          version: 0,
          patches: [],
          live: %{},
          blobs: %{},
          phone_state: %Hash{},
          phone_errors: [],
          iqs: [],
          conflicts: 0,
          reject: nil,
          conflict_snapshot: false,
          before_send: nil,
          chunk: opts[:chunk],
          external_patches: opts[:external_patches] || false,
          blob_seq: 0
        }
      end)

    :ok = Memory.put_key(@phone_jid, key_id, %{data: key_data, fingerprint: <<>>, timestamp: 1})
    agent
  end

  # --- phone actions ------------------------------------------------------------

  @doc "The phone makes a change: encoded and applied by the phone, then stored by the server."
  def phone_apply(agent, %Patch{} = patch) do
    st = get(agent)
    proc = Processor.new(@phone_jid, store: Memory)
    {:ok, enc} = Processor.encode_patch(proc, patch, st.phone_state)
    put(agent, accept(st, enc.bytes))
    :ok
  end

  @doc "Change `:chunk` / `:external_patches` on a running server."
  def configure(agent, opts) do
    update(agent, fn st ->
      %{
        st
        | chunk: Keyword.get(opts, :chunk, st.chunk),
          external_patches: Keyword.get(opts, :external_patches, st.external_patches)
      }
    end)
  end

  @doc "Run `fun.(agent)` just before the next sent patch is handled."
  def before_next_send(agent, fun), do: update(agent, &%{&1 | before_send: fun})

  @doc "The next `n` sends are answered with 409 whether or not the version matches."
  def conflicts(agent, n), do: update(agent, &%{&1 | conflicts: n})

  @doc "The next conflict response carries a full snapshot instead of patches."
  def conflict_with_snapshot(agent), do: update(agent, &%{&1 | conflict_snapshot: true})

  @doc "The next send is refused with `code`."
  def reject_next(agent, code), do: update(agent, &%{&1 | reject: code})

  def version(agent), do: get(agent).version
  def phone_errors(agent), do: agent |> get() |> Map.fetch!(:phone_errors) |> Enum.reverse()
  def phone_state(agent), do: get(agent).phone_state
  def patches(agent), do: agent |> get() |> Map.fetch!(:patches) |> Enum.reverse()
  def iqs(agent), do: agent |> get() |> Map.fetch!(:iqs) |> Enum.reverse()

  # --- the wire ------------------------------------------------------------------

  @doc """
  Injection options for `Whatsmeow.AppState.Sync.context/2` wired to this server.
  Key requests are reported to `:notify` (default: the calling process) as
  `{:key_request, ids}`.
  """
  def opts(agent, extra \\ []) do
    notify = Keyword.get(extra, :notify, self())

    Keyword.merge(
      [
        our_jid: "me@s.whatsapp.net",
        store: Memory,
        send_iq: send_iq(agent),
        download: download(agent),
        request_keys: fn ids -> send(notify, {:key_request, ids}) end,
        collections: [@name]
      ],
      Keyword.delete(extra, :notify)
    )
  end

  @doc "`send_iq` for `Whatsmeow.AppState.Sync.context/2`."
  def send_iq(agent), do: fn iq -> {:ok, handle_iq(agent, iq)} end

  @doc "`download` for `Whatsmeow.AppState.Sync.context/2`."
  def download(agent) do
    fn %ExternalBlobReference{directPath: handle} ->
      case Map.fetch(get(agent).blobs, handle) do
        {:ok, blob} -> {:ok, blob}
        :error -> {:error, :no_such_blob}
      end
    end
  end

  defp handle_iq(agent, iq) do
    [sync] = iq.content
    [collection] = sync.content
    update(agent, &%{&1 | iqs: [%{iq: iq, collection: collection} | &1.iqs]})

    case Node.get_child(collection, "patch") do
      nil -> fetch_response(agent, collection)
      %Node{content: bytes} -> send_response(agent, collection, bytes)
    end
  end

  defp fetch_response(agent, collection) do
    st = get(agent)

    {node, st} =
      if collection.attrs["return_snapshot"] == "true" do
        snapshot_collection(st)
      else
        patches_collection(st, String.to_integer(collection.attrs["version"]), nil)
      end

    put(agent, st)
    wrap(node)
  end

  defp send_response(agent, collection, bytes) do
    run_before_send(agent)
    st = get(agent)
    client_version = String.to_integer(collection.attrs["version"])

    cond do
      st.reject != nil ->
        put(agent, %{st | reject: nil})
        wrap(error_collection(st.reject))

      st.conflicts > 0 ->
        {node, st} = patches_collection(st, client_version, 409)
        put(agent, %{st | conflicts: st.conflicts - 1})
        wrap(node)

      client_version != st.version ->
        {node, st} = conflict_collection(st, client_version)
        put(agent, %{st | conflict_snapshot: false})
        wrap(node)

      true ->
        st = accept(st, bytes)
        put(agent, st)
        wrap(Node.new("collection", %{"name" => @name, "version" => "#{st.version}"}, nil))
    end
  end

  defp run_before_send(agent) do
    case get(agent).before_send do
      nil ->
        :ok

      fun ->
        update(agent, &%{&1 | before_send: nil})
        fun.(agent)
    end
  end

  # --- server internals ----------------------------------------------------------

  # Accept `bytes` (a SyncdPatch): stamp the next version, let the phone verify and
  # apply it, store it. The server itself verifies nothing.
  defp accept(st, bytes) do
    version = st.version + 1
    patch = bytes |> SyncdPatch.decode() |> then(&%{&1 | version: %SyncdVersion{version: version}})

    phone = Processor.new(@phone_jid, store: Memory)
    list = %PatchList{name: @name, patches: [patch]}

    st =
      case Processor.decode_patches(phone, list, st.phone_state, true) do
        {:ok, _muts, new_state} ->
          %{st | phone_state: new_state, live: apply_live(st.live, patch)}

        {:error, reason} ->
          %{st | phone_errors: [{version, reason} | st.phone_errors]}
      end

    %{st | version: version, patches: [{version, patch} | st.patches]}
  end

  defp apply_live(live, %SyncdPatch{mutations: mutations}) do
    Enum.reduce(mutations, live, fn m, acc ->
      index_mac = m.record.index.blob

      case m.operation do
        :REMOVE -> Map.delete(acc, index_mac)
        _ -> Map.put(acc, index_mac, m.record)
      end
    end)
  end

  defp snapshot_collection(st) do
    keys = Keys.expand(st.key_data)

    snapshot = %SyncdSnapshot{
      version: %SyncdVersion{version: st.version},
      records: Map.values(st.live),
      mac: Hash.snapshot_mac(%{st.phone_state | version: st.version}, @name, keys.snapshot_mac),
      keyID: %KeyId{ID: st.key_id}
    }

    handle = "snapshot-#{st.blob_seq}"
    st = put_blob(st, handle, SyncdSnapshot.encode(snapshot))
    ref = %ExternalBlobReference{directPath: handle}

    {Node.new("collection", %{"name" => @name, "version" => "#{st.version}"}, [
       Node.new("snapshot", %{}, bin(ExternalBlobReference.encode(ref)))
     ]), st}
  end

  # A `<collection>` of the patches after `from`, honouring `chunk`; with an
  # `error_code`, the same payload inside `type="error"` (a conflict response).
  defp patches_collection(st, from, error_code) do
    pending = st.patches |> Enum.reverse() |> Enum.filter(fn {v, _} -> v > from end)

    {page, more?} =
      case st.chunk do
        nil -> {pending, false}
        n -> {Enum.take(pending, n), length(pending) > n}
      end

    {nodes, st} =
      Enum.map_reduce(page, st, fn {_v, patch}, st ->
        if st.external_patches do
          handle = "patch-#{st.blob_seq}"

          st =
            put_blob(
              %{st | blob_seq: st.blob_seq + 1},
              handle,
              SyncdMutations.encode(%SyncdMutations{mutations: patch.mutations})
            )

          slim = %{
            patch
            | mutations: [],
              externalMutations: %ExternalBlobReference{directPath: handle}
          }

          {Node.new("patch", %{}, bin(SyncdPatch.encode(slim))), st}
        else
          {Node.new("patch", %{}, bin(SyncdPatch.encode(patch))), st}
        end
      end)

    attrs = %{"name" => @name, "has_more_patches" => to_string(more?)}
    patches = Node.new("patches", %{}, nodes)

    case error_code do
      nil ->
        {Node.new("collection", attrs, [patches]), st}

      code ->
        error = Node.new("error", %{"code" => "#{code}", "text" => "conflict"}, nil)
        {Node.new("collection", Map.put(attrs, "type", "error"), [error, patches]), st}
    end
  end

  # A 409 body: normally the patches the client lacks; with `conflict_snapshot`, the
  # whole collection as a snapshot (what the server sends when it is too far ahead).
  defp conflict_collection(%{conflict_snapshot: true} = st, _client_version) do
    {snap, st} = snapshot_collection(st)
    error = Node.new("error", %{"code" => "409", "text" => "conflict"}, nil)
    {%{snap | attrs: Map.put(snap.attrs, "type", "error"), content: [error | snap.content]}, st}
  end

  defp conflict_collection(st, client_version), do: patches_collection(st, client_version, 409)

  defp error_collection(code) do
    Node.new("collection", %{"name" => @name, "type" => "error"}, [
      Node.new("error", %{"code" => "#{code}", "text" => "refused"}, nil)
    ])
  end

  defp wrap(collection),
    do: Node.new("iq", %{"type" => "result"}, [Node.new("sync", %{}, [collection])])

  defp put_blob(st, handle, iodata),
    do: %{st | blobs: Map.put(st.blobs, handle, bin(iodata)), blob_seq: st.blob_seq + 1}

  defp bin(iodata), do: IO.iodata_to_binary(iodata)

  defp get(agent), do: Agent.get(agent, & &1)
  defp put(agent, st), do: Agent.update(agent, fn _ -> st end)
  defp update(agent, fun), do: Agent.update(agent, fun)
end
