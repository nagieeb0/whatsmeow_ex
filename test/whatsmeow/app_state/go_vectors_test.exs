defmodule Whatsmeow.AppState.GoVectorsTest do
  @moduledoc """
  The app-state codec against **Go whatsmeow's own output**.

  `test/fixtures/app_state/go_vectors.json` was produced by running the real Go
  `appstate` package (`scripts/app_state_vectors/run.sh gen`): primitive MACs,
  and six patches encoded by Go's `EncodePatch`/`BuildArchive`/
  `BuildMarkChatAsRead` and decoded back by Go's `DecodePatches`.

  An encode→decode test of our own code proves only that two halves agree with
  each other. That is exactly how the content MAC's operation byte was wrong
  (2/3 where Go has 1/2) while every self-test passed. These tests cannot be
  fooled that way: the expected values come from Go.
  """
  use ExUnit.Case, async: false

  import Whatsmeow.Test.AppStateVectors

  alias Whatsmeow.AppState.{Decode, Encode, Hash, Keys, LTHash, Patch, PatchList, Processor}
  alias Whatsmeow.AppState.Store.Memory

  @jid "me@s.whatsapp.net"
  @t0 1_700_000_000
  @target "201141465543@s.whatsapp.net"
  @group "120363025246125486@g.us"

  setup_all do
    {:ok, _} = start_supervised(Memory)
    %{v: load()}
  end

  setup %{v: v} do
    Memory.reset()

    :ok =
      Memory.put_key(@jid, d(v["key_id"]), %{
        data: d(v["key_data"]),
        fingerprint: <<>>,
        timestamp: 1
      })

    %{
      proc: Processor.new(@jid, store: Memory),
      key_id: d(v["key_id"]),
      keys: Keys.expand(d(v["key_data"]))
    }
  end

  describe "primitives" do
    test "HKDF key expansion", %{v: v, keys: keys} do
      for {k, name} <- [
            index: "index",
            value_encryption: "value_encryption",
            value_mac: "value_mac",
            snapshot_mac: "snapshot_mac",
            patch_mac: "patch_mac"
          ] do
        assert e(keys[k]) == v["expanded"][name], "#{name} differs from Go"
      end
    end

    test "LTHash add / subtract-then-add / subtract-from-zero", %{v: v} do
      for l <- v["lthash"] do
        got =
          LTHash.subtract_then_add(d(l["base"]), Enum.map(l["sub"], &d/1), Enum.map(l["add"], &d/1))

        assert e(got) == l["result"]
      end
    end

    test "content MAC: SET uses op byte 1, REMOVE uses 2", %{v: v} do
      for c <- v["content_mac"] do
        op = if c["op"] == "SET", do: :set, else: :remove
        got = Hash.content_mac(op, d(c["data"]), d(c["key_id"]), d(c["key"]))
        assert e(got) == c["mac"], "#{c["op"]} content MAC differs from Go"
      end
    end

    test "the old op bytes (2 for SET, 3 for REMOVE) are NOT what Go computes", %{v: v} do
      # Regression pin for the bug this replaced: the same HMAC with the wrong byte.
      [set, remove] = v["content_mac"]

      wrong = fn op_byte, c ->
        :crypto.mac(:hmac, :sha512, d(c["key"]), [
          <<op_byte>>,
          d(c["key_id"]),
          d(c["data"]),
          <<byte_size(d(c["key_id"])) + 1::64>>
        ])
        |> binary_part(0, 32)
      end

      refute e(wrong.(2, set)) == set["mac"]
      refute e(wrong.(3, remove)) == remove["mac"]
      assert e(wrong.(1, set)) == set["mac"]
      assert e(wrong.(2, remove)) == remove["mac"]
    end

    test "snapshot MAC", %{v: v} do
      s = v["snapshot_mac"]
      state = %Hash{version: String.to_integer(s["version"]), hash: d(s["hash"])}
      assert e(Hash.snapshot_mac(state, s["name"], d(s["key"]))) == s["mac"]
    end

    test "patch MAC", %{v: v} do
      p = v["patch_mac"]

      got =
        Hash.patch_mac(
          d(p["snapshot_mac"]),
          Enum.map(p["value_macs"], &d/1),
          p["version"],
          p["name"],
          d(p["key"])
        )

      assert e(got) == p["mac"]
    end
  end

  describe "decoding Go's patches" do
    test "every step: Go's patch verifies here and lands on Go's exact state", %{v: v, proc: proc} do
      Enum.reduce(v["steps"], %Hash{}, fn s, state ->
        assert state.version == s["state_before"]["version"]
        assert e(state.hash) == s["state_before"]["hash"]

        patch = %{
          WAServerSync.SyncdPatch.decode(d(s["patch"]))
          | version: %WAServerSync.SyncdVersion{version: s["patch_version"]}
        }

        list = %PatchList{name: s["patch_name"], patches: [patch]}

        assert {:ok, muts, new_state} = Processor.decode_patches(proc, list, state, true),
               "#{s["name"]}: Go's own patch was rejected"

        assert new_state.version == s["state_after"]["version"]
        assert e(new_state.hash) == s["state_after"]["hash"], "#{s["name"]}: LTHash differs from Go"

        got =
          Enum.map(muts, &{&1.index, &1.operation, &1.version, e(&1.index_mac), e(&1.value_mac)})

        want =
          Enum.map(s["mutations"], fn m ->
            {m["index"], op(m["operation"]), m["version"], m["index_mac"], m["value_mac"]}
          end)

        assert got == want
        new_state
      end)
    end

    test "decoded content: archived / read / pinned flags and message ranges", %{v: v, proc: proc} do
      steps = Map.new(v["steps"], &{&1["name"], &1})

      run = fn name, state ->
        s = steps[name]

        patch = %{
          WAServerSync.SyncdPatch.decode(d(s["patch"]))
          | version: %WAServerSync.SyncdVersion{version: s["patch_version"]}
        }

        {:ok, muts, ns} =
          Processor.decode_patches(
            proc,
            %PatchList{name: s["patch_name"], patches: [patch]},
            state,
            true
          )

        {muts, ns}
      end

      {[m1], st} = run.("archive_false_first", %Hash{})
      assert m1.index == ["archive", @target]
      assert m1.action.archiveChatAction.archived == false

      {[m2, m3], st} = run.("archive_true_replaces_previous", st)
      assert m2.action.archiveChatAction.archived == true
      assert m3.index == ["pin_v1", @target]
      assert m3.action.pinAction.pinned == false
      [msg] = m2.action.archiveChatAction.messageRange.messages
      assert %{key: %{ID: "3EB0ABCDEF0123456789"}} = msg

      {[m4], st} = run.("mark_read_with_key", st)
      assert m4.index == ["markChatAsRead", @target]
      assert m4.action.markChatAsReadAction.read == true

      {[m5], st} = run.("mark_unread_no_key", st)
      assert m5.action.markChatAsReadAction.read == false
      assert m5.action.markChatAsReadAction.messageRange.messages == []

      {[m6, _], st} = run.("archive_group", st)
      assert m6.index == ["archive", @group]

      {[m7], _} = run.("remove_mark_read", st)
      assert m7.operation == :remove
    end

    test "the REMOVE patch really removed the stored MAC", %{v: v, proc: proc} do
      Enum.reduce(v["steps"], %Hash{}, fn s, state ->
        patch = %{
          WAServerSync.SyncdPatch.decode(d(s["patch"]))
          | version: %WAServerSync.SyncdVersion{version: s["patch_version"]}
        }

        {:ok, _, ns} =
          Processor.decode_patches(
            proc,
            %PatchList{name: s["patch_name"], patches: [patch]},
            state,
            true
          )

        ns
      end)

      index_mac =
        Hash.index_mac(
          Jason.encode!(["markChatAsRead", @target]),
          Keys.expand(d(v["key_data"])).index
        )

      assert :not_found = Memory.get_mutation_mac(@jid, "regular_low", index_mac)
    end
  end

  describe "encoding: byte-identical to Go" do
    # Give our encoder the IV Go happened to pick and the same inputs; the whole
    # serialized SyncdPatch must then match Go's bytes. That covers the protobuf
    # field set and ordering, `padding`, CBC + PKCS#7, both MACs, and the LTHash
    # update (including subtracting the previous SET) in one comparison.
    test "five patches Go built come out of our encoder byte for byte", %{
      v: v,
      key_id: key_id,
      keys: keys
    } do
      key = %{id: "3EB0ABCDEF0123456789", remote_jid: @target, from_me: false}

      patches = %{
        "archive_false_first" => {0, Patch.build_archive(@target, false, @t0, nil)},
        "archive_true_replaces_previous" => {1, Patch.build_archive(@target, true, @t0 + 60, key)},
        "mark_read_with_key" => {2, Patch.build_mark_chat_as_read(@target, true, @t0 + 120, key)},
        "mark_unread_no_key" => {3, Patch.build_mark_chat_as_read(@target, false, @t0 + 180, nil)},
        "archive_group" => {4, Patch.build_archive(@group, true, @t0 + 240, nil)}
      }

      for s <- v["steps"], {k, patch} <- [patches[s["name"]]], patch != nil do
        Memory.reset()

        :ok =
          Memory.put_key(@jid, key_id, %{data: d(v["key_data"]), fingerprint: <<>>, timestamp: 1})

        prior = for m <- s["prior_macs"] || [], do: {d(m["index_mac"]), d(m["value_mac"])}

        :ok =
          Memory.apply_patch_state(
            @jid,
            s["patch_name"],
            s["state_before"]["version"],
            d(s["state_before"]["hash"]),
            [],
            prior
          )

        go = WAServerSync.SyncdPatch.decode(d(s["patch"]))
        ivs = for m <- go.mutations, do: binary_part(m.record.value.blob, 0, 16)
        {:ok, agent} = Agent.start_link(fn -> ivs end)
        iv_fun = fn -> Agent.get_and_update(agent, fn [h | t] -> {h, t} end) end

        state = %Hash{version: s["state_before"]["version"], hash: d(s["state_before"]["hash"])}
        patch = %{patch | timestamp_ms: (@t0 + 60 * k) * 1000}

        prev = fn index_mac, _ ->
          case Memory.get_mutation_mac(@jid, s["patch_name"], index_mac) do
            {:ok, mac} -> mac
            :not_found -> nil
          end
        end

        assert {:ok, r} = Encode.encode_patch(patch, key_id, keys, state, prev, iv_fun: iv_fun)

        assert r.bytes == d(s["patch"]), "#{s["name"]}: serialized patch differs from Go's"
        assert e(r.state.hash) == s["state_after"]["hash"]
        assert r.state.version == s["state_after"]["version"]
      end
    end

    test "archive is two mutations (archive + unpin), unarchive is one — as Go's BuildArchive" do
      assert [%{index: ["archive", @target]}, %{index: ["pin_v1", @target], version: 5}] =
               Patch.build_archive(@target, true, @t0).mutations

      assert [%{index: ["archive", @target], version: 3}] =
               Patch.build_archive(@target, false, @t0).mutations

      assert [%{index: ["markChatAsRead", @target], version: 3}] =
               Patch.build_mark_chat_as_read(@target, true, @t0).mutations
    end
  end

  describe "tampering is caught — each check on its own" do
    setup %{v: v} do
      s = Enum.find(v["steps"], &(&1["name"] == "archive_true_replaces_previous"))
      first = hd(v["steps"])
      %{s: s, first: first}
    end

    # Bring the store to the state before `s`, then try a tampered copy of `s`.
    defp decode_tampered(%{v: v, proc: proc}, s, tamper) do
      Enum.reduce_while(v["steps"], %Hash{}, fn step, state ->
        if step["name"] == s["name"] do
          patch =
            tamper.(%{
              WAServerSync.SyncdPatch.decode(d(step["patch"]))
              | version: %WAServerSync.SyncdVersion{version: step["patch_version"]}
            })

          {:halt,
           Processor.decode_patches(
             proc,
             %PatchList{name: step["patch_name"], patches: [patch]},
             state,
             true
           )}
        else
          patch = %{
            WAServerSync.SyncdPatch.decode(d(step["patch"]))
            | version: %WAServerSync.SyncdVersion{version: step["patch_version"]}
          }

          {:ok, _, ns} =
            Processor.decode_patches(
              proc,
              %PatchList{name: step["patch_name"], patches: [patch]},
              state,
              true
            )

          {:cont, ns}
        end
      end)
    end

    defp flip(bin, at) do
      <<head::binary-size(^at), b, rest::binary>> = bin
      <<head::binary, Bitwise.bxor(b, 1), rest::binary>>
    end

    test "untouched control decodes", ctx do
      assert {:ok, _, _} = decode_tampered(ctx, ctx.s, & &1)
    end

    test "flipped ciphertext bit → content MAC", ctx do
      r = decode_tampered(ctx, ctx.s, fn p -> put_blob(p, 0, &flip(&1, 20)) end)
      assert {:error, {:mismatching_content_mac, 1}} = r
    end

    # The trailing 32 bytes are fed into the LTHash, so changing them is caught by
    # the snapshot MAC *before* any per-mutation check runs — Go checks in this
    # order too (validatePatch, then decodeMutations).
    test "flipped value-MAC bit → LTHash mismatch (snapshot MAC is checked first)", ctx do
      r = decode_tampered(ctx, ctx.s, fn p -> put_blob(p, 0, &flip(&1, byte_size(&1) - 1)) end)
      assert {:error, {:mismatching_lthash, 2}} = r
    end

    test "…and with validation off, the content MAC is what catches it", ctx do
      patch_fun = fn p -> put_blob(p, 0, &flip(&1, byte_size(&1) - 1)) end
      v = ctx.v

      # Bring the store up to step 1, then decode the tampered step 2 with
      # snapshot/patch MAC checks *on* but look only at which mutation check fires
      # by decoding the mutation directly.
      s2 = ctx.s

      patch =
        patch_fun.(%{
          WAServerSync.SyncdPatch.decode(d(s2["patch"]))
          | version: %WAServerSync.SyncdVersion{version: 2}
        })

      keys = %{ctx.key_id => ctx.keys}
      [m | _] = patch.mutations
      assert {:error, {:mismatching_content_mac, 1}} = Decode.decode_mutation(m, 0, keys, true)
      _ = v
    end

    test "replaced snapshot MAC → LTHash mismatch", ctx do
      r = decode_tampered(ctx, ctx.s, fn p -> %{p | snapshotMAC: flip(p.snapshotMAC, 0)} end)
      assert {:error, {:mismatching_lthash, 2}} = r
    end

    test "replaced patch MAC → patch MAC mismatch", ctx do
      r = decode_tampered(ctx, ctx.s, fn p -> %{p | patchMAC: flip(p.patchMAC, 0)} end)
      assert {:error, {:mismatching_patch_mac, 2}} = r
    end

    test "wrong version stamped on the patch breaks the snapshot MAC (it is bound in)", ctx do
      r =
        decode_tampered(ctx, ctx.s, fn p ->
          %{p | version: %WAServerSync.SyncdVersion{version: 9}}
        end)

      assert {:error, {:mismatching_lthash, 9}} = r
    end

    # (Not step 2: that one *replaces* the only previous SET, and an LTHash is a set
    # hash — old − old + new equals new from zero, so a zero base is genuinely valid.)
    test "a patch applied to the wrong base state is rejected", %{v: v, proc: proc} do
      s = Enum.find(v["steps"], &(&1["name"] == "mark_read_with_key"))

      patch = %{
        WAServerSync.SyncdPatch.decode(d(s["patch"]))
        | version: %WAServerSync.SyncdVersion{version: s["patch_version"]}
      }

      assert {:error, {:mismatching_lthash, 3}} =
               Processor.decode_patches(
                 proc,
                 %PatchList{name: s["patch_name"], patches: [patch]},
                 %Hash{},
                 true
               )
    end

    test "a patch decoded under the wrong collection name is rejected (name is in the MAC)", %{
      proc: proc,
      first: s
    } do
      patch = %{
        WAServerSync.SyncdPatch.decode(d(s["patch"]))
        | version: %WAServerSync.SyncdVersion{version: 1}
      }

      assert {:error, {:mismatching_lthash, _}} =
               Processor.decode_patches(
                 proc,
                 %PatchList{name: "regular_high", patches: [patch]},
                 %Hash{},
                 true
               )
    end

    test "a value blob too short to hold IV + MAC is an error, not a crash", ctx do
      r = decode_tampered(ctx, ctx.s, fn p -> put_blob(p, 0, fn _ -> <<1, 2, 3>> end) end)
      assert {:error, {:invalid_value_blob, {1, 3}}} = r
    end

    test "no key for the patch → key_not_found, nothing applied", %{v: v, proc: proc, first: s} do
      patch = %{
        WAServerSync.SyncdPatch.decode(d(s["patch"]))
        | version: %WAServerSync.SyncdVersion{version: 1}
      }

      other = WAServerSync.KeyId |> struct(ID: <<9, 9, 9>>)
      patch = %{patch | keyID: other}

      assert {:error, {:key_not_found, <<9, 9, 9>>}} =
               Processor.decode_patches(
                 proc,
                 %PatchList{name: "regular_low", patches: [patch]},
                 %Hash{},
                 true
               )

      assert {:ok, 0, _} = Memory.get_version(@jid, "regular_low")
      _ = v
    end
  end

  defp put_blob(%WAServerSync.SyncdPatch{mutations: muts} = patch, i, fun) do
    muts =
      List.update_at(muts, i, fn m ->
        blob = fun.(m.record.value.blob)
        %{m | record: %{m.record | value: %{m.record.value | blob: blob}}}
      end)

    %{patch | mutations: muts}
  end

  defp op("SET"), do: :set
  defp op("REMOVE"), do: :remove
end
