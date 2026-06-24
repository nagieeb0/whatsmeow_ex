defmodule Whatsmeow.Call do
  @moduledoc """
  Call signaling — inbound offer/accept/terminate notifications.

  Ports `whatsmeow-main/call.go`. Scaffolded for Phase 13.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Types

  @doc "Decode a `<call>` notification node into a typed event."
  @spec from_node(String.t(), Node.t()) :: Types.Events.CallEvent.t() | nil
  def from_node(device_id, %Node{tag: "call"} = node) do
    %Types.Events.CallEvent{
      device_id: device_id,
      call: %Types.Call{
        id: Node.attr(node, "id"),
        from: parse_jid(Node.attr(node, "from")),
        timestamp: DateTime.utc_now(),
        video: Node.attr(node, "video", "false") == "true",
        group_call: false
      },
      kind: :offer
    }
  end

  def from_node(_, _), do: nil

  @doc """
  Build a `<call>` node that rejects an incoming call.

  WhatsApp's reject sequence is a one-shot stanza with a `<reject>` child
  carrying the original `call-id` and `call-creator`. After this the
  server sends a `<call><terminate reason="reject">` back to the caller.

  * `our_jid`  — our user JID (non-AD); pulled from `Session.get_device/1`
  * `call_from` — the caller's JID (non-AD)
  * `call_id`  — the `call-id` from the inbound offer

  Mirrors `whatsmeow-main/call.go#RejectCall` (`call.go:106`).
  """
  @spec build_reject(
          Types.JID.t() | String.t(),
          Types.JID.t() | String.t(),
          String.t(),
          keyword()
        ) :: Node.t()
  def build_reject(our_jid, call_from, call_id, opts \\ []) when is_binary(call_id) do
    {:ok, ours} = to_non_ad(our_jid)
    {:ok, theirs} = to_non_ad(call_from)
    msg_id = Keyword.get(opts, :msg_id) || Whatsmeow.Send.generate_message_id()

    Node.new(
      "call",
      %{"id" => msg_id, "from" => ours, "to" => theirs},
      [
        Node.new(
          "reject",
          %{
            "call-id" => call_id,
            "call-creator" => theirs,
            "count" => "0"
          },
          nil
        )
      ]
    )
  end

  @doc """
  Reject an active incoming call. Wraps `build_reject/4` with a live
  `Session.send_node/2`.
  """
  @spec reject_call(
          pid() | String.t(),
          Types.JID.t() | String.t(),
          String.t()
        ) :: :ok | {:error, term()}
  def reject_call(session, call_from, call_id) do
    case Whatsmeow.Session.get_device(session) do
      {:ok, %{jid: our_jid}} ->
        Whatsmeow.Session.send_node(session, build_reject(our_jid, call_from, call_id))

      {:error, _} = err ->
        err
    end
  end

  defp parse_jid(s) when is_binary(s), do: Types.JID.parse!(s)
  defp parse_jid(%Types.JID{} = j), do: j
  defp parse_jid(_), do: %Types.JID{server: ""}

  defp to_non_ad(%Types.JID{} = j), do: {:ok, Types.JID.to_non_ad(j)}

  defp to_non_ad(s) when is_binary(s) do
    case Types.JID.parse(s) do
      {:ok, j} -> {:ok, Types.JID.to_non_ad(j)}
      err -> err
    end
  end
end
