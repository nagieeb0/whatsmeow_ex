defmodule Whatsmeow.AppState.SyncTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.AppState.Sync
  alias Whatsmeow.AppState.Sync.PatchList
  alias Whatsmeow.Binary.Node

  describe "build_fetch_patches_iq/4" do
    test "snapshot request omits version, sets return_snapshot=true" do
      iq = Sync.build_fetch_patches_iq("critical_block", 0, true)

      assert iq.tag == "iq"
      assert iq.attrs["to"] == "s.whatsapp.net"
      assert iq.attrs["type"] == "set"
      assert iq.attrs["xmlns"] == "w:sync:app:state"

      [sync] = iq.content
      [collection] = sync.content
      assert collection.tag == "collection"
      assert collection.attrs["name"] == "critical_block"
      assert collection.attrs["return_snapshot"] == "true"
      refute Map.has_key?(collection.attrs, "version")
    end

    test "incremental request includes version, return_snapshot=false" do
      iq = Sync.build_fetch_patches_iq("regular", 42, false)

      [sync] = iq.content
      [collection] = sync.content
      assert collection.attrs["version"] == "42"
      assert collection.attrs["return_snapshot"] == "false"
    end

    test "uses caller-provided id when given" do
      iq = Sync.build_fetch_patches_iq("regular", 0, true, id: "FIXED-1")
      assert iq.attrs["id"] == "FIXED-1"
    end

    test "accepts all 5 collection names" do
      Enum.each(Sync.patch_names(), fn name ->
        iq = Sync.build_fetch_patches_iq(name, 0, true)
        [sync] = iq.content
        [coll] = sync.content
        assert coll.attrs["name"] == name
      end)
    end
  end

  describe "parse_patch_list/1" do
    test "returns :missing_sync when response has no <sync> child" do
      assert {:error, :missing_sync} =
               Sync.parse_patch_list(Node.new("iq", %{"type" => "result"}, []))
    end

    test "returns :missing_collection when <sync> has no <collection> child" do
      resp = Node.new("iq", %{}, [Node.new("sync", %{}, [])])
      assert {:error, :missing_collection} = Sync.parse_patch_list(resp)
    end

    test "parses an empty collection (no patches, no snapshot)" do
      resp =
        Node.new("iq", %{}, [
          Node.new("sync", %{}, [
            Node.new(
              "collection",
              %{"name" => "regular_low", "has_more_patches" => "false"},
              []
            )
          ])
        ])

      assert {:ok, %PatchList{} = list} = Sync.parse_patch_list(resp)
      assert list.name == "regular_low"
      assert list.has_more_patches? == false
      assert list.patches == []
      assert list.snapshot == nil
    end

    test "parses has_more_patches=true" do
      resp =
        Node.new("iq", %{}, [
          Node.new("sync", %{}, [
            Node.new(
              "collection",
              %{"name" => "regular", "has_more_patches" => "true"},
              []
            )
          ])
        ])

      assert {:ok, %PatchList{has_more_patches?: true}} = Sync.parse_patch_list(resp)
    end

    test "decodes a real SyncdPatch protobuf" do
      patch = %WAServerSync.SyncdPatch{version: %WAServerSync.SyncdVersion{version: 7}}
      patch_bytes = patch |> WAServerSync.SyncdPatch.encode() |> IO.iodata_to_binary()

      resp =
        Node.new("iq", %{}, [
          Node.new("sync", %{}, [
            Node.new(
              "collection",
              %{"name" => "regular"},
              [
                Node.new("patches", %{}, [
                  Node.new("patch", %{}, patch_bytes)
                ])
              ]
            )
          ])
        ])

      assert {:ok, %PatchList{patches: [decoded]}} = Sync.parse_patch_list(resp)
      assert decoded.version.version == 7
    end

    test "decodes an ExternalBlobReference snapshot" do
      ref = %WAServerSync.ExternalBlobReference{
        mediaKey: <<1, 2, 3>>,
        directPath: "/v/t62/test"
      }

      bytes = ref |> WAServerSync.ExternalBlobReference.encode() |> IO.iodata_to_binary()

      resp =
        Node.new("iq", %{}, [
          Node.new("sync", %{}, [
            Node.new(
              "collection",
              %{"name" => "regular"},
              [Node.new("snapshot", %{}, bytes)]
            )
          ])
        ])

      assert {:ok, %PatchList{snapshot: %WAServerSync.ExternalBlobReference{} = s}} =
               Sync.parse_patch_list(resp)

      assert s.mediaKey == <<1, 2, 3>>
      assert s.directPath == "/v/t62/test"
    end

    test "patches_from_node skips non-binary content but proto errors halt" do
      garbage_patch = Node.new("patch", %{}, <<0xFF, 0xFF>>)

      resp =
        Node.new("iq", %{}, [
          Node.new("sync", %{}, [
            Node.new(
              "collection",
              %{"name" => "regular"},
              [Node.new("patches", %{}, [garbage_patch])]
            )
          ])
        ])

      assert {:error, {:proto_decode, _}} = Sync.parse_patch_list(resp)
    end
  end
end
