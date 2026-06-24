defmodule Whatsmeow.UserTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Types.JID
  alias Whatsmeow.User
  alias Whatsmeow.User.{Info, IsOnWhatsAppResponse}

  defp user_with_jid(jid, children, extra_attrs \\ %{}) do
    Node.new("user", Map.merge(%{"jid" => jid}, extra_attrs), children)
  end

  defp devices_node(ids, opts \\ []) do
    hosted? = Keyword.get(opts, :hosted, false)

    children =
      Enum.map(ids, fn id ->
        attrs = %{"id" => id}
        attrs = if hosted?, do: Map.put(attrs, "is_hosted", "true"), else: attrs
        Node.new("device", attrs, nil)
      end)

    Node.new("devices", %{"version" => "2"}, [Node.new("device-list", %{}, children)])
  end

  describe "parse_device_list/2" do
    test "returns AD-JIDs preserving the user component and overriding device" do
      {:ok, base} = JID.parse("447400000000@s.whatsapp.net")
      devices = devices_node([0, 1, 17])

      ads = User.parse_device_list(base, devices)

      assert length(ads) == 3
      assert Enum.map(ads, & &1.device) == [0, 1, 17]
      assert Enum.all?(ads, &(&1.user == "447400000000"))
      assert Enum.all?(ads, &(&1.server == "s.whatsapp.net"))
    end

    test "rewrites server to hosted when is_hosted=\"true\"" do
      {:ok, base} = JID.parse("447400000000@s.whatsapp.net")
      devices = devices_node([5], hosted: true)

      assert [%JID{device: 5, server: "hosted"}] = User.parse_device_list(base, devices)
    end

    test "hidden-user (lid) → hosted.lid when is_hosted=\"true\"" do
      {:ok, base} = JID.parse("447400000000@lid")
      devices = devices_node([2], hosted: true)

      assert [%JID{device: 2, server: "hosted.lid"}] = User.parse_device_list(base, devices)
    end

    test "tolerates integer device ids (decoder already coerced)" do
      {:ok, base} = JID.parse("1@s.whatsapp.net")

      list =
        Node.new("devices", %{"version" => "2"}, [
          Node.new("device-list", %{}, [Node.new("device", %{"id" => 9}, nil)])
        ])

      assert [%JID{device: 9}] = User.parse_device_list(base, list)
    end

    test "skips devices with malformed or negative ids" do
      {:ok, base} = JID.parse("1@s.whatsapp.net")

      list =
        Node.new("devices", %{"version" => "2"}, [
          Node.new("device-list", %{}, [
            Node.new("device", %{"id" => "abc"}, nil),
            Node.new("device", %{"id" => "-1"}, nil),
            Node.new("device", %{"id" => "4"}, nil)
          ])
        ])

      assert [%JID{device: 4}] = User.parse_device_list(base, list)
    end

    test "returns [] for nil / unexpected tags / missing device-list child" do
      {:ok, base} = JID.parse("1@s.whatsapp.net")

      assert User.parse_device_list(base, nil) == []
      assert User.parse_device_list(base, Node.new("devices", %{}, nil)) == []

      # devices tag but no inner device-list
      stray = Node.new("devices", %{"version" => "2"}, [Node.new("other", %{}, nil)])
      assert User.parse_device_list(base, stray) == []
    end
  end

  describe "parse_is_on_whatsapp/1" do
    test "registered contact → is_in? true, jid preserved, query suffix stripped" do
      list =
        Node.new("list", %{}, [
          user_with_jid("447400000000@s.whatsapp.net", [
            Node.new("contact", %{"type" => "in"}, "+447400000000@c.us")
          ])
        ])

      assert [
               %IsOnWhatsAppResponse{
                 query: "+447400000000",
                 jid: %JID{user: "447400000000", server: "s.whatsapp.net"},
                 is_in?: true,
                 verified_name: nil
               }
             ] = User.parse_is_on_whatsapp(list)
    end

    test "unregistered contact → is_in? false" do
      list =
        Node.new("list", %{}, [
          user_with_jid("1@s.whatsapp.net", [
            Node.new("contact", %{"type" => "out"}, "+1@c.us")
          ])
        ])

      assert [%IsOnWhatsAppResponse{is_in?: false}] = User.parse_is_on_whatsapp(list)
    end

    test "skips children that aren't <user> or that lack a jid attr" do
      list =
        Node.new("list", %{}, [
          Node.new("garbage", %{}, nil),
          Node.new("user", %{}, []),
          user_with_jid("1@s.whatsapp.net", [Node.new("contact", %{"type" => "in"}, "+1@c.us")])
        ])

      assert [%IsOnWhatsAppResponse{jid: %JID{user: "1"}}] = User.parse_is_on_whatsapp(list)
    end

    test "verified-name surfaced when business/verified_name child is present" do
      list =
        Node.new("list", %{}, [
          user_with_jid("2@s.whatsapp.net", [
            Node.new("business", %{}, [Node.new("verified_name", %{}, "ACME proto bytes")]),
            Node.new("contact", %{"type" => "in"}, "+2@c.us")
          ])
        ])

      assert [%IsOnWhatsAppResponse{verified_name: "ACME proto bytes"}] =
               User.parse_is_on_whatsapp(list)
    end

    test "accepts pre-parsed %JID{} attr (binary-XML decoder may coerce)" do
      {:ok, parsed} = JID.parse("3@s.whatsapp.net")

      list =
        Node.new("list", %{}, [
          Node.new(
            "user",
            %{"jid" => parsed},
            [Node.new("contact", %{"type" => "in"}, "+3@c.us")]
          )
        ])

      assert [%IsOnWhatsAppResponse{jid: ^parsed}] = User.parse_is_on_whatsapp(list)
    end
  end

  describe "parse_user_info/1" do
    test "extracts status, picture id, lid, devices, verified name" do
      list =
        Node.new("list", %{}, [
          user_with_jid("447400000000@s.whatsapp.net", [
            Node.new("business", %{}, [Node.new("verified_name", %{}, "vname-bytes")]),
            Node.new("status", %{}, "hello world"),
            Node.new("picture", %{"id" => "12345"}, nil),
            devices_node([0, 1]),
            Node.new("lid", %{"val" => "11111.0:0@lid"}, nil)
          ])
        ])

      assert %{"447400000000@s.whatsapp.net" => info} = User.parse_user_info(list)
      assert %Info{} = info
      assert info.status == "hello world"
      assert info.picture_id == "12345"
      assert info.verified_name == "vname-bytes"
      assert info.lid.user == "11111"
      assert Enum.map(info.devices, & &1.device) == [0, 1]
    end

    test "missing optional children leave struct fields nil/[]" do
      list =
        Node.new("list", %{}, [
          user_with_jid("1@s.whatsapp.net", [])
        ])

      assert %{"1@s.whatsapp.net" => info} = User.parse_user_info(list)
      assert info.status == nil
      assert info.picture_id == nil
      assert info.verified_name == nil
      assert info.lid == nil
      assert info.devices == []
    end
  end
end
