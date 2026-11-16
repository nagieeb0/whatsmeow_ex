defmodule Whatsmeow.AppStateTest do
  @moduledoc """
  The fetch / apply / send loop against `Whatsmeow.AppStateFake`, a server
  that only accepts a patch another device would verify.
  """
  use ExUnit.Case, async: true

  alias WAWebProtobufSyncAction, as: SA
  alias Whatsmeow.AppState
  alias Whatsmeow.AppState.{Decode, Encode, Hash, Keys, KeyStore, Patch, Processor}
  alias Whatsmeow.AppState.Store.Memory
  alias Whatsmeow.AppState.Sync.PatchList
  alias Whatsmeow.AppStateFake, as: Fake

  @digits "1234567890"
  @chat "1234567890@s.whatsapp.net"
  @other "1098765432@s.whatsapp.net"

  setup do
    jid = "#{System.unique_integer([:positive])}.0:1@s.whatsapp.net"
    fake = Fake.start()
    ctx = Fake.context(fake, jid, Memory)
    %{jid: jid, fake: fake, ctx: ctx}
  end

  defp share_key(%{jid: jid, fake: fake}) do
    {:ok, [_]} = KeyStore.put_key_share(jid, Fake.key_share(fake), store: Memory)
    :ok
  end

  defp pin(jid, pinned?),
    do: {:set, ["pin_v1", jid], %SA.SyncActionValue{pinAction: %SA.PinAction{pinned: pinned?}}, 5}

  defp mute(jid),
    do: {:set, ["mute", jid], %SA.SyncActionValue{muteAction: %SA.MuteAction{muted: true}}, 2}

  # What the phone already has: our chat pinned, another chat pinned then
  # unpinned and removed, a mute — some in a snapshot, some after it, one
  # patch as an external blob.
  defp seed_account(fake) do
    Fake.phone_write(fake, "regular_low", [pin(@chat, true), pin(@other, true)])
    Fake.phone_write(fake, "regular_low", [mute(@other)])
    Fake.take_snapshot(fake, "regular_low")
    Fake.phone_write(fake, "regular_low", [{:remove, ["pin_v1", @other], 5}])
    Fake.phone_write(fake, "regular_low", [mute(@chat)], external?: true)
  end

  defp sent(fake), do: Fake.get(fake).sends

  defp decrypt_sent(fake, patch) do
    keys = Keys.expand(Fake.get(fake).key_data)

    Enum.map(patch.mutations, fn m ->
      {:ok, %{plaintext: plain}} =
        Decode.decode_mutation(
          %{
            operation: :set,
            value_blob: m.record.value.blob,
            index_mac: m.record.index.blob,
            key_id: m.record.keyID."ID"
          },
          keys,
          true
        )

      data = SA.SyncActionData.decode(plain)
      {Jason.decode!(data.index), data.version, data.value}
    end)
  end

  describe "archive_chat/3" do
    setup [:share_key]

    test "syncs from a snapshot, sends a patch other devices verify, re-syncs", %{
      fake: fake,
      ctx: ctx,
      jid: jid
    } do
      seed_account(fake)

      assert :ok = AppState.archive_chat(ctx, @digits, true)

      assert [{:accepted, patch}] = sent(fake)

      assert [
               {["archive", @chat], 3,
                %SA.SyncActionValue{archiveChatAction: %SA.ArchiveChatAction{archived: true} = a} =
                  v1},
               {["pin_v1", @chat], 5,
                %SA.SyncActionValue{pinAction: %SA.PinAction{pinned: false}} = v2}
             ] = decrypt_sent(fake, patch)

      assert is_integer(a.messageRange.lastMessageTimestamp)
      assert v1.timestamp == v2.timestamp

      # Our stored state is the server's head, including our own patch.
      head = Fake.head(fake, "regular_low")
      assert {:ok, ^head} = Memory.get_version(jid, "regular_low")
      assert head.version == 5
    end

    test "then mark_chat_as_read/3", %{fake: fake, ctx: ctx} do
      seed_account(fake)
      assert :ok = AppState.archive_chat(ctx, @digits, true)
      assert :ok = AppState.mark_chat_as_read(ctx, @digits, true)

      assert [{:accepted, _}, {:accepted, patch}] = sent(fake)

      assert [
               {["markChatAsRead", @chat], 3,
                %SA.SyncActionValue{markChatAsReadAction: %SA.MarkChatAsReadAction{read: true}}}
             ] =
               decrypt_sent(fake, patch)
    end

    test "unarchive is one mutation", %{fake: fake, ctx: ctx} do
      seed_account(fake)
      assert :ok = AppState.archive_chat(ctx, @digits, false)
      assert [{:accepted, patch}] = sent(fake)

      assert [{["archive", @chat], 3, %{archiveChatAction: %{archived: false}}}] =
               decrypt_sent(fake, patch)
    end

    test "works on a fresh collection with no snapshot", %{fake: fake, ctx: ctx} do
      assert :ok = AppState.archive_chat(ctx, @digits, true)
      assert [{:accepted, _}] = sent(fake)
    end

    test "follows has_more_patches across pages", %{ctx: ctx} = c do
      fake =
        Fake.start(key_data: Fake.get(c.fake).key_data, key_id: Fake.key_id(c.fake), page_size: 1)

      ctx = %{
        ctx
        | iq: Fake.context(fake, ctx.jid, Memory).iq,
          download: Fake.context(fake, ctx.jid, Memory).download
      }

      Fake.phone_write(fake, "regular_low", [pin(@chat, true)])
      Fake.take_snapshot(fake, "regular_low")
      for _ <- 1..3, do: Fake.phone_write(fake, "regular_low", [mute(@other)])

      assert :ok = AppState.archive_chat(ctx, @digits, true)
      assert [{:accepted, _}] = sent(fake)
      assert {:ok, %Hash{version: 5}} = Memory.get_version(ctx.jid, "regular_low")
    end

    test "rejects anything that is not digits", %{ctx: ctx, fake: fake} do
      for bad <- ["", "12ab5678", "+201012345678", "1234", "1234567890@s.whatsapp.net"] do
        assert {:error, :invalid_phone} = AppState.archive_chat(ctx, bad, true)
      end

      assert Fake.get(fake).iqs == []
    end
  end

  describe "409 conflict" do
    setup [:share_key]

    test "applies the server's patches and retries once", %{fake: fake, ctx: ctx, jid: jid} do
      seed_account(fake)
      Fake.race_next_send(fake, "regular_low", [mute(@other)])

      assert :ok = AppState.archive_chat(ctx, @digits, true)

      assert [{:conflict, _}, {:accepted, patch}] = sent(fake)
      assert [{["archive", @chat], _, _}, {["pin_v1", @chat], _, _}] = decrypt_sent(fake, patch)

      head = Fake.head(fake, "regular_low")
      assert {:ok, ^head} = Memory.get_version(jid, "regular_low")
    end

    test "a second conflict is an error, not a loop", %{fake: fake, ctx: ctx} do
      seed_account(fake)

      # Race the first send, and the retry too.
      ctx = %{
        ctx
        | iq: fn node ->
            if match?([%{content: [%{content: [%{tag: "patch"}]}]}], node.content) do
              Fake.race_next_send(fake, "regular_low", [mute(@other)])
            end

            ctx.iq.(node)
          end
      }

      assert {:error, {:app_state_update_failed, "regular_low", "409", _}} =
               AppState.archive_chat(ctx, @digits, true)

      assert [{:conflict, _}, {:conflict, _}] = sent(fake)
    end
  end

  describe "refusals" do
    test "no key for the collection: nothing is sent and the key is requested once", %{
      fake: fake,
      ctx: ctx
    } do
      seed_account(fake)
      key_id = Fake.key_id(fake)

      assert {:error, {:not_synced, {:key_not_found, ^key_id}}} =
               AppState.archive_chat(ctx, @digits, true)

      assert_received {:key_request, [^key_id]}

      # Within the day Go waits before asking again: no second request.
      assert {:error, {:not_synced, {:key_not_found, ^key_id}}} =
               AppState.archive_chat(ctx, @digits, true)

      refute_received {:key_request, _}

      assert sent(fake) == []
      assert {:ok, %Hash{version: 0}} = Memory.get_version(ctx.jid, "regular_low")
    end

    test "no key at all, on an empty collection: refused", %{fake: fake, ctx: ctx} do
      assert {:error, :no_app_state_keys} = AppState.archive_chat(ctx, @digits, true)
      assert sent(fake) == []
    end

    test "a patch whose snapshot MAC does not verify: refused, nothing stored",
         %{fake: fake, ctx: ctx} = c do
      share_key(c)
      Fake.phone_write(fake, "regular_low", [pin(@chat, true)])
      Fake.phone_write(fake, "regular_low", [mute(@other)])
      Fake.tamper_last_patch(fake, "regular_low", :snapshotMAC)

      assert {:error, {:not_synced, :mismatching_lthash}} =
               AppState.archive_chat(ctx, @digits, true)

      assert sent(fake) == []
      # The first patch verified and was kept, as in Go; the bad one was not.
      assert {:ok, %Hash{version: 1}} = Memory.get_version(ctx.jid, "regular_low")
    end

    test "a patch whose patch MAC does not verify: refused", %{fake: fake, ctx: ctx} = c do
      share_key(c)
      Fake.phone_write(fake, "regular_low", [pin(@chat, true)])
      Fake.tamper_last_patch(fake, "regular_low", :patchMAC)

      assert {:error, {:not_synced, :mismatching_patch_mac}} =
               AppState.archive_chat(ctx, @digits, true)

      assert sent(fake) == []
      assert {:ok, %Hash{version: 0}} = Memory.get_version(ctx.jid, "regular_low")
    end

    test "unknown collection", %{ctx: ctx} do
      assert {:error, {:unknown_collection, "nope"}} =
               AppState.send_patch(ctx, %Patch{type: "nope", mutations: []})
    end
  end

  describe "handle_key_share/3" do
    test "stores the key and syncs every collection", %{fake: fake, ctx: ctx, jid: jid} do
      Fake.phone_write(fake, "regular_high", [mute(@chat)])
      assert :ok = AppState.handle_key_share(ctx, Fake.key_share(fake))

      names = Enum.map(Fake.get(fake).iqs, fn iq -> hd(hd(iq.content).content).attrs["name"] end)
      assert Enum.sort(names) == Enum.sort(Keys.all_patch_names())
      assert {:ok, %Hash{version: 1}} = Memory.get_version(jid, "regular_high")

      # Synced collections are not fetched again on the next share.
      assert :ok = AppState.handle_key_share(ctx, Fake.key_share(fake, 2))
      names2 = Enum.map(Fake.get(fake).iqs, fn iq -> hd(hd(iq.content).content).attrs["name"] end)
      refute "regular_high" in Enum.drop(names2, length(names))
    end

    test "the requested key arriving re-syncs and unblocks the send", %{fake: fake, ctx: ctx} do
      seed_account(fake)
      assert {:error, {:not_synced, _}} = AppState.archive_chat(ctx, @digits, true)
      assert :ok = AppState.handle_key_share(ctx, Fake.key_share(fake))
      assert :ok = AppState.archive_chat(ctx, @digits, true)
    end
  end

  describe "KeyStore (memory)" do
    test "stores a share, keeps the newer key, answers latest_key_id", %{jid: jid} do
      share = fn id, data, ts ->
        %WAWebProtobufsE2E.AppStateSyncKeyShare{
          keys: [
            %WAWebProtobufsE2E.AppStateSyncKey{
              keyID: %WAWebProtobufsE2E.AppStateSyncKeyId{keyID: id},
              keyData: %WAWebProtobufsE2E.AppStateSyncKeyData{keyData: data, timestamp: ts}
            }
          ]
        }
      end

      assert {:error, :no_keys} = KeyStore.latest_key_id(jid, store: Memory)
      assert {:ok, ["a"]} = KeyStore.put_key_share(jid, share.("a", "old", 10), store: Memory)
      assert {:ok, ["b"]} = KeyStore.put_key_share(jid, share.("b", "kb", 20), store: Memory)
      assert {:ok, ["a"]} = KeyStore.put_key_share(jid, share.("a", "stale", 5), store: Memory)

      assert {:ok, %{key_data: "old", timestamp: 10, fingerprint: ""}} =
               KeyStore.get_key(jid, "a", store: Memory)

      assert {:ok, "b"} = KeyStore.latest_key_id(jid, store: Memory)
      assert {:error, :key_not_found} = KeyStore.get_key(jid, "zz", store: Memory)
      assert {:error, :key_not_found} = KeyStore.get_key("someone-else", "a", store: Memory)
    end

    test "the fingerprint is stored marshalled", %{jid: jid, fake: fake} do
      {:ok, [id]} = KeyStore.put_key_share(jid, Fake.key_share(fake), store: Memory)
      {:ok, %{fingerprint: fp}} = KeyStore.get_key(jid, id, store: Memory)

      assert WAWebProtobufsE2E.AppStateSyncKeyFingerprint.decode(fp) ==
               %WAWebProtobufsE2E.AppStateSyncKeyFingerprint{rawID: 7, currentIndex: 1}
    end
  end

  defp no_prev(_index_mac, _i), do: nil

  describe "encode then decode" do
    test "a patch we encode verifies with the same keys, and the state matches", %{jid: jid} do
      key_data = :crypto.strong_rand_bytes(32)
      key_id = :crypto.strong_rand_bytes(6)
      :ok = Memory.put_sync_key(jid, key_id, %{key_data: key_data, fingerprint: "", timestamp: 1})
      keys = Keys.expand(key_data)

      {:ok, %{patch: bytes, state: encoded_state}} =
        Encode.encode_syncd_patch(
          Patch.build_archive(@chat, true),
          keys,
          key_id,
          Hash.new(),
          &no_prev/2
        )

      patch = WAServerSync.SyncdPatch.decode(bytes)
      patch = %{patch | version: %WAServerSync.SyncdVersion{version: 1}}
      list = %PatchList{name: "regular_low", patches: [patch], has_more_patches?: false}

      assert {:ok, [m1, m2], state} =
               Processor.decode_patches(%{jid: jid, store: Memory}, list, Hash.new())

      assert state == encoded_state
      assert m1.index == ["archive", @chat] and m1.action.archiveChatAction.archived
      assert m2.index == ["pin_v1", @chat] and m2.action.pinAction.pinned == false

      # Stored: the value MACs are what a later patch on these indexes subtracts.
      assert {:ok, mac} = Memory.get_mutation_mac(jid, "regular_low", m1.index_mac)
      assert mac == m1.value_mac
    end

    test "a flipped ciphertext byte fails the content MAC", %{jid: jid} do
      key_data = :crypto.strong_rand_bytes(32)
      key_id = :crypto.strong_rand_bytes(6)
      :ok = Memory.put_sync_key(jid, key_id, %{key_data: key_data, fingerprint: "", timestamp: 1})

      {:ok, %{patch: bytes}} =
        Encode.encode_syncd_patch(
          Patch.build_pin(@chat, true),
          Keys.expand(key_data),
          key_id,
          Hash.new(),
          fn _, _ -> nil end
        )

      patch = WAServerSync.SyncdPatch.decode(bytes)
      [m] = patch.mutations
      <<iv::binary-16, b, rest::binary>> = m.record.value.blob
      m = put_in(m.record.value.blob, <<iv::binary, Bitwise.bxor(b, 1), rest::binary>>)

      # The patch MAC covers value MACs, not ciphertext: verify with validation
      # of the patch and snapshot MACs passing, so the content MAC is what fails.
      # (A server never sends this; a corrupted blob must still be refused.)
      list = %PatchList{
        name: "regular_low",
        patches: [%{patch | mutations: [m], version: %WAServerSync.SyncdVersion{version: 1}}]
      }

      assert {:error, {:mismatching_content_mac, {:mutation, 1}}} =
               Processor.decode_patches(%{jid: jid, store: Memory}, list, Hash.new())
    end
  end
end
