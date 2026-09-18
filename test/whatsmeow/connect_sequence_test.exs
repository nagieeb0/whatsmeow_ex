defmodule Whatsmeow.ConnectSequenceTest do
  @moduledoc """
  The five stanzas a login sends, of which this port sent two.

  `amarula` is an independent Elixir WhatsApp client that mirrors Baileys. Its
  `finish_login/1` (`connection.ex:4801`) is:

      |> send_passive_iq("active")     # we had this
      |> send_unified_session()        # missing — Go sends it too
      |> send_digest_iq()              # missing
      |> maybe_send_init_queries()     # missing
      |> maybe_mark_online()           # we had this

  And the comment above the fourth, which is why this test exists at all
  (`connection.ex:3417`):

  > *Baileys `executeInitQueries`, fired on `open`: fetchProps + blocklist +
  > privacy. **These appear to be a server-side precondition for E2E
  > key-exchange: without them the server SILENTLY ignores our prekey-bundle
  > fetches (answers every other IQ).***

  That sentence describes, exactly, the state measured on a live device for six
  hours on 19 September: authenticated, keepalive IQs answered, receipts
  arriving, `<active/>` accepted, twenty-five pre-keys on the server, the device
  listed in its own account's `usync` reply — and thirteen queued messages the
  server announced and never delivered.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ

  describe "unified_session" do
    test "is an <ib> carrying a rotating id" do
      node = IQ.build_unified_session()

      assert node.tag == "ib"
      assert [%Node{tag: "unified_session", attrs: %{"id" => id}}] = Node.children(node)
      assert {n, ""} = Integer.parse(id)
      assert n >= 0
    end

    # `(now + 3 days) % 7 days` — a rotating bucket, not an identifier. Both Go
    # and amarula compute it the same way, so a week is its whole range.
    test "and the id stays inside a week of milliseconds" do
      %{attrs: %{"id" => id}} = hd(Node.children(IQ.build_unified_session()))

      assert String.to_integer(id) < 7 * 24 * 60 * 60 * 1000
    end
  end

  describe "the digest key-bundle check" do
    test "asks the encrypt namespace to validate what we published" do
      iq = IQ.build_digest("d1")

      assert iq.attrs["type"] == "get"
      assert iq.attrs["xmlns"] == "encrypt"
      assert to_string(iq.attrs["to"]) == "s.whatsapp.net"
      assert [%Node{tag: "digest"}] = Node.children(iq)
    end
  end

  describe "the init queries Baileys calls a precondition" do
    setup do: %{queries: IQ.build_init_queries()}

    test "all three go out, in Baileys' order", %{queries: queries} do
      assert [abt, blocklist, privacy] = queries

      assert abt.attrs["xmlns"] == "abt"
      assert [%Node{tag: "props", attrs: %{"protocol" => "1"}}] = Node.children(abt)

      assert blocklist.attrs["xmlns"] == "blocklist"
      assert privacy.attrs["xmlns"] == "privacy"
      assert [%Node{tag: "privacy"}] = Node.children(privacy)
    end

    test "each is a get addressed to the server", %{queries: queries} do
      for q <- queries do
        assert q.tag == "iq"
        assert q.attrs["type"] == "get"
        assert to_string(q.attrs["to"]) == "s.whatsapp.net"
      end
    end

    # Three stanzas in flight at once, so three ids. A collision would park two
    # callers on one entry in the pending map.
    test "and no two share an id", %{queries: queries} do
      ids = Enum.map(queries, & &1.attrs["id"])

      assert length(Enum.uniq(ids)) == 3
      assert Enum.all?(ids, &(byte_size(&1) > 0))
    end
  end
end
