defmodule Whatsmeow.Receipt do
  @moduledoc """
  Receipt handling — delivery, read, played, server-error, inactive.

  Ports `whatsmeow-main/receipt.go`. The receive pipeline turns inbound
  `<receipt>` nodes into `Whatsmeow.Types.Events.Receipt` structs and
  publishes them on PubSub.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Types.{Events, JID}

  @doc """
  Decode a `<receipt>` node into a typed `Receipt` event for the given
  device.
  """
  @spec from_node(String.t(), Node.t()) :: Events.Receipt.t() | nil
  def from_node(device_id, %Node{tag: "receipt"} = node) do
    type =
      case Node.attr(node, "type") do
        nil -> :delivery
        "read" -> :read
        "read-self" -> :read
        "played" -> :played
        "server-error" -> :server_error
        "inactive" -> :inactive
        "sender" -> :sender
        "retry" -> :retry
        _ -> :delivery
      end

    ids =
      case Node.attr(node, "id") do
        nil -> Enum.map(Node.get_children(node, "item"), &Node.attr(&1, "id"))
        id -> [id]
      end

    %Events.Receipt{
      device_id: device_id,
      type: type,
      message_ids: Enum.reject(ids, &is_nil/1),
      from: parse_jid(Node.attr(node, "from")),
      timestamp: DateTime.utc_now()
    }
  end

  def from_node(_device_id, _node), do: nil

  @doc """
  Build the `<ack>` reply WhatsApp expects for every inbound
  `<message>` / `<receipt>` / `<notification>`. Without this the server
  resends the same node indefinitely.

  Mirrors Go's `sendAck` (`whatsmeow-main/receipt.go`). The `class`
  attribute echoes the inbound tag; `to`, `participant`, and `recipient`
  echo the inbound `from` / `participant` / `recipient`.

  Pass an `error` >= 0 to signal a Nack — `0` means clean ack.
  """
  @spec build_ack(Node.t(), non_neg_integer()) :: Node.t()
  def build_ack(%Node{} = inbound, error \\ 0) do
    base_attrs = %{
      "class" => inbound.tag,
      "id" => Node.attr(inbound, "id"),
      "to" => Node.attr(inbound, "from")
    }

    attrs =
      base_attrs
      |> maybe_put("participant", Node.attr(inbound, "participant"))
      |> maybe_put("recipient", Node.attr(inbound, "recipient"))
      |> maybe_put("type", maybe_ack_type(inbound))
      |> maybe_put("error", if(error > 0, do: Integer.to_string(error), else: nil))

    Node.new("ack", drop_nils(attrs), nil)
  end

  @doc """
  Build an outbound `<receipt type="retry">` for an inbound `<message>` we
  couldn't decrypt.

  Asks the sender to re-derive and re-send. The `count` increments on each
  retry; after 5 the server treats the failure as terminal (Go's
  `sendRetryReceipt` mirrors this with the same `>= 5` cutoff).

  `opts`:

  * `:count`       — retry attempt number (1-indexed). Default `1`.
  * `:registration_id` — our own registration id (uint32). Defaults to `0`.
  * `:keys`        — optional `{identity_pub, signed_prekey_node, prekey_node,
                     device_identity_bytes}` 4-tuple. When provided, attaches
                     the `<keys>` child that lets the sender start a fresh
                     Signal session (forces identity-include path on
                     `count > 1` or `force_include_identity=true`).

  Resulting shape:

      <receipt id="<msg_id>" to="<from>" type="retry" participant="<optional>">
        <retry count="N" id="<msg_id>" t="<server_t>" v="1"/>
        <registration><registration_id_be32></registration>
        [<keys>...</keys>]?
      </receipt>

  Mirrors Go's `sendRetryReceipt` (`retry.go:465`). Pure builder — caller
  threads through `Whatsmeow.Session.send_node/2`.
  """
  @spec build_retry_receipt(Node.t(), keyword()) :: Node.t()
  def build_retry_receipt(%Node{tag: "message"} = msg, opts \\ []) do
    count = Keyword.get(opts, :count, 1)
    registration_id = Keyword.get(opts, :registration_id, 0)
    keys = Keyword.get(opts, :keys)

    msg_id = Node.attr(msg, "id")
    server_t = Node.attr(msg, "t")

    base_attrs = %{
      "id" => msg_id,
      "to" => Node.attr(msg, "from"),
      "type" => "retry"
    }

    attrs =
      base_attrs
      |> maybe_put("participant", Node.attr(msg, "participant"))
      |> maybe_put("recipient", Node.attr(msg, "recipient"))

    retry_attrs =
      %{
        "count" => Integer.to_string(count),
        "id" => msg_id,
        "v" => "1"
      }
      |> maybe_put("t", server_t)

    children = [
      Node.new("retry", retry_attrs, nil),
      Node.new("registration", %{}, <<registration_id::big-unsigned-32>>)
    ]

    children = if keys, do: children ++ [build_retry_keys_node(keys)], else: children

    Node.new("receipt", drop_nils(attrs), children)
  end

  defp build_retry_keys_node({identity_pub, signed_prekey_node, prekey_node, device_identity}) do
    Node.new("keys", %{}, [
      Node.new("type", %{}, <<0x05>>),
      Node.new("identity", %{}, identity_pub),
      prekey_node,
      signed_prekey_node,
      Node.new("device-identity", %{}, device_identity)
    ])
  end

  @doc """
  Build a `<receipt type="read">` for an inbound `<message>` — the
  WhatsApp protocol equivalent of "the user opened the chat".

  Sent AFTER `build_delivery_receipt` for messages whose chat is
  considered "currently open" by the client. The peer's WhatsApp app
  flips the message's tick from grey-double to blue-double when this
  arrives. Use sparingly — sending `read` for every inbound makes
  the chat look like the user is glued to it 24/7.

  Mirrors Go's `Client.MarkRead` outbound shape.
  """
  @spec build_read_receipt(Node.t()) :: Node.t()
  def build_read_receipt(%Node{tag: "message"} = msg) do
    base = %{
      "id" => Node.attr(msg, "id"),
      "to" => Node.attr(msg, "from"),
      "type" => "read"
    }

    attrs =
      base
      |> maybe_put("participant", Node.attr(msg, "participant"))
      |> maybe_put("recipient", Node.attr(msg, "recipient"))
      |> Map.put("t", Integer.to_string(System.os_time(:second)))

    Node.new("receipt", drop_nils(attrs), nil)
  end

  @doc """
  Build a delivery `<receipt>` for an inbound `<message>` — what the Go
  client sends after a successful decrypt to confirm receipt.

  Resulting shape:

      <receipt id="<msg_id>" to="<from>" participant="<optional>" />
  """
  @spec build_delivery_receipt(Node.t()) :: Node.t()
  def build_delivery_receipt(%Node{tag: "message"} = msg) do
    base = %{
      "id" => Node.attr(msg, "id"),
      "to" => Node.attr(msg, "from")
    }

    attrs =
      base
      |> maybe_put("participant", Node.attr(msg, "participant"))
      |> maybe_put("recipient", Node.attr(msg, "recipient"))

    Node.new("receipt", drop_nils(attrs), nil)
  end

  defp maybe_ack_type(%Node{tag: "message"} = msg) do
    case Node.attr(msg, "type") do
      "text" -> nil
      "media" -> nil
      _ -> nil
    end
  end

  defp maybe_ack_type(_), do: nil

  defp maybe_put(map, _key, nil), do: map
  defp maybe_put(map, _key, ""), do: map
  defp maybe_put(map, key, val), do: Map.put(map, key, val)

  defp drop_nils(map), do: Map.reject(map, fn {_, v} -> is_nil(v) end)

  defp parse_jid(nil), do: %JID{server: ""}
  defp parse_jid(s) when is_binary(s), do: JID.parse!(s)
  defp parse_jid(%JID{} = j), do: j
end
