defmodule Whatsmeow.AppState.GoInteropTest do
  @moduledoc """
  Patches built by *this library's production encode path* are decoded and
  MAC-verified by **Go whatsmeow's real `appstate.DecodePatches`**.

  This is the check that matters for the failure mode this feature has: the
  server cannot validate a patch, so a wrong MAC is only discovered by the phone.
  Go's decoder is the closest thing to the phone we can run.

  Opt-in — it builds a small Go program (needs `go` and module-download network):

      mix test --include go_interop

  The program is `scripts/app_state_vectors`; its `appstate` package is a verbatim
  copy of `whatsmeow-main/appstate`, and `verify` mode adds no MAC logic of its own.
  """
  use ExUnit.Case, async: false

  import Whatsmeow.Test.AppStateVectors

  alias Whatsmeow.AppState.{Hash, Patch, PatchList, Processor}
  alias Whatsmeow.AppState.Store.Memory

  @moduletag :go_interop
  @moduletag timeout: 300_000

  @jid "me@s.whatsapp.net"
  @name "regular_low"
  @target "201141465543@s.whatsapp.net"
  @group "120363025246125486@g.us"

  setup_all do
    go = System.find_executable("go") || flunk("go_interop tests need `go` on PATH")
    out = Path.join(System.tmp_dir!(), "wa_govec_#{System.unique_integer([:positive])}")
    script = Path.expand("../../../scripts/app_state_vectors/run.sh", __DIR__)

    {output, status} =
      System.cmd("bash", [script, "build", out],
        env: [{"PATH", Path.dirname(go) <> ":" <> System.get_env("PATH")}],
        stderr_to_stdout: true
      )

    assert status == 0, "building the Go verifier failed:\n#{output}"
    on_exit(fn -> File.rm_rf(out) end)

    {:ok, _} = start_supervised(Memory)
    %{govec: Path.join(out, "govec"), v: load()}
  end

  setup %{v: v} do
    Memory.reset()
    key_id = d(v["key_id"])
    :ok = Memory.put_key(@jid, key_id, %{data: d(v["key_data"]), fingerprint: <<>>, timestamp: 1})
    %{proc: Processor.new(@jid, store: Memory), key_id: key_id}
  end

  # Ask Go to verify `bytes` as patch `version` on top of `state` + stored MACs.
  defp go_verify(govec, v, key_id, state, bytes, version) do
    macs = for {im, vm} <- Memory.dump_macs(@jid, @name), do: %{index_mac: e(im), value_mac: e(vm)}

    input =
      Jason.encode!(%{
        key_id: e(key_id),
        key_data: v["key_data"],
        patch_name: @name,
        state_version: state.version,
        state_hash: e(state.hash),
        prior_macs: macs,
        patch: e(bytes),
        patch_version: version
      })

    {out, 0} = run_verify(govec, input)
    Jason.decode!(out)
  end

  # The tool reads its request from stdin to EOF; feed it from a file.
  defp run_verify(govec, input) do
    f = Path.join(System.tmp_dir!(), "wa_govec_in_#{System.unique_integer([:positive])}.json")
    File.write!(f, input)

    try do
      System.cmd("sh", ["-c", "\"$0\" verify < \"$1\"", govec, f])
    after
      File.rm(f)
    end
  end

  # Advance our own store/state exactly as `Sync` would after the server accepts.
  defp commit(proc, state, enc, version) do
    patch = %{
      WAServerSync.SyncdPatch.decode(enc.bytes)
      | version: %WAServerSync.SyncdVersion{version: version}
    }

    {:ok, _, ns} =
      Processor.decode_patches(proc, %PatchList{name: @name, patches: [patch]}, state, true)

    ns
  end

  test "a chain of production-encoded patches, each verified by Go's decoder", ctx do
    %{govec: govec, v: v, proc: proc, key_id: key_id} = ctx
    key = %{id: "3EB0ABCDEF0123456789", remote_jid: @target, from_me: false}

    chain = [
      {"archive", Patch.build_archive(@target, true, 1_700_000_000, key), ["archive", "pin_v1"]},
      {"mark read", Patch.build_mark_chat_as_read(@target, true, 1_700_000_100, key),
       ["markChatAsRead"]},
      {"mark unread (replaces previous)",
       Patch.build_mark_chat_as_read(@target, false, 1_700_000_200, nil), ["markChatAsRead"]},
      {"unarchive (replaces previous)", Patch.build_archive(@target, false, 1_700_000_300, nil),
       ["archive"]},
      {"archive a group", Patch.build_archive(@group, true, nil, nil), ["archive", "pin_v1"]},
      {"re-archive (replaces archive + pin)",
       Patch.build_archive(@target, true, 1_700_000_400, key), ["archive", "pin_v1"]}
    ]

    Enum.reduce(chain, %Hash{}, fn {label, patch, expected_kinds}, state ->
      assert {:ok, enc} = Processor.encode_patch(proc, patch, state)
      version = state.version + 1

      res = go_verify(govec, v, key_id, state, enc.bytes, version)
      assert res["ok"], "#{label}: Go rejected our patch: #{inspect(res["error"])}"
      assert Enum.map(res["mutations"], &hd(&1["index"])) == expected_kinds
      assert Enum.all?(res["mutations"], &(&1["operation"] == "SET"))
      assert res["state_after"]["version"] == enc.state.version

      assert res["state_after"]["hash"] == e(enc.state.hash),
             "#{label}: Go computed a different LTHash"

      commit(proc, state, enc, version)
    end)
  end

  test "the verifier is a real check: Go rejects a patch with a corrupted snapshot MAC", ctx do
    %{govec: govec, v: v, proc: proc, key_id: key_id} = ctx

    {:ok, enc} =
      Processor.encode_patch(proc, Patch.build_archive(@target, true, 1_700_000_000, nil), %Hash{})

    good = go_verify(govec, v, key_id, %Hash{}, enc.bytes, 1)
    assert good["ok"]

    <<first, rest::binary>> = enc.patch.snapshotMAC
    bad = %{enc.patch | snapshotMAC: <<Bitwise.bxor(first, 1), rest::binary>>}
    bad_bytes = bad |> WAServerSync.SyncdPatch.encode() |> IO.iodata_to_binary()

    res = go_verify(govec, v, key_id, %Hash{}, bad_bytes, 1)
    refute res["ok"]
    assert res["error"] =~ "mismatching LTHash"
  end
end
