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

  describe "voice notes" do
    @upload %{
      url: "https://mmg.whatsapp.net/x",
      direct_path: "/x",
      media_key: <<1::256>>,
      file_sha256: <<2::256>>,
      file_enc_sha256: <<3::256>>,
      file_length: 4_096
    }

    # The bars WhatsApp draws under a voice note come from this field alone.
    # It was not being set, so every voice note this library sent rendered flat.
    test "carry the waveform they were given" do
      bars = :binary.copy(<<40>>, 64)

      msg = Send.build_media_message_proto(:voice, @upload, waveform: bars, duration_seconds: 7)

      assert msg.audioMessage.waveform == bars
      assert msg.audioMessage.seconds == 7
      assert Map.fetch!(msg.audioMessage, :PTT)
    end

    test "and are content to have none" do
      msg = Send.build_media_message_proto(:voice, @upload, [])

      assert msg.audioMessage.waveform == nil
    end
  end

  describe "edit_attribute/1 — Go's getEditAttribute (send.go:1030)" do
    test "a reaction with empty text is a revoke, not an empty reaction" do
      msg = Send.build_reaction("12345@s.whatsapp.net", nil, "MSG1", "")
      assert Send.edit_attribute(msg) == "7"
    end

    test "an ordinary reaction carries no edit attribute" do
      msg = Send.build_reaction("12345@s.whatsapp.net", nil, "MSG1", "\u{1F440}")
      assert Send.edit_attribute(msg) == nil
    end

    test "revoking our own message is a sender revoke" do
      msg = Send.build_revoke("12345@s.whatsapp.net", nil, "MSG1")
      assert Send.edit_attribute(msg) == "7"
    end

    test "revoking someone else's message as admin is an admin revoke" do
      {:ok, peer} = JID.parse("99999@s.whatsapp.net")
      msg = Send.build_revoke("group@g.us", peer, "MSG1")
      assert Send.edit_attribute(msg) == "8"
    end

    test "an edit is a message edit" do
      new_body = %WAWebProtobufsE2E.Message{conversation: "edited body"}
      msg = Send.build_edit("12345@s.whatsapp.net", "ORIG-ID", new_body)
      assert Send.edit_attribute(msg) == "1"
    end

    test "plain text has none" do
      assert Send.edit_attribute(%WAWebProtobufsE2E.Message{conversation: "hi"}) == nil
    end
  end

  describe "enc_attrs/3 — decrypt-fail (Go send.go:1195-1200)" do
    test "a reaction tells the peer to stay silent if it cannot decrypt" do
      msg = Send.build_reaction("12345@s.whatsapp.net", nil, "MSG1", "\u{1F440}")
      assert Send.enc_attrs("reaction", msg, nil) == %{"decrypt-fail" => "hide"}
    end

    test "so does anything carrying an edit attribute" do
      msg = Send.build_reaction("12345@s.whatsapp.net", nil, "MSG1", "")
      assert Send.enc_attrs("reaction", msg, "7") == %{"decrypt-fail" => "hide"}
    end

    test "plain text does not" do
      assert Send.enc_attrs("text", %WAWebProtobufsE2E.Message{conversation: "hi"}, nil) == %{}
    end
  end

  describe "build_message_key/4 — naming ourselves (Go send.go:494)" do
    test "our phone number as sender is still fromMe" do
      {:ok, own} = JID.parse("12345@s.whatsapp.net")
      key = Send.build_message_key("99999@s.whatsapp.net", own, "MSG1", ["12345", "77777"])
      assert key.fromMe == true
      assert key.participant == nil
    end

    test "our LID as sender is still fromMe" do
      {:ok, own_lid} = JID.parse("77777@lid")
      key = Send.build_message_key("99999@lid", own_lid, "MSG1", ["12345", "77777"])
      assert key.fromMe == true
    end

    test "a peer is still not us" do
      {:ok, peer} = JID.parse("99999@s.whatsapp.net")
      key = Send.build_message_key("99999@s.whatsapp.net", peer, "MSG1", ["12345", "77777"])
      assert key.fromMe == false
    end

    test "no own users means the old behaviour" do
      {:ok, own} = JID.parse("12345@s.whatsapp.net")
      assert Send.build_message_key("99999@s.whatsapp.net", own, "MSG1").fromMe == false
    end
  end

  describe "own_users/1" do
    test "both identities, bare" do
      device = %Whatsmeow.Store.Schemas.Device{
        jid: "12345.0:3@s.whatsapp.net",
        lid: "77777.0:3@lid"
      }

      assert Send.own_users(device) == ["12345", "77777"]
    end

    test "a device paired before the LID was stored yields just the phone number" do
      device = %Whatsmeow.Store.Schemas.Device{jid: "12345.0:3@s.whatsapp.net", lid: nil}
      assert Send.own_users(device) == ["12345"]
    end
  end
end
