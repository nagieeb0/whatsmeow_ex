defmodule Whatsmeow.Types.JIDTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Whatsmeow.Types.JID

  doctest JID

  describe "parse/1 — regular JIDs" do
    test "phone number on s.whatsapp.net" do
      assert {:ok, jid} = JID.parse("447400000000@s.whatsapp.net")
      assert jid == %JID{user: "447400000000", server: "s.whatsapp.net"}
    end

    test "group JID on g.us" do
      assert {:ok, %JID{user: "1234567890-1612345678", server: "g.us"}} =
               JID.parse("1234567890-1612345678@g.us")
    end

    test "status broadcast" do
      assert {:ok, %JID{user: "status", server: "broadcast"}} = JID.parse("status@broadcast")
    end

    test "newsletter" do
      assert {:ok, %JID{user: "120363012345678901", server: "newsletter"}} =
               JID.parse("120363012345678901@newsletter")
    end

    test "server-only JID" do
      assert {:ok, %JID{user: "", server: "g.us"}} = JID.parse("g.us")
    end
  end

  describe "parse/1 — device JIDs" do
    test "device-only form (user:device@server)" do
      assert {:ok, %JID{user: "447400000000", agent: 0, device: 2, server: "s.whatsapp.net"}} =
               JID.parse("447400000000:2@s.whatsapp.net")
    end

    test "AD-JID form (user.agent:device@server)" do
      assert {:ok, %JID{user: "447400000000", agent: 1, device: 3, server: "s.whatsapp.net"}} =
               JID.parse("447400000000.1:3@s.whatsapp.net")
    end

    test "AD-JID without explicit device" do
      assert {:ok, %JID{user: "447400000000", agent: 2, device: 0, server: "s.whatsapp.net"}} =
               JID.parse("447400000000.2@s.whatsapp.net")
    end
  end

  describe "parse/1 — invalid input" do
    test "multiple dots" do
      assert {:error, :unexpected_dot_count} = JID.parse("user.1.2@s.whatsapp.net")
    end

    test "non-integer agent" do
      assert {:error, :invalid_integer} = JID.parse("user.abc:1@s.whatsapp.net")
    end

    test "non-integer device" do
      assert {:error, :invalid_integer} = JID.parse("user.1:abc@s.whatsapp.net")
    end

    test "agent overflow" do
      assert {:error, :invalid_integer} = JID.parse("user.256:1@s.whatsapp.net")
    end

    test "device overflow" do
      assert {:error, :invalid_integer} = JID.parse("user.1:65536@s.whatsapp.net")
    end
  end

  describe "to_string/1 — round-trip" do
    test "regular JID" do
      jid = JID.new("447400000000", "s.whatsapp.net")
      assert JID.to_string(jid) == "447400000000@s.whatsapp.net"
      assert {:ok, ^jid} = JID.parse(JID.to_string(jid))
    end

    test "device-only JID" do
      jid = %JID{user: "447400000000", device: 2, server: "s.whatsapp.net"}
      assert JID.to_string(jid) == "447400000000:2@s.whatsapp.net"
      assert {:ok, ^jid} = JID.parse(JID.to_string(jid))
    end

    test "AD-JID with agent" do
      jid = %JID{user: "447400000000", agent: 1, device: 3, server: "s.whatsapp.net"}
      assert JID.to_string(jid) == "447400000000.1:3@s.whatsapp.net"
      assert {:ok, ^jid} = JID.parse(JID.to_string(jid))
    end

    test "server-only" do
      jid = %JID{user: "", server: "g.us"}
      assert JID.to_string(jid) == "g.us"
      assert {:ok, ^jid} = JID.parse(JID.to_string(jid))
    end
  end

  describe "iron law: no atom creation from network input" do
    test "parsing a brand-new server string does not create a new atom" do
      atoms_before = :erlang.system_info(:atom_count)
      _ = JID.parse("user@some-random-server-#{System.unique_integer([:positive])}.example")
      atoms_after = :erlang.system_info(:atom_count)
      assert atoms_after == atoms_before
    end
  end

  describe "helpers" do
    test "to_non_ad/1 strips agent and device" do
      jid = %JID{user: "447400000000", agent: 1, device: 3, server: "s.whatsapp.net"}

      assert %JID{user: "447400000000", agent: 0, device: 0, server: "s.whatsapp.net"} =
               JID.to_non_ad(jid)
    end

    test "empty?/1 distinguishes empty from server-only" do
      assert JID.empty?(%JID{server: ""})
      refute JID.empty?(%JID{server: "g.us"})
    end

    test "user_int/1 parses numeric users" do
      assert JID.user_int(%JID{user: "447400000000", server: "s.whatsapp.net"}) ==
               447_400_000_000
    end

    test "user_int/1 returns nil for non-numeric users" do
      assert JID.user_int(%JID{user: "status", server: "broadcast"}) == nil
    end

    test "actual_agent/1 maps server to domain type" do
      assert JID.actual_agent(JID.new("u", "s.whatsapp.net")) == 0
      assert JID.actual_agent(JID.new("u", "lid")) == 1
      assert JID.actual_agent(JID.new("u", "hosted")) == 128
      assert JID.actual_agent(JID.new("u", "hosted.lid")) == 129
      assert JID.actual_agent(%JID{user: "u", agent: 5, server: "g.us"}) == 5
    end
  end

  describe "property: parse(to_string(jid)) == jid" do
    property "round-trip for arbitrary valid JIDs" do
      check all(
              user <- StreamData.string(:alphanumeric, min_length: 0, max_length: 20),
              agent <- StreamData.integer(0..255),
              device <- StreamData.integer(0..65_535),
              server <-
                StreamData.member_of([
                  "s.whatsapp.net",
                  "g.us",
                  "lid",
                  "broadcast",
                  "newsletter",
                  "bot",
                  "c.us"
                ])
            ) do
        jid = %JID{user: user, agent: agent, device: device, server: server}
        formatted = JID.to_string(jid)
        assert {:ok, parsed} = JID.parse(formatted)
        assert parsed == jid
      end
    end
  end
end
