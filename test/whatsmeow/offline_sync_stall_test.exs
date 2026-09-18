defmodule Whatsmeow.OfflineSyncStallTest do
  @moduledoc """
  The server says it has messages for us and then sends none.

  Measured repeatedly on 19 September, on four separate connects and three
  separate containers:

      <ib><offline_preview message="13" count="145"/>
      stanzas  = %{"ib" => 4, "iq" => 5, "receipt" => 5, "success" => 1}
      received = 0
      offline_flushed = nil

  An authenticated, two-way socket. Receipts arrive, keepalive IQs are answered,
  the server accepted `<active/>`, the pre-key pool is full, and the device is
  listed in its own account's `usync` reply — so senders can encrypt to it. And
  not one `<message>`, and no `<ib><offline/>` to say the sync had ended.

  A sync that begins and never finishes. **The root cause is not known.** What is
  known is that a clinic in this state receives nothing until a person walks to
  the phone and re-pairs it, which is not a thing a product can require after
  every deploy.

  So it is treated as a fault to recover from rather than a mystery to wait on.
  `<passive/>` then `<active/>` is the documented way to ask the server to start
  feeding a device, and re-sending it costs two stanzas. Bounded, because if the
  queue has not moved after a few tries nothing here will move it, and then the
  right answer is to make somebody's phone ring.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.ConnectionEvents, as: CE

  defp ib(children), do: Node.new("ib", %{"from" => "s.whatsapp.net"}, children)

  test "an announced queue is a number we can act on" do
    node = ib([Node.new("offline_preview", %{"count" => "145", "message" => "13"}, nil)])

    assert [{:offline_preview, %{messages: 13, total: 145}}] = CE.decode_ib(node)
  end

  # The distinction the whole recovery rests on: the server saying "done" is a
  # different fact from the server saying nothing, and only one of them means
  # the queue is still owed to us.
  test "and a completed sync is what ends the watch" do
    assert [{:offline_complete, 13}] =
             CE.decode_ib(ib([Node.new("offline", %{"count" => "13"}, nil)]))
  end

  test "zero announced is not a stall, it is an empty queue" do
    assert [{:offline_preview, %{messages: 0}}] =
             CE.decode_ib(ib([Node.new("offline_preview", %{"count" => "0", "message" => "0"}, nil)]))
  end

  describe "the wire form of the restart" do
    test "passive and active are the same stanza with opposite children" do
      passive = Whatsmeow.IQ.build_set_passive(true, "a")
      active = Whatsmeow.IQ.build_set_passive(false, "b")

      assert passive.attrs["xmlns"] == "passive"
      assert active.attrs["xmlns"] == "passive"
      assert [%Node{tag: "passive"}] = Node.children(passive)
      assert [%Node{tag: "active"}] = Node.children(active)
    end
  end

  describe "how long it waits and how often it asks" do
    test "the grace period is long enough for a real flush to land" do
      assert Whatsmeow.Session.offline_sync_grace_ms() >= 10_000,
             "a burst of queued messages takes a moment; poking too early would " <>
               "restart a sync that was working"
    end

    test "and the asking is bounded, because a fourth try is somebody's phone ringing" do
      assert Whatsmeow.Session.offline_sync_pokes() in 1..5
    end
  end

  # The four `<ib>` children this device receives on every single connect, named
  # by the tally rather than inferred. Three of the four are not understood by
  # `decode_ib/1`, and that is deliberate — an unknown child must never stop a
  # session — but it is why they had to be counted to be seen at all.
  test "an unknown ib child is still dropped rather than raised on" do
    assert [] = CE.decode_ib(ib([Node.new("edge_routing", %{}, nil)]))
    assert [] = CE.decode_ib(ib([Node.new("thread_metadata", %{}, nil)]))
  end
end
