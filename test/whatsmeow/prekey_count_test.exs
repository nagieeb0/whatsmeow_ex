defmodule Whatsmeow.PreKeyCountTest do
  @moduledoc """
  The number that decides whether a stranger can message this device at all.

  A peer with no existing Signal session fetches a one-time pre-key from the
  server before it can encrypt anything to us. With none left it cannot
  complete X3DH, so it **does not send** — the message is never transmitted and
  never queued, and from inside this library that is indistinguishable from
  nobody having written.

  Every local signal stays green through it: `status: :authenticated`, healthy
  keepalives, an `<active/>` the server answered. Measured live on 19 September,
  a device in exactly that state reported zero stanzas received while WhatsApp's
  own offline preview said it had no messages for us.

  Go asks the server for this count. This port described the response shape in
  `Whatsmeow.PreKeys`' own moduledoc and never sent the stanza, and decoded the
  server's unprompted warning into a struct nothing consumed.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Notification
  alias Whatsmeow.PreKeys

  describe "asking the server" do
    test "the request is a get on the encrypt namespace, carrying <count/>" do
      iq = PreKeys.build_count_iq("abc")

      assert iq.tag == "iq"
      assert iq.attrs["type"] == "get"
      assert iq.attrs["xmlns"] == "encrypt"
      assert iq.attrs["to"] == "s.whatsapp.net"
      assert iq.attrs["id"] == "abc"
      assert %Node{tag: "count"} = Node.get_child(iq, "count")
    end

    test "and every call gets its own id, because two in flight must not collide" do
      refute PreKeys.build_count_iq().attrs["id"] == PreKeys.build_count_iq().attrs["id"]
    end
  end

  describe "reading the answer" do
    defp reply(children), do: Node.new("iq", %{"type" => "result"}, children)

    test "the count comes off the attribute" do
      assert {:ok, 42} = PreKeys.read_count(reply([Node.new("count", %{"value" => "42"}, nil)]))
    end

    # The whole point of the number. Zero is not an absence — it is the server
    # stating that nobody new can reach this device.
    test "and zero is a number, not a missing one" do
      assert {:ok, 0} = PreKeys.read_count(reply([Node.new("count", %{"value" => "0"}, nil)]))
    end

    # The binary-XML encoder writes small integers as binaries in some places
    # and as attributes in others, and which one a server build picks is not
    # ours to decide.
    test "a count written as a binary child is read too" do
      assert {:ok, 50} = PreKeys.read_count(reply([Node.new("count", %{}, <<0, 50>>)]))
    end

    @doc """
    **"The server says none" and "we could not read the server" are opposite.**

    One means every stranger is being turned away and a person must be told.
    The other means try again. Collapsing an unreadable reply to `0` would
    trigger a 50-key upload on every parse hiccup; collapsing it the other way
    would hide the outage this number exists to expose.
    """
    test "an unreadable count is an error and never zero" do
      assert {:error, _} = PreKeys.read_count(reply([Node.new("count", %{"value" => "?"}, nil)]))
      assert {:error, :no_count} = PreKeys.read_count(reply([]))
    end
  end

  describe "the order the two post-login stanzas go out in" do
    @doc """
    **Pre-keys settle, then `<active/>` — and this port had it backwards.**

    Go's `handleConnectSuccess` (`connectionevents.go:187-206`) is one goroutine
    in strict sequence: count what we hold, ask the server what it holds, upload
    if either is short, and only then `SetPassive(false)`.

    This sent `<active/>` first and fired the pre-key work into a detached Task
    behind it, so the two raced on every connect — over the one stanza that
    tells the server to start flushing the offline queue. A race resolves
    differently on a warm reconnect than on a container booting under deploy
    load, which is the shape of a fault that only shows up after a deploy.
    """
    test "a device must not be left passive when the upload hangs" do
      assert Whatsmeow.Session.active_after_prekeys_ms() > 0,
             "a passive device receives nothing at all, so the wait for pre-keys " <>
               "has to be bounded — the deadline is what stops a hung upload " <>
               "from silencing the number for ever"
    end
  end

  describe "the warning the server sends unprompted" do
    # Decoded correctly since this module was written, and consumed by nothing —
    # the same shape as the `<ib>` offline preview before it was wired up.
    test "<notification type=\"encrypt\"><count/> decodes to a usable number" do
      node =
        Node.new("notification", %{"type" => "encrypt", "from" => "s.whatsapp.net"}, [
          Node.new("count", %{"value" => "3"}, nil)
        ])

      assert [%Notification.PreKeyCount{value: 3}] = Notification.from_node(node)
    end

    test "and three is below the threshold that should trigger a top-up" do
      assert 3 < PreKeys.min_count(),
             "if min_count/0 changes, the test above stops describing a low pool"
    end
  end
end
