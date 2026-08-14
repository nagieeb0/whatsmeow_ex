defmodule Whatsmeow.ContentTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Content
  alias Whatsmeow.Send
  alias Whatsmeow.Types.JID

  # Every builder must survive a protobuf encode/decode round-trip. A field that
  # doesn't exist on the wire silently vanishes here rather than at 3am.
  defp roundtrip(%WAWebProtobufsE2E.Message{} = msg) do
    msg
    |> WAWebProtobufsE2E.Message.encode()
    |> IO.iodata_to_binary()
    |> WAWebProtobufsE2E.Message.decode()
  end

  describe "location/3" do
    test "carries coordinates and place details through the wire" do
      msg = Content.location(30.0444, 31.2357, name: "Cairo", address: "Tahrir Square")

      assert %{locationMessage: loc} = roundtrip(msg)
      assert_in_delta loc.degreesLatitude, 30.0444, 0.00001
      assert_in_delta loc.degreesLongitude, 31.2357, 0.00001
      assert loc.name == "Cairo"
      assert loc.address == "Tahrir Square"
    end

    test "integer coordinates are accepted and coerced to float" do
      msg = Content.location(30, 31)
      assert %{locationMessage: loc} = roundtrip(msg)
      assert loc.degreesLatitude == 30.0
    end

    test "goes out as type=text — Go's media list excludes location" do
      assert Send.message_type(Content.location(1, 2)) == "text"
    end
  end

  describe "vcard/2 and contact/2" do
    test "builds a vCard with the waid that makes the card tappable" do
      card = Content.vcard("Ahmed", "+20 100 123 4567")

      assert card =~ "BEGIN:VCARD"
      assert card =~ "FN:Ahmed"
      assert card =~ "waid=201001234567"
      assert card =~ "END:VCARD"
    end

    test "strips punctuation from the phone number" do
      assert Content.vcard("X", "(555) 123-4567") =~ "waid=5551234567"
    end

    test "contact/2 round-trips" do
      msg = Content.contact("Ahmed", Content.vcard("Ahmed", "201001234567"))
      assert %{contactMessage: %{displayName: "Ahmed", vcard: card}} = roundtrip(msg)
      assert card =~ "waid=201001234567"
    end

    test "contacts/2 keeps every card" do
      cards = [{"A", Content.vcard("A", "111")}, {"B", Content.vcard("B", "222")}]
      msg = Content.contacts("Team", cards)

      assert %{contactsArrayMessage: %{displayName: "Team", contacts: [a, b]}} = roundtrip(msg)
      assert a.displayName == "A"
      assert b.displayName == "B"
    end
  end

  describe "link_preview/3" do
    test "a title is what makes the preview render" do
      msg = Content.link_preview("see https://example.com", "https://example.com", title: "Example")

      assert %{extendedTextMessage: ext} = roundtrip(msg)
      assert ext.text == "see https://example.com"
      assert ext.matchedText == "https://example.com"
      assert ext.title == "Example"
    end
  end

  describe "group_invite/5" do
    test "round-trips the code and expiry the recipient needs to join" do
      msg =
        Content.group_invite(
          "120363000000000000@g.us",
          "ABC123",
          1_800_000_000,
          "Eng Team"
        )

      assert %{groupInviteMessage: inv} = roundtrip(msg)
      assert inv.groupJID == "120363000000000000@g.us"
      assert inv.inviteCode == "ABC123"
      assert inv.inviteExpiration == 1_800_000_000
      assert inv.groupName == "Eng Team"
    end
  end

  describe "pin / unpin / keep / unkeep" do
    test "pin carries the duration in the add-on field, not the pin message" do
      msg = Content.pin("15551234567@s.whatsapp.net", nil, "MSG1", 86_400)

      assert %{pinInChatMessage: pin, messageContextInfo: ctx} = roundtrip(msg)
      assert pin.type == :PIN_FOR_ALL
      assert pin.key."ID" == "MSG1"
      assert ctx.messageAddOnDurationInSecs == 86_400
    end

    test "unpin is the same message with the opposite type" do
      assert %{pinInChatMessage: %{type: :UNPIN_FOR_ALL}} =
               roundtrip(Content.unpin("15551234567@s.whatsapp.net", nil, "MSG1"))
    end

    test "keep and unkeep are a matched pair" do
      assert %{keepInChatMessage: %{keepType: :KEEP_FOR_ALL}} =
               roundtrip(Content.keep("15551234567@s.whatsapp.net", nil, "MSG1"))

      assert %{keepInChatMessage: %{keepType: :UNDO_KEEP_FOR_ALL}} =
               roundtrip(Content.unkeep("15551234567@s.whatsapp.net", nil, "MSG1"))
    end
  end

  describe "event/3" do
    test "carries an embedded location and gets a message secret" do
      msg =
        Content.event("Standup", 1_800_000_000,
          description: "Daily",
          end_time: 1_800_003_600,
          location: Content.location(30.0, 31.0, name: "Office")
        )

      assert %{eventMessage: ev, messageContextInfo: ctx} = roundtrip(msg)
      assert ev.name == "Standup"
      assert ev.description == "Daily"
      assert ev.endTime == 1_800_003_600
      assert ev.location.name == "Office"
      # Responses to an event are encrypted under this secret.
      assert byte_size(ctx.messageSecret) == 32
    end
  end

  describe "composition" do
    test "reply/3 promotes plain text to extendedTextMessage so context has a home" do
      key = %{ID: "ORIG1", participant: "15551234567@s.whatsapp.net"}
      msg = "hello" |> Content.text() |> Content.reply(key)

      assert %{conversation: nil, extendedTextMessage: ext} = roundtrip(msg)
      assert ext.text == "hello"
      assert ext.contextInfo.stanzaID == "ORIG1"
      assert ext.contextInfo.participant == "15551234567@s.whatsapp.net"
    end

    test "mention/2 and reply/3 compose without either clobbering the other" do
      key = %{ID: "ORIG1", participant: "111@s.whatsapp.net"}

      msg =
        "hi @222"
        |> Content.text()
        |> Content.reply(key)
        |> Content.mention(["222@s.whatsapp.net"])

      assert %{extendedTextMessage: %{contextInfo: ctx}} = roundtrip(msg)
      assert ctx.stanzaID == "ORIG1"
      assert ctx.mentionedJID == ["222@s.whatsapp.net"]
    end

    test "order doesn't matter — mention then reply is the same" do
      key = %{ID: "ORIG1", participant: "111@s.whatsapp.net"}

      msg =
        "hi @222"
        |> Content.text()
        |> Content.mention(["222@s.whatsapp.net"])
        |> Content.reply(key)

      assert %{extendedTextMessage: %{contextInfo: ctx}} = roundtrip(msg)
      assert ctx.stanzaID == "ORIG1"
      assert ctx.mentionedJID == ["222@s.whatsapp.net"]
    end

    test "mention accepts JID structs as well as strings" do
      msg = Content.mention(Content.text("hi"), [JID.parse!("222@s.whatsapp.net")])
      assert %{extendedTextMessage: %{contextInfo: ctx}} = roundtrip(msg)
      assert ctx.mentionedJID == ["222@s.whatsapp.net"]
    end

    test "context attaches to non-text content too" do
      msg = Content.mention(Content.location(1, 2), ["222@s.whatsapp.net"])
      assert %{locationMessage: %{contextInfo: ctx}} = roundtrip(msg)
      assert ctx.mentionedJID == ["222@s.whatsapp.net"]
    end

    test "view_once/1 wraps with V2 and the type is read from inside the wrapper" do
      msg = Content.view_once(Content.text("secret"))

      assert %{viewOnceMessageV2: %{message: inner}} = roundtrip(msg)
      assert inner.conversation == "secret"
      assert Send.message_type(msg) == "text"
    end

    test "forwarded/2 sets the counter clients render from" do
      assert %{extendedTextMessage: %{contextInfo: ctx}} =
               roundtrip(Content.forwarded(Content.text("fwd"), 5))

      assert ctx.isForwarded == true
      assert ctx.forwardingScore == 5
    end
  end

  describe "album/2 and album_item/4" do
    test "the parent announces the counts the client waits for" do
      assert %{albumMessage: %{expectedImageCount: 3, expectedVideoCount: 1}} =
               roundtrip(Content.album(3, 1))
    end

    test "an item points back at the parent with its index" do
      msg =
        Content.text("x")
        |> Content.album_item("ALBUM1", "15551234567@s.whatsapp.net", 2)

      assert %{messageContextInfo: %{messageAssociation: assoc}} = roundtrip(msg)
      assert assoc.associationType == :MEDIA_ALBUM
      assert assoc.parentMessageKey."ID" == "ALBUM1"
      assert assoc.messageIndex == 2
    end
  end

  describe "the :decorate hook on media" do
    # Media payloads only exist after an upload, so `reply`/`mention`/`view_once`
    # have nothing to compose with beforehand. Without this hook, an image simply
    # cannot be sent as a reply. These exercise the composition on a stand-in for
    # the built media message, which is exactly what the hook receives.
    test "reply context attaches to an image message" do
      built = %WAWebProtobufsE2E.Message{
        imageMessage: %WAWebProtobufsE2E.ImageMessage{mimetype: "image/jpeg"}
      }

      decorated = Content.reply(built, %{ID: "ORIG1", participant: "111@s.whatsapp.net"})

      assert %{imageMessage: %{contextInfo: ctx}} = roundtrip(decorated)
      assert ctx.stanzaID == "ORIG1"
      assert ctx.participant == "111@s.whatsapp.net"
    end

    test "an album item tag attaches to a video message" do
      built = %WAWebProtobufsE2E.Message{
        videoMessage: %WAWebProtobufsE2E.VideoMessage{mimetype: "video/mp4"}
      }

      decorated = Content.album_item(built, "ALBUM1", "15551234567@s.whatsapp.net", 0)

      assert %{messageContextInfo: %{messageAssociation: assoc}} = roundtrip(decorated)
      assert assoc.associationType == :MEDIA_ALBUM
      assert assoc.messageIndex == 0
    end

    test "view-once wraps a built media payload without losing it" do
      built = %WAWebProtobufsE2E.Message{
        imageMessage: %WAWebProtobufsE2E.ImageMessage{mimetype: "image/jpeg"}
      }

      assert %{viewOnceMessageV2: %{message: %{imageMessage: %{mimetype: "image/jpeg"}}}} =
               roundtrip(Content.view_once(built))
    end
  end

  describe "poll_vote/3" do
    test "refuses to fabricate a vote when the poll's secret was never stored" do
      poll = %{chat: "15551234567@s.whatsapp.net", sender: "15551234567@s.whatsapp.net", id: "P1"}

      assert {:error, :no_message_secret} =
               Content.poll_vote("me@s.whatsapp.net", poll, ["Yes"])
    end
  end

  describe "Send.message_type/1" do
    test "reactions and polls get their own type; everything else is text" do
      reaction = Send.build_reaction("15551234567@s.whatsapp.net", nil, "M1", "👍")
      poll = Send.build_poll_creation("Lunch?", ["Yes", "No"], 1)

      assert Send.message_type(reaction) == "reaction"
      assert Send.message_type(poll) == "poll"
      assert Send.message_type(Content.text("hi")) == "text"
      assert Send.message_type(Content.contact("A", "x")) == "text"
    end

    test "a wrapped reaction is still a reaction" do
      reaction = Send.build_reaction("15551234567@s.whatsapp.net", nil, "M1", "👍")
      assert Send.message_type(Content.view_once(reaction)) == "reaction"
    end
  end
end
