defmodule Whatsmeow.CleanDirtyTest do
  @moduledoc """
  The other stanza we dropped because Go drops it.

  `<ib><dirty type="account_sync" timestamp="…"/></ib>` arrives on every connect
  to this device. It was decoded, logged, and thrown away, on this reasoning:

  > *`dirty` and `downgrade_webclient` are decoded and deliberately not
  > broadcast: Go ignores the first…*

  Which is true — `connectionevents.go:91` has `MarkNotDirty` commented out.
  It is also the exact reasoning that left `<ib><offline_preview/></ib>`
  unanswered for eight hypotheses and eight deploys, each costing a deploy to
  disprove. **Go is a different client with a different feature set, and "Go
  gets away without it" is not "the server does not want it".**

  `amarula`, which works, sends the clean and says why:

  > *"Baileys `CB:ib,,dirty` (chats.ts): clear the server's dirty sync flag with
  > `<iq type=set xmlns="urn:xmpp:whatsapp:dirty"><clean type=../></iq>`.
  > **Until this is acked the server keeps the companion's sync paused.**"*

  That is the standing candidate for the history sync this device has never
  received. Unproven — but cheap, and now visible on the transcript either way.
  """
  use ExUnit.Case, async: false

  import ExUnit.CaptureLog

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Session
  alias Whatsmeow.Store.Schemas.Device

  describe "the stanza" do
    test "is a set iq in the dirty namespace, carrying the type" do
      node = IQ.build_clean_dirty("account_sync", 1_726_700_000)

      assert node.tag == "iq"
      assert node.attrs["type"] == "set"
      assert node.attrs["xmlns"] == "urn:xmpp:whatsapp:dirty"

      assert [%Node{tag: "clean", attrs: attrs}] = Node.children(node)
      assert attrs["type"] == "account_sync"
      assert attrs["timestamp"] == "1726700000"
    end

    # Baileys omits the attribute rather than sending an empty one, and a
    # server that validates its own schema is not a thing to gamble on.
    test "and omits the timestamp when the server gave none" do
      assert [%Node{attrs: attrs}] = Node.children(IQ.build_clean_dirty("account_sync"))

      refute Map.has_key?(attrs, "timestamp")
    end

    test "every iq needs its own id" do
      a = IQ.build_clean_dirty("account_sync")
      b = IQ.build_clean_dirty("account_sync")

      assert a.attrs["id"] != b.attrs["id"]
    end
  end

  describe "answering the notice" do
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

    test "a dirty account_sync is cleaned" do
      log =
        capture_log(fn ->
          Session.__dispatch_node__(
            state("dev-dirty-1"),
            Node.new("ib", %{"from" => "s.whatsapp.net"}, [
              Node.new("dirty", %{"type" => "account_sync", "timestamp" => "1726700000"}, nil)
            ])
          )
        end)

      assert log =~ "clean_dirty"
    end

    # The type is the server's word, echoed back. Hard-coding `account_sync`
    # would leave every other kind of dirty flag set for ever.
    test "and so is any other kind the server names" do
      log =
        capture_log(fn ->
          Session.__dispatch_node__(
            state("dev-dirty-2"),
            Node.new("ib", %{"from" => "s.whatsapp.net"}, [
              Node.new("dirty", %{"type" => "groups"}, nil)
            ])
          )
        end)

      assert log =~ "clean_dirty"
    end
  end
end
