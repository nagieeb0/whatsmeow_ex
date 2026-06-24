defmodule Whatsmeow.Send.BuildersTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Send
  alias Whatsmeow.Types.JID

  describe "build_message_key/3" do
    test "from_me when sender is nil" do
      key = Send.build_message_key("12345@s.whatsapp.net", nil, "MSG1")
      assert key.fromMe == true
      assert key."ID" == "MSG1"
      assert key.remoteJID == "12345@s.whatsapp.net"
      assert key.participant == nil
    end

    test "from_me when sender is empty JID" do
      empty = %JID{server: ""}
      key = Send.build_message_key("12345@s.whatsapp.net", empty, "MSG1")
      assert key.fromMe == true
    end

    test "another user in a group → from_me=false, participant set" do
      {:ok, peer} = JID.parse("99999@s.whatsapp.net")
      key = Send.build_message_key("group@g.us", peer, "MSG1")
      assert key.fromMe == false
      assert key.remoteJID == "group@g.us"
      assert key.participant == "99999@s.whatsapp.net"
    end

    test "another user in a 1:1 chat → from_me=false, no participant" do
      {:ok, peer} = JID.parse("99999@s.whatsapp.net")
      key = Send.build_message_key("peer@s.whatsapp.net", peer, "MSG1")
      assert key.fromMe == false
      assert key.participant == nil
    end
  end

  describe "build_revoke/3" do
    test "wraps in ProtocolMessage with REVOKE type" do
      msg = Send.build_revoke("12345@s.whatsapp.net", nil, "MSG1")

      assert msg.protocolMessage.type == :REVOKE
      assert msg.protocolMessage.key."ID" == "MSG1"
      assert msg.protocolMessage.key.fromMe == true
    end

    test "encodes to valid protobuf bytes" do
      msg = Send.build_revoke("12345@s.whatsapp.net", nil, "MSG1")
      bytes = msg |> WAWebProtobufsE2E.Message.encode() |> IO.iodata_to_binary()
      assert is_binary(bytes) and byte_size(bytes) > 0

      decoded = WAWebProtobufsE2E.Message.decode(bytes)
      assert decoded.protocolMessage.type == :REVOKE
    end
  end

  describe "build_reaction/4" do
    test "sets text + key + timestamp" do
      msg = Send.build_reaction("12345@s.whatsapp.net", nil, "MSG1", "🐈️")

      assert msg.reactionMessage.text == "🐈️"
      assert msg.reactionMessage.key."ID" == "MSG1"
      assert is_integer(msg.reactionMessage.senderTimestampMS)
      assert msg.reactionMessage.senderTimestampMS > 1_700_000_000_000
    end

    test "empty string removes a prior reaction" do
      msg = Send.build_reaction("12345@s.whatsapp.net", nil, "MSG1", "")
      assert msg.reactionMessage.text == ""
    end
  end

  describe "build_edit/3" do
    test "wraps new_content in editedMessage > futureProof > protocolMessage with MESSAGE_EDIT" do
      new_body = %WAWebProtobufsE2E.Message{conversation: "edited body"}
      msg = Send.build_edit("12345@s.whatsapp.net", "ORIG-ID", new_body)

      proto = msg.editedMessage.message.protocolMessage
      assert proto.type == :MESSAGE_EDIT
      assert proto.key."ID" == "ORIG-ID"
      assert proto.editedMessage.conversation == "edited body"
      assert is_integer(proto.timestampMS)
    end

    test "round-trips through protobuf" do
      new_body = %WAWebProtobufsE2E.Message{conversation: "rewritten"}
      msg = Send.build_edit("12345@s.whatsapp.net", "ORIG", new_body)

      bytes = msg |> WAWebProtobufsE2E.Message.encode() |> IO.iodata_to_binary()
      decoded = WAWebProtobufsE2E.Message.decode(bytes)

      assert decoded.editedMessage.message.protocolMessage.editedMessage.conversation == "rewritten"
    end
  end

  describe "build_poll_creation/3" do
    test "embeds name + options + selectable count" do
      msg = Send.build_poll_creation("meow?", ["yes", "no"], 1)

      assert msg.pollCreationMessage.name == "meow?"
      assert Enum.map(msg.pollCreationMessage.options, & &1.optionName) == ["yes", "no"]
      assert msg.pollCreationMessage.selectableOptionsCount == 1
    end

    test "32-byte messageSecret generated" do
      msg = Send.build_poll_creation("q", ["a"], 0)
      assert byte_size(msg.messageContextInfo.messageSecret) == 32
    end

    test "selectable_count above option count → 0 (no limit)" do
      msg = Send.build_poll_creation("q", ["a", "b"], 99)
      assert msg.pollCreationMessage.selectableOptionsCount == 0
    end

    test "each call produces a distinct messageSecret" do
      a = Send.build_poll_creation("q", ["a"], 0)
      b = Send.build_poll_creation("q", ["a"], 0)
      refute a.messageContextInfo.messageSecret == b.messageContextInfo.messageSecret
    end
  end
end
