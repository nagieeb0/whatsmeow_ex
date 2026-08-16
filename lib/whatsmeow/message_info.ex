defmodule Whatsmeow.MessageInfo do
  @moduledoc """
  Parsed attributes of an inbound `<message>` stanza — the metadata
  needed to dispatch and reply, separate from the encrypted body.

  Mirrors Go's `types.MessageInfo` (`whatsmeow-main/types/message.go`).
  This struct is purely the IQ-level envelope: who sent it, to which
  chat, what type, when. The decrypted payload (a `WaE2E.Message`
  protobuf) is delivered separately via `Whatsmeow.Types.Events.Message`.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Types.JID

  @enforce_keys [:id, :from, :timestamp]
  defstruct [
    :id,
    :from,
    :to,
    :type,
    :timestamp,
    :participant,
    :push_name,
    :addressing_mode,
    :sender_alt,
    :is_group?,
    :is_from_me?
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          from: JID.t(),
          to: JID.t() | nil,
          type: String.t() | nil,
          timestamp: DateTime.t(),
          participant: JID.t() | nil,
          push_name: String.t() | nil,
          addressing_mode: String.t() | nil,
          sender_alt: JID.t() | nil,
          is_group?: boolean(),
          is_from_me?: boolean()
        }

  @doc """
  Build a `%MessageInfo{}` from an inbound `<message>` node.

  Returns `{:error, :missing_id | :missing_from | :bad_jid}` if the
  required attributes are absent or unparsable. Group / individual is
  inferred from `from.server == "g.us"`; `is_from_me?` is set when
  `from.user == own_jid.user` (caller passes `own_jid` so this is
  decoupled from session state).
  """
  @spec from_node(Node.t(), JID.t() | nil) :: {:ok, t()} | {:error, atom()}
  def from_node(node, own_jid \\ nil)

  def from_node(%Node{tag: "message"} = node, own_jid) do
    with {:ok, id} <- get_id(node),
         {:ok, from} <- get_jid(node, "from"),
         {:ok, ts} <- get_timestamp(node) do
      to = optional_jid(node, "to")
      participant = optional_jid(node, "participant")
      is_group? = from.server == JID.group_server()

      is_from_me? =
        case {own_jid, from, participant} do
          {%JID{user: ou}, _, %JID{user: pu}} when is_group? -> ou == pu
          {%JID{user: ou}, %JID{user: fu}, _} -> ou == fu
          _ -> false
        end

      addressing_mode = Node.attr(node, "addressing_mode")
      sender = if is_group?, do: participant, else: from

      {:ok,
       %__MODULE__{
         id: id,
         from: from,
         to: to,
         type: Node.attr(node, "type"),
         timestamp: ts,
         participant: participant,
         push_name: Node.attr(node, "notify"),
         addressing_mode: addressing_mode,
         sender_alt: sender_alt(node, is_group?, addressing_mode, sender),
         is_group?: is_group?,
         is_from_me?: is_from_me?
       }}
    end
  end

  def from_node(%Node{}, _own_jid), do: {:error, :not_a_message_node}

  # --- the sender's other address --------------------------------------------

  # WhatsApp is migrating to LIDs, and a contact with privacy on reaches you as
  # `123456789@lid` with no phone number in it. The number is not lost, though:
  # the server puts the other form of the address in a sibling attribute of the
  # very same stanza. Not reading it is what leaves a CRM full of leads whose
  # "phone number" is a LID with a plus in front of it.
  #
  # Which attribute carries it depends on which way round the addressing is,
  # and groups name it differently from one-to-one chats. Mirrors Go's
  # `parseMessageSource` (`whatsmeow-main/message.go`).
  defp sender_alt(_node, _is_group?, _mode, nil), do: nil

  defp sender_alt(node, is_group?, addressing_mode, %JID{} = sender) do
    {attr, servers} = alt_attr(is_group?, addressing_mode, sender)

    node
    |> optional_jid(attr)
    |> on_server(servers)
    |> carry_device(sender)
  end

  # In a group the server states the addressing mode outright. In a 1:1 it does
  # not always, so the sender's own server is the more reliable tell.
  defp alt_attr(true, "lid", _sender), do: {"participant_pn", pn_servers()}
  defp alt_attr(true, _mode, _sender), do: {"participant_lid", lid_servers()}

  defp alt_attr(false, _mode, %JID{server: server}) do
    if server in lid_servers(),
      do: {"sender_pn", pn_servers()},
      else: {"sender_lid", lid_servers()}
  end

  defp pn_servers, do: [JID.default_user_server(), JID.hosted_server()]
  defp lid_servers, do: [JID.hidden_user_server(), JID.hosted_lid_server()]

  # `JID.parse/1` is permissive by design — it will read "not a jid at all" as a
  # server with no user. That is fine for a wire format that has to survive
  # whatever arrives, and wrong here: an alt is only meaningful if it is a real
  # user on the server this attribute is supposed to name, and anything else
  # would end up written into a CRM as somebody's phone number.
  defp on_server(%JID{user: user, server: server} = jid, servers)
       when is_binary(user) and user != "" do
    if server in servers, do: jid, else: nil
  end

  defp on_server(_jid, _servers), do: nil

  # The alt arrives bare while the sender is device-suffixed. The device index
  # is the same on both sides, so carrying it over keeps a session keyed by one
  # form resolvable from the other.
  defp carry_device(nil, _sender), do: nil

  defp carry_device(%JID{device: device} = alt, %JID{device: sender_device})
       when device in [nil, 0] and is_integer(sender_device) do
    %JID{alt | device: sender_device}
  end

  defp carry_device(%JID{} = alt, _sender), do: alt

  # --- internals ------------------------------------------------------------

  defp get_id(node) do
    case Node.attr(node, "id") do
      id when is_binary(id) and id != "" -> {:ok, id}
      _ -> {:error, :missing_id}
    end
  end

  defp get_jid(node, key) do
    case Node.attr(node, key) do
      %JID{} = j -> {:ok, j}
      bin when is_binary(bin) and bin != "" -> JID.parse(bin)
      _ -> {:error, :missing_from}
    end
  end

  defp optional_jid(node, key) do
    case Node.attr(node, key) do
      %JID{} = j -> j
      bin when is_binary(bin) and bin != "" -> JID.parse(bin) |> ok_or_nil()
      _ -> nil
    end
  end

  defp ok_or_nil({:ok, v}), do: v
  defp ok_or_nil(_), do: nil

  defp get_timestamp(node) do
    case Node.attr(node, "t") do
      ts when is_binary(ts) ->
        case Integer.parse(ts) do
          {n, _} -> {:ok, DateTime.from_unix!(n)}
          :error -> {:error, :bad_timestamp}
        end

      ts when is_integer(ts) ->
        {:ok, DateTime.from_unix!(ts)}

      _ ->
        {:ok, DateTime.utc_now()}
    end
  end
end
