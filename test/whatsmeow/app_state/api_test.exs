defmodule Whatsmeow.AppState.ApiTest do
  @moduledoc """
  The public contract: `Whatsmeow.archive_chat/3` and friends return
  `{:ok, version} | {:error, reason}` and never raise, whatever they are given.
  """
  use ExUnit.Case, async: false

  @moduletag :capture_log

  alias Whatsmeow.AppState
  alias Whatsmeow.AppState.{Coordinator, Hash, Patch, PatchList, Processor}
  alias Whatsmeow.AppState.Store.Memory
  alias Whatsmeow.Test.AppStateFake, as: Fake
  alias Whatsmeow.Types.JID

  @me "me@s.whatsapp.net"
  @name "regular_low"
  @chat "201141465543@s.whatsapp.net"
  @key_id <<0, 0, 0, 0, 0, 42>>

  setup do
    start_supervised!(Memory)
    Coordinator.reset_requests()
    key_data = :crypto.strong_rand_bytes(32)
    server = Fake.start(@key_id, key_data)
    :ok = Memory.put_key(@me, @key_id, %{data: key_data, fingerprint: <<>>, timestamp: 1})
    %{server: server, opts: Fake.opts(server)}
  end

  # What the phone would see: decode every patch the server holds, in order, through
  # a fresh verifying processor, and return the mutations.
  defp phone_view(server) do
    proc = Processor.new("viewer@s.whatsapp.net", store: Memory)

    :ok =
      Memory.put_key(
        "viewer@s.whatsapp.net",
        @key_id,
        elem(Memory.get_key(Fake.phone_jid(), @key_id), 1)
      )

    {muts, _} =
      Enum.reduce(Fake.patches(server), {[], %Hash{}}, fn {_v, patch}, {acc, state} ->
        {:ok, m, ns} =
          Processor.decode_patches(
            proc,
            %PatchList{name: @name, patches: [patch]},
            state,
            true
          )

        {acc ++ m, ns}
      end)

    muts
  end

  describe "the exported surface (imdent probes arity 3)" do
    test "Whatsmeow.archive_chat/2 and /3 exist, as do the others" do
      Code.ensure_loaded!(Whatsmeow)

      for f <- [:archive_chat, :unarchive_chat, :mark_chat_read, :mark_chat_unread] do
        assert function_exported?(Whatsmeow, f, 3), "#{f}/3"
        assert function_exported?(Whatsmeow, f, 2), "#{f}/2"
      end
    end
  end

  describe "archive_chat" do
    test "sends archive + unpin and returns the new collection version", ctx do
      assert {:ok, 1} = AppState.archive_chat(nil, @chat, nil, ctx.opts)
      assert Fake.phone_errors(ctx.server) == []

      muts = phone_view(ctx.server)
      assert Enum.map(muts, & &1.index) == [["archive", @chat], ["pin_v1", @chat]]

      assert [%{archiveChatAction: %{archived: true}}, %{pinAction: %{pinned: false}}] =
               Enum.map(muts, & &1.action)
    end

    test "unarchive is a single archived:false mutation", ctx do
      assert {:ok, 1} = AppState.unarchive_chat(nil, @chat, nil, ctx.opts)

      assert [%{index: ["archive", @chat], action: %{archiveChatAction: %{archived: false}}}] =
               phone_view(ctx.server)
    end

    test "the last message's timestamp and key travel in the message range", ctx do
      key = %{id: "3EB0ABCDEF0123456789", remote_jid: @chat, from_me: false}
      assert {:ok, _} = AppState.archive_chat(nil, @chat, {1_700_000_000, key}, ctx.opts)

      [archive, _] = phone_view(ctx.server)
      range = archive.action.archiveChatAction.messageRange
      assert range.lastMessageTimestamp == 1_700_000_000
      assert [%{timestamp: 1_700_000_000, key: %{remoteJID: @chat, fromMe: false}}] = range.messages
      assert [%{key: %{ID: "3EB0ABCDEF0123456789"}}] = range.messages
    end

    test "a JID struct is accepted as well as a string", ctx do
      {:ok, jid} = JID.parse(@chat)
      assert {:ok, 1} = AppState.archive_chat(nil, jid, nil, ctx.opts)
    end

    test "repeated calls build on each other and the phone verifies the whole chain", ctx do
      assert {:ok, 1} = AppState.archive_chat(nil, @chat, nil, ctx.opts)
      assert {:ok, 2} = AppState.mark_chat_read(nil, @chat, nil, ctx.opts)
      assert {:ok, 3} = AppState.unarchive_chat(nil, @chat, nil, ctx.opts)
      assert {:ok, 4} = AppState.archive_chat(nil, @chat, nil, ctx.opts)
      assert Fake.phone_errors(ctx.server) == []
      assert Fake.version(ctx.server) == 4
    end
  end

  describe "mark_chat_read / unread" do
    test "read: true, one markChatAsRead mutation", ctx do
      assert {:ok, 1} = AppState.mark_chat_read(nil, @chat, nil, ctx.opts)

      assert [%{index: ["markChatAsRead", @chat], action: %{markChatAsReadAction: %{read: true}}}] =
               phone_view(ctx.server)
    end

    test "unread: read: false", ctx do
      assert {:ok, 1} = AppState.mark_chat_unread(nil, @chat, nil, ctx.opts)
      assert [%{action: %{markChatAsReadAction: %{read: false}}}] = phone_view(ctx.server)
    end
  end

  describe "input validation — nothing reaches the wire" do
    test "bad JIDs", ctx do
      for {bad, reason} <- [
            {"", :invalid_jid},
            {nil, :invalid_jid},
            {:atom, :invalid_jid},
            {123, :invalid_jid},
            {"not a jid", :invalid_jid},
            {"@s.whatsapp.net", :invalid_jid},
            {"201141465543:5@s.whatsapp.net",
             {:device_jid_not_allowed, "201141465543:5@s.whatsapp.net"}},
            {"status@broadcast", {:unsupported_chat_jid, "broadcast"}},
            {"123@newsletter", {:unsupported_chat_jid, "newsletter"}},
            # a permanent mutation for a chat that cannot exist is worse than an error
            {" 1@s.whatsapp.net", :invalid_jid},
            {"+201141465543@s.whatsapp.net", :invalid_jid},
            {"<&>@s.whatsapp.net", :invalid_jid},
            {"abc@s.whatsapp.net", :invalid_jid},
            {"١٢٣@s.whatsapp.net", :invalid_jid},
            {String.duplicate("1", 41) <> "@s.whatsapp.net", :invalid_jid},
            {"1-2@s.whatsapp.net", :invalid_jid},
            {"abc@g.us", :invalid_jid},
            {"1-@g.us", :invalid_jid}
          ] do
        assert {:error, ^reason} = AppState.archive_chat(nil, bad, nil, ctx.opts),
               "for #{inspect(bad)}"
      end

      assert Fake.iqs(ctx.server) == []
    end

    test "user, LID and group chats are accepted", ctx do
      for jid <- [
            @chat,
            "182909923287057@lid",
            "120363025246125486@g.us",
            "201141465543-1600000000@g.us"
          ] do
        assert {:ok, _} = AppState.mark_chat_read(nil, jid, nil, ctx.opts), jid
      end
    end

    test "bad last_message", ctx do
      for bad <- [:nope, "x", 1.5, {:a, :b, :c}, -5, {"x", nil}] do
        assert {:error, r} = AppState.archive_chat(nil, @chat, bad, ctx.opts)
        assert r in [:invalid_last_message, :invalid_timestamp], inspect({bad, r})
      end

      assert Fake.iqs(ctx.server) == []
    end

    test "last_message shapes", _ctx do
      key = %{id: "A", remote_jid: @chat}
      assert {:ok, nil, nil} = AppState.last_message(nil)
      assert {:ok, 1_700_000_000, nil} = AppState.last_message(1_700_000_000)
      assert {:ok, 1_700_000_000, nil} = AppState.last_message(~U[2023-11-14 22:13:20Z])
      assert {:ok, 1_700_000_000, ^key} = AppState.last_message({1_700_000_000, key})

      assert {:ok, 1_700_000_000, ^key} =
               AppState.last_message(last_message_timestamp: 1_700_000_000, last_message_key: key)

      assert {:ok, 1_700_000_000, ^key} =
               AppState.last_message(%{timestamp: 1_700_000_000, message_key: key})

      assert {:ok, 1_700_000_000, [^key]} =
               AppState.last_message(%{ts: 1_700_000_000, messages: [key]})

      assert {:ok, nil, [^key]} = AppState.last_message([key])
      assert {:ok, nil, nil} = AppState.last_message(0), "Go: a zero timestamp means 'now'"
    end

    test "a millisecond timestamp is converted, not sent as year 55 000" do
      p = Patch.build_archive(@chat, true, 1_700_000_000_123, nil)

      assert [
               %{
                 value: %{
                   archiveChatAction: %{messageRange: %{lastMessageTimestamp: 1_700_000_000}}
                 }
               },
               _
             ] = p.mutations
    end

    test "an agent on the JID struct is refused" do
      assert {:error, :invalid_jid} =
               AppState.chat_jid(%JID{user: "1", server: "s.whatsapp.net", agent: 1})
    end

    test "a %MessageKey{} in the builder does not raise, and odd key fields are tolerated" do
      mk = %WACommon.MessageKey{ID: "S", remoteJID: @chat, fromMe: true}
      p = Patch.build_archive(@chat, true, 1_700_000_000, mk)

      assert [
               %{
                 value: %{
                   archiveChatAction: %{
                     messageRange: %{messages: [%{timestamp: 1_700_000_000, key: %{ID: "S"}}]}
                   }
                 }
               },
               _
             ] = p.mutations

      p =
        Patch.build_archive(@chat, true, 1_700_000_000, [
          %{id: "A", participant: 5, from_me: "yes", remote_jid: 7}
        ])

      assert [
               %{
                 value: %{
                   archiveChatAction: %{
                     messageRange: %{
                       messages: [
                         %{key: %{ID: "A", participant: nil, remoteJID: nil, fromMe: false}}
                       ]
                     }
                   }
                 }
               },
               _
             ] = p.mutations
    end

    test "message keys: struct, map, keyword, list" do
      mk = %WACommon.MessageKey{ID: "S", remoteJID: @chat, fromMe: true}
      assert %{ID: "S"} = Patch.message_key(mk)

      assert %{ID: "M", fromMe: false, remoteJID: @chat} =
               Patch.message_key(%{id: "M", remote_jid: @chat})

      assert %{ID: "K", fromMe: true} = Patch.message_key(id: "K", from_me: true)
      assert nil == Patch.message_key(%{no_id: true})

      range =
        Patch.build_mark_chat_as_read(@chat, true, 100, [
          %{id: "A", timestamp: 90},
          %{id: "B"},
          %{nothing: 1}
        ]).mutations
        |> hd()
        |> then(& &1.value.markChatAsReadAction.messageRange)

      assert [%{timestamp: 90}, %{timestamp: 100}] = range.messages
    end
  end

  describe "never raises" do
    test "no session at all" do
      assert {:error, :no_session} = AppState.archive_chat(nil, @chat)
    end

    test "a session that is not there" do
      dead = spawn(fn -> :ok end)
      Process.sleep(10)
      assert {:error, _} = AppState.archive_chat(dead, @chat)
      assert {:error, _} = AppState.mark_chat_read("nobody-by-that-name", @chat)
    end

    test "a transport that throws or exits", ctx do
      assert {:error, {:exception, _}} =
               AppState.archive_chat(
                 nil,
                 @chat,
                 nil,
                 Keyword.put(ctx.opts, :send_iq, fn _ -> raise "boom" end)
               )

      assert {:error, {:exit, _}} =
               AppState.archive_chat(
                 nil,
                 @chat,
                 nil,
                 Keyword.put(ctx.opts, :send_iq, fn _ -> exit(:gone) end)
               )
    end

    test "errors from the layers below come back as tuples", ctx do
      Fake.reject_next(ctx.server, 400)
      assert {:error, {:rejected, %{code: 400}}} = AppState.archive_chat(nil, @chat, nil, ctx.opts)
    end
  end

  describe "sync/3" do
    test "fetches without sending and returns the version", ctx do
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin(@chat, true))
      assert {:ok, 1} = AppState.sync(nil, @name, ctx.opts)
      assert Enum.all?(Fake.iqs(ctx.server), &(not is_nil(&1.collection)))

      assert Enum.all?(
               Fake.iqs(ctx.server),
               &(Whatsmeow.Binary.Node.get_child(&1.collection, "patch") == nil)
             )
    end
  end
end
