defmodule Whatsmeow.Signal.MessageBuilderTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.MessageInfo
  alias Whatsmeow.Signal.MessageBuilder
  alias Whatsmeow.Types.JID

  defp info(opts \\ []) do
    %MessageInfo{
      id: Keyword.get(opts, :id, "3EB0CAFE"),
      from: Keyword.get(opts, :from, %JID{user: "111", server: "s.whatsapp.net"}),
      to: nil,
      type: "text",
      timestamp: ~U[2024-05-12 00:00:00Z],
      participant: Keyword.get(opts, :participant),
      push_name: Keyword.get(opts, :push_name, "Test"),
      is_group?: Keyword.get(opts, :is_group?, false),
      is_from_me?: false
    }
  end

  defp encode(msg), do: msg |> WAWebProtobufsE2E.Message.encode() |> IO.iodata_to_binary()

  describe "from_plaintext/2 — text bodies" do
    test "extracts a plain `conversation` body" do
      pt = encode(%WAWebProtobufsE2E.Message{conversation: "Hello"})
      assert {:ok, msg, []} = MessageBuilder.from_plaintext(pt, info())
      assert msg.body == "Hello"
      assert msg.id == "3EB0CAFE"
      assert msg.attachments == []
    end

    test "extracts an `extendedTextMessage.text` body" do
      pt =
        encode(%WAWebProtobufsE2E.Message{
          extendedTextMessage: %WAWebProtobufsE2E.ExtendedTextMessage{text: "Bold thing"}
        })

      assert {:ok, msg, []} = MessageBuilder.from_plaintext(pt, info())
      assert msg.body == "Bold thing"
    end

    test "decodes garbage as a proto error" do
      assert {:error, {:proto_decode, _}} =
               MessageBuilder.from_plaintext(<<0xFF, 0xFE, 0xFD>>, info())
    end
  end

  describe "from_plaintext/2 — media flattening" do
    test "image attachment carries url/mediaKey/sha/mime" do
      media_key = :crypto.strong_rand_bytes(32)

      pt =
        encode(%WAWebProtobufsE2E.Message{
          imageMessage: %WAWebProtobufsE2E.ImageMessage{
            URL: "https://mmg.whatsapp.net/foo",
            directPath: "/v/t62/foo",
            mediaKey: media_key,
            mimetype: "image/jpeg",
            fileSHA256: <<1::256>>,
            fileEncSHA256: <<2::256>>,
            fileLength: 1234,
            caption: "Smile!"
          }
        })

      assert {:ok, msg, [att]} = MessageBuilder.from_plaintext(pt, info())
      assert msg.body == nil
      assert att.kind == :image
      assert att.url == "https://mmg.whatsapp.net/foo"
      assert att.direct_path == "/v/t62/foo"
      assert att.media_key == media_key
      assert att.mime_type == "image/jpeg"
      assert att.caption == "Smile!"
      assert att.file_length == 1234
    end

    test "voice messages (PTT audio) get :voice kind" do
      pt =
        encode(%WAWebProtobufsE2E.Message{
          audioMessage: %WAWebProtobufsE2E.AudioMessage{
            URL: "https://mmg.whatsapp.net/voice",
            mediaKey: :crypto.strong_rand_bytes(32),
            mimetype: "audio/ogg; codecs=opus",
            seconds: 12,
            PTT: true
          }
        })

      assert {:ok, _msg, [att]} = MessageBuilder.from_plaintext(pt, info())
      assert att.kind == :voice
      assert att.ptt? == true
      assert att.duration_seconds == 12
    end

    test "non-PTT audio stays :audio" do
      pt =
        encode(%WAWebProtobufsE2E.Message{
          audioMessage: %WAWebProtobufsE2E.AudioMessage{
            URL: "https://mmg.whatsapp.net/song",
            mediaKey: :crypto.strong_rand_bytes(32),
            mimetype: "audio/mpeg",
            seconds: 180
          }
        })

      assert {:ok, _msg, [att]} = MessageBuilder.from_plaintext(pt, info())
      assert att.kind == :audio
      refute att.ptt?
    end

    test "documents include filename" do
      pt =
        encode(%WAWebProtobufsE2E.Message{
          documentMessage: %WAWebProtobufsE2E.DocumentMessage{
            URL: "https://mmg.whatsapp.net/doc",
            mediaKey: :crypto.strong_rand_bytes(32),
            mimetype: "application/pdf",
            fileName: "invoice.pdf"
          }
        })

      assert {:ok, _msg, [att]} = MessageBuilder.from_plaintext(pt, info())
      assert att.kind == :document
      assert att.file_name == "invoice.pdf"
    end
  end

  describe "from_plaintext/2 — wrappers" do
    test "ephemeralMessage unwraps to find the inner attachment" do
      inner = %WAWebProtobufsE2E.Message{
        imageMessage: %WAWebProtobufsE2E.ImageMessage{
          URL: "https://mmg.whatsapp.net/inner-img",
          mediaKey: :crypto.strong_rand_bytes(32),
          mimetype: "image/png"
        }
      }

      pt =
        encode(%WAWebProtobufsE2E.Message{
          ephemeralMessage: %WAWebProtobufsE2E.FutureProofMessage{message: inner}
        })

      assert {:ok, msg, [att]} = MessageBuilder.from_plaintext(pt, info())
      assert msg.is_ephemeral
      assert att.kind == :image
      assert att.mime_type == "image/png"
    end
  end

  describe "from_plaintext/2 — chat/sender derivation" do
    test "individual chat: chat == sender == info.from" do
      pt = encode(%WAWebProtobufsE2E.Message{conversation: "hi"})
      from = %JID{user: "555", server: "s.whatsapp.net"}
      assert {:ok, msg, _} = MessageBuilder.from_plaintext(pt, info(from: from))
      assert msg.chat == from
      assert msg.sender == from
      refute msg.is_group
    end

    test "group chat: chat = group jid, sender = participant" do
      pt = encode(%WAWebProtobufsE2E.Message{conversation: "yo"})
      group = %JID{user: "groupid", server: "g.us"}
      participant = %JID{user: "9999", server: "s.whatsapp.net"}

      assert {:ok, msg, _} =
               MessageBuilder.from_plaintext(
                 pt,
                 info(from: group, participant: participant, is_group?: true)
               )

      assert msg.chat == group
      assert msg.sender == participant
      assert msg.is_group
    end
  end
end
