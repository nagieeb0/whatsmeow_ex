defmodule Whatsmeow.Privacy do
  @moduledoc """
  Privacy-settings + blocklist IQs.

  Two namespaces:

  * `xmlns="privacy"` — per-setting toggles (last seen, profile, read
    receipts, status, online indicator, etc.) and the
    `<disappearing_mode>` default-timer toggle.
  * `xmlns="blocklist"` — blocked-contacts list management.

  Mirrors `whatsmeow-main/privacysettings.go` + the blocklist helpers in
  `user.go` (`parseBlocklist`, `GetBlocklist`, `UpdateBlocklist`).
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Session
  alias Whatsmeow.Types.JID

  @server_jid "s.whatsapp.net"
  @default_timeout 30_000

  @typedoc "Names of the per-setting privacy toggles WhatsApp exposes."
  @type setting_name ::
          :group_add
          | :last_seen
          | :status
          | :profile
          | :read_receipts
          | :online
          | :call_add
          | :messages
          | :defense
          | :stickers

  @typedoc "Visibility values a privacy setting can take."
  @type setting_value ::
          :all
          | :contacts
          | :contact_blacklist
          | :match_last_seen
          | :known
          | :nobody

  defmodule Settings do
    @moduledoc "User-wide privacy settings (parsed from the `<privacy>` IQ result)."
    defstruct group_add: nil,
              last_seen: nil,
              status: nil,
              profile: nil,
              read_receipts: nil,
              online: nil,
              call_add: nil,
              messages: nil,
              defense: nil,
              stickers: nil

    @type t :: %__MODULE__{
            group_add: atom() | nil,
            last_seen: atom() | nil,
            status: atom() | nil,
            profile: atom() | nil,
            read_receipts: atom() | nil,
            online: atom() | nil,
            call_add: atom() | nil,
            messages: atom() | nil,
            defense: atom() | nil,
            stickers: atom() | nil
          }
  end

  defmodule Blocklist do
    @moduledoc "List of blocked contacts (parsed from `<blocklist><list>`)."
    defstruct dhash: nil, jids: []

    @type t :: %__MODULE__{
            dhash: String.t() | nil,
            jids: [Whatsmeow.Types.JID.t()]
          }
  end

  # --- Privacy settings ------------------------------------------------------

  @doc """
  Fetch all privacy settings via `<iq xmlns="privacy" type="get">`.

  Returns `{:ok, %Settings{}}` or `{:error, reason}`.

  Mirrors Go's `TryFetchPrivacySettings` (`privacysettings.go:20`).
  """
  @spec get_settings(pid() | String.t(), keyword()) ::
          {:ok, Settings.t()} | {:error, term()}
  def get_settings(session, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    iq = build_get_settings_iq(opts)

    with {:ok, resp} <- Session.send_iq(session, iq, timeout) do
      case Node.get_child(resp, "privacy") do
        %Node{} = privacy -> {:ok, parse_privacy_node(privacy)}
        _ -> {:error, :missing_privacy_node}
      end
    end
  end

  @doc """
  Set a single privacy toggle. Returns updated `%Settings{}` on success.

  Mirrors Go's `SetPrivacySetting` (`privacysettings.go:63`).
  """
  @spec set_setting(pid() | String.t(), setting_name(), setting_value(), keyword()) ::
          {:ok, Settings.t()} | {:error, term()}
  def set_setting(session, name, value, opts \\ [])
      when is_atom(name) and is_atom(value) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    iq = build_set_setting_iq(name, value, opts)

    with {:ok, _} <- Session.send_iq(session, iq, timeout),
         {:ok, current} <- get_settings(session, opts) do
      {:ok, apply_setting(current, name, value)}
    end
  end

  @doc """
  Set the default disappearing-messages timer for new chats.

  `duration_seconds` must be `0` (off), `86_400` (24h), `604_800` (7d), or
  `7_776_000` (90d). The server rejects other values.

  Mirrors Go's `SetDefaultDisappearingTimer` (`privacysettings.go:108`).
  """
  @spec set_default_disappearing_timer(pid() | String.t(), non_neg_integer(), keyword()) ::
          :ok | {:error, term()}
  def set_default_disappearing_timer(session, duration_seconds, opts \\ [])
      when is_integer(duration_seconds) and duration_seconds >= 0 do
    timeout = Keyword.get(opts, :timeout, @default_timeout)
    id = Keyword.get(opts, :id) || IQ.generate_id()

    iq =
      Node.new(
        "iq",
        %{
          "id" => id,
          "to" => @server_jid,
          "type" => "set",
          "xmlns" => "disappearing_mode"
        },
        [
          Node.new(
            "disappearing_mode",
            %{"duration" => Integer.to_string(duration_seconds)},
            nil
          )
        ]
      )

    case Session.send_iq(session, iq, timeout) do
      {:ok, _} -> :ok
      err -> err
    end
  end

  # --- Blocklist -------------------------------------------------------------

  @doc """
  Fetch the user's blocklist via `<iq xmlns="blocklist" type="get">`.

  Mirrors Go's `GetBlocklist` (`user.go:927`).
  """
  @spec get_blocklist(pid() | String.t(), keyword()) ::
          {:ok, Blocklist.t()} | {:error, term()}
  def get_blocklist(session, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)
    id = Keyword.get(opts, :id) || IQ.generate_id()

    iq =
      Node.new(
        "iq",
        %{
          "id" => id,
          "to" => @server_jid,
          "type" => "get",
          "xmlns" => "blocklist"
        },
        nil
      )

    with {:ok, resp} <- Session.send_iq(session, iq, timeout) do
      case Node.get_child(resp, "list") do
        %Node{} = list -> {:ok, parse_blocklist_node(list)}
        _ -> {:error, :missing_list}
      end
    end
  end

  @doc """
  Block or unblock a contact.

  `action` is `:block` or `:unblock`. Returns the updated blocklist.

  Mirrors Go's `UpdateBlocklist` (`user.go:944`).
  """
  @spec update_blocklist(
          pid() | String.t(),
          JID.t() | String.t(),
          :block | :unblock,
          keyword()
        ) :: {:ok, Blocklist.t()} | {:error, term()}
  def update_blocklist(session, jid, action, opts \\ [])
      when action in [:block, :unblock] do
    timeout = Keyword.get(opts, :timeout, @default_timeout)
    {:ok, parsed} = to_jid(jid)
    id = Keyword.get(opts, :id) || IQ.generate_id()

    iq =
      Node.new(
        "iq",
        %{
          "id" => id,
          "to" => @server_jid,
          "type" => "set",
          "xmlns" => "blocklist"
        },
        [
          Node.new(
            "item",
            %{"jid" => parsed, "action" => Atom.to_string(action)},
            nil
          )
        ]
      )

    with {:ok, resp} <- Session.send_iq(session, iq, timeout) do
      case Node.get_child(resp, "list") do
        %Node{} = list -> {:ok, parse_blocklist_node(list)}
        _ -> {:error, :missing_list}
      end
    end
  end

  # --- Public builders (for testing without a live session) -----------------

  @doc "Build the `<iq xmlns=\"privacy\" type=\"get\">` IQ."
  @spec build_get_settings_iq(keyword()) :: Node.t()
  def build_get_settings_iq(opts \\ []) do
    id = Keyword.get(opts, :id) || IQ.generate_id()

    Node.new(
      "iq",
      %{
        "id" => id,
        "to" => @server_jid,
        "type" => "get",
        "xmlns" => "privacy"
      },
      [Node.new("privacy", %{}, nil)]
    )
  end

  @doc "Build the `<iq xmlns=\"privacy\" type=\"set\">` IQ for a single toggle."
  @spec build_set_setting_iq(setting_name(), setting_value(), keyword()) :: Node.t()
  def build_set_setting_iq(name, value, opts \\ []) when is_atom(name) and is_atom(value) do
    id = Keyword.get(opts, :id) || IQ.generate_id()

    Node.new(
      "iq",
      %{
        "id" => id,
        "to" => @server_jid,
        "type" => "set",
        "xmlns" => "privacy"
      },
      [
        Node.new("privacy", %{}, [
          Node.new(
            "category",
            %{"name" => setting_name_str(name), "value" => setting_value_str(value)},
            nil
          )
        ])
      ]
    )
  end

  @doc "Parse a `<privacy>` IQ-result child into a `%Settings{}`."
  @spec parse_privacy_node(Node.t()) :: Settings.t()
  def parse_privacy_node(%Node{} = privacy_node) do
    privacy_node
    |> Node.get_children("category")
    |> Enum.reduce(%Settings{}, fn category, acc ->
      name = setting_name_from_str(Node.attr(category, "name"))
      value = setting_value_from_str(Node.attr(category, "value"))

      if name && value, do: Map.put(acc, name, value), else: acc
    end)
  end

  @doc "Parse a `<list>` child of a blocklist IQ result into a `%Blocklist{}`."
  @spec parse_blocklist_node(Node.t()) :: Blocklist.t()
  def parse_blocklist_node(%Node{} = list_node) do
    jids =
      list_node
      |> Node.children()
      |> Enum.flat_map(fn child ->
        case Node.attr(child, "jid") do
          %JID{} = j ->
            [j]

          s when is_binary(s) ->
            case JID.parse(s) do
              {:ok, j} -> [j]
              _ -> []
            end

          _ ->
            []
        end
      end)

    %Blocklist{
      dhash: Node.attr(list_node, "dhash"),
      jids: jids
    }
  end

  # --- Setting name/value coercion ------------------------------------------

  @setting_name_map %{
    group_add: "groupadd",
    last_seen: "last",
    status: "status",
    profile: "profile",
    read_receipts: "readreceipts",
    online: "online",
    call_add: "calladd",
    messages: "messages",
    defense: "defense",
    stickers: "stickers"
  }

  @setting_value_map %{
    all: "all",
    contacts: "contacts",
    contact_blacklist: "contact_blacklist",
    match_last_seen: "match_last_seen",
    known: "known",
    nobody: "none"
  }

  defp setting_name_str(name) do
    Map.get(@setting_name_map, name) ||
      raise ArgumentError, "unknown privacy setting #{inspect(name)}"
  end

  defp setting_value_str(value) do
    Map.get(@setting_value_map, value) ||
      raise ArgumentError, "unknown privacy value #{inspect(value)}"
  end

  defp setting_name_from_str(str) do
    Enum.find_value(@setting_name_map, fn {atom, s} -> if s == str, do: atom end)
  end

  defp setting_value_from_str(str) do
    Enum.find_value(@setting_value_map, fn {atom, s} -> if s == str, do: atom end)
  end

  defp apply_setting(%Settings{} = s, name, value), do: Map.put(s, name, value)

  defp to_jid(%JID{} = j), do: {:ok, j}

  defp to_jid(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, j} -> {:ok, j}
      err -> err
    end
  end
end
