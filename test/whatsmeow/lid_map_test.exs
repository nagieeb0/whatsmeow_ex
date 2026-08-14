defmodule Whatsmeow.LIDMapTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.LIDMap
  alias Whatsmeow.Types.JID

  # These run without a Repo. What is being pinned here is the *validation and
  # normalisation* layer — the part that decides what is even eligible to be
  # stored or looked up. The old raw INSERT had none of it and happily wrote
  # device-suffixed JIDs that then never matched a lookup.
  describe "put/2 input handling" do
    test "never raises, whatever it is handed" do
      assert LIDMap.put(nil, nil) == :ok
      assert LIDMap.put("", "") == :ok
      assert LIDMap.put("not a jid", "also not") == :ok
      assert LIDMap.put(:garbage, 42) == :ok
      # Two LIDs, or two PNs, are not a pairing.
      assert LIDMap.put("111@lid", "222@lid") == :ok
      assert LIDMap.put("15551234567@s.whatsapp.net", "15559999999@s.whatsapp.net") == :ok
    end

    test "put_all/1 counts what it processed" do
      assert LIDMap.put_all([]) == 0
      assert LIDMap.put_all([{"111@lid", "15551234567@s.whatsapp.net"}]) == 1
    end
  end

  describe "lookups without a stored mapping" do
    test "return nil rather than raising or inventing a JID" do
      assert LIDMap.pn_for("111@lid") == nil
      assert LIDMap.lid_for("15551234567@s.whatsapp.net") == nil
      assert LIDMap.pn_for(nil) == nil
      assert LIDMap.lid_for(nil) == nil
      assert LIDMap.pn_for("garbage") == nil
    end
  end

  describe "resolve/1" do
    test "passes a phone-number JID straight through" do
      pn = JID.parse!("15551234567@s.whatsapp.net")
      assert LIDMap.resolve(pn) == pn
    end

    test "returns the LID unchanged when no mapping is known" do
      lid = JID.parse!("111222333@lid")
      assert LIDMap.resolve(lid) == lid
    end

    test "leaves group JIDs alone" do
      group = JID.parse!("120363000000000000@g.us")
      assert LIDMap.resolve(group) == group
    end

    test "nil in, nil out" do
      assert LIDMap.resolve(nil) == nil
    end
  end
end
