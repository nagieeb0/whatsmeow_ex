defmodule Whatsmeow.Presence do
  @moduledoc """
  Presence + chat-state builders, decoders, and live senders.

  WhatsApp distinguishes:

  * **Global presence** (`<presence type="available|unavailable">`) — your
    online state, broadcast to everyone in your contact list. Required at
    least once post-login so peers see your push name instead of "-".
  * **Chat presence / typing** (`<chatstate><composing|paused/></chatstate>`)
    — per-chat typing indicator.
  * **Subscribe** (`<presence type="subscribe" to=JID>`) — opt into the
    typing/online indicators of a specific peer.

  Mirrors `whatsmeow-main/presence.go`.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Session
  alias Whatsmeow.Types.JID

  @typedoc "Global presence state."
  @type presence_state :: :available | :unavailable

  @typedoc "Per-chat typing state."
  @type chat_state :: :composing | :paused

  @typedoc "Media-type hint for `:composing` (recording vs typing)."
  @type chat_media :: nil | :audio | :other

  # --- Builders --------------------------------------------------------------

  @doc """
  Build a global `<presence>` node.

  * `state` — `:available` or `:unavailable`
  * `opts[:push_name]` — when present (and state is `:available`), included
    as the `name` attr so peers see your display name. Mirrors Go's
    `SendPresence` which sources this from `Store.PushName`.

  Example shape: `<presence type="available" name="alice"/>`.

  Mirrors `whatsmeow-main/presence.go#SendPresence` (`presence.go:64`).
  """
  @spec build_presence(presence_state(), keyword()) :: Node.t()
  def build_presence(state, opts \\ []) when state in [:available, :unavailable] do
    base = %{"type" => Atom.to_string(state)}

    attrs =
      case Keyword.get(opts, :push_name) do
        name when is_binary(name) and name != "" -> Map.put(base, "name", name)
        _ -> base
      end

    Node.new("presence", attrs, nil)
  end

  @doc """
  Build a `<presence type="subscribe" to=JID>` node — opt into another
  user's presence updates.

  Optional `opts[:privacy_token]` attaches a `<tctoken>` child for accounts
  that have one stored. Mirrors Go's behaviour when the privacy-token
  store is populated.

  Mirrors `whatsmeow-main/presence.go#SubscribePresence` (`presence.go:97`).
  """
  @spec build_subscribe(JID.t() | String.t(), keyword()) :: Node.t()
  def build_subscribe(jid, opts \\ []) do
    {:ok, parsed} = to_jid(jid)

    base_attrs = %{"type" => "subscribe", "to" => parsed}

    content =
      case Keyword.get(opts, :privacy_token) do
        token when is_binary(token) ->
          [Node.new("tctoken", %{}, token)]

        _ ->
          nil
      end

    Node.new("presence", base_attrs, content)
  end

  @doc """
  Build a `<chatstate from=our_jid to=peer_jid><composing|paused/></chatstate>`
  node — typing indicator for a single chat.

  * `our_jid`  — our own JID (use `device.jid` from `Session.get_device/1`)
  * `peer_jid` — the chat JID (1:1 or group)
  * `state`    — `:composing` (typing) or `:paused` (typing stopped)
  * `media`    — when `state == :composing`, optionally `:audio` to signal
                 a voice-note recording instead of typing.

  Mirrors `whatsmeow-main/presence.go#SendChatPresence` (`presence.go:130`).
  """
  @spec build_chat_state(JID.t() | String.t(), JID.t() | String.t(), chat_state(), chat_media()) ::
          Node.t()
  def build_chat_state(our_jid, peer_jid, state, media \\ nil)
      when state in [:composing, :paused] do
    {:ok, ours} = to_jid(our_jid)
    {:ok, theirs} = to_jid(peer_jid)

    inner_attrs =
      case {state, media} do
        {:composing, m} when m in [:audio, :other] ->
          %{"media" => Atom.to_string(m)}

        _ ->
          %{}
      end

    Node.new(
      "chatstate",
      %{"from" => ours, "to" => theirs},
      [Node.new(Atom.to_string(state), inner_attrs, nil)]
    )
  end

  # --- Live senders ----------------------------------------------------------

  @doc """
  Send a global presence update on `session`.

  Returns `:ok` or `{:error, reason}` from the underlying transport.

  Pre-condition: session must be authenticated.
  """
  @spec send_presence(pid() | String.t(), presence_state(), keyword()) ::
          :ok | {:error, term()}
  def send_presence(session, state, opts \\ []) do
    Session.send_node(session, build_presence(state, opts))
  end

  @doc """
  Subscribe to a peer's presence updates.

  Note: peer presence events come back through the regular `Events.Presence`
  PubSub broadcast — they are not returned synchronously.
  """
  @spec subscribe(pid() | String.t(), JID.t() | String.t(), keyword()) ::
          :ok | {:error, term()}
  def subscribe(session, jid, opts \\ []) do
    Session.send_node(session, build_subscribe(jid, opts))
  end

  @doc """
  Send a typing indicator (`composing`/`paused`) to a peer.

  The chat-state convention is fire-and-forget — `:composing` typically
  pairs with a `:paused` ~3-5 s later, or the receiver shows typing
  indefinitely.

  Resolves `our_jid` from `Session.get_device/1` automatically.
  """
  @spec send_chat_state(
          pid() | String.t(),
          JID.t() | String.t(),
          chat_state(),
          chat_media()
        ) :: :ok | {:error, term()}
  def send_chat_state(session, peer_jid, state, media \\ nil) do
    case Session.get_device(session) do
      {:ok, %{jid: our_jid}} ->
        Session.send_node(session, build_chat_state(our_jid, peer_jid, state, media))

      {:error, _} = err ->
        err
    end
  end

  # --- Decoders --------------------------------------------------------------

  defmodule Event do
    @moduledoc """
    Parsed `<presence>` event from a peer.

    * `:from` — peer JID
    * `:unavailable?` — `true` for `type="unavailable"`, else `false`
    * `:last_seen` — unix timestamp from the `last` attr, or `nil` (when
                     `last="deny"` the server hides the timestamp).
    """
    defstruct [:from, :unavailable?, :last_seen]

    @type t :: %__MODULE__{
            from: Whatsmeow.Types.JID.t() | nil,
            unavailable?: boolean(),
            last_seen: integer() | nil
          }
  end

  defmodule ChatStateEvent do
    @moduledoc """
    Parsed `<chatstate>` (typing) event from a peer.

    * `:from` — peer JID
    * `:state` — `:composing` or `:paused`
    * `:media` — `:audio` or nil
    """
    defstruct [:from, :state, :media]

    @type t :: %__MODULE__{
            from: Whatsmeow.Types.JID.t() | nil,
            state: :composing | :paused,
            media: :audio | :other | nil
          }
  end

  @doc """
  Parse an inbound `<presence>` node into a structured event.

  Returns `{:ok, %Event{}}` or `{:error, :unparseable}`.

  Mirrors `handlePresence` (`presence.go:39`).
  """
  @spec from_presence_node(Node.t()) :: {:ok, Event.t()} | {:error, :unparseable}
  def from_presence_node(%Node{tag: "presence"} = node) do
    from = parse_jid_attr(Node.attr(node, "from"))
    presence_type = Node.attr(node, "type")
    unavailable? = presence_type == "unavailable"

    last_seen =
      case Node.attr(node, "last") do
        ts when is_binary(ts) and ts != "deny" and ts != "" ->
          case Integer.parse(ts) do
            {n, ""} -> n
            _ -> nil
          end

        n when is_integer(n) ->
          n

        _ ->
          nil
      end

    {:ok, %Event{from: from, unavailable?: unavailable?, last_seen: last_seen}}
  end

  def from_presence_node(_), do: {:error, :unparseable}

  @doc """
  Parse an inbound `<chatstate>` node into a `%ChatStateEvent{}`.

  Returns `{:ok, %ChatStateEvent{}}` or `{:error, :unparseable}`.

  Mirrors `handleChatState` (`presence.go:18`).
  """
  @spec from_chat_state_node(Node.t()) ::
          {:ok, ChatStateEvent.t()} | {:error, :unparseable}
  def from_chat_state_node(%Node{tag: "chatstate"} = node) do
    from = parse_jid_attr(Node.attr(node, "from"))

    case Node.children(node) do
      [%Node{tag: tag} = inner] when tag in ["composing", "paused"] ->
        state = String.to_existing_atom(tag)

        media =
          case Node.attr(inner, "media") do
            "audio" -> :audio
            "other" -> :other
            _ -> nil
          end

        {:ok, %ChatStateEvent{from: from, state: state, media: media}}

      _ ->
        {:error, :unparseable}
    end
  end

  def from_chat_state_node(_), do: {:error, :unparseable}

  # --- Helpers ---------------------------------------------------------------

  defp to_jid(%JID{} = j), do: {:ok, j}

  defp to_jid(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, j} -> {:ok, j}
      err -> err
    end
  end

  defp parse_jid_attr(%JID{} = j), do: j

  defp parse_jid_attr(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, j} -> j
      _ -> nil
    end
  end

  defp parse_jid_attr(_), do: nil
end
