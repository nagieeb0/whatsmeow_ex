defmodule Whatsmeow.SendTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Send
  alias Whatsmeow.Types.JID

  describe "generate_message_id/0" do
    test "starts with the upstream 3EB0 prefix" do
      assert "3EB0" <> _rest = Send.generate_message_id()
    end

    test "is unique across calls" do
      ids = for _ <- 1..50, do: Send.generate_message_id()
      assert length(Enum.uniq(ids)) == 50
    end
  end

  describe "build_text_message_node/4" do
    test "wraps the Signal envelope under <message><enc v=2 type=msg>" do
      to = %JID{user: "1234567890", server: "s.whatsapp.net"}
      envelope = <<0x33, 1, 2, 3, 4, 5, 6>>

      msg = Send.build_text_message_node(to, "3EB0ABCD", envelope, "msg")

      assert %Node{tag: "message", attrs: %{"id" => "3EB0ABCD", "type" => "text", "to" => ^to}} =
               msg

      assert [%Node{tag: "enc", attrs: %{"v" => "2", "type" => "msg"}, content: ^envelope}] =
               Node.children(msg)
    end

    test "type=pkmsg is accepted (first-contact)" do
      to = %JID{user: "1", server: "s.whatsapp.net"}
      msg = Send.build_text_message_node(to, "id", <<0x33>>, "pkmsg")
      [%Node{attrs: %{"type" => "pkmsg"}}] = Node.children(msg)
    end

    test "rejects unknown enc types at the guard" do
      to = %JID{user: "1", server: "s.whatsapp.net"}

      assert_raise FunctionClauseError, fn ->
        Send.build_text_message_node(to, "id", <<0>>, "skmsg")
      end
    end
  end

  describe "build_e2e_text_message/1" do
    test "produces decodable WAWebProtobufsE2E.Message bytes with conversation set" do
      bytes = Send.build_e2e_text_message("Hello, world")
      decoded = WAWebProtobufsE2E.Message.decode(bytes)
      assert decoded.conversation == "Hello, world"
    end

    test "empty string round-trips" do
      bytes = Send.build_e2e_text_message("")
      decoded = WAWebProtobufsE2E.Message.decode(bytes)
      assert decoded.conversation == ""
    end
  end
end
