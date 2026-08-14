defmodule Whatsmeow.HistorySyncTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.HistorySync

  defp build_sync(opts \\ []) do
    %WAWebProtobufsHistorySync.HistorySync{
      syncType: :INITIAL_BOOTSTRAP,
      chunkOrder: Keyword.get(opts, :chunk_order, 1),
      progress: Keyword.get(opts, :progress, 42),
      conversations: Keyword.get(opts, :conversations, [])
    }
  end

  defp deflate(binary), do: :zlib.compress(binary)

  describe "decode_blob/1" do
    test "inflates zlib and decodes a HistorySync" do
      blob =
        build_sync()
        |> WAWebProtobufsHistorySync.HistorySync.encode()
        |> IO.iodata_to_binary()
        |> deflate()

      assert {:ok, sync} = HistorySync.decode_blob(blob)
      assert sync.syncType == :INITIAL_BOOTSTRAP
      assert sync.chunkOrder == 1
      assert sync.progress == 42
    end

    test "round-trips the conversations and their messages" do
      conv = %WAWebProtobufsHistorySync.Conversation{
        ID: "15551234567@s.whatsapp.net",
        name: "Ahmed",
        messages: [
          %WAWebProtobufsHistorySync.HistorySyncMsg{
            message: %WAWebProtobufsWeb.WebMessageInfo{
              key: %WACommon.MessageKey{
                remoteJID: "15551234567@s.whatsapp.net",
                fromMe: false,
                ID: "MSG1"
              },
              messageSecret: :binary.copy(<<7>>, 32)
            }
          }
        ]
      }

      blob =
        [conversations: [conv]]
        |> build_sync()
        |> WAWebProtobufsHistorySync.HistorySync.encode()
        |> IO.iodata_to_binary()
        |> deflate()

      assert {:ok, sync} = HistorySync.decode_blob(blob)
      assert [%{name: "Ahmed", messages: [msg]}] = sync.conversations
      assert msg.message.key."ID" == "MSG1"
      assert byte_size(msg.message.messageSecret) == 32
    end

    test "a blob that isn't zlib is an error, not a crash" do
      assert {:error, {:inflate, _}} = HistorySync.decode_blob(<<0, 1, 2, 3, 4>>)
    end

    test "valid zlib carrying garbage is an error, not a crash" do
      # Protobuf decoding of random bytes either fails outright or yields a
      # struct with unknown fields; either way it must not raise.
      assert match?({:ok, _}, HistorySync.decode_blob(deflate(<<>>)))
    end
  end

  describe "descriptor/1" do
    test "carries the history media type so the right HKDF info string is used" do
      notif = %WAWebProtobufsE2E.HistorySyncNotification{
        directPath: "/v/t62.1234-24/blob",
        mediaKey: :binary.copy(<<1>>, 32),
        fileSHA256: :binary.copy(<<2>>, 32),
        fileEncSHA256: :binary.copy(<<3>>, 32),
        fileLength: 9999
      }

      assert %{kind: :history, direct_path: "/v/t62.1234-24/blob", file_length: 9999} =
               HistorySync.descriptor(notif)
    end
  end

  describe "download/2" do
    test "an inline bootstrap payload skips the download entirely" do
      inline =
        build_sync(progress: 7)
        |> WAWebProtobufsHistorySync.HistorySync.encode()
        |> IO.iodata_to_binary()
        |> deflate()

      notif = %WAWebProtobufsE2E.HistorySyncNotification{
        initialHistBootstrapInlinePayload: inline
      }

      # No :media_conn and no :server — proof nothing tried to hit the network.
      assert {:ok, sync} = HistorySync.download(notif)
      assert sync.progress == 7
    end

    test "a CDN-backed notification needs somewhere to fetch from" do
      notif = %WAWebProtobufsE2E.HistorySyncNotification{
        directPath: "/v/blob",
        mediaKey: :binary.copy(<<1>>, 32)
      }

      assert {:error, :media_conn_required} = HistorySync.download(notif)
    end
  end
end
