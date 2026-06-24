defmodule Whatsmeow.Send.GroupTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Send.Group
  alias Whatsmeow.Signal.GroupSession
  alias Whatsmeow.Types.JID

  describe "participant_list_hash_v2/1" do
    test "sorts JIDs lexicographically before hashing — order-independent" do
      {:ok, a} = JID.parse("1.0:0@s.whatsapp.net")
      {:ok, b} = JID.parse("2.0:1@s.whatsapp.net")
      {:ok, c} = JID.parse("3.0:2@s.whatsapp.net")

      assert Group.participant_list_hash_v2([a, b, c]) ==
               Group.participant_list_hash_v2([c, b, a])
    end

    test "format is \"2:\" <> base64-no-pad of 6 bytes" do
      {:ok, jid} = JID.parse("12345.0:0@s.whatsapp.net")
      h = Group.participant_list_hash_v2([jid])

      assert "2:" <> rest = h
      decoded = Base.decode64!(rest, padding: false)
      assert byte_size(decoded) == 6
    end

    test "different device sets produce different hashes" do
      {:ok, a} = JID.parse("1@s.whatsapp.net")
      {:ok, b} = JID.parse("2@s.whatsapp.net")
      refute Group.participant_list_hash_v2([a]) == Group.participant_list_hash_v2([a, b])
    end

    test "matches known fixture for empty list" do
      empty_hash = Group.participant_list_hash_v2([])
      assert "2:" <> _ = empty_hash
      # SHA256("") starts with bytes <0xE3, 0xB0, 0xC4, 0x42, 0x98, 0xFC, …>
      <<expected::binary-size(6), _::binary>> = :crypto.hash(:sha256, "")
      assert empty_hash == "2:" <> Base.encode64(expected, padding: false)
    end
  end

  describe "send_text/4 — input validation" do
    test "rejects non-group JIDs" do
      assert {:error, :invalid_group_jid} =
               Group.send_text(:fake_pid, "12345@s.whatsapp.net", "hi", participants: ["1@x"])
    end

    test "rejects when participants opt is missing" do
      assert {:error, :no_participants} =
               Group.send_text(:fake_pid, "12345@g.us", "hi")
    end

    test "rejects when participants opt is empty" do
      assert {:error, :no_participants} =
               Group.send_text(:fake_pid, "12345@g.us", "hi", participants: [])
    end
  end

  describe "outbound GroupSession primitives" do
    test "GroupSession.new/1 has a signing_priv (required by encrypt_envelope)" do
      gs = GroupSession.new(0)
      assert is_binary(gs.signing_priv) and byte_size(gs.signing_priv) == 32
      assert is_binary(gs.signing_pub) and byte_size(gs.signing_pub) == 32
      assert is_binary(gs.chain_key) and byte_size(gs.chain_key) == 32
      assert gs.iteration == 0
    end

    test "encrypt → wire-decode the skmsg envelope cleanly" do
      gs = GroupSession.new(7)
      {envelope, _gs2} = Whatsmeow.Signal.GroupDecrypt.encrypt_envelope(gs, "hello group")

      assert {:ok, %{iteration: 0, id: 7}, _signed_input, sig} =
               Whatsmeow.Signal.SenderKeyWire.decode_sender_key_message(envelope)

      assert byte_size(sig) == 64
    end

    test "to_distribution → encode_sender_key_distribution_message has the 0x33 prefix" do
      gs = GroupSession.new(0)
      libsignal = GroupSession.to_distribution(gs)

      wire =
        Whatsmeow.Signal.SenderKeyWire.encode_sender_key_distribution_message(
          %Whatsmeow.Signal.SenderKeyWire.SenderKeyDistributionMessage{
            id: libsignal.id,
            iteration: libsignal.iteration,
            chainKey: libsignal.chainKey,
            signingKey: libsignal.signingKey
          }
        )

      assert <<0x33, _rest::binary>> = wire
    end
  end
end
