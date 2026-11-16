defmodule Whatsmeow.AppState.EncodeDecodeTest do
  @moduledoc """
  Round-trips and the in-patch hash semantics of `Processor`.

  A round-trip alone proves only that our encoder and decoder agree (see
  `GoVectorsTest` for why that is not enough). What these add is coverage of
  Go's `validatePatch` rules for a mutation whose index is mentioned more than once
  — the cases where an off-by-one in "which previous MAC do I subtract" silently
  produces a hash the server's other devices will not reproduce.
  """
  use ExUnit.Case, async: false

  @moduletag :capture_log

  alias Whatsmeow.AppState.{
    Decode,
    Encode,
    Hash,
    Keys,
    LTHash,
    Patch,
    PatchList,
    Processor,
    Recovery
  }

  alias Whatsmeow.AppState.Store.Memory

  alias WAServerSync.{KeyId, SyncdPatch, SyncdVersion}

  @jid "me@s.whatsapp.net"
  @name "regular_low"

  setup do
    start_supervised!(Memory)
    key_data = :crypto.strong_rand_bytes(32)
    key_id = <<1, 2, 3, 4, 5, 6>>
    :ok = Memory.put_key(@jid, key_id, %{data: key_data, fingerprint: <<>>, timestamp: 1})
    %{proc: Processor.new(@jid, store: Memory), keys: Keys.expand(key_data), key_id: key_id}
  end

  describe "Keys.expand/1" do
    test "splits HKDF output into 5 distinct 32-byte keys" do
      keys = Keys.expand(:crypto.strong_rand_bytes(32))
      vals = [keys.index, keys.value_encryption, keys.value_mac, keys.snapshot_mac, keys.patch_mac]
      assert Enum.all?(vals, &(byte_size(&1) == 32))
      assert vals == Enum.uniq(vals)
    end
  end

  describe "round trip through the production path" do
    test "an encoded patch decodes to the mutations that went in", %{proc: proc} do
      patch =
        Patch.build_archive("555@s.whatsapp.net", true, 1_700_000_000, %{
          id: "ABC",
          remote_jid: "555@s.whatsapp.net",
          from_me: true
        })

      assert {:ok, enc} = Processor.encode_patch(proc, patch, %Hash{})

      assert {:ok, muts, state} =
               Processor.decode_patches(proc, list([stamp(enc.bytes, 1)]), %Hash{}, true)

      assert state == enc.state

      assert Enum.map(muts, & &1.index) == [
               ["archive", "555@s.whatsapp.net"],
               ["pin_v1", "555@s.whatsapp.net"]
             ]

      assert [%{archiveChatAction: %{archived: true}}, %{pinAction: %{pinned: false}}] =
               Enum.map(muts, & &1.action)

      assert Enum.map(muts, & &1.version) == [3, 5]
      assert Enum.all?(muts, &(&1.patch_version == 1))
    end

    test "the mutation timestamp is the patch timestamp in milliseconds; the range is seconds", %{
      proc: proc
    } do
      patch = %{
        Patch.build_mark_chat_as_read("555@s.whatsapp.net", true, 1_700_000_000, nil)
        | timestamp_ms: 1_700_000_123_456
      }

      {:ok, enc} = Processor.encode_patch(proc, patch, %Hash{})
      {:ok, [m], _} = Processor.decode_patches(proc, list([stamp(enc.bytes, 1)]), %Hash{}, true)

      assert m.action.timestamp == 1_700_000_123_456
      assert m.action.markChatAsReadAction.messageRange.lastMessageTimestamp == 1_700_000_000
    end

    test "state evolves across a chain and the store tracks every live MAC", %{proc: proc} do
      chat = fn n -> "55#{n}@s.whatsapp.net" end

      final =
        Enum.reduce(1..25, %Hash{}, fn n, state ->
          {:ok, enc} =
            Processor.encode_patch(
              proc,
              Patch.build_archive(chat.(rem(n, 7)), rem(n, 2) == 0, nil, nil),
              state
            )

          {:ok, _, ns} =
            Processor.decode_patches(proc, list([stamp(enc.bytes, state.version + 1)]), state, true)

          assert ns == enc.state
          ns
        end)

      assert final.version == 25
      # seven chats × (archive + pin) at most; every stored MAC is a real 32 bytes
      macs = Memory.dump_macs(@jid, @name)
      assert map_size(macs) <= 14
      assert Enum.all?(Map.values(macs), &(byte_size(&1) == 32))
      assert {:ok, 25, hash} = Memory.get_version(@jid, @name)
      assert hash == final.hash
    end

    test "a bigger patch than we will ever send (200 mutations) still verifies", %{
      keys: keys,
      key_id: key_id,
      proc: proc
    } do
      muts =
        for n <- 1..200,
            do: %Patch.Mutation{
              index: ["pin_v1", "#{n}@s.whatsapp.net"],
              version: 5,
              value: %WAWebProtobufSyncAction.SyncActionValue{
                pinAction: %WAWebProtobufSyncAction.PinAction{pinned: true}
              }
            }

      patch = %Patch{type: @name, mutations: muts, timestamp_ms: 1}
      {:ok, enc} = Encode.encode_patch(patch, key_id, keys, %Hash{}, fn _, _ -> nil end)

      assert {:ok, decoded, _} =
               Processor.decode_patches(proc, list([stamp(enc.bytes, 1)]), %Hash{}, true)

      assert length(decoded) == 200
    end
  end

  describe "Go's validatePatch rules for repeated and removed indexes" do
    # Build a patch with arbitrary operations. Deliberately independent of
    # `Encode.encode_patch` (which only emits SETs): it uses only the primitive
    # MAC functions, in the order Go does.
    defp build(ctx, ops, state) do
      %{keys: keys, key_id: key_id} = ctx

      mutations =
        for {op, chat, ver} <- ops do
          index = ["archive", chat]

          m =
            Encode.encode_mutation(
              %Patch.Mutation{
                index: index,
                version: ver,
                value: %WAWebProtobufSyncAction.SyncActionValue{
                  archiveChatAction: %WAWebProtobufSyncAction.ArchiveChatAction{archived: true}
                }
              },
              1,
              key_id,
              keys,
              fn -> :crypto.strong_rand_bytes(16) end
            )

          if op == :remove do
            iv_ct = binary_part(m.record.value.blob, 0, byte_size(m.record.value.blob) - 32)
            mac = Hash.content_mac(:remove, iv_ct, key_id, keys.value_mac)

            %{
              m
              | operation: :REMOVE,
                record: %{m.record | value: %{m.record.value | blob: iv_ct <> mac}}
            }
          else
            m
          end
        end

      inputs =
        for m <- mutations,
            do: %{
              operation: Decode.operation(m.operation),
              value_mac: tail(m),
              index_mac: m.record.index.blob
            }

      # The reference model: walk the mutations keeping a map of live index → value MAC.
      {added, removed, _live} =
        Enum.reduce(inputs, {[], [], ctx[:live] || %{}}, fn m, {add, rem, live} ->
          prev = Map.get(live, m.index_mac)
          rem = if prev, do: [prev | rem], else: rem
          add = if m.operation == :set, do: [m.value_mac | add], else: add

          live =
            if m.operation == :set,
              do: Map.put(live, m.index_mac, m.value_mac),
              else: Map.delete(live, m.index_mac)

          {add, rem, live}
        end)

      new_state = %{
        state
        | version: state.version + 1,
          hash: LTHash.subtract_then_add(state.hash, Enum.reverse(removed), Enum.reverse(added))
      }

      snap = Hash.snapshot_mac(new_state, @name, keys.snapshot_mac)

      patch_mac =
        Hash.patch_mac(
          snap,
          Enum.map(inputs, & &1.value_mac),
          new_state.version,
          @name,
          keys.patch_mac
        )

      %SyncdPatch{
        snapshotMAC: snap,
        keyID: %KeyId{ID: key_id},
        mutations: mutations,
        patchMAC: patch_mac,
        version: %SyncdVersion{version: new_state.version}
      }
    end

    defp tail(m), do: binary_part(m.record.value.blob, byte_size(m.record.value.blob) - 32, 32)

    defp decode(proc, patch, state),
      do: Processor.decode_patches(proc, %PatchList{name: @name, patches: [patch]}, state, true)

    test "SET then REMOVE of the same index in one patch nets to nothing", ctx do
      patch = build(ctx, [{:set, "a@s.whatsapp.net", 3}, {:remove, "a@s.whatsapp.net", 3}], %Hash{})

      assert {:ok, [set, remove], state} = decode(ctx.proc, patch, %Hash{})
      assert {set.operation, remove.operation} == {:set, :remove}

      assert state.hash == <<0::1024>>,
             "an index set and removed in the same patch leaves no trace in the LTHash"

      assert map_size(Memory.dump_macs(@jid, @name)) == 0
    end

    test "REMOVE then SET of the same index replaces the stored value once", ctx do
      first = build(ctx, [{:set, "a@s.whatsapp.net", 3}], %Hash{})
      {:ok, _, s1} = decode(ctx.proc, first, %Hash{})
      [old] = Map.values(Memory.dump_macs(@jid, @name))

      second =
        build(
          Map.put(ctx, :live, live_of(first)),
          [{:remove, "a@s.whatsapp.net", 3}, {:set, "a@s.whatsapp.net", 3}],
          s1
        )

      assert {:ok, _, s2} = decode(ctx.proc, second, s1)

      [new] = Map.values(Memory.dump_macs(@jid, @name))
      refute new == old
      assert s2.hash == LTHash.subtract_then_add(s1.hash, [old], [new])
    end

    test "two SETs of the same index in one patch: the second replaces the first", ctx do
      patch = build(ctx, [{:set, "a@s.whatsapp.net", 3}, {:set, "a@s.whatsapp.net", 3}], %Hash{})
      assert {:ok, [m1, m2], state} = decode(ctx.proc, patch, %Hash{})

      assert state.hash == LTHash.subtract_then_add(<<0::1024>>, [], [m2.value_mac]),
             "only the last SET of an index contributes to the hash (#{inspect(m1.value_mac == m2.value_mac)})"

      assert Memory.dump_macs(@jid, @name) == %{m2.index_mac => m2.value_mac}
    end

    test "REMOVE with no previous SET is a warning, not an error, and changes nothing", ctx do
      patch = build(ctx, [{:remove, "ghost@s.whatsapp.net", 3}], %Hash{})
      assert {:ok, [m], state} = decode(ctx.proc, patch, %Hash{})
      assert m.operation == :remove
      assert state.hash == <<0::1024>>
      assert state.version == 1
    end

    # What the model above assumed, made explicit: the store is the source of truth
    # for "previous", and a SET in the patch overrides it.
    defp live_of(%SyncdPatch{mutations: ms}) do
      Map.new(ms, fn m ->
        {m.record.index.blob,
         binary_part(m.record.value.blob, byte_size(m.record.value.blob) - 32, 32)}
      end)
    end
  end

  describe "Decode.safe_equal?/2" do
    test "unequal lengths are false rather than raising (a server-supplied MAC can be any length)" do
      refute Decode.safe_equal?(<<1, 2, 3>>, <<1, 2>>)
      refute Decode.safe_equal?(<<>>, <<1>>)
      assert Decode.safe_equal?(<<1, 2, 3>>, <<1, 2, 3>>)
    end

    test "a snapshot MAC of the wrong length is a mismatch, not a crash" do
      assert {:error, {:mismatching_lthash, 0}} =
               Decode.verify_snapshot_mac(%Hash{}, @name, :crypto.strong_rand_bytes(32), <<1, 2>>)
    end
  end

  describe "Hash.update/3" do
    test "REMOVE without a prior SET emits a warning" do
      m = %{operation: :remove, value_mac: <<0::256>>, index_mac: <<1::256>>}

      assert {:ok, _state, [{:missing_previous_set_value, _}]} =
               Hash.update(Hash.new(), [m], fn _, _ -> nil end)
    end

    test "SET-only patch produces no warnings" do
      m = %{operation: :set, value_mac: :crypto.strong_rand_bytes(32), index_mac: <<2::256>>}
      assert {:ok, _state, []} = Hash.update(Hash.new(), [m], fn _, _ -> nil end)
    end

    test "a failing lookup aborts the update (Go: failed to get value MAC of previous SET)" do
      m = %{operation: :set, value_mac: :crypto.strong_rand_bytes(32), index_mac: <<2::256>>}

      assert {:error, {:prev_set_value_mac, :db_down}} =
               Hash.update(Hash.new(), [m], fn _, _ -> {:error, :db_down} end)
    end
  end

  describe "Recovery" do
    test "decompress identity when not compressed" do
      assert {:ok, "hello"} = Recovery.decompress("hello", false)
    end

    test "decompress unwraps gzip when compressed" do
      raw = "the lazy dog jumps over"
      assert {:ok, ^raw} = Recovery.decompress(:zlib.gzip(raw), true)
    end

    test "process rejects an invalid lthash length" do
      assert {:error, {:invalid_lthash_length, 8}} =
               Recovery.process(
                 %{
                   collection_lthash: <<0::64>>,
                   version: 1,
                   mutation_records: [],
                   collection_name: "x"
                 },
                 fn _ -> {:error, :key_not_found} end
               )
    end

    test "process computes index MACs for each record", %{keys: keys, key_id: key_id} do
      lthash = :crypto.strong_rand_bytes(128)

      records = [
        %{
          key_id: key_id,
          index_json: ~s(["pin_v1","x"]),
          mac: :crypto.strong_rand_bytes(32),
          value: %{}
        }
      ]

      recovery = %{
        collection_name: @name,
        collection_lthash: lthash,
        version: 7,
        mutation_records: records
      }

      assert {:ok, %{lthash: ^lthash, version: 7, mutations: [out]}} =
               Recovery.process(recovery, fn ^key_id -> {:ok, keys} end)

      assert out.index_mac == Hash.index_mac(~s(["pin_v1","x"]), keys.index)
      assert out.value_mac == hd(records).mac
    end
  end

  # --- helpers ----------------------------------------------------------------

  defp stamp(bytes, version) do
    %{SyncdPatch.decode(bytes) | version: %SyncdVersion{version: version}}
  end

  defp list(patches), do: %PatchList{name: @name, patches: patches}
end
