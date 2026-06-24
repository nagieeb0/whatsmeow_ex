defmodule Whatsmeow.AppState.LTHashTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.AppState.LTHash

  describe "pointwise/3" do
    test "adding zeros leaves base unchanged" do
      base = :crypto.strong_rand_bytes(128)
      assert LTHash.pointwise(base, <<0::1024>>, :add) == base
    end

    test "add then sub returns base unchanged (homomorphic round-trip)" do
      base = :crypto.strong_rand_bytes(128)
      delta = :crypto.strong_rand_bytes(128)
      after_add = LTHash.pointwise(base, delta, :add)
      assert LTHash.pointwise(after_add, delta, :sub) == base
    end

    test "u16 little-endian addition wraps at 2^16" do
      base = <<0xFFFF::little-unsigned-16>>
      input = <<0x0001::little-unsigned-16>>
      assert LTHash.pointwise(base, input, :add) == <<0::little-unsigned-16>>
    end
  end

  describe "subtract_then_add/3 (homomorphic property)" do
    test "applying mutations in two batches matches applying them in one" do
      base = :crypto.strong_rand_bytes(128)
      m1 = "mutation-#{System.unique_integer([:positive])}"
      m2 = "mutation-#{System.unique_integer([:positive])}"
      m3 = "mutation-#{System.unique_integer([:positive])}"

      one_batch = LTHash.subtract_then_add(base, [], [m1, m2, m3])
      step1 = LTHash.subtract_then_add(base, [], [m1])
      step2 = LTHash.subtract_then_add(step1, [], [m2])
      step3 = LTHash.subtract_then_add(step2, [], [m3])

      assert step3 == one_batch
    end

    test "subtract and re-add a mutation is identity" do
      base = :crypto.strong_rand_bytes(128)
      m = "mutation-#{System.unique_integer([:positive])}"
      after_add = LTHash.subtract_then_add(base, [], [m])
      after_remove = LTHash.subtract_then_add(after_add, [m], [])
      assert after_remove == base
    end

    test "commutativity — order of additions doesn't matter" do
      base = :crypto.strong_rand_bytes(128)
      order1 = LTHash.subtract_then_add(base, [], ["a", "b", "c"])
      order2 = LTHash.subtract_then_add(base, [], ["c", "a", "b"])
      assert order1 == order2
    end
  end
end
