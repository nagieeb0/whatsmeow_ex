defmodule Whatsmeow.Notification do
  @moduledoc """
  Decode `<notification>` payloads into typed events.

  The Session dispatch loop receives `<notification>` stanzas after auth
  and acks each one. The notification's `type` attribute selects what to
  do next:

  * `"encrypt"` — server tells us our pre-key count is low (`<count value=N>`)
    or a peer's identity changed (`<identity/>` child).
  * `"server_sync"` — one or more collection versions have advanced; we
    should run `Whatsmeow.AppState.Sync.fetch_patches/4` for each.
  * `"picture"` — a contact's profile picture changed.
  * `"devices"` — a contact's device list changed (invalidates the cache).
  * `"account_sync"` — our own settings changed remotely.
  * `"privacy_token"` — a peer issued or rotated their privacy token.

  This module ships **pure decoders** — it returns typed events; the
  Session is responsible for calling `FetchAppState`, `UploadPreKeys`, etc.
  in response.

  Mirrors `whatsmeow-main/notification.go`.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Types.JID

  defmodule PreKeyCount do
    @moduledoc "Server's view of how many of our prekeys it has cached."
    defstruct [:value]
    @type t :: %__MODULE__{value: non_neg_integer()}
  end

  defmodule IdentityChange do
    @moduledoc "A peer's Signal identity key changed — wipe local sessions."
    defstruct [:jid, :timestamp]

    @type t :: %__MODULE__{
            jid: Whatsmeow.Types.JID.t() | nil,
            timestamp: integer() | nil
          }
  end

  defmodule ServerSync do
    @moduledoc """
    AppState collection version bumps. Each `:collections` entry is a
    `{name, version}` tuple.
    """
    defstruct [:collections, :timestamp]

    @type t :: %__MODULE__{
            collections: [{String.t(), non_neg_integer()}],
            timestamp: integer() | nil
          }
  end

  defmodule Picture do
    @moduledoc "Profile-picture change (set, add, or delete)."
    defstruct [:action, :jid, :author, :picture_id, :timestamp]

    @type t :: %__MODULE__{
            action: :set | :add | :delete,
            jid: Whatsmeow.Types.JID.t() | nil,
            author: Whatsmeow.Types.JID.t() | nil,
            picture_id: String.t() | nil,
            timestamp: integer() | nil
          }
  end

  defmodule DevicesChanged do
    @moduledoc "A user's device list changed — invalidate cache."
    defstruct [:from, :timestamp]

    @type t :: %__MODULE__{
            from: Whatsmeow.Types.JID.t() | nil,
            timestamp: integer() | nil
          }
  end

  defmodule AccountSync do
    @moduledoc "Our own account settings synced from another device."
    defstruct [:children, :timestamp]
    @type t :: %__MODULE__{children: [String.t()], timestamp: integer() | nil}
  end

  defmodule PrivacyToken do
    @moduledoc "A peer issued or rotated their privacy token."
    defstruct [:from, :token, :timestamp]

    @type t :: %__MODULE__{
            from: Whatsmeow.Types.JID.t() | nil,
            token: binary() | nil,
            timestamp: integer() | nil
          }
  end

  defmodule Unknown do
    @moduledoc "A notification type this module doesn't decode yet."
    defstruct [:type, :raw]
    @type t :: %__MODULE__{type: String.t() | nil, raw: Whatsmeow.Binary.Node.t()}
  end

  @doc """
  Decode a `<notification>` node into a typed event.

  Returns a list of zero, one, or many events depending on the children.
  (E.g. an `encrypt` notification can emit `%PreKeyCount{}` OR
  `%IdentityChange{}` — the type attr alone isn't sufficient.)
  """
  @spec from_node(Node.t()) :: [
          PreKeyCount.t()
          | IdentityChange.t()
          | ServerSync.t()
          | Picture.t()
          | DevicesChanged.t()
          | AccountSync.t()
          | PrivacyToken.t()
          | Unknown.t()
        ]
  def from_node(%Node{tag: "notification"} = node) do
    type = Node.attr(node, "type")
    ts = coerce_int(Node.attr(node, "t"))

    case type do
      "encrypt" -> decode_encrypt(node, ts)
      "server_sync" -> [decode_server_sync(node, ts)]
      "picture" -> decode_picture(node, ts)
      "devices" -> decode_devices_changed(node, ts)
      "account_sync" -> [decode_account_sync(node, ts)]
      "privacy_token" -> [decode_privacy_token(node, ts)]
      other -> [%Unknown{type: other, raw: node}]
    end
  end

  def from_node(_), do: []

  # --- Type decoders ---------------------------------------------------------

  defp decode_encrypt(%Node{} = node, _ts) do
    cond do
      count = Node.get_child(node, "count") ->
        [%PreKeyCount{value: coerce_int(Node.attr(count, "value")) || 0}]

      Node.get_child(node, "identity") != nil ->
        [
          %IdentityChange{
            jid: parse_jid_attr(Node.attr(node, "from")),
            timestamp: coerce_int(Node.attr(node, "t"))
          }
        ]

      true ->
        [%Unknown{type: "encrypt", raw: node}]
    end
  end

  defp decode_server_sync(%Node{} = node, ts) do
    collections =
      node
      |> Node.get_children("collection")
      |> Enum.map(fn c ->
        {Node.attr(c, "name") || "", coerce_int(Node.attr(c, "version")) || 0}
      end)

    %ServerSync{collections: collections, timestamp: ts}
  end

  defp decode_picture(%Node{} = node, ts) do
    node
    |> Node.children()
    |> Enum.flat_map(fn child ->
      action =
        case child.tag do
          "set" -> :set
          "add" -> :add
          "delete" -> :delete
          _ -> nil
        end

      if action do
        [
          %Picture{
            action: action,
            jid: parse_jid_attr(Node.attr(child, "jid")),
            author: parse_jid_attr(Node.attr(child, "author")),
            picture_id:
              case Node.attr(child, "id") do
                s when is_binary(s) -> s
                _ -> nil
              end,
            timestamp: ts
          }
        ]
      else
        []
      end
    end)
  end

  defp decode_devices_changed(%Node{} = node, ts) do
    [
      %DevicesChanged{
        from: parse_jid_attr(Node.attr(node, "from")),
        timestamp: ts
      }
    ]
  end

  defp decode_account_sync(%Node{} = node, ts) do
    %AccountSync{
      children: node |> Node.children() |> Enum.map(& &1.tag),
      timestamp: ts
    }
  end

  defp decode_privacy_token(%Node{} = node, ts) do
    token =
      case Node.get_child(node, "tokens") do
        %Node{} = tokens ->
          case Node.get_child(tokens, "token") do
            %Node{content: bin} when is_binary(bin) -> bin
            _ -> nil
          end

        _ ->
          nil
      end

    %PrivacyToken{
      from: parse_jid_attr(Node.attr(node, "from")),
      token: token,
      timestamp: ts
    }
  end

  # --- Helpers ---------------------------------------------------------------

  defp parse_jid_attr(nil), do: nil
  defp parse_jid_attr(%JID{} = j), do: j

  defp parse_jid_attr(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, j} -> j
      _ -> nil
    end
  end

  defp parse_jid_attr(_), do: nil

  defp coerce_int(nil), do: nil
  defp coerce_int(n) when is_integer(n), do: n

  defp coerce_int(bin) when is_binary(bin) do
    case Integer.parse(bin) do
      {n, ""} -> n
      _ -> nil
    end
  end
end
