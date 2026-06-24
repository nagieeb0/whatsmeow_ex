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

      {:ok,
       %__MODULE__{
         id: id,
         from: from,
         to: to,
         type: Node.attr(node, "type"),
         timestamp: ts,
         participant: participant,
         push_name: Node.attr(node, "notify"),
         is_group?: is_group?,
         is_from_me?: is_from_me?
       }}
    end
  end

  def from_node(%Node{}, _own_jid), do: {:error, :not_a_message_node}

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
