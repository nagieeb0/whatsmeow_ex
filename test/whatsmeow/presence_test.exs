defmodule Whatsmeow.PresenceTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Presence
  alias Whatsmeow.Presence.{ChatStateEvent, Event}
  alias Whatsmeow.Types.JID

  describe "build_presence/2" do
    test "available without push_name → just type attr" do
      n = Presence.build_presence(:available)
      assert n.tag == "presence"
      assert n.attrs == %{"type" => "available"}
    end

    test "available with push_name → name attr included" do
      n = Presence.build_presence(:available, push_name: "alice")
      assert n.attrs["name"] == "alice"
      assert n.attrs["type"] == "available"
    end

    test "unavailable" do
      n = Presence.build_presence(:unavailable)
      assert n.attrs["type"] == "unavailable"
    end

    test "blank push_name not attached" do
      n = Presence.build_presence(:available, push_name: "")
      refute Map.has_key?(n.attrs, "name")
    end
  end

  describe "build_subscribe/2" do
    test "type=subscribe + to attr" do
      n = Presence.build_subscribe("12345@s.whatsapp.net")
      assert n.attrs["type"] == "subscribe"
      assert %JID{user: "12345"} = n.attrs["to"]
      assert n.content == nil
    end

    test "privacy_token attaches <tctoken> child" do
      n = Presence.build_subscribe("12345@s.whatsapp.net", privacy_token: <<1, 2, 3>>)
      [token_node] = n.content
      assert token_node.tag == "tctoken"
      assert token_node.content == <<1, 2, 3>>
    end
  end

  describe "build_chat_state/4" do
    test "composing without media" do
      n = Presence.build_chat_state("us@s.whatsapp.net", "peer@s.whatsapp.net", :composing)
      assert n.tag == "chatstate"
      [inner] = n.content
      assert inner.tag == "composing"
      assert inner.attrs == %{}
    end

    test "composing with :audio media" do
      n =
        Presence.build_chat_state("us@s.whatsapp.net", "peer@s.whatsapp.net", :composing, :audio)

      [inner] = n.content
      assert inner.attrs["media"] == "audio"
    end

    test ":paused never carries media attr" do
      n = Presence.build_chat_state("us@s.whatsapp.net", "peer@s.whatsapp.net", :paused, :audio)
      [inner] = n.content
      assert inner.attrs == %{}
    end
  end

  describe "from_presence_node/1" do
    test "available presence with last seen" do
      n =
        Node.new(
          "presence",
          %{"from" => "12345@s.whatsapp.net", "last" => "1715000000"},
          nil
        )

      assert {:ok, %Event{} = ev} = Presence.from_presence_node(n)
      assert ev.from.user == "12345"
      assert ev.unavailable? == false
      assert ev.last_seen == 1_715_000_000
    end

    test "unavailable presence + last=\"deny\" → no last_seen" do
      n =
        Node.new(
          "presence",
          %{"from" => "12345@s.whatsapp.net", "type" => "unavailable", "last" => "deny"},
          nil
        )

      assert {:ok, ev} = Presence.from_presence_node(n)
      assert ev.unavailable? == true
      assert ev.last_seen == nil
    end

    test "integer last attr coerced cleanly" do
      n = Node.new("presence", %{"from" => "1@s.whatsapp.net", "last" => 12345}, nil)
      assert {:ok, ev} = Presence.from_presence_node(n)
      assert ev.last_seen == 12345
    end

    test "returns :unparseable for non-presence nodes" do
      assert {:error, :unparseable} =
               Presence.from_presence_node(Node.new("message", %{}, nil))
    end
  end

  describe "from_chat_state_node/1" do
    test "composing → state :composing" do
      n =
        Node.new("chatstate", %{"from" => "1@s.whatsapp.net"}, [
          Node.new("composing", %{}, nil)
        ])

      assert {:ok, %ChatStateEvent{state: :composing, media: nil}} =
               Presence.from_chat_state_node(n)
    end

    test "composing with media=audio" do
      n =
        Node.new("chatstate", %{"from" => "1@s.whatsapp.net"}, [
          Node.new("composing", %{"media" => "audio"}, nil)
        ])

      assert {:ok, %ChatStateEvent{state: :composing, media: :audio}} =
               Presence.from_chat_state_node(n)
    end

    test "paused" do
      n =
        Node.new("chatstate", %{"from" => "1@s.whatsapp.net"}, [
          Node.new("paused", %{}, nil)
        ])

      assert {:ok, %ChatStateEvent{state: :paused}} = Presence.from_chat_state_node(n)
    end

    test "unparseable when no recognized inner tag" do
      n =
        Node.new("chatstate", %{"from" => "1@s.whatsapp.net"}, [
          Node.new("unknown", %{}, nil)
        ])

      assert {:error, :unparseable} = Presence.from_chat_state_node(n)
    end
  end
end
