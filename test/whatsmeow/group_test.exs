defmodule Whatsmeow.GroupTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Group
  alias Whatsmeow.Group.Info
  alias Whatsmeow.Types.JID

  defp group_jid, do: "1234567890-9876543210@g.us"

  describe "build_create_iq/3" do
    test "basic create" do
      iq = Group.build_create_iq("test group", ["1@s.whatsapp.net", "2@s.whatsapp.net"], id: "FX")

      assert iq.tag == "iq"
      assert iq.attrs["xmlns"] == "w:g2"
      assert iq.attrs["type"] == "set"
      assert iq.attrs["to"] == "g.us"
      assert iq.attrs["id"] == "FX"

      [create] = iq.content
      assert create.tag == "create"
      assert create.attrs["subject"] == "test group"
      assert is_binary(create.attrs["key"])

      tags = Enum.map(create.content, & &1.tag)
      assert Enum.count(tags, &(&1 == "participant")) == 2
    end

    test "announce + locked + ephemeral_seconds" do
      iq =
        Group.build_create_iq("g", ["1@s.whatsapp.net"],
          announce?: true,
          locked?: true,
          ephemeral_seconds: 86_400
        )

      [create] = iq.content
      tags = Enum.map(create.content, & &1.tag)
      assert "announcement" in tags
      assert "locked" in tags
      assert "ephemeral" in tags

      eph = Enum.find(create.content, &(&1.tag == "ephemeral"))
      assert eph.attrs["expiration"] == "86400"
    end

    test "participants are downgraded to non-AD JIDs" do
      {:ok, ad} = JID.parse("99999.0:5@s.whatsapp.net")
      iq = Group.build_create_iq("g", [ad])

      [create] = iq.content
      [participant] = create.content
      assert participant.attrs["jid"].user == "99999"
      assert participant.attrs["jid"].device == 0
      assert participant.attrs["jid"].agent == 0
    end
  end

  describe "build_leave_iq/2" do
    test "<iq><leave><group id=…/></leave></iq>" do
      iq = Group.build_leave_iq(group_jid(), id: "X")
      assert iq.attrs["type"] == "set"
      [leave] = iq.content
      [group] = leave.content
      assert group.tag == "group"
      assert %JID{server: "g.us"} = group.attrs["id"]
    end

    test "rejects non-group JIDs" do
      assert_raise MatchError, fn ->
        Group.build_leave_iq("12345@s.whatsapp.net")
      end
    end
  end

  describe "build_get_info_iq/2" do
    test "type=get + xmlns=w:g2 + <query>" do
      iq = Group.build_get_info_iq(group_jid())
      assert iq.attrs["type"] == "get"
      [query] = iq.content
      assert query.tag == "query"
      assert query.attrs["request"] == "interactive"
    end
  end

  describe "build_set_name_iq/3" do
    test "<subject>name</subject>" do
      iq = Group.build_set_name_iq(group_jid(), "New Name")
      [subject] = iq.content
      assert subject.tag == "subject"
      assert subject.content == "New Name"
    end
  end

  describe "build_set_topic_iq/3" do
    test "topic body + auto-generated description id" do
      iq = Group.build_set_topic_iq(group_jid(), "the topic")
      [desc] = iq.content
      assert desc.tag == "description"
      assert is_binary(desc.attrs["id"])
      refute Map.has_key?(desc.attrs, "prev")

      [body] = desc.content
      assert body.tag == "body"
      assert body.content == "the topic"
    end

    test "previous_id sets the prev attr" do
      iq =
        Group.build_set_topic_iq(group_jid(), "new",
          description_id: "DESC-NEW",
          previous_id: "DESC-OLD"
        )

      [desc] = iq.content
      assert desc.attrs["id"] == "DESC-NEW"
      assert desc.attrs["prev"] == "DESC-OLD"
    end
  end

  describe "build_update_participants_iq/4" do
    for action <- [:add, :remove, :promote, :demote] do
      test "action #{inspect(action)} produces <#{action}><participant/></#{action}>" do
        iq =
          Group.build_update_participants_iq(group_jid(), ["1@s.whatsapp.net"], unquote(action))

        [action_node] = iq.content
        assert action_node.tag == Atom.to_string(unquote(action))
        [p] = action_node.content
        assert p.tag == "participant"
        assert p.attrs["jid"].user == "1"
      end
    end
  end

  describe "build_get_invite_link_iq/2" do
    test "default get" do
      iq = Group.build_get_invite_link_iq(group_jid())
      assert iq.attrs["type"] == "get"
      [invite] = iq.content
      assert invite.tag == "invite"
      refute Map.has_key?(invite.attrs, "reset")
    end

    test "reset?: true adds the reset attr" do
      iq = Group.build_get_invite_link_iq(group_jid(), reset?: true)
      [invite] = iq.content
      assert invite.attrs["reset"] == "true"
    end
  end

  describe "build_join_via_invite_iq/2" do
    test "embeds the code attr" do
      iq = Group.build_join_via_invite_iq("ABC123")
      [invite] = iq.content
      assert invite.tag == "invite"
      assert invite.attrs["code"] == "ABC123"
    end
  end

  describe "parse_group_node/1" do
    test "decodes core attrs + participants" do
      node =
        Node.new(
          "group",
          %{
            "id" => "1234567890-9876543210@g.us",
            "creator" => "111@s.whatsapp.net",
            "subject" => "my group",
            "creation" => "1715000000"
          },
          [
            Node.new("participant", %{"jid" => "111@s.whatsapp.net", "type" => "superadmin"}, nil),
            Node.new("participant", %{"jid" => "222@s.whatsapp.net"}, nil)
          ]
        )

      info = Group.parse_group_node(node)
      assert %Info{} = info
      assert info.jid.server == "g.us"
      assert info.owner.user == "111"
      assert info.name == "my group"
      assert info.creation == 1_715_000_000
      assert [p1, p2] = info.participants
      assert p1.role == :super_admin
      assert p2.role == :member
    end

    test "ephemeral expiration carried through" do
      node =
        Node.new(
          "group",
          %{"id" => "1@g.us"},
          [Node.new("ephemeral", %{"expiration" => "604800"}, nil)]
        )

      info = Group.parse_group_node(node)
      assert info.is_ephemeral?
      assert info.disappearing_timer == 604_800
    end

    test "announcement + locked flags" do
      node =
        Node.new(
          "group",
          %{"id" => "1@g.us"},
          [
            Node.new("announcement", %{}, nil),
            Node.new("locked", %{}, nil)
          ]
        )

      info = Group.parse_group_node(node)
      assert info.is_announce?
      assert info.is_locked?
    end
  end
end
