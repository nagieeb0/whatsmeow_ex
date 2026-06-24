defmodule Whatsmeow.PrivacyTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Privacy
  alias Whatsmeow.Privacy.{Blocklist, Settings}
  alias Whatsmeow.Types.JID

  describe "build_get_settings_iq/1" do
    test "correct namespace, type, server JID" do
      iq = Privacy.build_get_settings_iq(id: "ID-1")
      assert iq.attrs["xmlns"] == "privacy"
      assert iq.attrs["type"] == "get"
      assert iq.attrs["to"] == "s.whatsapp.net"
      assert iq.attrs["id"] == "ID-1"
      assert [%Node{tag: "privacy"}] = iq.content
    end
  end

  describe "build_set_setting_iq/3" do
    test "maps :last_seen, :all → category[name=last,value=all]" do
      iq = Privacy.build_set_setting_iq(:last_seen, :all)

      [privacy] = iq.content
      [category] = privacy.content
      assert category.attrs["name"] == "last"
      assert category.attrs["value"] == "all"
    end

    test "maps :read_receipts, :nobody → category[name=readreceipts,value=none]" do
      iq = Privacy.build_set_setting_iq(:read_receipts, :nobody)
      [privacy] = iq.content
      [category] = privacy.content
      assert category.attrs["name"] == "readreceipts"
      assert category.attrs["value"] == "none"
    end

    test "raises on unknown setting name" do
      assert_raise ArgumentError, fn ->
        Privacy.build_set_setting_iq(:bogus_setting, :all)
      end
    end

    test "raises on unknown setting value" do
      assert_raise ArgumentError, fn ->
        Privacy.build_set_setting_iq(:last_seen, :bogus_value)
      end
    end
  end

  describe "parse_privacy_node/1" do
    test "extracts settings from category children" do
      privacy =
        Node.new("privacy", %{}, [
          Node.new("category", %{"name" => "last", "value" => "contacts"}, nil),
          Node.new("category", %{"name" => "readreceipts", "value" => "all"}, nil),
          Node.new("category", %{"name" => "profile", "value" => "none"}, nil)
        ])

      settings = Privacy.parse_privacy_node(privacy)
      assert %Settings{last_seen: :contacts, read_receipts: :all, profile: :nobody} = settings
    end

    test "ignores unknown category names" do
      privacy =
        Node.new("privacy", %{}, [
          Node.new("category", %{"name" => "future_setting", "value" => "all"}, nil),
          Node.new("category", %{"name" => "last", "value" => "all"}, nil)
        ])

      settings = Privacy.parse_privacy_node(privacy)
      assert settings.last_seen == :all
    end
  end

  describe "parse_blocklist_node/1" do
    test "extracts JIDs and dhash" do
      list =
        Node.new("list", %{"dhash" => "abc123"}, [
          Node.new("item", %{"jid" => "1@s.whatsapp.net"}, nil),
          Node.new("item", %{"jid" => "2@s.whatsapp.net"}, nil)
        ])

      assert %Blocklist{dhash: "abc123", jids: [j1, j2]} =
               Privacy.parse_blocklist_node(list)

      assert %JID{user: "1"} = j1
      assert %JID{user: "2"} = j2
    end

    test "accepts pre-parsed %JID{} attr values" do
      {:ok, parsed} = JID.parse("9@s.whatsapp.net")

      list =
        Node.new("list", %{}, [
          Node.new("item", %{"jid" => parsed}, nil)
        ])

      assert %Blocklist{jids: [^parsed]} = Privacy.parse_blocklist_node(list)
    end

    test "skips items with missing jid" do
      list = Node.new("list", %{}, [Node.new("item", %{}, nil)])
      assert %Blocklist{jids: []} = Privacy.parse_blocklist_node(list)
    end
  end
end
