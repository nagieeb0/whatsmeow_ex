defmodule Whatsmeow.NewsletterTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Newsletter

  @channel "120363026XXXXXXXXX@newsletter"

  describe "build_subscribe_live_updates_iq/2" do
    test "canonical shape" do
      iq = Newsletter.build_subscribe_live_updates_iq(@channel, id: "FX")

      assert iq.tag == "iq"
      assert iq.attrs["xmlns"] == "newsletter"
      assert iq.attrs["type"] == "set"
      assert iq.attrs["id"] == "FX"
      assert iq.attrs["to"].server == "newsletter"
      [lu] = iq.content
      assert lu.tag == "live_updates"
    end

    test "rejects non-newsletter JIDs" do
      assert_raise MatchError, fn ->
        Newsletter.build_subscribe_live_updates_iq("12345@s.whatsapp.net")
      end
    end
  end

  describe "build_mark_viewed_node/3" do
    test "produces <receipt type=view><list><item server_id=N>...>" do
      node = Newsletter.build_mark_viewed_node(@channel, [100, 101, 102], id: "RX")

      assert node.tag == "receipt"
      assert node.attrs["type"] == "view"
      assert node.attrs["id"] == "RX"

      [list] = node.content
      assert list.tag == "list"
      items = list.content
      assert length(items) == 3
      assert Enum.map(items, & &1.attrs["server_id"]) == ["100", "101", "102"]
    end

    test "string server_ids pass through as-is" do
      node = Newsletter.build_mark_viewed_node(@channel, ["abc"])
      [list] = node.content
      [item] = list.content
      assert item.attrs["server_id"] == "abc"
    end
  end

  describe "build_send_reaction_node/4" do
    test "adding a reaction (code attr present, no edit)" do
      node = Newsletter.build_send_reaction_node(@channel, 42, "🐈️", message_id: "MID-1")

      assert node.tag == "message"
      assert node.attrs["type"] == "reaction"
      assert node.attrs["server_id"] == "42"
      assert node.attrs["id"] == "MID-1"
      refute Map.has_key?(node.attrs, "edit")

      [reaction] = node.content
      assert reaction.tag == "reaction"
      assert reaction.attrs["code"] == "🐈️"
    end

    test "removing a reaction: empty string → edit=7, no code attr" do
      node = Newsletter.build_send_reaction_node(@channel, 42, "")
      assert node.attrs["edit"] == "7"

      [reaction] = node.content
      refute Map.has_key?(reaction.attrs, "code")
    end

    test "auto-generates a message_id when not provided" do
      node = Newsletter.build_send_reaction_node(@channel, 42, "👍")
      assert is_binary(node.attrs["id"])
      assert String.starts_with?(node.attrs["id"], "3EB0")
    end
  end
end
