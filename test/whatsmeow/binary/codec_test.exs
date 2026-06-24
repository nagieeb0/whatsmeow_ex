defmodule Whatsmeow.Binary.CodecTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Whatsmeow.Binary
  alias Whatsmeow.Binary.{Decoder, Node}
  alias Whatsmeow.Types.JID

  describe "round-trip — leaf nodes" do
    test "tag-only node with a single-byte token tag" do
      n = Node.new("iq")
      encoded = Binary.encode(n)
      assert {:ok, decoded} = Binary.decode(encoded)
      assert decoded == n
    end

    test "tag with one attribute (both single-byte tokens)" do
      n = Node.new("iq", %{"type" => "set"})
      assert {:ok, ^n} = Binary.decode(Binary.encode(n))
    end

    test "tag with attribute holding a JID" do
      jid = %JID{user: "447400000000", server: "s.whatsapp.net"}
      n = Node.new("message", %{"to" => jid})
      assert {:ok, decoded} = Binary.decode(Binary.encode(n))
      assert decoded.tag == "message"
      assert decoded.attrs["to"] == jid
    end

    test "tag with raw-binary content" do
      n = Node.new("enc", %{}, "some binary content")
      assert {:ok, decoded} = Binary.decode(Binary.encode(n))
      assert decoded.tag == "enc"
      assert decoded.content == "some binary content"
    end

    test "AD-JID round-trip" do
      jid = %JID{user: "447400000000", device: 3, server: "s.whatsapp.net"}
      n = Node.new("to", %{"jid" => jid})
      assert {:ok, decoded} = Binary.decode(Binary.encode(n))
      assert decoded.attrs["jid"] == jid
    end
  end

  describe "round-trip — nested" do
    test "node with list of child nodes" do
      children = [
        Node.new("device", %{"jid" => "1@s.whatsapp.net"}),
        Node.new("device", %{"jid" => "2@s.whatsapp.net"})
      ]

      n = Node.new("devices", %{}, children)

      assert {:ok, decoded} = Binary.decode(Binary.encode(n))
      assert decoded.tag == "devices"
      assert is_list(decoded.content)
      assert length(decoded.content) == 2
    end

    test "deeply nested tree" do
      tree =
        Node.new("iq", %{"id" => "abc", "type" => "set"}, [
          Node.new("query", %{"xmlns" => "urn:xmpp:ping"})
        ])

      assert {:ok, decoded} = Binary.decode(Binary.encode(tree))
      assert decoded.tag == "iq"
      assert decoded.attrs["id"] == "abc"
      assert hd(decoded.content).tag == "query"
    end
  end

  describe "packed nibble strings" do
    test "phone-number-style strings round-trip via nibble packing" do
      # "1234567890" is pack-as-nibble eligible (digits only)
      n = Node.new("user", %{"phone" => "1234567890"})
      assert {:ok, decoded} = Binary.decode(Binary.encode(n))
      assert decoded.attrs["phone"] == "1234567890"
    end

    test "uppercase-hex strings round-trip via hex packing" do
      n = Node.new("key", %{"id" => "ABCDEF0123"})
      assert {:ok, decoded} = Binary.decode(Binary.encode(n))
      assert decoded.attrs["id"] == "ABCDEF0123"
    end
  end

  describe "error handling" do
    test "decoding empty input returns :error" do
      assert {:error, :eof} = Decoder.decode(<<>>, strip_flag?: false)
    end

    test "decoding a single byte 0 returns invalid_node" do
      assert {:error, :invalid_node} = Decoder.decode(<<0, 0>>, strip_flag?: false)
    end
  end

  describe "property: encode/decode is identity for random trees" do
    property "Node round-trip" do
      check all(tree <- node_gen(3), max_runs: 50) do
        encoded = Binary.encode(tree)
        assert {:ok, decoded} = Binary.decode(encoded)
        assert decoded == tree
      end
    end

    defp node_gen(0) do
      gen all(
            tag <- StreamData.member_of(~w(iq message receipt enc device key from to)),
            attrs <- attr_gen(2)
          ) do
        Node.new(tag, attrs, nil)
      end
    end

    defp node_gen(depth) when depth > 0 do
      child = node_gen(depth - 1)

      gen all(
            tag <- StreamData.member_of(~w(iq message receipt notification list)),
            attrs <- attr_gen(2),
            children <- StreamData.list_of(child, max_length: 3),
            include_children? <- StreamData.boolean()
          ) do
        content = if include_children? and children != [], do: children, else: nil
        Node.new(tag, attrs, content)
      end
    end

    defp attr_gen(max) do
      gen all(
            pairs <-
              StreamData.list_of(
                StreamData.tuple({
                  StreamData.member_of(~w(type id from to participant version count xmlns)),
                  StreamData.member_of(["set", "get", "result", "1", "abc", "xyz"])
                }),
                max_length: max
              )
          ) do
        Map.new(pairs)
      end
    end
  end
end
