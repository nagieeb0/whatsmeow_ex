defmodule Whatsmeow.OfflineSyncTest do
  @moduledoc """
  The server's own statement of what it queued, delivered to the host.

  `<ib><offline_preview …/></ib>` is the only place WhatsApp says how much it is
  about to hand over. This library decoded it correctly and then wrote it to a
  `Logger.debug` — the comment on `on_ib/2` said a future patch could broadcast
  it "when the host needs them".

  A host needed it. A clinic's number went deaf for hours: authenticated,
  keepalive-healthy, sending fine, receiving nothing, and every health signal
  green. The one number that would have settled whether the loss was above or
  below the socket was in a log that host could not read.

  A host told seven and writing no rows knows the fault is its own. A host told
  zero knows the server had nothing to give it. Those have opposite fixes and
  nothing else distinguishes them.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.ConnectionEvents, as: CE
  alias Whatsmeow.Types.Events

  defp ib(children), do: Node.new("ib", %{"from" => "s.whatsapp.net"}, children)

  describe "what the wire says" do
    test "a preview carries every count the server sent" do
      node =
        ib([
          Node.new(
            "offline_preview",
            %{"count" => "7", "message" => "7", "notification" => "2", "receipt" => "1"},
            nil
          )
        ])

      assert [{:offline_preview, counts}] = CE.decode_ib(node)
      assert counts.total == 7
      assert counts.messages == 7
      assert counts.notifications == 2
      assert counts.receipts == 1
    end

    # Zero is the answer that matters most: it says the server had nothing
    # queued, which is a fact about WhatsApp and not about the host.
    test "and zero is a number, not an absence" do
      node = ib([Node.new("offline_preview", %{"count" => "0", "message" => "0"}, nil)])

      assert [{:offline_preview, %{total: 0, messages: 0}}] = CE.decode_ib(node)
    end

    test "a completed sync carries its count" do
      assert [{:offline_complete, 7}] =
               CE.decode_ib(ib([Node.new("offline", %{"count" => "7"}, nil)]))
    end

    # Go ignores what it does not recognise and so does this. A future `<ib>`
    # child must never be the reason a session stops.
    test "and an unknown child is dropped rather than raised on" do
      assert [] = CE.decode_ib(ib([Node.new("something_new", %{"x" => "1"}, nil)]))
    end
  end

  describe "counting a stanza before anything can reject it" do
    @doc """
    Every other signal about an inbound message fires after parsing and after
    decrypt. So a stanza rejected by `MessageInfo.from_node/2` looked exactly
    like a stanza the server never sent — and those are opposite problems.

    Measured live: a device announced thirty-five queued messages, reported the
    server had accepted its `<active/>`, and decrypted none of them. Without a
    count taken on arrival there was no way to say whether the bytes had come.
    """
    test "the arrival event names the device and the sender" do
      ref =
        :telemetry_test.attach_event_handlers(self(), [[:whatsmeow, :session, :message_received]])

      on_exit(fn -> :telemetry.detach(ref) end)

      :telemetry.execute(
        [:whatsmeow, :session, :message_received],
        %{system_time: System.system_time()},
        %{device_id: "d1", from: "966501234567@s.whatsapp.net"}
      )

      assert_receive {[:whatsmeow, :session, :message_received], ^ref, _measure, meta}
      assert meta.device_id == "d1"
      assert meta.from == "966501234567@s.whatsapp.net"
    end

    # The branch that consumes a message without ever reaching a decrypt event.
    test "and a rejected stanza says why" do
      ref =
        :telemetry_test.attach_event_handlers(self(), [[:whatsmeow, :session, :message_rejected]])

      on_exit(fn -> :telemetry.detach(ref) end)

      :telemetry.execute(
        [:whatsmeow, :session, :message_rejected],
        %{system_time: System.system_time()},
        %{device_id: "d1", from: "x", reason: :no_sender}
      )

      assert_receive {[:whatsmeow, :session, :message_rejected], ^ref, _measure,
                      %{reason: :no_sender}}
    end
  end

  describe "what the host receives" do
    setup do
      device_id = "offline-sync-#{System.unique_integer([:positive])}"
      Whatsmeow.Notifications.subscribe(device_id)
      %{device_id: device_id}
    end

    test "a preview arrives as an event with the counts on it", %{device_id: device_id} do
      Whatsmeow.Notifications.broadcast(device_id, %Events.OfflineSyncPreview{
        device_id: device_id,
        total: 7,
        messages: 7,
        notifications: 0,
        receipts: 0,
        app_data_changes: 0
      })

      assert_receive {:whatsmeow, %Events.OfflineSyncPreview{total: 7, messages: 7}}
    end

    test "and so does the completion", %{device_id: device_id} do
      Whatsmeow.Notifications.broadcast(device_id, %Events.OfflineSyncCompleted{
        device_id: device_id,
        count: 7
      })

      assert_receive {:whatsmeow, %Events.OfflineSyncCompleted{count: 7}}
    end
  end
end
