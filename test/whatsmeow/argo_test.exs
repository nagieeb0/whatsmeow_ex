defmodule Whatsmeow.ArgoTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  import Bitwise

  alias Whatsmeow.Argo
  alias Whatsmeow.Argo.{Label, Store, Varint}

  describe "Varint" do
    test "ULEB128 round-trip on small ints" do
      for n <- [0, 1, 127, 128, 255, 16_383, 16_384, 1_000_000, 1 <<< 40] do
        bin = Varint.unsigned_encode(n)
        assert {^n, ""} = Varint.unsigned_decode(bin)
      end
    end

    test "ZigZag handles signed ints around 0" do
      assert Varint.zigzag_encode(0) == 0
      assert Varint.zigzag_encode(-1) == 1
      assert Varint.zigzag_encode(1) == 2
      assert Varint.zigzag_encode(-2) == 3
      assert Varint.zigzag_encode(2_147_483_647) == 4_294_967_294
      assert Varint.zigzag_decode(Varint.zigzag_encode(-2_147_483_648)) == -2_147_483_648
    end

    property "signed varint round-trips" do
      check all(n <- integer(-1_000_000_000..1_000_000_000)) do
        {decoded, ""} = Varint.signed_decode(Varint.signed_encode(n))
        assert decoded == n
      end
    end
  end

  describe "Label" do
    test "classify sentinels and lengths" do
      assert Label.kind(Label.null()) == :null
      assert Label.kind(Label.absent()) == :absent
      assert Label.kind(Label.error_marker()) == :error
      assert Label.kind(0) == :length
      assert Label.kind(5) == :length
      assert Label.kind(-4) == :backref
      assert Label.kind(-100) == :backref
    end

    test "backref → offset" do
      assert Label.to_offset(-4) == {:ok, 1}
      assert Label.to_offset(-5) == {:ok, 2}
      assert Label.to_offset(-10) == {:ok, 7}
      assert Label.to_offset(-1) == {:error, :not_a_backref}
    end
  end

  describe "Self-describing round-trip" do
    test "nil/true/false" do
      for v <- [nil, true, false] do
        assert {:ok, ^v, ""} = Argo.decode(Argo.encode(v))
      end
    end

    test "integers — signed range" do
      for n <- [0, 1, -1, 42, -42, 2_147_483_647, -2_147_483_648, 1 <<< 50] do
        assert {:ok, ^n, ""} = Argo.decode(Argo.encode(n))
      end
    end

    test "floats" do
      for f <- [0.0, 1.5, -3.14159, 1.0e300, -1.0e-200] do
        assert {:ok, decoded, ""} = Argo.decode(Argo.encode(f))
        assert decoded == f
      end
    end

    test "strings (UTF-8) and raw bytes" do
      assert {:ok, "héllo", ""} = Argo.decode(Argo.encode("héllo"))

      assert {:ok, <<0xFF, 0xFE, 0x00>>, ""} =
               Argo.decode(Argo.encode({:bytes, <<0xFF, 0xFE, 0x00>>}))
    end

    test "list" do
      v = [1, "two", 3.0, nil, true]
      assert {:ok, ^v, ""} = Argo.decode(Argo.encode(v))
    end

    test "map with binary keys" do
      v = %{"name" => "alice", "age" => 30, "active" => true}
      assert {:ok, ^v, ""} = Argo.decode(Argo.encode(v))
    end

    test "nested structures" do
      v = %{
        "users" => [
          %{"id" => 1, "name" => "a"},
          %{"id" => 2, "name" => "b"}
        ],
        "count" => 2
      }

      assert {:ok, ^v, ""} = Argo.decode(Argo.encode(v))
    end
  end

  describe "Query-id store" do
    setup do
      Store.reload()
      :ok
    end

    test "lookups are bidirectional" do
      [name | _] = Store.names()
      id = Store.query_id_for_name(name)
      assert is_binary(id)
      assert Store.name_for_query_id(id) == name
    end

    test "unknown names return nil" do
      assert Store.query_id_for_name("XXXX-not-real") == nil
      assert Store.name_for_query_id("00000") == nil
    end
  end
end
