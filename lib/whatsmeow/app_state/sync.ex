defmodule Whatsmeow.AppState.Sync do
  @moduledoc """
  Live `<iq xmlns="w:sync:app:state">` orchestration: fetch app-state patches
  from the server, parse them into a `%PatchList{}`.

  The patch list is what feeds `Whatsmeow.AppState.Decode` / `.Hash` /
  `.LTHash` to advance per-collection state. The crypto + MAC verification
  is already locked; this module just wires the IQ + parser.

  ## Scope

  This module ships:

  * `build_fetch_patches_iq/3` — the `<iq>` builder
  * `parse_patch_list/1` — the response parser (`<sync><collection>` →
    `%PatchList{}`)
  * `fetch_patches/4` — live IQ round-trip via `Session.send_iq`

  It does **not yet** ship the full `FetchAppState` loop (Go's
  `cli.fetchAppState`): the apply-mutations step requires the
  per-collection key store (`appstate.GetAppStateSyncKey`) plus the
  event dispatch wiring that we'll land in a follow-up — but everything
  here is the live-server-side prerequisite for that loop.

  ## Patch names

  WhatsApp maintains 5 named collections, each with its own hash state:

  * `"critical_block"` — block / unblock
  * `"critical_unblock_low"` — companion to critical_block
  * `"regular_low"` — push names, contact metadata
  * `"regular_high"` — pinned chats, chat settings
  * `"regular"` — everything else

  Mirrors Go's `whatsmeow-main/appstate.go` (`fetchAppStatePatches`,
  `ParsePatchList`).
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Session

  @server_jid "s.whatsapp.net"
  @default_timeout 30_000

  @critical_block "critical_block"
  @critical_unblock_low "critical_unblock_low"
  @regular_low "regular_low"
  @regular_high "regular_high"
  @regular "regular"

  @patch_names [
    @critical_block,
    @critical_unblock_low,
    @regular_low,
    @regular_high,
    @regular
  ]

  defmodule PatchList do
    @moduledoc """
    Parsed `<sync><collection>` payload.

    Mirrors Go's `appstate.PatchList`.

    * `:name`             — collection name
    * `:has_more_patches?` — true if the server is holding more for this collection
    * `:patches`           — list of `%WAServerSync.SyncdPatch{}` (decoded protos)
    * `:snapshot`          — `%WAServerSync.ExternalBlobReference{}` (CDN ptr) or
                             `%WAServerSync.SyncdSnapshot{}` if the server inlined one
    """
    defstruct [:name, :has_more_patches?, :patches, :snapshot]

    @type t :: %__MODULE__{
            name: String.t(),
            has_more_patches?: boolean(),
            patches: [struct()],
            snapshot: struct() | nil
          }
  end

  @doc "All supported patch names, in iteration order."
  @spec patch_names() :: [String.t()]
  def patch_names, do: @patch_names

  @doc """
  Build a `<iq xmlns="w:sync:app:state" type="set">` requesting patches for
  the named collection.

  * `name`            — one of `patch_names/0`
  * `from_version`    — the local version (server returns deltas after it).
                        Required when `return_snapshot?` is `false`.
  * `return_snapshot?` — `true` for the initial full sync. `false` for incremental.

  Mirrors Go's `cli.fetchAppStatePatches` IQ shape (`appstate.go:431`).
  """
  @spec build_fetch_patches_iq(String.t(), non_neg_integer(), boolean(), keyword()) :: Node.t()
  def build_fetch_patches_iq(name, from_version, return_snapshot?, opts \\ [])
      when is_binary(name) and is_integer(from_version) and from_version >= 0 and
             is_boolean(return_snapshot?) do
    id = Keyword.get(opts, :id) || IQ.generate_id()

    base_attrs = %{
      "name" => name,
      "return_snapshot" => to_string(return_snapshot?)
    }

    attrs =
      if return_snapshot?,
        do: base_attrs,
        else: Map.put(base_attrs, "version", Integer.to_string(from_version))

    Node.new(
      "iq",
      %{
        "id" => id,
        "to" => @server_jid,
        "type" => "set",
        "xmlns" => "w:sync:app:state"
      },
      [
        Node.new("sync", %{}, [
          Node.new("collection", attrs, nil)
        ])
      ]
    )
  end

  @doc """
  Fetch a patch list from the live server, blocking until the matching
  `<iq type="result">` arrives.

  Returns `{:ok, %PatchList{}}` on success. Any external-blob expansion
  (when patches reference CDN-hosted mutation blobs) is **not yet
  performed** — the returned `%PatchList{}` will have those references in
  the patches' `external_mutations` field for the caller / a follow-up
  loop to download.
  """
  @spec fetch_patches(
          pid() | String.t(),
          String.t(),
          non_neg_integer(),
          keyword()
        ) :: {:ok, PatchList.t()} | {:error, term()}
  def fetch_patches(session, name, from_version, opts \\ [])
      when is_binary(name) and is_integer(from_version) do
    return_snapshot? = Keyword.get(opts, :return_snapshot?, from_version == 0)
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    iq = build_fetch_patches_iq(name, from_version, return_snapshot?, opts)

    with {:ok, response} <- Session.send_iq(session, iq, timeout) do
      parse_patch_list(response)
    end
  end

  @doc """
  Parse a `<iq type="result">` response into a `%PatchList{}`.

  Returns `{:ok, %PatchList{}}` on success or `{:error, reason}` if the
  expected `<sync><collection>` shape isn't present / protos fail to decode.
  """
  @spec parse_patch_list(Node.t()) :: {:ok, PatchList.t()} | {:error, term()}
  def parse_patch_list(%Node{} = response) do
    with {:ok, collection} <- extract_collection(response) do
      patches =
        collection
        |> Node.get_child("patches")
        |> patches_from_node()

      snapshot = snapshot_from_node(Node.get_child(collection, "snapshot"))

      case patches do
        {:error, _} = err ->
          err

        list ->
          {:ok,
           %PatchList{
             name: Node.attr(collection, "name") || "",
             has_more_patches?: truthy?(Node.attr(collection, "has_more_patches")),
             patches: list,
             snapshot: snapshot
           }}
      end
    end
  end

  # --- Internals -------------------------------------------------------------

  defp extract_collection(response) do
    case Node.get_child(response, "sync") do
      %Node{} = sync ->
        case Node.get_child(sync, "collection") do
          %Node{} = c -> {:ok, c}
          _ -> {:error, :missing_collection}
        end

      _ ->
        {:error, :missing_sync}
    end
  end

  defp patches_from_node(nil), do: []

  defp patches_from_node(%Node{} = patches_node) do
    patches_node
    |> Node.get_children("patch")
    |> Enum.reduce_while([], fn %Node{content: bin}, acc when is_binary(bin) ->
      case safe_decode(WAServerSync.SyncdPatch, bin) do
        {:ok, p} -> {:cont, [p | acc]}
        {:error, _} = err -> {:halt, err}
      end
    end)
    |> case do
      list when is_list(list) -> Enum.reverse(list)
      {:error, _} = err -> err
    end
  end

  defp snapshot_from_node(nil), do: nil

  defp snapshot_from_node(%Node{content: bin}) when is_binary(bin) do
    case safe_decode(WAServerSync.ExternalBlobReference, bin) do
      {:ok, ref} -> ref
      _ -> nil
    end
  end

  defp snapshot_from_node(%Node{}), do: nil

  defp safe_decode(mod, bin) do
    {:ok, mod.decode(bin)}
  rescue
    e -> {:error, {:proto_decode, Exception.message(e)}}
  end

  defp truthy?(true), do: true
  defp truthy?("true"), do: true
  defp truthy?("1"), do: true
  defp truthy?(1), do: true
  defp truthy?(_), do: false
end
