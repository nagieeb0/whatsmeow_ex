defmodule Whatsmeow.Retry.RecentCacheTest do
  use ExUnit.Case, async: false

  alias Whatsmeow.Retry.RecentCache

  setup do
    RecentCache.clear()
    :ok
  end

  test "put/get round-trips an entry" do
    :ok = RecentCache.put("1@s.whatsapp.net", "MSG1", "hello", "text")

    assert {:ok, entry} = RecentCache.get("1@s.whatsapp.net", "MSG1")
    assert entry.to_jid == "1@s.whatsapp.net"
    assert entry.message_id == "MSG1"
    assert entry.plaintext == "hello"
    assert entry.msg_type == "text"
    assert is_integer(entry.stored_at)
  end

  test "get/2 returns :not_found for unknown keys" do
    assert RecentCache.get("999@s.whatsapp.net", "MISSING") == :not_found
  end

  test "put/4 is idempotent on the same key (no LRU bump)" do
    :ok = RecentCache.put("1@x", "ID", "v1", "text")
    :ok = RecentCache.put("1@x", "ID", "v2", "text")

    assert {:ok, entry} = RecentCache.get("1@x", "ID")
    assert entry.plaintext == "v2"
    assert RecentCache.size() == 1
  end

  test "exceeding capacity evicts the oldest" do
    # We can't reconfigure the running cache mid-test cheaply; rely on the
    # default 256-entry capacity.
    capacity = RecentCache.capacity()

    # Insert capacity+5 distinct entries; assert size never exceeds capacity.
    for i <- 1..(capacity + 5) do
      :ok = RecentCache.put("user#{i}@x", "ID#{i}", "plain#{i}", "text")
    end

    assert RecentCache.size() <= capacity

    # The oldest entry (the very first) should have been evicted.
    assert RecentCache.get("user1@x", "ID1") == :not_found

    # The newest entry must still be there.
    last = capacity + 5
    assert {:ok, _} = RecentCache.get("user#{last}@x", "ID#{last}")
  end

  test "clear/0 wipes everything" do
    :ok = RecentCache.put("a@x", "1", "p", "text")
    :ok = RecentCache.put("b@x", "2", "p", "text")

    :ok = RecentCache.clear()

    assert RecentCache.size() == 0
    assert RecentCache.get("a@x", "1") == :not_found
  end
end
