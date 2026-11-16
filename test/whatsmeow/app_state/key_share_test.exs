defmodule Whatsmeow.AppState.KeyShareTest do
  use ExUnit.Case, async: false

  @moduletag :capture_log

  alias Whatsmeow.AppState.{Coordinator, KeyShare, Patch, Sync}
  alias Whatsmeow.AppState.Store.Memory
  alias Whatsmeow.Test.AppStateFake, as: Fake

  alias WAWebProtobufsE2E.{
    AppStateSyncKey,
    AppStateSyncKeyData,
    AppStateSyncKeyFingerprint,
    AppStateSyncKeyId,
    AppStateSyncKeyShare,
    Message,
    ProtocolMessage
  }

  @me "me@s.whatsapp.net"
  @name "regular_low"
  @key_id <<0, 0, 0, 0, 0, 42>>
  @chat "201141465543@s.whatsapp.net"

  setup do
    start_supervised!(Memory)
    Coordinator.reset_requests()
    key_data = :crypto.strong_rand_bytes(32)
    %{server: Fake.start(@key_id, key_data), key_data: key_data}
  end

  defp share(keys), do: %AppStateSyncKeyShare{keys: keys}

  defp key(id, data, ts, fingerprint \\ nil) do
    %AppStateSyncKey{
      keyID: %AppStateSyncKeyId{keyID: id},
      keyData: %AppStateSyncKeyData{keyData: data, timestamp: ts, fingerprint: fingerprint}
    }
  end

  defp wrap(share),
    do: %Message{
      protocolMessage: %ProtocolMessage{
        type: :APP_STATE_SYNC_KEY_SHARE,
        appStateSyncKeyShare: share
      }
    }

  describe "extract/2 — only our own account may share keys" do
    test "from us: the share is returned" do
      s = share([key(<<1>>, <<2>>, 3)])
      assert ^s = KeyShare.extract(wrap(s), true)
    end

    test "from anyone else: nothing — a stored key becomes the one every patch is encrypted under" do
      assert nil == KeyShare.extract(wrap(share([key(<<1>>, <<2>>, 3)])), false)
    end

    test "a message that is not a key share" do
      assert nil == KeyShare.extract(%Message{conversation: "hi"}, true)

      assert nil ==
               KeyShare.extract(%Message{protocolMessage: %ProtocolMessage{type: :REVOKE}}, true)

      assert nil == KeyShare.extract(nil, true)
    end
  end

  describe "build_key_request/1" do
    test "is an APP_STATE_SYNC_KEY_REQUEST (7 on the wire) naming each key" do
      msg = KeyShare.build_key_request([<<1, 2>>, <<3, 4>>])
      bytes = msg |> Message.encode() |> IO.iodata_to_binary()
      decoded = Message.decode(bytes)

      assert %ProtocolMessage{
               type: :APP_STATE_SYNC_KEY_REQUEST,
               appStateSyncKeyRequest: %{keyIDs: ids}
             } = decoded.protocolMessage

      assert Enum.map(ids, & &1.keyID) == [<<1, 2>>, <<3, 4>>]

      # Go: ProtocolMessage_APP_STATE_SYNC_KEY_REQUEST = 7. `type` is field 2.
      pm = decoded.protocolMessage |> ProtocolMessage.encode() |> IO.iodata_to_binary()
      assert :binary.match(pm, <<0x10, 7>>) != :nomatch
    end

    test "request_keys with nothing to ask is a no-op" do
      assert :noop = KeyShare.request_keys(self(), [])
    end
  end

  describe "handle_share/3 — storing" do
    test "stores key id → data + marshaled fingerprint + timestamp", ctx do
      fp = %AppStateSyncKeyFingerprint{rawID: 7, currentIndex: 2, deviceIndexes: [0, 1]}
      opts = Fake.opts(ctx.server, collections: [])

      assert :ok = KeyShare.handle_share(nil, share([key(@key_id, ctx.key_data, 1234, fp)]), opts)

      assert {:ok, %{data: data, fingerprint: stored_fp, timestamp: 1234}} =
               Memory.get_key(@me, @key_id)

      assert data == ctx.key_data
      assert AppStateSyncKeyFingerprint.decode(stored_fp) == fp
    end

    test "a key with no fingerprint stores an empty one (Go marshals nil to nothing)", ctx do
      KeyShare.handle_share(
        nil,
        share([key(@key_id, ctx.key_data, 1)]),
        Fake.opts(ctx.server, collections: [])
      )

      assert {:ok, %{fingerprint: <<>>}} = Memory.get_key(@me, @key_id)
    end

    test "keys with no id or no data are skipped; the valid one beside them is stored", ctx do
      keys = [
        key(<<>>, <<1>>, 99),
        key(<<5>>, <<>>, 99),
        key(nil, <<1>>, 99),
        key(@key_id, ctx.key_data, 1)
      ]

      KeyShare.handle_share(nil, share(keys), Fake.opts(ctx.server, collections: []))

      assert :not_found = Memory.get_key(@me, <<>>)
      assert :not_found = Memory.get_key(@me, <<5>>)
      assert {:ok, %{timestamp: 1}} = Memory.get_key(@me, @key_id)

      assert {:ok, @key_id} = Memory.latest_key_id(@me),
             "a junk key with a huge timestamp must not become 'latest'"
    end

    test "an older share does not replace a newer key; a newer one does", ctx do
      opts = Fake.opts(ctx.server, collections: [])
      KeyShare.handle_share(nil, share([key(@key_id, ctx.key_data, 100)]), opts)

      KeyShare.handle_share(
        nil,
        share([key(@key_id, "stale-stale-stale-stale-stale-12", 50)]),
        opts
      )

      assert {:ok, %{data: data, timestamp: 100}} = Memory.get_key(@me, @key_id)
      assert data == ctx.key_data

      KeyShare.handle_share(
        nil,
        share([key(@key_id, "fresh-fresh-fresh-fresh-fresh-123", 200)]),
        opts
      )

      assert {:ok, %{timestamp: 200}} = Memory.get_key(@me, @key_id)
    end

    test "no device and no session: an error, not a crash" do
      assert {:error, :no_device} = KeyShare.handle_share(nil, share([key(<<1>>, <<2>>, 3)]))
    end
  end

  describe "handle_share/3 — syncing afterwards" do
    test "a collection we have never synced is fetched", ctx do
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin(@chat, true))

      assert :ok =
               KeyShare.handle_share(
                 nil,
                 share([key(@key_id, ctx.key_data, 1)]),
                 Fake.opts(ctx.server)
               )

      assert {:ok, 1, hash} = Memory.get_version(@me, @name)
      assert hash == Fake.phone_state(ctx.server).hash
    end

    test "one we already have is left alone — a routine re-share is no reason to re-read", ctx do
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin(@chat, true))
      opts = Fake.opts(ctx.server)
      :ok = KeyShare.handle_share(nil, share([key(@key_id, ctx.key_data, 1)]), opts)
      n = length(Fake.iqs(ctx.server))

      :ok = KeyShare.handle_share(nil, share([key(@key_id, ctx.key_data, 2)]), opts)
      assert length(Fake.iqs(ctx.server)) == n
    end

    test "…unless it is the answer to a request we made, which forces a sync", ctx do
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin(@chat, true))
      opts = Fake.opts(ctx.server)
      :ok = KeyShare.handle_share(nil, share([key(@key_id, ctx.key_data, 1)]), opts)
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin("201000000001@s.whatsapp.net", true))
      n = length(Fake.iqs(ctx.server))

      [@key_id] = Coordinator.claim_key_requests(@me, [@key_id])
      :ok = KeyShare.handle_share(nil, share([key(@key_id, ctx.key_data, 3)]), opts)

      assert length(Fake.iqs(ctx.server)) > n
      assert {:ok, 2, _} = Memory.get_version(@me, @name)
    end

    test "a sync that fails is logged and does not fail the share (the keys are stored regardless)",
         ctx do
      boom = fn _ -> {:error, :timeout} end
      opts = Fake.opts(ctx.server, send_iq: boom)

      assert :ok =
               ExUnit.CaptureLog.with_log(fn ->
                 KeyShare.handle_share(nil, share([key(@key_id, ctx.key_data, 1)]), opts)
               end)
               |> elem(0)

      assert {:ok, _} = Memory.get_key(@me, @key_id)
    end
  end

  describe "a device paired before this existed" do
    test "first call asks the phone for the key; once it answers, the next call goes through",
         ctx do
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin(@chat, true))
      opts = Fake.opts(ctx.server)

      # No keys. The first archive finds the snapshot is encrypted under a key we lack.
      assert {:error, {:key_not_found, @key_id}} =
               Sync.send_patch(nil, Patch.build_archive(@chat, true, nil, nil), opts)

      assert_received {:key_request, [@key_id]}
      assert Fake.version(ctx.server) == 1, "nothing was sent"

      # The phone answers with a key share. It syncs the collection as a side effect.
      :ok = KeyShare.handle_share(nil, share([key(@key_id, ctx.key_data, 1)]), opts)

      assert {:ok, state} = Sync.send_patch(nil, Patch.build_archive(@chat, true, nil, nil), opts)
      assert state.version == 2
      assert Fake.phone_errors(ctx.server) == []
    end
  end
end
