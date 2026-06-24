defmodule Whatsmeow.MessageInfoTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.MessageInfo
  alias Whatsmeow.Types.JID

  describe "from_node/2" do
    test "extracts id, from, to, type, timestamp, push_name" do
      now = System.system_time(:second)

      node =
        Node.new("message", %{
          "id" => "3EB0ABCD",
          "from" => "11111@s.whatsapp.net",
          "to" => "22222@s.whatsapp.net",
          "type" => "text",
          "t" => Integer.to_string(now),
          "notify" => "Alice"
        })

      assert {:ok, info} = MessageInfo.from_node(node)
      assert info.id == "3EB0ABCD"
      assert info.from.user == "11111"
      assert info.to.user == "22222"
      assert info.type == "text"
      assert info.push_name == "Alice"
      assert DateTime.to_unix(info.timestamp) == now
      refute info.is_group?
      refute info.is_from_me?
    end

    test "marks group messages and surfaces participant" do
      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "1234@g.us",
          "type" => "text",
          "t" => "1715000000",
          "participant" => "5555@s.whatsapp.net"
        })

      assert {:ok, info} = MessageInfo.from_node(node)
      assert info.is_group?
      assert info.participant.user == "5555"
    end

    test "is_from_me? for an individual chat compares from.user with own_jid.user" do
      own = %JID{user: "9999", server: "s.whatsapp.net"}

      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "9999:1@s.whatsapp.net",
          "type" => "text",
          "t" => "1715000000"
        })

      assert {:ok, info} = MessageInfo.from_node(node, own)
      assert info.is_from_me?
    end

    test "is_from_me? for a group compares participant.user with own_jid.user" do
      own = %JID{user: "9999", server: "s.whatsapp.net"}

      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "555@g.us",
          "type" => "text",
          "t" => "1715000000",
          "participant" => "9999:2@s.whatsapp.net"
        })

      assert {:ok, info} = MessageInfo.from_node(node, own)
      assert info.is_from_me?
    end

    test "missing id is rejected" do
      node = Node.new("message", %{"from" => "111@s.whatsapp.net", "t" => "1"})
      assert {:error, :missing_id} = MessageInfo.from_node(node)
    end

    test "missing from is rejected" do
      node = Node.new("message", %{"id" => "3EB0", "t" => "1"})
      assert {:error, :missing_from} = MessageInfo.from_node(node)
    end

    test "wrong tag is rejected (no atom growth on the wire data)" do
      assert {:error, :not_a_message_node} =
               MessageInfo.from_node(Node.new("iq", %{"id" => "x"}))
    end
  end
end
