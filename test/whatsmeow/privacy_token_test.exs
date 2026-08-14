defmodule Whatsmeow.PrivacyTokenTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.PrivacyToken
  alias Whatsmeow.Types.JID

  @bucket 604_800

  describe "bucket policy" do
    test "cutoff is bucket-aligned and 3 buckets back" do
      now = 100 * @bucket + 12_345
      assert PrivacyToken.cutoff(now) == (100 - 3) * @bucket
    end

    test "a token from this bucket is live, one from 4 buckets ago is expired" do
      now = System.system_time(:second)

      refute PrivacyToken.expired?(now)
      refute PrivacyToken.expired?(now - 3 * @bucket + 60)
      assert PrivacyToken.expired?(now - 4 * @bucket)
      assert PrivacyToken.expired?(nil)
      assert PrivacyToken.expired?(0)
    end

    test "issues once per bucket, not once per message" do
      now = System.system_time(:second)

      # Already issued in the current bucket — stay quiet.
      refute PrivacyToken.should_issue?(now)

      # Last issued a full bucket ago — time to ask again.
      assert PrivacyToken.should_issue?(now - @bucket)
      assert PrivacyToken.should_issue?(nil)
    end
  end

  describe "eligible?/1" do
    test "true for 1:1 chats on the phone-number and LID servers" do
      assert PrivacyToken.eligible?(JID.parse!("15551234567@s.whatsapp.net"))
      assert PrivacyToken.eligible?(JID.parse!("123456789@lid"))
    end

    test "ignores the device suffix" do
      assert PrivacyToken.eligible?(JID.new_ad("15551234567", 0, 3))
    end

    test "false for groups, the PSA account, and Meta's bots" do
      refute PrivacyToken.eligible?(JID.parse!("120363000000000000@g.us"))
      refute PrivacyToken.eligible?(JID.parse!("0@s.whatsapp.net"))
      refute PrivacyToken.eligible?(JID.parse!("13135550002@s.whatsapp.net"))
      refute PrivacyToken.eligible?(JID.parse!("867051314767696@bot"))
      refute PrivacyToken.eligible?(JID.parse!("status@broadcast"))
    end
  end

  describe "issue gating" do
    setup do
      # The clock is process-independent ETS; keep tests from leaking into
      # each other.
      :ets.whereis(:whatsmeow_tctoken_issued_at)
      |> case do
        :undefined -> :ok
        _ -> :ets.delete_all_objects(:whatsmeow_tctoken_issued_at)
      end

      :ok
    end

    test "a contact we've never issued for reads as never issued" do
      assert PrivacyToken.last_issued_at("me@s.whatsapp.net", "111@s.whatsapp.net") == 0
    end

    test "the clock answers without a stored token row" do
      # This is the case the DB cannot serve: a 463 means we hold no token, so
      # there is no row to stamp a timestamp on. If the clock only read the
      # database, every rejection in a burst would fire its own IQ.
      now = System.system_time(:second)
      :ok = PrivacyToken.mark_issued("me@s.whatsapp.net", "111@s.whatsapp.net", now)

      assert PrivacyToken.last_issued_at("me@s.whatsapp.net", "111@s.whatsapp.net") == now
      assert PrivacyToken.fetch("me@s.whatsapp.net", "111@s.whatsapp.net") == :not_found
    end

    test "the clock is per contact, not global" do
      now = System.system_time(:second)
      :ok = PrivacyToken.mark_issued("me@s.whatsapp.net", "111@s.whatsapp.net", now)

      assert PrivacyToken.last_issued_at("me@s.whatsapp.net", "222@s.whatsapp.net") == 0
    end

    test "the device suffix doesn't split the clock — a token is per person" do
      now = System.system_time(:second)
      :ok = PrivacyToken.mark_issued("me@s.whatsapp.net", JID.new_ad("111", 0, 3), now)

      assert PrivacyToken.last_issued_at("me@s.whatsapp.net", "111@s.whatsapp.net") == now
    end

    test "an issue inside the current bucket closes the send-path gate" do
      now = System.system_time(:second)
      :ok = PrivacyToken.mark_issued("me@s.whatsapp.net", "111@s.whatsapp.net", now)

      refute PrivacyToken.should_issue?(
               PrivacyToken.last_issued_at("me@s.whatsapp.net", "111@s.whatsapp.net")
             )
    end
  end

  describe "build_issue_iq/3" do
    test "matches the shape Go's issuePrivacyToken sends" do
      peer = JID.new_ad("15551234567", 0, 2)
      iq = PrivacyToken.build_issue_iq(peer, 1_700_000_000, "ID-1")

      assert iq.tag == "iq"
      assert iq.attrs["id"] == "ID-1"
      assert iq.attrs["type"] == "set"
      assert iq.attrs["xmlns"] == "privacy"
      # Typed JID, not a bare string — the encoder needs the jid_pair opcode.
      assert %JID{user: "", server: "s.whatsapp.net"} = iq.attrs["to"]

      assert [%Node{tag: "tokens", content: [token]}] = iq.content
      assert token.tag == "token"
      assert token.attrs["type"] == "trusted_contact"
      assert token.attrs["t"] == "1700000000"
      # The device suffix is stripped — tokens are per contact, not per device.
      assert %JID{user: "15551234567", device: device} = token.attrs["jid"]
      assert device in [0, nil]
    end
  end
end
