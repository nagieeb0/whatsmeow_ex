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

  describe "the sender's other address" do
    test "a LID sender carries their phone number in sender_pn" do
      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "123456789@lid",
          "t" => "1715000000",
          "addressing_mode" => "lid",
          "sender_pn" => "201001234567@s.whatsapp.net"
        })

      assert {:ok, info} = MessageInfo.from_node(node)
      assert info.addressing_mode == "lid"
      assert info.sender_alt.user == "201001234567"
      assert info.sender_alt.server == JID.default_user_server()
      # The address the message was sent with is untouched — it is what a reply
      # and a Signal session are keyed by.
      assert info.from.server == JID.hidden_user_server()
    end

    test "a phone-number sender carries their LID in sender_lid" do
      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "201001234567@s.whatsapp.net",
          "t" => "1715000000",
          "sender_lid" => "123456789@lid"
        })

      assert {:ok, info} = MessageInfo.from_node(node)
      assert info.sender_alt.user == "123456789"
      assert info.sender_alt.server == JID.hidden_user_server()
    end

    test "a group names it participant_pn instead" do
      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "1234@g.us",
          "t" => "1715000000",
          "addressing_mode" => "lid",
          "participant" => "123456789@lid",
          "participant_pn" => "201001234567@s.whatsapp.net"
        })

      assert {:ok, info} = MessageInfo.from_node(node)
      assert info.sender_alt.user == "201001234567"
    end

    test "a group addressed by phone number names it participant_lid" do
      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "1234@g.us",
          "t" => "1715000000",
          "participant" => "201001234567@s.whatsapp.net",
          "participant_lid" => "123456789@lid"
        })

      assert {:ok, info} = MessageInfo.from_node(node)
      assert info.sender_alt.user == "123456789"
    end

    test "the sender's device index is carried onto the bare alt" do
      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "123456789:3@lid",
          "t" => "1715000000",
          "sender_pn" => "201001234567@s.whatsapp.net"
        })

      assert {:ok, info} = MessageInfo.from_node(node)
      # Same person, same device — a session keyed by one form has to resolve
      # to the same device on the other.
      assert info.sender_alt.device == 3
    end

    test "a stanza without the attribute simply has no alt" do
      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "123456789@lid",
          "t" => "1715000000"
        })

      assert {:ok, info} = MessageInfo.from_node(node)
      assert is_nil(info.sender_alt)
    end

    test "a malformed alt is dropped rather than failing the message" do
      node =
        Node.new("message", %{
          "id" => "3EB0",
          "from" => "123456789@lid",
          "t" => "1715000000",
          "sender_pn" => "not a jid at all"
        })

      assert {:ok, info} = MessageInfo.from_node(node)
      assert is_nil(info.sender_alt)
    end
  end
end
