defmodule Whatsmeow.User do
  @moduledoc """
  USync-driven user queries: contact resolution + device discovery.

  Mirrors `whatsmeow-main/user.go` — `IsOnWhatsApp`, `GetUserDevices`,
  `GetUserInfo`. All three share a single `<usync>` IQ machinery that
  varies `mode` (`query`/`full`) and `context` (`interactive`/`background`/
  `message`) plus a `<query>` child describing which sub-nodes the
  caller wants in each `<user>` response.

  Pure IQ — no Signal crypto, no media, no protobuf. Returns parsed
  structs to the caller.

  ## Why this exists

  Group fanout (`<enc type="msg">` SKDM per-device) needs the AD-JID list
  for every group member. `GetUserDevices/2` is the only way to get that
  list. So this module is a prerequisite for outbound group send.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Session
  alias Whatsmeow.Types.JID
  alias Whatsmeow.User.DeviceCache

  @server_jid "s.whatsapp.net"
  @default_timeout 30_000

  @typedoc "Either a running session pid or a device id registered in `Whatsmeow.Sessions.Registry`."
  @type session :: pid() | String.t()

  defmodule IsOnWhatsAppResponse do
    @moduledoc """
    One entry in the `is_on_whatsapp/2` result list.

    * `:query`   — the original phone number the caller passed in
    * `:jid`     — the resolved WhatsApp user JID (numeric `@s.whatsapp.net`)
    * `:is_in?`  — `true` when WhatsApp confirmed the contact is registered
    * `:verified_name` — business verified-name string, or `nil`
    """
    defstruct [:query, :jid, :is_in?, :verified_name]

    @type t :: %__MODULE__{
            query: String.t(),
            jid: Whatsmeow.Types.JID.t(),
            is_in?: boolean(),
            verified_name: String.t() | nil
          }
  end

  defmodule Info do
    @moduledoc """
    One entry in the `get_user_info/2` result.

    `:devices` is the list of AD-JIDs (`user.agent:device@…`) — that's the
    fanout target list for group SKDM distribution.
    """
    defstruct [:jid, :lid, :status, :picture_id, :verified_name, :devices]

    @type t :: %__MODULE__{
            jid: Whatsmeow.Types.JID.t(),
            lid: Whatsmeow.Types.JID.t() | nil,
            status: String.t() | nil,
            picture_id: String.t() | nil,
            verified_name: String.t() | nil,
            devices: [Whatsmeow.Types.JID.t()]
          }
  end

  # --- Public API ------------------------------------------------------------

  @doc """
  Check whether each phone number is registered on WhatsApp.

  `phones` are international-format strings (with or without `+`); they're
  wrapped into `<contact>` legacy-server JIDs as the server expects.

  Returns `{:ok, [%IsOnWhatsAppResponse{}]}` or `{:error, reason}`.

  Mirrors Go's `Client.IsOnWhatsApp` (`user.go:168`).
  """
  @spec is_on_whatsapp(session(), [String.t()], keyword()) ::
          {:ok, [IsOnWhatsAppResponse.t()]} | {:error, term()}
  def is_on_whatsapp(session, phones, opts \\ []) when is_list(phones) do
    jids =
      Enum.map(phones, fn phone ->
        JID.new(strip_plus(phone), JID.legacy_user_server())
      end)

    query = [
      Node.new("business", %{}, [Node.new("verified_name", %{}, nil)]),
      Node.new("contact", %{}, nil)
    ]

    with {:ok, list} <- usync(session, jids, "query", "interactive", query, opts) do
      {:ok, parse_is_on_whatsapp(list)}
    end
  end

  @doc """
  Resolve a list of user JIDs to their full device lists.

  Input is `[%JID{} | String.t()]` — strings are parsed. Output is a flat list
  of AD-JIDs (`user.agent:device@<server>`), the canonical addressing form
  for SKDM fanout and for fetching per-device PreKey bundles.

  Bots and hosted users are handled inline; FB Messenger server JIDs return
  `{:error, :messenger_server_unsupported}` (the upstream Go path goes through
  `fbid:devices` which we haven't ported yet).

  Mirrors Go's `Client.GetUserDevices` (`user.go:448`).
  """
  @spec get_user_devices(session(), [String.t() | JID.t()], keyword()) ::
          {:ok, [JID.t()]} | {:error, term()}
  def get_user_devices(session, jids, opts \\ []) when is_list(jids) do
    case normalize_jids(jids) do
      {:ok, parsed} -> do_get_user_devices(session, parsed, opts)
      {:error, _} = err -> err
    end
  end

  @doc """
  Full user info: verified name, status, picture id, device list, LID.

  Mirrors Go's `Client.GetUserInfo` (`user.go:203`). Returns
  `{:ok, %{jid_string => %Info{}}}`.
  """
  @spec get_user_info(session(), [String.t() | JID.t()], keyword()) ::
          {:ok, %{String.t() => Info.t()}} | {:error, term()}
  def get_user_info(session, jids, opts \\ []) when is_list(jids) do
    with {:ok, parsed} <- normalize_jids(jids) do
      query = [
        Node.new("business", %{}, [Node.new("verified_name", %{}, nil)]),
        Node.new("status", %{}, nil),
        Node.new("picture", %{}, nil),
        Node.new("devices", %{"version" => "2"}, nil),
        Node.new("lid", %{}, nil)
      ]

      with {:ok, list} <- usync(session, parsed, "full", "background", query, opts) do
        info = parse_user_info(list)
        # The server volunteered the LID alongside the phone number — that
        # pairing is exactly what `Whatsmeow.LIDMap` exists to remember, and
        # throwing it away here meant the same contact stayed unrecognisable
        # the next time they arrived as a bare LID.
        _ = cache_lid_mappings(info)
        {:ok, info}
      end
    end
  end

  @doc """
  Resolve contacts to their `{lid, pn}` pair.

  Answers "is this LID the same person as this number?" — the question you have
  to answer before a privacy-LID contact can be matched against an address book,
  or before two Signal sessions can be recognised as one conversation.

  Checks `Whatsmeow.LIDMap` first and only issues a USync for what's missing, so
  repeat lookups cost nothing. Returns a list of
  `%{lid: %JID{} | nil, pn: %JID{} | nil}`, one per input, in input order.
  """
  @spec resolve_lid(pid() | String.t(), [JID.t() | String.t()], keyword()) ::
          {:ok, [%{lid: JID.t() | nil, pn: JID.t() | nil}]} | {:error, term()}
  def resolve_lid(session, jids, opts \\ []) when is_list(jids) do
    with {:ok, parsed} <- normalize_jids(jids) do
      {cached, missing} =
        Enum.split_with(parsed, fn jid -> not is_nil(pair_from_cache(jid)) end)

      cached_pairs = Map.new(cached, fn jid -> {JID.to_string(jid), pair_from_cache(jid)} end)

      fetched =
        case missing do
          [] ->
            %{}

          _ ->
            case get_user_info(session, missing, opts) do
              {:ok, info} ->
                Map.new(info, fn {key, %Info{jid: jid, lid: lid}} -> {key, %{lid: lid, pn: jid}} end)

              {:error, _} ->
                %{}
            end
        end

      all = Map.merge(cached_pairs, fetched)

      {:ok,
       Enum.map(parsed, fn jid ->
         Map.get(all, JID.to_string(jid), %{lid: nil, pn: nil})
       end)}
    end
  end

  defp pair_from_cache(%JID{server: server} = jid) do
    cond do
      server == JID.hidden_user_server() ->
        case Whatsmeow.LIDMap.pn_for(jid) do
          %JID{} = pn -> %{lid: jid, pn: pn}
          nil -> nil
        end

      server == JID.default_user_server() ->
        case Whatsmeow.LIDMap.lid_for(jid) do
          %JID{} = lid -> %{lid: lid, pn: jid}
          nil -> nil
        end

      true ->
        nil
    end
  end

  defp cache_lid_mappings(info) when is_map(info) do
    Enum.each(info, fn
      {_key, %Info{jid: %JID{} = jid, lid: %JID{} = lid}} -> Whatsmeow.LIDMap.put(lid, jid)
      _ -> :ok
    end)
  rescue
    _ -> :ok
  end

  @doc """
  Send a raw `<usync>` IQ with the given `mode`, `context`, `<query>` children,
  and the implicit `<list>` of `<user>` children built from `jids`.

  Returns `{:ok, <list>}` — the `<usync><list>` child of the IQ result — or
  `{:error, reason}`.

  Mirrors Go's `Client.usync` (`user.go:836`). Public so callers (e.g. group
  fanout) can issue exotic queries the high-level helpers don't cover yet.
  """
  @spec usync(session(), [JID.t()], String.t(), String.t(), [Node.t()], keyword()) ::
          {:ok, Node.t()} | {:error, term()}
  def usync(session, jids, mode, context, query, opts \\ [])
      when is_list(jids) and is_binary(mode) and is_binary(context) and is_list(query) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)

    with {:ok, user_list} <- build_user_list(jids),
         iq = build_usync_iq(user_list, mode, context, query),
         {:ok, resp} <- Session.send_iq(session, iq, timeout),
         {:ok, list_node} <- extract_usync_list(resp) do
      {:ok, list_node}
    end
  end

  # --- Parsers (pure) --------------------------------------------------------

  @doc """
  Parse a `<usync><list>` child returned by IsOnWhatsApp into structured
  responses. Public for unit-testing without a live session.
  """
  @spec parse_is_on_whatsapp(Node.t()) :: [IsOnWhatsAppResponse.t()]
  def parse_is_on_whatsapp(%Node{} = list_node) do
    suffix = "@" <> JID.legacy_user_server()

    list_node
    |> Node.get_children("user")
    |> Enum.flat_map(fn user_node ->
      case parse_user_jid(user_node) do
        nil ->
          []

        jid ->
          contact_node = Node.get_child(user_node, "contact")

          query =
            case contact_node && contact_node.content do
              c when is_binary(c) -> String.replace_suffix(c, suffix, "")
              _ -> ""
            end

          is_in? =
            case contact_node do
              %Node{attrs: attrs} -> Map.get(attrs, "type") == "in"
              _ -> false
            end

          [
            %IsOnWhatsAppResponse{
              query: query,
              jid: jid,
              is_in?: is_in?,
              verified_name: parse_verified_name(Node.get_child(user_node, "business"))
            }
          ]
      end
    end)
  end

  @doc """
  Parse a `<usync><list>` for GetUserInfo into `%{jid_string => %Info{}}`.
  """
  @spec parse_user_info(Node.t()) :: %{String.t() => Info.t()}
  def parse_user_info(%Node{} = list_node) do
    list_node
    |> Node.get_children("user")
    |> Enum.flat_map(fn user_node ->
      case parse_user_jid(user_node) do
        nil ->
          []

        jid ->
          info = %Info{
            jid: jid,
            lid: parse_lid(user_node),
            status: text_content(Node.get_child(user_node, "status")),
            picture_id: picture_id(Node.get_child(user_node, "picture")),
            verified_name: parse_verified_name(Node.get_child(user_node, "business")),
            devices: parse_device_list(jid, Node.get_child(user_node, "devices"))
          }

          [{JID.to_string(jid), info}]
      end
    end)
    |> Map.new()
  end

  @doc """
  Parse a `<devices version="2"><device-list><device id="N" .../>...` block
  into a list of AD-JIDs rooted at `base_jid`.

  Mirrors Go's `parseDeviceList` (`user.go:739`). Treats `is_hosted="true"`
  by rewriting the server: `s.whatsapp.net → hosted`, `lid → hosted.lid`.
  """
  @spec parse_device_list(JID.t(), Node.t() | nil) :: [JID.t()]
  def parse_device_list(_jid, nil), do: []

  def parse_device_list(%JID{} = base_jid, %Node{tag: "devices"} = devices_node) do
    case Node.get_child(devices_node, "device-list") do
      %Node{tag: "device-list"} = dl ->
        dl
        |> Node.get_children("device")
        |> Enum.flat_map(fn device_node ->
          with {:ok, id} <- coerce_int(Node.attr(device_node, "id")) do
            is_hosted? = truthy?(Node.attr(device_node, "is_hosted"))
            server = device_server(base_jid, is_hosted?)
            [%JID{base_jid | device: id, server: server}]
          else
            _ -> []
          end
        end)

      _ ->
        []
    end
  end

  def parse_device_list(_jid, %Node{}), do: []

  @doc """
  Pull the verified-name string out of a `<business><verified_name>` node.
  Returns `nil` when missing. The full `WAVnameCert` proto parse is upstream
  to-do; for now we surface the raw bytes' presence as a flag.
  """
  @spec parse_verified_name(Node.t() | nil) :: String.t() | nil
  def parse_verified_name(nil), do: nil

  def parse_verified_name(%Node{} = business_node) do
    case Node.get_child(business_node, "verified_name") do
      %Node{content: c} when is_binary(c) and byte_size(c) > 0 -> c
      _ -> nil
    end
  end

  # --- Internals -------------------------------------------------------------

  defp do_get_user_devices(session, jids, opts) do
    # Validation runs before the cache, not inside the fetch: an unsupported
    # server must be rejected whether or not we happen to hold an answer for it.
    with :ok <- reject_unsupported_servers(jids) do
      # Device lists barely change, and this call sits on the critical path of
      # every send. Serve what we already know and only ask the server about the
      # rest — a burst of messages to one chat then costs a single USync instead
      # of one per message. Pass `cache: false` to force a round-trip.
      if Keyword.get(opts, :cache, true) do
        {hits, misses} =
          Enum.reduce(jids, {[], []}, fn jid, {hits, misses} ->
            case DeviceCache.get(jid) do
              {:ok, devices} -> {devices ++ hits, misses}
              :miss -> {hits, [jid | misses]}
            end
          end)

        case Enum.reverse(misses) do
          [] ->
            {:ok, hits}

          missing ->
            with {:ok, fetched} <- fetch_user_devices(session, missing, opts),
                 do: {:ok, hits ++ fetched}
        end
      else
        fetch_user_devices(session, jids, opts)
      end
    end
  end

  defp fetch_user_devices(session, jids, opts) do
    # `<lid/>` alongside `<devices/>`, and not only in `get_user_info/3`.
    #
    # The send path files each peer's session under its encryption identity —
    # the LID where one is known (`Whatsmeow.Signal.Address`) — and it can only
    # do that for a peer already in `Whatsmeow.LIDMap`. This query is the one
    # the fanout actually calls, and it used to ask for devices alone. So a
    # contact nobody had looked up in full — every outreach target, every
    # booking notification — had its first message encrypted under the phone
    # number while the reply arrived under the LID, splitting the session into
    # two ratchets and leaving the recipient's phone stuck on "waiting for this
    # message". Upstream Go reads the mapping from this same device-list query
    # (`whatsmeow-main/send.go:1285-1300`).
    query = [
      Node.new("devices", %{"version" => "2"}, nil),
      Node.new("lid", %{}, nil)
    ]

    with {:ok, list} <- usync(session, jids, "query", "message", query, opts) do
      devices =
        list
        |> Node.get_children("user")
        |> Enum.flat_map(fn user_node ->
          case parse_user_jid(user_node) do
            nil ->
              []

            jid ->
              _ = learn_lid(jid, parse_lid(user_node))
              parse_device_list(jid, Node.get_child(user_node, "devices"))
          end
        end)

      _ = DeviceCache.put_response(jids, devices)
      {:ok, devices}
    end
  end

  # Best effort, for the same reason `cache_lid_mappings/1` is: a mapping we
  # fail to record costs one un-canonicalised send, never the message itself.
  defp learn_lid(%JID{} = pn, %JID{} = lid), do: Whatsmeow.LIDMap.put(lid, pn)
  defp learn_lid(_pn, _lid), do: :ok

  defp reject_unsupported_servers(jids) do
    case Enum.find(jids, &(&1.server == JID.messenger_server())) do
      nil -> :ok
      _ -> {:error, :messenger_server_unsupported}
    end
  end

  defp build_user_list(jids) do
    user_nodes =
      Enum.map(jids, fn %JID{} = jid ->
        non_ad = JID.to_non_ad(jid)
        user_node_for(non_ad)
      end)

    if Enum.any?(user_nodes, &(&1 == :error)) do
      {:error, :unsupported_user_server}
    else
      {:ok, user_nodes}
    end
  end

  defp user_node_for(%JID{server: server} = jid) do
    cond do
      server == JID.legacy_user_server() ->
        Node.new("user", %{}, [Node.new("contact", %{}, JID.to_string(jid))])

      server == JID.default_user_server() or server == JID.hidden_user_server() ->
        Node.new("user", %{"jid" => jid}, nil)

      true ->
        :error
    end
  end

  defp build_usync_iq(user_list, mode, context, query) do
    Node.new(
      "iq",
      %{
        "id" => IQ.generate_id(),
        "to" => @server_jid,
        "type" => "get",
        "xmlns" => "usync"
      },
      [
        Node.new(
          "usync",
          %{
            "sid" => IQ.generate_id(),
            "mode" => mode,
            "last" => "true",
            "index" => "0",
            "context" => context
          },
          [
            Node.new("query", %{}, query),
            Node.new("list", %{}, user_list)
          ]
        )
      ]
    )
  end

  defp extract_usync_list(%Node{} = resp) do
    with %Node{} = usync_node <- Node.get_child(resp, "usync"),
         %Node{} = list <- Node.get_child(usync_node, "list") do
      {:ok, list}
    else
      _ -> {:error, :missing_usync_list}
    end
  end

  defp normalize_jids(jids) do
    Enum.reduce_while(jids, {:ok, []}, fn entry, {:ok, acc} ->
      case to_jid(entry) do
        {:ok, jid} -> {:cont, {:ok, [jid | acc]}}
        {:error, _} = err -> {:halt, err}
      end
    end)
    |> case do
      {:ok, list} -> {:ok, Enum.reverse(list)}
      err -> err
    end
  end

  defp to_jid(%JID{} = jid), do: {:ok, jid}
  defp to_jid(bin) when is_binary(bin), do: JID.parse(bin)

  defp parse_user_jid(%Node{attrs: attrs}) do
    case Map.get(attrs, "jid") do
      %JID{} = jid ->
        jid

      bin when is_binary(bin) ->
        case JID.parse(bin) do
          {:ok, jid} -> jid
          _ -> nil
        end

      _ ->
        nil
    end
  end

  defp parse_lid(user_node) do
    case Node.get_child(user_node, "lid") do
      %Node{attrs: attrs} ->
        case Map.get(attrs, "val") do
          %JID{} = jid ->
            jid

          bin when is_binary(bin) and bin != "" ->
            case JID.parse(bin) do
              {:ok, jid} -> jid
              _ -> nil
            end

          _ ->
            nil
        end

      _ ->
        nil
    end
  end

  defp text_content(nil), do: nil
  defp text_content(%Node{content: c}) when is_binary(c), do: c
  defp text_content(%Node{}), do: nil

  defp picture_id(nil), do: nil
  defp picture_id(%Node{attrs: %{"id" => id}}) when is_binary(id), do: id
  defp picture_id(%Node{}), do: nil

  defp device_server(%JID{server: server}, true) do
    cond do
      server == JID.hidden_user_server() -> JID.hosted_lid_server()
      true -> JID.hosted_server()
    end
  end

  defp device_server(%JID{server: server}, false), do: server

  defp coerce_int(n) when is_integer(n) and n >= 0, do: {:ok, n}

  defp coerce_int(bin) when is_binary(bin) do
    case Integer.parse(bin) do
      {n, ""} when n >= 0 -> {:ok, n}
      _ -> :error
    end
  end

  defp coerce_int(_), do: :error

  defp truthy?(true), do: true
  defp truthy?("true"), do: true
  defp truthy?("1"), do: true
  defp truthy?(1), do: true
  defp truthy?(_), do: false

  defp strip_plus("+" <> rest), do: rest
  defp strip_plus(s) when is_binary(s), do: s
end
