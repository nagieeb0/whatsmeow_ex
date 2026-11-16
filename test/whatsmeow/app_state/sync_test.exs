defmodule Whatsmeow.AppState.SyncTest do
  @moduledoc """
  Fetch and send against a fake server (`Whatsmeow.Test.AppStateFake`): no network.

  The fake server never checks MACs — like the real one — while the fake *phone*
  behind it verifies every patch it is forwarded. So `phone_errors == []` after a
  send means a verifying peer accepted what we sent, which is the property that
  protects the owner's real phone.
  """
  use ExUnit.Case, async: false

  @moduletag :capture_log

  alias Whatsmeow.AppState.{Coordinator, Hash, Patch, PatchList, Sync}
  alias Whatsmeow.AppState.Store.Memory
  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Test.AppStateFake, as: Fake

  @me "me@s.whatsapp.net"
  @name "regular_low"
  @chat "201141465543@s.whatsapp.net"
  @other "201000000000@s.whatsapp.net"
  @key_id <<0, 0, 0, 0, 0, 42>>

  setup do
    start_supervised!(Memory)
    Coordinator.reset_requests()
    key_data = :crypto.strong_rand_bytes(32)
    server = Fake.start(@key_id, key_data)
    %{server: server, key_data: key_data}
  end

  # Give the device the phone's key, as a key share would.
  defp give_key(%{key_data: key_data}) do
    :ok = Memory.put_key(@me, @key_id, %{data: key_data, fingerprint: <<>>, timestamp: 1})
  end

  defp opts(%{server: server}, extra \\ []), do: Fake.opts(server, extra)

  defp phone_has_a_few(server) do
    :ok = Fake.phone_apply(server, Patch.build_pin(@other, true))
    :ok = Fake.phone_apply(server, Patch.build_mark_chat_as_read(@other, false, 1_700_000_000, nil))
    :ok = Fake.phone_apply(server, Patch.build_archive(@chat, false, 1_700_000_000, nil))
  end

  defp local_state do
    {:ok, v, h} = Memory.get_version(@me, @name)
    %Hash{version: v, hash: h}
  end

  defp sends(server), do: Enum.filter(Fake.iqs(server), &Node.get_child(&1.collection, "patch"))

  # --- IQ builders ----------------------------------------------------------------

  describe "IQ builders" do
    test "fetch with snapshot omits version" do
      iq = Sync.build_fetch_patches_iq(@name, 0, true, id: "X")
      assert %{"xmlns" => "w:sync:app:state", "type" => "set", "id" => "X"} = iq.attrs
      [sync] = iq.content
      [collection] = sync.content
      assert collection.attrs == %{"name" => @name, "return_snapshot" => "true"}
    end

    test "incremental fetch carries the version as a decimal string" do
      [sync] = Sync.build_fetch_patches_iq(@name, 1234, false).content
      [collection] = sync.content

      assert collection.attrs == %{
               "name" => @name,
               "return_snapshot" => "false",
               "version" => "1234"
             }
    end

    test "`to` is a typed server JID, not the string (see Whatsmeow.IQ)" do
      iq = Sync.build_fetch_patches_iq(@name, 0, true)
      assert %Whatsmeow.Types.JID{user: "", server: "s.whatsapp.net"} = iq.attrs["to"]
    end

    test "send IQ: the version we are extending, return_snapshot=false, patch bytes as content" do
      iq = Sync.build_send_patch_iq(@name, 41, <<1, 2, 3>>)
      [sync] = iq.content
      [collection] = sync.content
      assert collection.attrs == %{"name" => @name, "version" => "41", "return_snapshot" => "false"}
      assert [%Node{tag: "patch", content: <<1, 2, 3>>}] = collection.content
    end
  end

  # --- parsing ---------------------------------------------------------------------

  describe "parse_collection/3" do
    test "an empty collection" do
      c = Node.new("collection", %{"name" => @name}, nil)

      assert {:ok, %PatchList{name: @name, patches: [], snapshot: nil, has_more_patches?: false}} =
               Sync.parse_collection(c, @name, nil)
    end

    test "has_more_patches" do
      c = Node.new("collection", %{"name" => @name, "has_more_patches" => "true"}, nil)
      assert {:ok, %PatchList{has_more_patches?: true}} = Sync.parse_collection(c, @name, nil)
    end

    test "a collection for a different name is refused — the name feeds the MACs" do
      c = Node.new("collection", %{"name" => "regular_high"}, nil)

      assert {:error, {:unexpected_collection, "regular_high", @name}} =
               Sync.parse_collection(c, @name, nil)
    end

    test "a missing name falls back to the one we asked for" do
      assert {:ok, %PatchList{name: @name}} =
               Sync.parse_collection(Node.new("collection", %{}, nil), @name, nil)
    end

    test "non-<patch> children and patches without bytes are skipped, bad protobuf is an error" do
      good = %WAServerSync.SyncdPatch{} |> WAServerSync.SyncdPatch.encode() |> IO.iodata_to_binary()

      c =
        Node.new("collection", %{"name" => @name}, [
          Node.new("patches", %{}, [
            Node.new("patch", %{}, good),
            Node.new("other", %{}, good),
            Node.new("patch", %{}, nil)
          ])
        ])

      assert {:ok, %PatchList{patches: [_]}} = Sync.parse_collection(c, @name, nil)

      bad =
        Node.new("collection", %{"name" => @name}, [
          Node.new("patches", %{}, [Node.new("patch", %{}, <<255, 255, 255>>)])
        ])

      assert {:error, {:invalid_protobuf, {:patch, 1}, _}} = Sync.parse_collection(bad, @name, nil)
    end

    test "a snapshot is downloaded and decoded; a failed download is an error" do
      snap = %WAServerSync.SyncdSnapshot{version: %WAServerSync.SyncdVersion{version: 9}}
      ref = %WAServerSync.ExternalBlobReference{directPath: "/x"}

      c =
        Node.new("collection", %{"name" => @name}, [
          Node.new(
            "snapshot",
            %{},
            ref |> WAServerSync.ExternalBlobReference.encode() |> IO.iodata_to_binary()
          )
        ])

      dl = fn %{directPath: "/x"} ->
        {:ok, snap |> WAServerSync.SyncdSnapshot.encode() |> IO.iodata_to_binary()}
      end

      assert {:ok, %PatchList{snapshot: %{version: %{version: 9}}}} =
               Sync.parse_collection(c, @name, dl)

      assert {:error, {:download_failed, :boom}} =
               Sync.parse_collection(c, @name, fn _ -> {:error, :boom} end)

      assert {:error, {:download_failed, :no_downloader}} = Sync.parse_collection(c, @name, nil)
    end

    test "external mutations are downloaded and inlined; an empty download is an error" do
      m = %WAServerSync.SyncdMutation{operation: :SET}
      ref = %WAServerSync.ExternalBlobReference{directPath: "/m"}
      patch = %WAServerSync.SyncdPatch{externalMutations: ref}

      c =
        Node.new("collection", %{"name" => @name}, [
          Node.new("patches", %{}, [
            Node.new(
              "patch",
              %{},
              patch |> WAServerSync.SyncdPatch.encode() |> IO.iodata_to_binary()
            )
          ])
        ])

      dl = fn _ ->
        {:ok,
         %WAServerSync.SyncdMutations{mutations: [m]}
         |> WAServerSync.SyncdMutations.encode()
         |> IO.iodata_to_binary()}
      end

      assert {:ok, %PatchList{patches: [%{mutations: [_]}]}} = Sync.parse_collection(c, @name, dl)

      empty = fn _ ->
        {:ok,
         %WAServerSync.SyncdMutations{}
         |> WAServerSync.SyncdMutations.encode()
         |> IO.iodata_to_binary()}
      end

      assert {:error, :no_mutations_in_download} = Sync.parse_collection(c, @name, empty)
    end
  end

  # --- fetch -----------------------------------------------------------------------

  describe "fetch/3" do
    test "first sync takes the snapshot and lands on exactly the phone's state", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)

      assert {:ok, state} = Sync.fetch(nil, @name, opts(ctx))
      assert state.version == 3
      assert state == Fake.phone_state(ctx.server)
      assert local_state() == state
      assert Memory.dump_macs(@me, @name) == Memory.dump_macs(Fake.phone_jid(), @name)

      [%{collection: c}] = Fake.iqs(ctx.server)
      assert c.attrs["return_snapshot"] == "true"
      refute Map.has_key?(c.attrs, "version")
    end

    test "after that, only the patches we lack are fetched", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      :ok = Fake.phone_apply(ctx.server, Patch.build_archive(@other, true, 1_700_000_001, nil))
      assert {:ok, state} = Sync.fetch(nil, @name, opts(ctx))

      assert state.version == 4
      assert state == Fake.phone_state(ctx.server)

      assert %{attrs: %{"return_snapshot" => "false", "version" => "3"}} =
               List.last(Fake.iqs(ctx.server)).collection
    end

    test "has_more_patches is followed page by page", ctx do
      server = ctx.server
      Fake.configure(server, chunk: 2)
      give_key(ctx)
      # A non-zero base, so the later fetches ask for patches rather than a snapshot.
      :ok = Fake.phone_apply(server, Patch.build_pin("201000000009@s.whatsapp.net", true))
      {:ok, %Hash{version: 1}} = Sync.fetch(nil, @name, Fake.opts(server))

      for n <- 1..7,
          do:
            :ok = Fake.phone_apply(server, Patch.build_pin("20100000000#{n}@s.whatsapp.net", true))

      before = length(Fake.iqs(server))

      assert {:ok, state} = Sync.fetch(nil, @name, Fake.opts(server))
      assert state == Fake.phone_state(server)
      assert length(Fake.iqs(server)) - before == 4, "7 patches at 2 per page is 4 requests"
    end

    test "patches whose mutations are external blobs are downloaded and applied", ctx do
      server = ctx.server
      Fake.configure(server, external_patches: true)
      give_key(ctx)
      :ok = Fake.phone_apply(server, Patch.build_pin("201000000009@s.whatsapp.net", true))
      {:ok, %Hash{version: 1}} = Sync.fetch(nil, @name, Fake.opts(server))

      :ok = Fake.phone_apply(server, Patch.build_archive(@chat, true, 1_700_000_000, nil))
      assert {:ok, state} = Sync.fetch(nil, @name, Fake.opts(server))
      assert state == Fake.phone_state(server)
    end

    test "only_if_not_synced does nothing once we have a version", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))
      n = length(Fake.iqs(ctx.server))

      assert {:ok, %Hash{version: 3}} = Sync.fetch(nil, @name, opts(ctx, only_if_not_synced: true))
      assert length(Fake.iqs(ctx.server)) == n
    end

    test "full_sync discards the stored state and takes a fresh snapshot", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      assert {:ok, state} = Sync.fetch(nil, @name, opts(ctx, full_sync: true))
      assert state == Fake.phone_state(ctx.server)
      assert List.last(Fake.iqs(ctx.server)).collection.attrs["return_snapshot"] == "true"
    end

    test "a snapshot starts from nothing: MACs left by an earlier life of the collection are cleared",
         ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)

      # Version 0 but an orphaned MAC — what a device delete leaves in the MACs table.
      stale = <<9::256>>
      :ok = Memory.apply_patch_state(@me, @name, 0, <<0::1024>>, [], [{stale, <<1::256>>}])

      assert {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      assert :not_found = Memory.get_mutation_mac(@me, @name, stale),
             "a stale MAC would be subtracted from a hash that never contained it"

      assert Memory.dump_macs(@me, @name) == Memory.dump_macs(Fake.phone_jid(), @name)
    end

    test "full_sync clears them too (Go only drops the version row)", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      stale = <<8::256>>

      :ok =
        Memory.apply_patch_state(@me, @name, 3, Fake.phone_state(ctx.server).hash, [], [
          {stale, <<1::256>>}
        ])

      assert {:ok, _} = Sync.fetch(nil, @name, opts(ctx, full_sync: true))
      assert :not_found = Memory.get_mutation_mac(@me, @name, stale)
    end

    test "an empty collection syncs to version 0 without complaint", ctx do
      give_key(ctx)
      assert {:ok, %Hash{version: 0}} = Sync.fetch(nil, @name, opts(ctx))
    end

    test "a snapshot we did not ask for is refused", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      # Answer an *incremental* request with a snapshot.
      snapshot_iq = fn _iq ->
        Fake.send_iq(ctx.server).(Sync.build_fetch_patches_iq(@name, 0, true))
      end

      assert {:error, {:unexpected_snapshot, @name}} =
               Sync.fetch(nil, @name, opts(ctx, send_iq: snapshot_iq))
    end

    test "a server that says 'more' forever without advancing is stopped", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      stuck = fn _ ->
        {:ok,
         Node.new("iq", %{"type" => "result"}, [
           Node.new("sync", %{}, [
             Node.new("collection", %{"name" => @name, "has_more_patches" => "true"}, nil)
           ])
         ])}
      end

      assert {:error, {:no_progress, @name, 3}} = Sync.fetch(nil, @name, opts(ctx, send_iq: stuck))
    end

    test "an error IQ is reported with its code", ctx do
      give_key(ctx)

      err = fn _ ->
        {:ok,
         Node.new("iq", %{"type" => "error"}, [
           Node.new("error", %{"code" => "500", "text" => "oops"}, nil)
         ])}
      end

      assert {:error, {:iq_error, %{code: 500, text: "oops"}}} =
               Sync.fetch(nil, @name, opts(ctx, send_iq: err))
    end

    test "a response with no <collection> is an error, not a crash", ctx do
      give_key(ctx)
      none = fn _ -> {:ok, Node.new("iq", %{"type" => "result"}, nil)} end

      assert {:error, {:missing_element, "collection"}} =
               Sync.fetch(nil, @name, opts(ctx, send_iq: none))
    end
  end

  describe "fetch/3 when keys are missing or data is bad" do
    test "a snapshot under a key we lack asks the phone for it, once per 24h", ctx do
      phone_has_a_few(ctx.server)
      assert :not_found = Memory.get_key(@me, @key_id)

      assert {:error, {:key_not_found, @key_id}} = Sync.fetch(nil, @name, opts(ctx))
      assert_received {:key_request, [@key_id]}

      # Retrying straight away must not ask again.
      assert {:error, {:key_not_found, @key_id}} = Sync.fetch(nil, @name, opts(ctx))
      refute_received {:key_request, _}
      assert Coordinator.requested?(@me, @key_id)

      assert {:ok, 0, _} = Memory.get_version(@me, @name), "nothing was applied"
    end

    test "a corrupted patch is rejected, and the stored state does not move", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, base} = Sync.fetch(nil, @name, opts(ctx))
      :ok = Fake.phone_apply(ctx.server, Patch.build_archive(@other, true, 1_700_000_001, nil))

      corrupt = fn iq ->
        {:ok, resp} = Fake.send_iq(ctx.server).(iq)
        {:ok, flip_patch_mac(resp)}
      end

      assert {:error, {:mismatching_patch_mac, 4}} =
               Sync.fetch(nil, @name, opts(ctx, send_iq: corrupt))

      assert local_state() == base
    end

    test "when the second of two patches is bad, the first is kept (each patch is persisted as it passes)",
         ctx do
      give_key(ctx)
      # A non-zero base: from version 0 the server would send a snapshot, not patches.
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin("201000000009@s.whatsapp.net", true))
      {:ok, %Hash{version: 1}} = Sync.fetch(nil, @name, opts(ctx))
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin(@other, true))
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin(@chat, true))

      corrupt_last = fn iq ->
        {:ok, resp} = Fake.send_iq(ctx.server).(iq)
        {:ok, flip_patch_mac(resp, :last)}
      end

      assert {:error, {:mismatching_patch_mac, 3}} =
               Sync.fetch(nil, @name, opts(ctx, send_iq: corrupt_last))

      assert local_state().version == 2, "v2 passed and was kept; v3 failed"
    end
  end

  # --- send ------------------------------------------------------------------------

  describe "send_patch/3: the straight path" do
    test "archive: server version advances, local state follows, the phone verifies it", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      assert {:ok, state} =
               Sync.send_patch(
                 nil,
                 Patch.build_archive(@other, true, 1_700_000_100, nil),
                 opts(ctx)
               )

      # 3 patches from the phone, then ours. Archive + unpin are two mutations in
      # ONE patch, so one version.
      assert state.version == 4
      assert Fake.version(ctx.server) == state.version
      assert state == Fake.phone_state(ctx.server)
      assert local_state() == state
      assert Fake.phone_errors(ctx.server) == []
      assert Memory.dump_macs(@me, @name) == Memory.dump_macs(Fake.phone_jid(), @name)

      [send] = sends(ctx.server)
      assert send.collection.attrs["version"] == "3", "extends the version we had"
      assert send.collection.attrs["return_snapshot"] == "false"
    end

    test "the version in the result is the patch's new version", ctx do
      server = ctx.server
      give_key(ctx)

      assert {:ok, %Hash{version: 1}} =
               Sync.send_patch(nil, Patch.build_archive(@chat, true, nil, nil), Fake.opts(server))

      assert {:ok, %Hash{version: 2}} =
               Sync.send_patch(
                 nil,
                 Patch.build_mark_chat_as_read(@chat, true, nil, nil),
                 Fake.opts(server)
               )

      assert {:ok, %Hash{version: 3}} =
               Sync.send_patch(nil, Patch.build_archive(@chat, false, nil, nil), Fake.opts(server))

      assert Fake.phone_errors(server) == []
    end

    test "a never-synced collection is fetched first, so we do not send against version 0", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)

      assert {:ok, state} =
               Sync.send_patch(nil, Patch.build_archive(@chat, true, nil, nil), opts(ctx))

      assert state.version == 4

      [first | _] = Fake.iqs(ctx.server)
      assert first.collection.attrs["return_snapshot"] == "true"
      [send] = sends(ctx.server)
      assert send.collection.attrs["version"] == "3"
      assert Fake.phone_errors(ctx.server) == []
    end

    test "replacing something the phone already set subtracts the old value (phone's LTHash agrees)",
         ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      # The phone already has ["archive", @chat] = false. Archive it for real.
      assert {:ok, state} =
               Sync.send_patch(nil, Patch.build_archive(@chat, true, 1_700_000_200, nil), opts(ctx))

      assert state == Fake.phone_state(ctx.server)
      assert Fake.phone_errors(ctx.server) == []
    end
  end

  describe "send_patch/3: version conflict (409)" do
    test "the phone changes something mid-send: apply what it sent, retry once, succeed", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      # Just before our send is handled, the phone marks another chat read.
      Fake.before_next_send(ctx.server, fn s ->
        Fake.phone_apply(s, Patch.build_mark_chat_as_read(@chat, true, 1_700_000_050, nil))
      end)

      assert {:ok, state} =
               Sync.send_patch(
                 nil,
                 Patch.build_archive(@other, true, 1_700_000_300, nil),
                 opts(ctx)
               )

      assert state.version == 5, "phone's patch took v4, ours v5"
      assert state == Fake.phone_state(ctx.server)
      assert local_state() == state
      assert Fake.phone_errors(ctx.server) == []

      versions = ctx.server |> sends() |> Enum.map(& &1.collection.attrs["version"])
      assert versions == ["3", "4"], "first attempt extends v3 and is refused; the retry extends v4"
    end

    test "the conflict response's patches are verified like any others", ctx do
      give_key(ctx)
      {:ok, %Hash{version: 0}} = Sync.fetch(nil, @name, opts(ctx))

      Fake.before_next_send(ctx.server, fn s ->
        Fake.phone_apply(s, Patch.build_pin(@other, true))
      end)

      # Corrupt the 409's patches on the way in.
      tamper = fn iq ->
        {:ok, resp} = Fake.send_iq(ctx.server).(iq)

        if Node.get_child(hd(hd(iq.content).content), "patch"),
          do: {:ok, flip_patch_mac(resp)},
          else: {:ok, resp}
      end

      assert {:error, {:conflict_resync_failed, {:mismatching_patch_mac, 1}, %{code: 409}}} =
               Sync.send_patch(
                 nil,
                 Patch.build_archive(@chat, true, nil, nil),
                 opts(ctx, send_iq: tamper)
               )

      assert local_state().version == 0
      assert length(sends(ctx.server)) == 1, "no retry on top of a state we could not verify"
    end

    test "a 409 that carries a snapshot triggers a full re-read, then the retry succeeds", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      Fake.conflict_with_snapshot(ctx.server)

      Fake.before_next_send(ctx.server, fn s ->
        Fake.phone_apply(s, Patch.build_mark_chat_as_read(@chat, true, 1_700_000_050, nil))
      end)

      assert {:ok, state} =
               Sync.send_patch(nil, Patch.build_archive(@other, true, nil, nil), opts(ctx))

      assert state == Fake.phone_state(ctx.server)
      assert Fake.phone_errors(ctx.server) == []
      assert state.version == 5

      returns = for %{collection: c} <- Fake.iqs(ctx.server), do: c.attrs["return_snapshot"]
      assert "true" in Enum.drop(returns, 1), "a snapshot was requested to catch up"
      assert Memory.dump_macs(@me, @name) == Memory.dump_macs(Fake.phone_jid(), @name)
    end

    test "a 409 with has_more_patches keeps reading before it retries", ctx do
      Fake.configure(ctx.server, chunk: 2)
      give_key(ctx)
      :ok = Fake.phone_apply(ctx.server, Patch.build_pin("201000000009@s.whatsapp.net", true))
      {:ok, %Hash{version: 1}} = Sync.fetch(nil, @name, opts(ctx))

      # The phone makes five changes before our send lands: 2 arrive with the 409,
      # 3 more are behind `has_more_patches`.
      Fake.before_next_send(ctx.server, fn s ->
        for n <- 1..5,
            do: Fake.phone_apply(s, Patch.build_pin("20100000000#{n}@s.whatsapp.net", true))
      end)

      assert {:ok, state} =
               Sync.send_patch(nil, Patch.build_archive(@chat, true, nil, nil), opts(ctx))

      assert state.version == 7
      assert state == Fake.phone_state(ctx.server)
      assert Fake.phone_errors(ctx.server) == []
      assert length(sends(ctx.server)) == 2, "exactly one retry, and it succeeded"
    end

    test "a second 409 is final: exactly two attempts, never a third", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))
      Fake.conflicts(ctx.server, 5)

      assert {:error, {:rejected, %{code: 409}}} =
               Sync.send_patch(nil, Patch.build_archive(@chat, true, nil, nil), opts(ctx))

      assert length(sends(ctx.server)) == 2
    end
  end

  describe "send_patch/3: failures" do
    test "a refusal other than 409 is returned as is and not retried", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, base} = Sync.fetch(nil, @name, opts(ctx))
      Fake.reject_next(ctx.server, 400)

      assert {:error, {:rejected, %{code: 400}}} =
               Sync.send_patch(nil, Patch.build_archive(@chat, true, nil, nil), opts(ctx))

      assert length(sends(ctx.server)) == 1
      assert local_state() == base
    end

    test "an IQ-level error", ctx do
      give_key(ctx)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      err = fn _ ->
        {:ok, Node.new("iq", %{"type" => "error"}, [Node.new("error", %{"code" => "503"}, nil)])}
      end

      assert {:error, {:iq_error, %{code: 503}}} =
               Sync.send_patch(nil, Patch.build_pin(@chat, true), opts(ctx, send_iq: err))
    end

    test "a transport error", ctx do
      give_key(ctx)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      assert {:error, :timeout} =
               Sync.send_patch(
                 nil,
                 Patch.build_pin(@chat, true),
                 opts(ctx, send_iq: fn _ -> {:error, :timeout} end)
               )
    end

    test "accepted but the re-read fails: {:resync_failed, _}, and the patch IS on the server",
         ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      # Let the send through, fail every request after it.
      {:ok, counter} = Agent.start_link(fn -> 0 end)

      flaky = fn iq ->
        if Node.get_child(hd(hd(iq.content).content), "patch") do
          Agent.update(counter, &(&1 + 1))
          Fake.send_iq(ctx.server).(iq)
        else
          if Agent.get(counter, & &1) > 0,
            do: {:error, :timeout},
            else: Fake.send_iq(ctx.server).(iq)
        end
      end

      assert {:error, {:resync_failed, :timeout}} =
               Sync.send_patch(
                 nil,
                 Patch.build_archive(@chat, true, nil, nil),
                 opts(ctx, send_iq: flaky)
               )

      assert Fake.version(ctx.server) == 4, "the patch was accepted"

      # And the next call recovers by itself: the re-read picks our own patch up.
      assert {:ok, state} =
               Sync.send_patch(nil, Patch.build_mark_chat_as_read(@chat, true, nil, nil), opts(ctx))

      assert state == Fake.phone_state(ctx.server)
      assert Fake.phone_errors(ctx.server) == []
    end

    test "no keys at all: :no_app_state_keys, nothing sent", ctx do
      # A synced collection but an empty key store (keys lost).
      :ok = Memory.apply_patch_state(@me, @name, 3, <<0::1024>>, [], [])

      assert {:error, :no_app_state_keys} =
               Sync.send_patch(nil, Patch.build_archive(@chat, true, nil, nil), opts(ctx))

      assert sends(ctx.server) == []
    end

    test "never synced and no key: the snapshot's key is requested from the phone", ctx do
      phone_has_a_few(ctx.server)

      assert {:error, {:key_not_found, @key_id}} =
               Sync.send_patch(nil, Patch.build_archive(@chat, true, nil, nil), opts(ctx))

      assert_received {:key_request, [@key_id]}
      assert sends(ctx.server) == []
    end

    test "a store that disagrees with itself is caught by the self-check and NOTHING is sent",
         ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      # The first previous-MAC lookup (encode) is told "none"; the second (the
      # self-check's decode) tells the truth. The encoded patch then fails the
      # verifying decode — exactly what a codec bug would look like.
      Process.put(:flaky_calls, 0)

      assert {:error, {:self_check_failed, {:mismatching_lthash, _}}} =
               Sync.send_patch(
                 nil,
                 Patch.build_archive(@chat, true, nil, nil),
                 opts(ctx, store: Whatsmeow.Test.FlakyMacStore)
               )

      assert sends(ctx.server) == [], "a patch that does not verify must never reach the wire"
    end
  end

  describe "locking" do
    test "two overlapping operations on one device are serialised", ctx do
      give_key(ctx)
      phone_has_a_few(ctx.server)
      {:ok, _} = Sync.fetch(nil, @name, opts(ctx))

      tasks =
        for n <- 1..4 do
          Task.async(fn ->
            Sync.send_patch(
              nil,
              Patch.build_pin("20100000000#{n}@s.whatsapp.net", true),
              opts(ctx, notify: self())
            )
          end)
        end

      results = Task.await_many(tasks, 30_000)
      assert Enum.all?(results, &match?({:ok, _}, &1)), inspect(results)
      assert Fake.phone_errors(ctx.server) == []
      assert Fake.version(ctx.server) == 7
      assert local_state() == Fake.phone_state(ctx.server)
    end
  end

  # --- helpers ---------------------------------------------------------------------

  # Corrupt the patch MAC of the first (or :last) patch in a fetch response.
  defp flip_patch_mac(resp, which \\ :first) do
    [sync] = resp.content
    [collection] = sync.content
    patches_node = Node.get_child(collection, "patches")

    update = fn %Node{content: bytes} = n ->
      p = WAServerSync.SyncdPatch.decode(bytes)
      <<b, rest::binary>> = p.patchMAC
      bad = %{p | patchMAC: <<Bitwise.bxor(b, 1), rest::binary>>}
      %{n | content: bad |> WAServerSync.SyncdPatch.encode() |> IO.iodata_to_binary()}
    end

    nodes = patches_node.content
    i = if which == :first, do: 0, else: length(nodes) - 1
    new_patches = %{patches_node | content: List.update_at(nodes, i, update)}

    new_collection = %{
      collection
      | content:
          Enum.map(collection.content, fn c -> if c.tag == "patches", do: new_patches, else: c end)
    }

    %{resp | content: [%{sync | content: [new_collection]}]}
  end
end
