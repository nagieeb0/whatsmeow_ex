defmodule Whatsmeow.NotificationTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Notification

  alias Whatsmeow.Notification.{
    AccountSync,
    DevicesChanged,
    IdentityChange,
    Picture,
    PreKeyCount,
    PrivacyToken,
    ServerSync,
    Unknown
  }

  describe "from_node/1 — type=encrypt" do
    test "pre-key count notification" do
      n =
        Node.new(
          "notification",
          %{"type" => "encrypt", "from" => "s.whatsapp.net"},
          [Node.new("count", %{"value" => "5"}, nil)]
        )

      assert [%PreKeyCount{value: 5}] = Notification.from_node(n)
    end

    test "identity-change notification → IdentityChange event" do
      n =
        Node.new(
          "notification",
          %{"type" => "encrypt", "from" => "447400000000@s.whatsapp.net", "t" => "1715000000"},
          [Node.new("identity", %{}, nil)]
        )

      assert [%IdentityChange{} = ic] = Notification.from_node(n)
      assert ic.jid.user == "447400000000"
      assert ic.timestamp == 1_715_000_000
    end

    test "unrecognised encrypt body → Unknown" do
      n = Node.new("notification", %{"type" => "encrypt"}, [Node.new("other", %{}, nil)])
      assert [%Unknown{type: "encrypt"}] = Notification.from_node(n)
    end
  end

  describe "from_node/1 — type=server_sync" do
    test "collections list parsed" do
      n =
        Node.new(
          "notification",
          %{"type" => "server_sync", "t" => "1715"},
          [
            Node.new("collection", %{"name" => "regular_low", "version" => "42"}, nil),
            Node.new("collection", %{"name" => "regular_high", "version" => "7"}, nil)
          ]
        )

      assert [%ServerSync{collections: cols, timestamp: 1715}] = Notification.from_node(n)
      assert cols == [{"regular_low", 42}, {"regular_high", 7}]
    end
  end

  describe "from_node/1 — type=picture" do
    test "set + add + delete sub-actions" do
      n =
        Node.new(
          "notification",
          %{"type" => "picture", "t" => "1715"},
          [
            Node.new("set", %{"jid" => "1@s.whatsapp.net", "id" => "PIC-1"}, nil),
            Node.new("delete", %{"jid" => "2@s.whatsapp.net"}, nil),
            Node.new("garbage", %{}, nil),
            Node.new("add", %{"jid" => "3@s.whatsapp.net", "id" => "PIC-3"}, nil)
          ]
        )

      assert [a, b, c] = Notification.from_node(n)
      assert %Picture{action: :set, jid: %{user: "1"}, picture_id: "PIC-1"} = a
      assert %Picture{action: :delete, jid: %{user: "2"}, picture_id: nil} = b
      assert %Picture{action: :add, jid: %{user: "3"}, picture_id: "PIC-3"} = c
    end
  end

  describe "from_node/1 — type=devices" do
    test "produces DevicesChanged event with from JID" do
      n =
        Node.new(
          "notification",
          %{"type" => "devices", "from" => "447400000000@s.whatsapp.net", "t" => "1"},
          []
        )

      assert [%DevicesChanged{from: %{user: "447400000000"}, timestamp: 1}] =
               Notification.from_node(n)
    end
  end

  describe "from_node/1 — type=account_sync" do
    test "lists children tags" do
      n =
        Node.new(
          "notification",
          %{"type" => "account_sync"},
          [Node.new("disappearing_mode", %{}, nil), Node.new("status", %{}, nil)]
        )

      assert [%AccountSync{children: ["disappearing_mode", "status"]}] =
               Notification.from_node(n)
    end
  end

  describe "from_node/1 — type=privacy_token" do
    test "extracts the token bytes" do
      n =
        Node.new(
          "notification",
          %{"type" => "privacy_token", "from" => "1@s.whatsapp.net"},
          [
            Node.new("tokens", %{}, [
              Node.new("token", %{}, <<1, 2, 3>>)
            ])
          ]
        )

      assert [%PrivacyToken{from: %{user: "1"}, token: <<1, 2, 3>>}] =
               Notification.from_node(n)
    end
  end

  describe "from_node/1 — unknown" do
    test "unrecognised type falls through to Unknown" do
      n = Node.new("notification", %{"type" => "future_type"}, [])
      assert [%Unknown{type: "future_type"}] = Notification.from_node(n)
    end

    test "non-notification node returns []" do
      assert Notification.from_node(Node.new("message", %{}, [])) == []
    end
  end
end
