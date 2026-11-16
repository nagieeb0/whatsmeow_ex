defmodule Whatsmeow.AppState.GoVectorsTest do
  @moduledoc """
  Byte-for-byte agreement with the Go reference.

  `fixtures/go_vectors.json` is the output of `scripts/app_state_vectors`,
  which runs the vendored whatsmeow's own `Processor.EncodePatch` and
  `DecodePatches` on fixed, made-up keys. Go draws a random IV per mutation,
  but the IV is the first 16 bytes of each value blob, so it is read back and
  injected here — after which every byte of the patch is determined, and ours
  must equal Go's.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.AppState.{Encode, Hash, Keys, Patch}

  @fixture Path.join(__DIR__, "fixtures/go_vectors.json")
  @external_resource @fixture
  @data @fixture |> File.read!() |> Jason.decode!()

  @target "1234567890@s.whatsapp.net"
  @last_msg 1_699_999_999

  defp hex!(s), do: Base.decode16!(s, case: :lower)

  defp keys, do: Keys.expand(hex!(@data["key_data"]))
  defp key_id, do: hex!(@data["key_id"])

  defp prev_fun do
    pin_index_mac = hex!(@data["pin_index_mac"])
    prev = hex!(@data["prev_pin_value_mac"])
    fn index_mac, _i -> if index_mac == pin_index_mac, do: prev, else: nil end
  end

  defp patch_for("archive"), do: Patch.build_archive(@target, true, @last_msg, nil)
  defp patch_for("unarchive"), do: Patch.build_archive(@target, false, @last_msg, nil)

  defp patch_for("mark_read") do
    Patch.build_mark_chat_as_read(@target, true, @last_msg, %WACommon.MessageKey{
      remoteJID: @target,
      fromMe: false,
      ID: "3EB0000000000000000000"
    })
  end

  for vector <- @data["vectors"] do
    @vector vector

    test "#{vector["name"]}: our encoded patch equals Go's, byte for byte" do
      v = @vector
      go_bytes = hex!(v["patch"])
      go_patch = WAServerSync.SyncdPatch.decode(go_bytes)

      ivs = Enum.map(go_patch.mutations, fn m -> binary_part(m.record.value.blob, 0, 16) end)
      state = %Hash{version: v["prev_version"], hash: hex!(v["prev_hash"])}
      patch = %{patch_for(v["name"]) | timestamp: v["timestamp_ms"]}

      assert {:ok, %{patch: ours, state: new_state}} =
               Encode.encode_syncd_patch(patch, keys(), key_id(), state, prev_fun(), ivs: ivs)

      assert Base.encode16(ours, case: :lower) == v["patch"]

      # And the state it leads to is the one Go's DecodePatches verified.
      assert new_state.version == v["new_version"]
      assert Base.encode16(new_state.hash, case: :lower) == v["new_hash"]
    end
  end

  test "Go's JSON index encoding" do
    assert Patch.index_json(["archive", @target]) == ~s(["archive","#{@target}"])
    assert Patch.index_json(["a<b>&c"]) == ~S(["a\u003cb\u003e\u0026c"])
    assert Patch.index_json([<<"q\"\\/\n", 1>>]) == ~S(["q\"\\/\n\u0001"])
    assert Patch.index_json([<<0x2028::utf8, "é">>]) == ~S(["\u2028é"])
    assert Patch.index_json([<<0xFF>>]) == ~S(["\ufffd"])
  end
end
