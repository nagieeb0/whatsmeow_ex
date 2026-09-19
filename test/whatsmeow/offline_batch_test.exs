defmodule Whatsmeow.OfflineBatchTest do
  @moduledoc """
  The offer nobody answered.

  `<ib><offline_preview count="48" message="5"/></ib>` is not a delivery. It is
  the server saying *"I am holding forty-eight things for you"* and waiting to
  be asked for them. Baileys asks with `<ib><offline_batch count="100"/></ib>`,
  and `amarula` — an independent Elixir client that works — carries the comment
  that ends eight hypotheses and eight deploys:

  > *"reply `<ib><offline_batch count="100"/></ib>` **or the server never
  > delivers the queued offline messages**."*

  This library decoded the preview, broadcast an event about it, armed a timer
  to notice that nothing arrived, and never asked.

  Which is why every instrument said the socket was healthy — it *was*. On the
  connect that finally showed the whole conversation:

      00:34:48 success
      00:34:49 iq[type=result](active)      ← the server took <active/>
      00:34:49 ib(offline_preview[count=48])
      00:34:49 receipt[type=read,offline=8]  ← the queue moved…
      00:34:49 receipt[type=read,offline=7]  ← …once, and stopped
      00:34:49 iq[type=result](digest)
      00:34:49 iq[type=result](privacy)
      (nothing, ever)

  Re-sending `passive`/`active` three times could not have worked: the server
  was not waiting on a state change. It was waiting for a question.
  """
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Session
  alias Whatsmeow.Store.Schemas.Device

  describe "the stanza" do
    test "is an <ib> asking for a batch, as Baileys sends it" do
      node = IQ.build_offline_batch()

      assert node.tag == "ib"
      assert [%Node{tag: "offline_batch", attrs: %{"count" => "100"}}] = Node.children(node)
    end

    test "and the size is the caller's to choose" do
      assert [%Node{attrs: %{"count" => "5"}}] = Node.children(IQ.build_offline_batch(5))
    end
  end

  describe "answering the preview" do
    defp state(device_id) do
      %Session{
        device_id: device_id,
        device: %Device{jid: "9999@s.whatsapp.net"},
        transport: Whatsmeow.Transport.WebSocket.Mint,
        transport_conn: nil,
        noise_socket: nil,
        status: :authenticated,
        auto_reconnect?: true,
        reconnect_attempts: 0,
        keepalive_failures: 0,
        pending: %{}
      }
    end

    defp preview(attrs) do
      Node.new("ib", %{"from" => "s.whatsapp.net"}, [
        Node.new("offline_preview", attrs, nil)
      ])
    end

    # `transport_conn` is nil, so the send fails and is logged by name. That is
    # the assertion: the log line proves the stanza was built and handed to the
    # transport, which is precisely what never happened before.
    test "a preview is answered with a batch request" do
      log =
        capture_log(fn ->
          Session.__dispatch_node__(state("dev-1"), preview(%{"count" => "48", "message" => "5"}))
        end)

      assert log =~ "offline_batch",
             "the server offered a queue and waited to be asked — this is the asking"
    end

    @doc """
    **Even when the preview says no messages.**

    `count` is items and `message` is the message subset of them, and a queue of
    pure receipts and notifications still has to be drained. Gating the request
    on `message > 0` would leave those undrained and re-offered on every connect
    for ever — and it is the same mistake in a smaller place: deciding not to
    ask because we assumed what the answer was worth.
    """
    test "and so is one with nothing but notifications in it" do
      log =
        capture_log(fn ->
          Session.__dispatch_node__(state("dev-2"), preview(%{"count" => "12", "message" => "0"}))
        end)

      assert log =~ "offline_batch"
    end

    @doc """
    **A queue of pure receipts is still a queue.**

    The stall watch was armed on the preview's message count. The connect that
    exposed this announced `messages="0" count="115"` — a hundred and fifteen
    receipts and notifications and not one message — so nothing watched it, and
    when it stopped ten items short of the end there was no timer to notice.

    A receipt that never arrives is a read marker the clinic's own screen never
    gets, and an undrained queue is re-offered on every connect for ever.
    """
    test "a queue with no messages in it is still watched" do
      state =
        capture_state(fn ->
          Session.__dispatch_node__(state("dev-4"), preview(%{"count" => "115", "message" => "0"}))
        end)

      assert state.offline_expected == 115,
             "the queue is the queue — gating the watch on messages left 115 items unwatched"
    end

    test "and an empty one is watched by nothing, because there is nothing to wait for" do
      state =
        capture_state(fn ->
          Session.__dispatch_node__(state("dev-5"), preview(%{"count" => "0", "message" => "0"}))
        end)

      assert state.offline_expected == 0
    end

    # The sends fail with no transport and log about it, which is not what these
    # two are measuring.
    defp capture_state(fun) do
      {result, _log} = with_log(fun)
      result
    end

    test "an <ib> that is not a preview asks for nothing" do
      log =
        capture_log(fn ->
          Session.__dispatch_node__(
            state("dev-3"),
            Node.new("ib", %{"from" => "s.whatsapp.net"}, [
              Node.new("edge_routing", %{}, nil)
            ])
          )
        end)

      refute log =~ "offline_batch"
    end
  end
end
