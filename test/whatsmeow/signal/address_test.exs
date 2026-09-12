defmodule Whatsmeow.Signal.AddressTest do
  @moduledoc """
  The session key is the peer's encryption identity, not the address a stanza
  happened to arrive from.

  The regression these guard against: one physical device filed under both its
  phone number and its LID, with two independent ratchets. Inbound advanced one,
  outbound advanced the other, and the peer — which keeps exactly one session —
  could no longer decrypt. It showed up as the recipient's phone stuck on
  "waiting for this message" while their laptop read the same reply fine.
  """

  # The library boots without the Repo in test (`start_repo?: false` in
  # `config/test.exs`), so this file brings it up for itself rather than
  # flipping that switch for every other test.
  use ExUnit.Case, async: false

  alias Whatsmeow.LIDMap
  alias Whatsmeow.Signal.Address
  alias Whatsmeow.Types.JID

  @pn "966511792082@s.whatsapp.net"
  @lid "132680784040127@lid"

  setup do
    # A small pool on purpose: the default is `schedulers_online() * 2`, which
    # on a dev box already running the app exhausts Postgres's connection limit
    # and fills the run with connect errors that have nothing to do with the test.
    start_supervised!({Whatsmeow.Repo, pool_size: 2})
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Whatsmeow.Repo)
    :ok
  end

  describe "without a mapping" do
    test "a phone number is left exactly as it is" do
      assert Address.session_key(@pn) == @pn
    end

    test "a LID is left exactly as it is" do
      assert Address.session_key(@lid) == @lid
    end

    test "servers with no LID concept pass through untouched" do
      for jid <- ["120363000000000000@g.us", "status@broadcast"] do
        assert Address.session_key(jid) == jid
      end
    end

    test "an unparseable address yields the empty key rather than raising" do
      # What the decrypt path already did with a malformed `from`: a key that
      # finds no session, on a stanza we could not have addressed anyway.
      assert Address.session_key("") == ""
      assert Address.session_key(nil) == ""
    end
  end

  describe "with a mapping" do
    setup do
      :ok = LIDMap.put(@lid, @pn)
      :ok
    end

    test "a phone number resolves to the LID" do
      assert Address.session_key(@pn) == @lid
    end

    test "a LID stays itself — canonicalisation is idempotent" do
      assert Address.session_key(@lid) == @lid
    end

    test "the device suffix survives, because a session is per device" do
      assert Address.session_key("966511792082:15@s.whatsapp.net") == "132680784040127:15@lid"
      assert Address.session_key("966511792082:17@s.whatsapp.net") == "132680784040127:17@lid"
    end

    test "the two addresses of one device agree on one key" do
      # This is the whole point. Inbound sees the LID, outbound sees the phone
      # number from the device list, and both must file under the same row.
      assert Address.session_key(@lid) == Address.session_key(@pn)

      assert Address.session_key("132680784040127:15@lid") ==
               Address.session_key("966511792082:15@s.whatsapp.net")
    end

    test "a different device of the same person keeps a different key" do
      refute Address.session_key("966511792082:15@s.whatsapp.net") ==
               Address.session_key("966511792082:16@s.whatsapp.net")

      refute Address.session_key("966511792082:15@s.whatsapp.net") == Address.session_key(@pn)
    end

    test "accepts a JID struct as readily as a string" do
      {:ok, jid} = JID.parse("966511792082:15@s.whatsapp.net")
      assert Address.session_key(jid) == "132680784040127:15@lid"

      assert %JID{server: "lid", user: "132680784040127", device: 15} =
               Address.encryption_identity(jid)
    end

    test "an unmapped peer is untouched while a mapped one moves" do
      assert Address.session_key("201000000000@s.whatsapp.net") == "201000000000@s.whatsapp.net"
      assert Address.session_key(@pn) == @lid
    end
  end
end
