defmodule Whatsmeow.LoginTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Login
  alias Whatsmeow.Login.Result
  alias Whatsmeow.Types.JID

  describe "parse_first_node/1 — success" do
    test "returns Result with lid and computed server_time_offset" do
      t = System.system_time(:second) + 7
      node = Node.new("success", %{"lid" => "201068010145.0:84@lid", "t" => Integer.to_string(t)})

      assert {:ok, %Result{lid: "201068010145.0:84@lid", server_time_offset: offset}} =
               Login.parse_first_node(node)

      # The math is `server - local`. We just slept ~0ms, so the offset is
      # whatever we baked in (7) plus or minus a one-second window. Cap the
      # tolerance generously to keep this from flaking on slow CI boxes.
      assert offset >= 5 and offset <= 9
    end

    test "normalizes a JID-typed lid attr to canonical string form" do
      jid = %JID{user: "201068010145", agent: 0, device: 84, server: "lid"}
      node = Node.new("success", %{"lid" => jid, "t" => "1715000000"})

      assert {:ok, %Result{lid: lid}} = Login.parse_first_node(node)
      assert lid == JID.to_string(jid)
    end

    test "tolerates a missing or empty lid attr" do
      node = Node.new("success", %{"t" => "1715000000"})
      assert {:ok, %Result{lid: nil}} = Login.parse_first_node(node)

      node2 = Node.new("success", %{"lid" => "", "t" => "1715000000"})
      assert {:ok, %Result{lid: nil}} = Login.parse_first_node(node2)
    end

    test "tolerates a missing t attr (offset becomes nil)" do
      node = Node.new("success", %{"lid" => "201068010145.0:84@lid"})
      assert {:ok, %Result{server_time_offset: nil}} = Login.parse_first_node(node)
    end

    test "rejects a non-integer t attr without crashing" do
      node = Node.new("success", %{"t" => "not-a-number"})
      assert {:ok, %Result{server_time_offset: nil}} = Login.parse_first_node(node)
    end
  end

  describe "parse_first_node/1 — error stanzas" do
    test "stream:error surfaces the code" do
      node = Node.new("stream:error", %{"code" => "500"})
      assert {:error, {:stream_error, "500"}} = Login.parse_first_node(node)
    end

    test "stream:error without a code still routes through" do
      node = Node.new("stream:error", %{})
      assert {:error, {:stream_error, nil}} = Login.parse_first_node(node)
    end

    test "failure surfaces both reason and code" do
      node = Node.new("failure", %{"reason" => "401", "code" => "device-removed"})
      assert {:error, {:failure, "401", "device-removed"}} = Login.parse_first_node(node)
    end

    test "unexpected tags become :unexpected_node" do
      node = Node.new("iq", %{"type" => "result"})
      assert {:error, :unexpected_node} = Login.parse_first_node(node)
    end
  end
end
