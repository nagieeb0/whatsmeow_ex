defmodule Whatsmeow.ReceiptTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Receipt

  defp inbound_msg(extra_attrs \\ %{}) do
    attrs =
      %{
        "id" => "3EB0ABCD1234",
        "from" => "447400000000@s.whatsapp.net",
        "t" => "1715000000"
      }
      |> Map.merge(extra_attrs)

    Node.new("message", attrs, [])
  end

  describe "build_retry_receipt/2" do
    test "produces the canonical shape: receipt → retry + registration" do
      msg = inbound_msg()

      node = Receipt.build_retry_receipt(msg, count: 1, registration_id: 42)

      assert node.tag == "receipt"
      assert node.attrs["id"] == "3EB0ABCD1234"
      assert node.attrs["to"] == "447400000000@s.whatsapp.net"
      assert node.attrs["type"] == "retry"

      assert [retry, registration] = node.content
      assert retry.tag == "retry"
      assert retry.attrs["count"] == "1"
      assert retry.attrs["id"] == "3EB0ABCD1234"
      assert retry.attrs["v"] == "1"
      assert retry.attrs["t"] == "1715000000"

      assert registration.tag == "registration"
      assert registration.content == <<42::big-unsigned-32>>
    end

    test "default count is 1, default registration_id is 0 (big-endian uint32)" do
      node = Receipt.build_retry_receipt(inbound_msg())

      [retry, registration] = node.content
      assert retry.attrs["count"] == "1"
      assert registration.content == <<0::big-unsigned-32>>
    end

    test "echoes participant + recipient when present" do
      msg =
        inbound_msg(%{
          "participant" => "111@s.whatsapp.net",
          "recipient" => "222@s.whatsapp.net"
        })

      node = Receipt.build_retry_receipt(msg)

      assert node.attrs["participant"] == "111@s.whatsapp.net"
      assert node.attrs["recipient"] == "222@s.whatsapp.net"
    end

    test "attaches <keys> child when :keys opt is provided" do
      identity_pub = :crypto.strong_rand_bytes(32)
      prekey_node = Node.new("key", %{}, [Node.new("id", %{}, <<7::big-unsigned-24>>)])
      signed_node = Node.new("skey", %{}, [Node.new("id", %{}, <<1::big-unsigned-24>>)])
      device_identity = :crypto.strong_rand_bytes(64)

      node =
        Receipt.build_retry_receipt(inbound_msg(),
          count: 2,
          keys: {identity_pub, signed_node, prekey_node, device_identity}
        )

      assert [_retry, _registration, keys] = node.content
      assert keys.tag == "keys"

      [type, identity, pkey, skey, di] = keys.content
      assert type.tag == "type" and type.content == <<0x05>>
      assert identity.tag == "identity" and identity.content == identity_pub
      assert pkey.tag == "key"
      assert skey.tag == "skey"
      assert di.tag == "device-identity" and di.content == device_identity
    end

    test "no <keys> child when :keys opt absent" do
      node = Receipt.build_retry_receipt(inbound_msg(), count: 1)
      assert length(node.content) == 2
    end
  end

  describe "from_node/2 — type=retry" do
    test "parses a retry receipt into :retry event" do
      node =
        Node.new(
          "receipt",
          %{
            "type" => "retry",
            "id" => "MSG1",
            "from" => "447400000000@s.whatsapp.net"
          },
          [Node.new("retry", %{"count" => "1", "id" => "MSG1"}, nil)]
        )

      ev = Receipt.from_node("device-1", node)
      assert ev.type == :retry
      assert ev.message_ids == ["MSG1"]
    end
  end
end
