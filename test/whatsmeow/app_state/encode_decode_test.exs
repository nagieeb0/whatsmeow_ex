defmodule Whatsmeow.AppState.EncodeDecodeTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.AppState.{Decode, Encode, Hash, Keys, Recovery}

  describe "Keys.expand/1" do
    test "splits HKDF output into 5 × 32-byte keys" do
      keys = Keys.expand(:crypto.strong_rand_bytes(32))

      for k <- [:index, :value_encryption, :value_mac, :snapshot_mac, :patch_mac] do
        assert byte_size(keys[k]) == 32
      end

      # All five sub-keys must be distinct.
      vals = [keys.index, keys.value_encryption, keys.value_mac, keys.snapshot_mac, keys.patch_mac]
      assert vals == Enum.uniq(vals)
    end

    test "expansion is deterministic" do
      seed = :crypto.strong_rand_bytes(32)
      assert Keys.expand(seed) == Keys.expand(seed)
    end
  end

  describe "Hash + Encode + Decode round-trip" do
    setup do
      key_data = :crypto.strong_rand_bytes(32)
      keys = Keys.expand(key_data)
      %{keys: keys, key_id: :crypto.strong_rand_bytes(6)}
    end

    test "encode → decode plaintext survives the round-trip", %{keys: keys, key_id: key_id} do
      input = %{
        index_json: ~s(["pin_v1","555@s.whatsapp.net"]),
        content: "hello, world — protobuf bytes go here",
        operation: :set
      }

      encoded = Encode.encode_mutation(input, keys, key_id)
      assert byte_size(encoded.index_mac) == 32
      assert byte_size(encoded.value_mac) == 32

      to_decode = %{
        operation: encoded.operation,
        value_blob: encoded.value_blob,
        index_mac: encoded.index_mac,
        key_id: encoded.key_id
      }

      assert {:ok, decoded} = Decode.decode_mutation(to_decode, keys, true)
      assert decoded.plaintext == input.content
      assert decoded.value_mac == encoded.value_mac
      assert decoded.operation == :set

      assert :ok = Decode.verify_index_mac(input.index_json, decoded.index_mac, keys)
    end

    test "tampered ciphertext is rejected", %{keys: keys, key_id: key_id} do
      input = %{index_json: ~s(["x"]), content: "secret", operation: :set}
      encoded = Encode.encode_mutation(input, keys, key_id)

      <<head::binary-size(20), _byte, tail::binary>> = encoded.value_blob
      bad = head <> <<0xFF>> <> tail

      assert {:error, :mismatching_content_mac} =
               Decode.decode_mutation(
                 %{
                   operation: :set,
                   value_blob: bad,
                   index_mac: encoded.index_mac,
                   key_id: key_id
                 },
                 keys,
                 true
               )
    end

    test "encode_patch produces snapshot+patch MACs that verify", %{keys: keys, key_id: key_id} do
      mutations = [
        %{index_json: ~s(["a"]), content: "v1", operation: :set},
        %{index_json: ~s(["b"]), content: "v2", operation: :set}
      ]

      result =
        Encode.encode_patch(mutations, keys, key_id, Hash.new(), "regular_low", fn _, _ -> nil end)

      assert result.state.version == 1
      assert byte_size(result.snapshot_mac) == 32
      assert byte_size(result.patch_mac) == 32

      # The snapshot MAC verifies against the new state.
      assert :ok =
               Decode.verify_snapshot_mac(
                 result.state,
                 "regular_low",
                 keys.snapshot_mac,
                 result.snapshot_mac
               )

      # The patch MAC verifies given the same set of value MACs.
      value_macs = Enum.map(result.mutations, & &1.value_mac)

      assert :ok =
               Decode.verify_patch_mac(
                 result.snapshot_mac,
                 value_macs,
                 result.state.version,
                 "regular_low",
                 keys.patch_mac,
                 result.patch_mac
               )
    end
  end

  describe "Recovery" do
    test "decompress identity when not compressed" do
      assert {:ok, "hello"} = Recovery.decompress("hello", false)
    end

    test "decompress unwraps gzip when compressed" do
      raw = "the lazy dog jumps over"
      compressed = :zlib.gzip(raw)
      assert {:ok, ^raw} = Recovery.decompress(compressed, true)
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

    test "process computes index MACs for each record" do
      key_data = :crypto.strong_rand_bytes(32)
      keys = Keys.expand(key_data)
      key_id = :crypto.strong_rand_bytes(6)
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
        collection_name: "regular_low",
        collection_lthash: lthash,
        version: 7,
        mutation_records: records
      }

      assert {:ok, %{lthash: ^lthash, version: 7, mutations: [out]}} =
               Recovery.process(recovery, fn ^key_id -> {:ok, keys} end)

      expected = Hash.index_mac(~s(["pin_v1","x"]), keys.index)
      assert out.index_mac == expected
      assert out.value_mac == hd(records).mac
    end
  end

  describe "Hash.update missing-prev warnings" do
    test "REMOVE without a prior SET emits a warning" do
      m = %{operation: :remove, value_mac: <<0::256>>, index_mac: <<1::256>>}
      {:ok, _state, warnings} = Hash.update(Hash.new(), [m], fn _, _ -> nil end)
      assert [{:missing_previous_set_value, _}] = warnings
    end

    test "SET-only patch produces no warnings" do
      m = %{operation: :set, value_mac: :crypto.strong_rand_bytes(32), index_mac: <<2::256>>}
      {:ok, _state, []} = Hash.update(Hash.new(), [m], fn _, _ -> nil end)
    end
  end
end
