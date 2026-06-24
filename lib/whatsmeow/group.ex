defmodule Whatsmeow.Group do
  @moduledoc """
  Group-chat IQs — create, modify, leave, query, participant management.

  Ports `whatsmeow-main/group.go`. Two layers:

  * **`build_*_iq/N`** — pure functions that produce `Whatsmeow.Binary.Node`
    structs. Test-friendly, no live session required.
  * **`create_group/3`, `leave_group/2`, …** — live wrappers that pipe the
    IQ through `Whatsmeow.Session.send_iq/2` and parse the response.

  Group IQs use the `xmlns="w:g2"` namespace. The `to` attr is either:

  * `s.whatsapp.net` (also reachable as the conceptual `@g.us`) for `create` /
    `leave` IQs that aren't bound to a specific group yet, or
  * the group JID for IQs that target an existing group (`query`, `subject`,
    `description`, participant changes).
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Session
  alias Whatsmeow.Types.JID

  @namespace "w:g2"
  @group_server_jid "g.us"
  @default_timeout 30_000

  defmodule Info do
    @moduledoc "Parsed `<group>` node from a `create` / `query` response."
    defstruct [
      :jid,
      :owner,
      :name,
      :name_set_at,
      :name_set_by,
      :topic,
      :topic_id,
      :topic_set_at,
      :topic_set_by,
      :creation,
      :participants,
      :is_announce?,
      :is_locked?,
      :is_ephemeral?,
      :disappearing_timer
    ]

    @type t :: %__MODULE__{
            jid: Whatsmeow.Types.JID.t() | nil,
            owner: Whatsmeow.Types.JID.t() | nil,
            name: String.t() | nil,
            name_set_at: integer() | nil,
            name_set_by: Whatsmeow.Types.JID.t() | nil,
            topic: String.t() | nil,
            topic_id: String.t() | nil,
            topic_set_at: integer() | nil,
            topic_set_by: Whatsmeow.Types.JID.t() | nil,
            creation: integer() | nil,
            participants: [map()],
            is_announce?: boolean(),
            is_locked?: boolean(),
            is_ephemeral?: boolean(),
            disappearing_timer: integer() | nil
          }
  end

  # --- Builders --------------------------------------------------------------

  @doc """
  Build the `<iq xmlns="w:g2" type="set">` that creates a new group.

  `participants` is a list of `JID.t() | String.t()` (non-AD user JIDs).
  Don't include our own JID — the server adds it implicitly.

  Mirrors Go's `CreateGroup` (`group.go:56`). The full Go variant supports
  community / parent / linked-parent / ephemeral / locked / announce
  modifiers via the `ReqCreateGroup` struct; this builder accepts them
  through `opts`:

  * `:create_key` — dedup key for the resulting `JoinedGroup` event
  * `:announce?` — true for announcement-only groups
  * `:locked?`   — true to lock the subject/photo to admins
  * `:ephemeral_seconds` — disappearing-message default for the new group
  """
  @spec build_create_iq(String.t(), [JID.t() | String.t()], keyword()) :: Node.t()
  def build_create_iq(name, participants, opts \\ []) when is_binary(name) do
    create_key = Keyword.get(opts, :create_key) || generate_create_key()

    base_children =
      Enum.map(participants, fn p ->
        {:ok, jid} = to_jid(p)
        Node.new("participant", %{"jid" => JID.to_non_ad(jid)}, nil)
      end)

    extras = []

    extras =
      if Keyword.get(opts, :announce?, false),
        do: extras ++ [Node.new("announcement", %{}, nil)],
        else: extras

    extras =
      if Keyword.get(opts, :locked?, false),
        do: extras ++ [Node.new("locked", %{}, nil)],
        else: extras

    extras =
      case Keyword.get(opts, :ephemeral_seconds) do
        n when is_integer(n) and n > 0 ->
          extras ++
            [
              Node.new(
                "ephemeral",
                %{"expiration" => Integer.to_string(n), "trigger" => "1"},
                nil
              )
            ]

        _ ->
          extras
      end

    Node.new(
      "iq",
      %{
        "id" => Keyword.get(opts, :id) || IQ.generate_id(),
        "to" => @group_server_jid,
        "type" => "set",
        "xmlns" => @namespace
      },
      [
        Node.new(
          "create",
          %{"subject" => name, "key" => create_key},
          base_children ++ extras
        )
      ]
    )
  end

  @doc "Build `<iq><leave><group id=jid/></leave></iq>` to leave a group."
  @spec build_leave_iq(JID.t() | String.t(), keyword()) :: Node.t()
  def build_leave_iq(group_jid, opts \\ []) do
    {:ok, jid} = to_group_jid(group_jid)

    group_iq(opts, @group_server_jid, "set", [
      Node.new("leave", %{}, [Node.new("group", %{"id" => jid}, nil)])
    ])
  end

  @doc "Build `<iq><query .../></iq>` requesting group info."
  @spec build_get_info_iq(JID.t() | String.t(), keyword()) :: Node.t()
  def build_get_info_iq(group_jid, opts \\ []) do
    {:ok, jid} = to_group_jid(group_jid)
    group_iq(opts, jid, "get", [Node.new("query", %{"request" => "interactive"}, nil)])
  end

  @doc "Build `<iq><subject>NAME</subject></iq>` setting the group's name."
  @spec build_set_name_iq(JID.t() | String.t(), String.t(), keyword()) :: Node.t()
  def build_set_name_iq(group_jid, name, opts \\ []) when is_binary(name) do
    {:ok, jid} = to_group_jid(group_jid)
    group_iq(opts, jid, "set", [Node.new("subject", %{}, name)])
  end

  @doc """
  Build `<iq><description ...><body>TOPIC</body></description></iq>` setting
  the group's topic.

  `opts[:previous_id]` — the prior topic id (returned by `get_group_info`);
  required when updating an existing topic.
  """
  @spec build_set_topic_iq(JID.t() | String.t(), String.t(), keyword()) :: Node.t()
  def build_set_topic_iq(group_jid, topic, opts \\ []) when is_binary(topic) do
    {:ok, jid} = to_group_jid(group_jid)
    desc_id = Keyword.get(opts, :description_id) || IQ.generate_id()
    prev_id = Keyword.get(opts, :previous_id)

    desc_attrs =
      %{"id" => desc_id}
      |> maybe_put("prev", prev_id)

    group_iq(opts, jid, "set", [
      Node.new("description", desc_attrs, [Node.new("body", %{}, topic)])
    ])
  end

  @doc """
  Build `<iq><action><participant jid=…/>…</action></iq>` where action is
  one of `:add` / `:remove` / `:promote` / `:demote`.
  """
  @spec build_update_participants_iq(
          JID.t() | String.t(),
          [JID.t() | String.t()],
          :add | :remove | :promote | :demote,
          keyword()
        ) :: Node.t()
  def build_update_participants_iq(group_jid, participants, action, opts \\ [])
      when action in [:add, :remove, :promote, :demote] do
    {:ok, jid} = to_group_jid(group_jid)

    children =
      Enum.map(participants, fn p ->
        {:ok, parsed} = to_jid(p)
        Node.new("participant", %{"jid" => JID.to_non_ad(parsed)}, nil)
      end)

    group_iq(opts, jid, "set", [Node.new(Atom.to_string(action), %{}, children)])
  end

  @doc "Build `<iq><invite/></iq>` requesting the group invite link."
  @spec build_get_invite_link_iq(JID.t() | String.t(), keyword()) :: Node.t()
  def build_get_invite_link_iq(group_jid, opts \\ []) do
    {:ok, jid} = to_group_jid(group_jid)
    reset? = Keyword.get(opts, :reset?, false)

    attrs = if reset?, do: %{"reset" => "true"}, else: %{}

    group_iq(opts, jid, "get", [Node.new("invite", attrs, nil)])
  end

  @doc """
  Build `<iq><invite code=CODE/></iq>` joining a group via an invite link
  code (the path component of `https://chat.whatsapp.com/CODE`).
  """
  @spec build_join_via_invite_iq(String.t(), keyword()) :: Node.t()
  def build_join_via_invite_iq(code, opts \\ []) when is_binary(code) do
    group_iq(opts, @group_server_jid, "set", [
      Node.new("invite", %{"code" => code}, nil)
    ])
  end

  @doc """
  Build `<iq xmlns=\"w:g2\" type=\"get\">` to list all joined groups.

  Returns under `<groups>`. Caller parses each `<group>` child via
  `parse_group_node/1`.
  """
  @spec build_get_joined_groups_iq(keyword()) :: Node.t()
  def build_get_joined_groups_iq(opts \\ []) do
    group_iq(opts, @group_server_jid, "get", [
      Node.new("participating", %{}, [Node.new("participants", %{}, nil)])
    ])
  end

  # --- Live wrappers ---------------------------------------------------------

  @doc """
  Create a group via live IQ. Returns `{:ok, %Info{}}` on success.

  Mirrors Go's `CreateGroup`.
  """
  @spec create_group(pid() | String.t(), String.t(), [JID.t() | String.t()], keyword()) ::
          {:ok, Info.t()} | {:error, term()}
  def create_group(session, name, participants, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)
    iq = build_create_iq(name, participants, opts)

    with {:ok, resp} <- Session.send_iq(session, iq, timeout),
         %Node{} = group_node <- Node.get_child(resp, "group") do
      {:ok, parse_group_node(group_node)}
    else
      nil -> {:error, :missing_group_node}
      err -> err
    end
  end

  @doc "Leave a group. Mirrors Go's `LeaveGroup`."
  @spec leave_group(pid() | String.t(), JID.t() | String.t(), keyword()) ::
          :ok | {:error, term()}
  def leave_group(session, group_jid, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    case Session.send_iq(session, build_leave_iq(group_jid, opts), timeout) do
      {:ok, _} -> :ok
      err -> err
    end
  end

  @doc "Fetch info for a group. Mirrors Go's `GetGroupInfo`."
  @spec get_group_info(pid() | String.t(), JID.t() | String.t(), keyword()) ::
          {:ok, Info.t()} | {:error, term()}
  def get_group_info(session, group_jid, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    with {:ok, resp} <- Session.send_iq(session, build_get_info_iq(group_jid, opts), timeout),
         %Node{} = group <- Node.get_child(resp, "group") do
      {:ok, parse_group_node(group)}
    else
      nil -> {:error, :missing_group_node}
      err -> err
    end
  end

  @doc "Update participants. `action` is `:add`/`:remove`/`:promote`/`:demote`."
  @spec update_participants(
          pid() | String.t(),
          JID.t() | String.t(),
          [JID.t() | String.t()],
          :add | :remove | :promote | :demote,
          keyword()
        ) :: {:ok, [map()]} | {:error, term()}
  def update_participants(session, group_jid, participants, action, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    iq = build_update_participants_iq(group_jid, participants, action, opts)

    with {:ok, resp} <- Session.send_iq(session, iq, timeout),
         %Node{} = action_node <- Node.get_child(resp, Atom.to_string(action)) do
      participants_out =
        action_node
        |> Node.get_children("participant")
        |> Enum.map(&parse_participant/1)

      {:ok, participants_out}
    else
      nil -> {:error, :missing_action_response}
      err -> err
    end
  end

  @doc "Set group name. Mirrors Go's `SetGroupName`."
  @spec set_group_name(pid() | String.t(), JID.t() | String.t(), String.t(), keyword()) ::
          :ok | {:error, term()}
  def set_group_name(session, group_jid, name, opts \\ []) do
    one_shot(session, build_set_name_iq(group_jid, name, opts), opts)
  end

  @doc "Set group topic. Mirrors Go's `SetGroupTopic`."
  @spec set_group_topic(pid() | String.t(), JID.t() | String.t(), String.t(), keyword()) ::
          :ok | {:error, term()}
  def set_group_topic(session, group_jid, topic, opts \\ []) do
    one_shot(session, build_set_topic_iq(group_jid, topic, opts), opts)
  end

  @doc """
  Fetch (or regenerate) the invite link for a group. Returns the bare code
  (the path component of `https://chat.whatsapp.com/<code>`).
  """
  @spec get_invite_link(pid() | String.t(), JID.t() | String.t(), keyword()) ::
          {:ok, String.t()} | {:error, term()}
  def get_invite_link(session, group_jid, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    with {:ok, resp} <-
           Session.send_iq(session, build_get_invite_link_iq(group_jid, opts), timeout),
         %Node{} = invite <- Node.get_child(resp, "invite") do
      case Node.attr(invite, "code") do
        code when is_binary(code) -> {:ok, code}
        _ -> {:error, :missing_invite_code}
      end
    else
      nil -> {:error, :missing_invite_node}
      err -> err
    end
  end

  @doc """
  Join a group via an invite code. Returns `{:ok, group_jid}`.
  """
  @spec join_via_invite(pid() | String.t(), String.t(), keyword()) ::
          {:ok, JID.t()} | {:error, term()}
  def join_via_invite(session, code, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    with {:ok, resp} <- Session.send_iq(session, build_join_via_invite_iq(code, opts), timeout),
         %Node{} = group <- Node.get_child(resp, "group") do
      case Node.attr(group, "jid") do
        %JID{} = j ->
          {:ok, j}

        s when is_binary(s) ->
          case JID.parse(s) do
            {:ok, j} -> {:ok, j}
            _ -> {:error, :bad_group_jid}
          end

        _ ->
          {:error, :missing_group_jid}
      end
    else
      nil -> {:error, :missing_group_node}
      err -> err
    end
  end

  # --- Parsers ---------------------------------------------------------------

  @doc "Parse a `<group>` node into a `%Info{}`."
  @spec parse_group_node(Node.t()) :: Info.t()
  def parse_group_node(%Node{} = node) do
    %Info{
      jid: parse_jid_attr(Node.attr(node, "id") || Node.attr(node, "jid")),
      owner: parse_jid_attr(Node.attr(node, "creator")),
      name: maybe_text(Node.get_child(node, "subject")) || Node.attr(node, "subject"),
      name_set_at: coerce_int(Node.attr(node, "s_t")),
      name_set_by: parse_jid_attr(Node.attr(node, "s_o")),
      topic: maybe_text(Node.get_child(node, "description") |> body_of()),
      topic_id:
        case Node.get_child(node, "description") do
          %Node{} = d -> Node.attr(d, "id")
          _ -> nil
        end,
      topic_set_at: coerce_int(Node.attr(node, "d_t")),
      topic_set_by: parse_jid_attr(Node.attr(node, "d_o")),
      creation: coerce_int(Node.attr(node, "creation")),
      participants:
        node
        |> Node.get_children("participant")
        |> Enum.map(&parse_participant/1),
      is_announce?: Node.get_child(node, "announcement") != nil,
      is_locked?: Node.get_child(node, "locked") != nil,
      is_ephemeral?: Node.get_child(node, "ephemeral") != nil,
      disappearing_timer:
        case Node.get_child(node, "ephemeral") do
          %Node{} = e -> coerce_int(Node.attr(e, "expiration"))
          _ -> nil
        end
    }
  end

  defp body_of(nil), do: nil
  defp body_of(%Node{} = desc), do: Node.get_child(desc, "body")

  defp parse_participant(%Node{} = node) do
    %{
      jid: parse_jid_attr(Node.attr(node, "jid")),
      role:
        case Node.attr(node, "type") do
          "admin" -> :admin
          "superadmin" -> :super_admin
          _ -> :member
        end
    }
  end

  # --- Helpers ---------------------------------------------------------------

  defp group_iq(opts, to, type, children) do
    id = Keyword.get(opts, :id) || IQ.generate_id()

    Node.new(
      "iq",
      %{"id" => id, "to" => to, "type" => type, "xmlns" => @namespace},
      children
    )
  end

  defp one_shot(session, iq, opts) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    case Session.send_iq(session, iq, timeout) do
      {:ok, _} -> :ok
      err -> err
    end
  end

  defp to_jid(%JID{} = j), do: {:ok, j}

  defp to_jid(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, j} -> {:ok, j}
      err -> err
    end
  end

  defp to_group_jid(%JID{server: "g.us"} = j), do: {:ok, j}

  defp to_group_jid(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, %JID{server: "g.us"} = j} -> {:ok, j}
      {:ok, _} -> {:error, :not_a_group_jid}
      err -> err
    end
  end

  defp to_group_jid(_), do: {:error, :not_a_group_jid}

  defp parse_jid_attr(nil), do: nil
  defp parse_jid_attr(%JID{} = j), do: j

  defp parse_jid_attr(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, j} -> j
      _ -> nil
    end
  end

  defp parse_jid_attr(_), do: nil

  defp maybe_text(nil), do: nil
  defp maybe_text(%Node{content: c}) when is_binary(c), do: c
  defp maybe_text(%Node{}), do: nil

  defp coerce_int(nil), do: nil
  defp coerce_int(n) when is_integer(n), do: n

  defp coerce_int(bin) when is_binary(bin) do
    case Integer.parse(bin) do
      {n, ""} -> n
      _ -> nil
    end
  end

  defp maybe_put(map, _k, nil), do: map
  defp maybe_put(map, k, v), do: Map.put(map, k, v)

  defp generate_create_key do
    # Strip the standard "3EB0" prefix the way Go does; the server doesn't
    # want it inside the create attr.
    Whatsmeow.Send.generate_message_id()
    |> String.replace_prefix("3EB0", "")
  end
end
