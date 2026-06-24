defmodule Whatsmeow.IQTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.Types.JID

  # The encoder serialises `to` differently for a typed %JID{} vs. a
  # plain string. Outbound IQs must use the typed form (matches Go's
  # `types.ServerJID`). Tests assert this shape so a regression to the
  # string form is caught at unit-test time, not by users via "QR scan
  # does nothing".
  @server_jid %JID{user: "", server: JID.default_user_server()}

  describe "generate_id/0" do
    test "produces a 16-char lowercase hex string" do
      id = IQ.generate_id()
      assert byte_size(id) == 16
      assert id =~ ~r/^[0-9a-f]{16}$/
    end

    test "ids are unique across calls" do
      ids = for _ <- 1..50, do: IQ.generate_id()
      assert length(Enum.uniq(ids)) == 50
    end
  end

  describe "build_keepalive/1" do
    test "default shape matches Go's sendKeepAlive infoQuery" do
      iq = IQ.build_keepalive()

      assert %Node{tag: "iq", attrs: attrs, content: nil} = iq
      assert attrs["to"] == @server_jid
      assert attrs["type"] == "get"
      assert attrs["xmlns"] == "w:p"
      assert is_binary(attrs["id"]) and byte_size(attrs["id"]) == 16
    end

    test "respects a caller-supplied id" do
      iq = IQ.build_keepalive("my-id-42")
      assert Node.attr(iq, "id") == "my-id-42"
    end
  end

  describe "build_set_passive/2 — post-login bootstrap" do
    test "active=true → <iq xmlns=\"passive\" type=\"set\"><active/></iq>" do
      iq = IQ.build_set_passive(false)
      assert %Node{tag: "iq", attrs: attrs, content: [%Node{tag: "active"}]} = iq
      assert attrs["type"] == "set"
      assert attrs["xmlns"] == "passive"
      assert attrs["to"] == @server_jid
    end

    test "passive=true → <passive/> child instead" do
      iq = IQ.build_set_passive(true)
      assert %Node{content: [%Node{tag: "passive"}]} = iq
    end

    test "respects caller-supplied id" do
      iq = IQ.build_set_passive(false, "boot-1")
      assert Node.attr(iq, "id") == "boot-1"
    end
  end

  describe "build_presence/2" do
    test "<presence type=\"available\" name=\"alice\"/>" do
      p = IQ.build_presence(:available, "alice")
      assert %Node{tag: "presence", attrs: %{"type" => "available", "name" => "alice"}} = p
    end

    test "<presence type=\"unavailable\"/> drops name when nil" do
      p = IQ.build_presence(:unavailable, nil)
      assert %Node{tag: "presence", attrs: attrs} = p
      assert attrs["type"] == "unavailable"
      refute Map.has_key?(attrs, "name")
    end

    test "drops name when push_name is empty string" do
      p = IQ.build_presence(:available, "")
      refute Map.has_key?(p.attrs, "name")
    end
  end

  describe "build_prekeys_get/2" do
    test "wraps each peer JID in a <user/> child as a typed %JID{}" do
      # CRITICAL: the encoder picks the wire opcode from the attr value's
      # Elixir type. `%JID{}` → `@jid_pair` (opcode 250). A plain string
      # → bare UTF-8 token, which WhatsApp's `xmlns="encrypt"` handler
      # silently drops without an `<iq type="error">`. Reproducing the
      # bug here so a regression is caught at unit-test time, not by
      # users via "test message never arrives".
      iq = IQ.build_prekeys_get(["111@s.whatsapp.net", "222@s.whatsapp.net"])

      assert %Node{tag: "iq", attrs: %{"type" => "get", "xmlns" => "encrypt"}} = iq
      assert [%Node{tag: "key", content: users}] = Node.children(iq)
      assert length(users) == 2
      assert Enum.all?(users, fn %Node{tag: "user"} -> true end)

      assert Enum.map(users, &Node.attr(&1, "jid")) == [
               %JID{user: "111", server: "s.whatsapp.net"},
               %JID{user: "222", server: "s.whatsapp.net"}
             ]
    end

    test "accepts typed %JID{} input verbatim" do
      jid = %JID{user: "111", server: "s.whatsapp.net"}
      iq = IQ.build_prekeys_get([jid])
      [%Node{content: [user]}] = Node.children(iq)
      assert Node.attr(user, "jid") == jid
    end

    test "default reason is \"identity\" — Go parity" do
      # Go's `whatsmeow-main/prekeys.go:130` always sets `reason: "identity"`.
      # Without this attr, WhatsApp's prekey-bundle handler silently
      # drops the IQ; client times out at `{:bundle_error, :timeout}`.
      iq = IQ.build_prekeys_get(["111@s.whatsapp.net"])
      [%Node{content: [user]}] = Node.children(iq)
      assert Node.attr(user, "reason") == "identity"
    end

    test "explicit reason override still works" do
      iq = IQ.build_prekeys_get(["111@s.whatsapp.net"], reason: "missing")
      [%Node{content: [user]}] = Node.children(iq)
      assert Node.attr(user, "reason") == "missing"
    end

    test "explicit empty-string reason omits the attr" do
      # Escape hatch for tests / future call sites that explicitly want
      # NO `reason`. Default path still injects `"identity"`.
      iq = IQ.build_prekeys_get(["111@s.whatsapp.net"], reason: "")
      [%Node{content: [user]}] = Node.children(iq)
      refute Map.has_key?(user.attrs, "reason")
    end

    test "wire encoding contains the @jid_pair opcode (250) for each user JID" do
      # End-to-end wire-shape assertion: pass the built IQ through the
      # real binary encoder and confirm the recipient JID is serialised
      # with opcode 250 (`@jid_pair`). The previous bug shipped the JID
      # as a generic UTF-8 string — server-side silent drop, client-side
      # 30s timeout. This test pins the encoding so the bug can't come
      # back via a refactor of the builder.
      iq = IQ.build_prekeys_get(["111@s.whatsapp.net"])
      bytes = Whatsmeow.Binary.encode(iq) |> IO.iodata_to_binary()
      assert :binary.match(bytes, <<250>>) != :nomatch
    end
  end
end
