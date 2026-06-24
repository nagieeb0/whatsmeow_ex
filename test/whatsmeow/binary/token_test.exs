defmodule Whatsmeow.Binary.TokenTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Token

  describe "compile-time table integrity" do
    test "dict_version is 3 (matches Go source)" do
      assert Token.dict_version() == 3
    end

    test "single_count is 236" do
      assert Token.single_count() == 236
    end

    test "double_dict_count is 4" do
      assert Token.double_dict_count() == 4
    end
  end

  describe "single-byte tokens — known values from Go source" do
    test "index 3 is the WhatsApp server name" do
      assert {:ok, "s.whatsapp.net"} = Token.at_single(3)
    end

    test "index 5 is 'participant'" do
      assert {:ok, "participant"} = Token.at_single(5)
    end

    test "index 9 is 'notification'" do
      assert {:ok, "notification"} = Token.at_single(9)
    end

    test "out-of-bounds is :error" do
      assert :error = Token.at_single(500)
      assert :error = Token.at_single(-1)
    end
  end

  describe "single_index/1 round-trip" do
    test "s.whatsapp.net → 3 → 's.whatsapp.net'" do
      assert {:ok, 3} = Token.single_index("s.whatsapp.net")
      assert {:ok, "s.whatsapp.net"} = Token.at_single(3)
    end

    test "unknown string is :error" do
      assert :error = Token.single_index("definitely_not_a_token_#{System.unique_integer()}")
    end

    test "empty string never resolves (sentinel slot)" do
      assert :error = Token.single_index("")
    end
  end

  describe "double-byte tokens" do
    test "dict 0 has well-known strings ('read-self', 'active', 'fbns')" do
      assert {:ok, "read-self"} = Token.at_double(0, 0)
      assert {:ok, "active"} = Token.at_double(0, 1)
      assert {:ok, "fbns"} = Token.at_double(0, 2)
    end

    test "double_index/1 round-trips" do
      assert {:ok, 0, 0} = Token.double_index("read-self")
      assert {:ok, "read-self"} = Token.at_double(0, 0)
    end

    test "out-of-bounds is :error" do
      assert :error = Token.at_double(4, 0)
      assert :error = Token.at_double(0, 256)
    end
  end
end
