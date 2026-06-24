defmodule Whatsmeow.PreKeyBundleTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.PreKeyBundle
  alias Whatsmeow.Types.JID

  defp registration_node(reg), do: Node.new("registration", %{}, <<reg::big-unsigned-32>>)
  defp identity_node(bytes), do: Node.new("identity", %{}, bytes)

  defp skey_node(id, pub, sig) do
    Node.new("skey", %{}, [
      Node.new("id", %{}, <<id::big-unsigned-24>>),
      Node.new("value", %{}, pub),
      Node.new("signature", %{}, sig)
    ])
  end

  defp prekey_node(id, pub) do
    Node.new("key", %{}, [
      Node.new("id", %{}, <<id::big-unsigned-24>>),
      Node.new("value", %{}, pub)
    ])
  end

  defp synthetic_pub, do: :crypto.strong_rand_bytes(32)
  defp synthetic_sig, do: :crypto.strong_rand_bytes(64)

  describe "from_user_node/1 — happy path" do
    test "extracts registration, identity, signed pre-key, and optional one-time pre-key" do
      identity = synthetic_pub()
      skey_pub = synthetic_pub()
      skey_sig = synthetic_sig()
      pre_pub = synthetic_pub()

      user =
        Node.new("user", %{"jid" => "201068010145.0:84@s.whatsapp.net"}, [
          registration_node(0xDEADBEEF),
          identity_node(identity),
          skey_node(7, skey_pub, skey_sig),
          prekey_node(42, pre_pub)
        ])

      assert {:ok, bundle} = PreKeyBundle.from_user_node(user)
      assert bundle.registration_id == 0xDEADBEEF
      assert bundle.identity_pub == identity
      assert bundle.signed_pre_key_id == 7
      assert bundle.signed_pre_key_pub == skey_pub
      assert bundle.signed_pre_key_sig == skey_sig
      assert bundle.pre_key_id == 42
      assert bundle.pre_key_pub == pre_pub
    end

    test "tolerates absent one-time pre-key (signed-pre-key only response)" do
      user =
        Node.new("user", %{"jid" => "1@s.whatsapp.net"}, [
          registration_node(1),
          identity_node(synthetic_pub()),
          skey_node(1, synthetic_pub(), synthetic_sig())
        ])

      assert {:ok, bundle} = PreKeyBundle.from_user_node(user)
      assert bundle.pre_key_id == nil
      assert bundle.pre_key_pub == nil
    end

    test "tolerates the optional <keys> wrapper around the inner key children" do
      identity = synthetic_pub()
      skey_pub = synthetic_pub()
      skey_sig = synthetic_sig()

      user =
        Node.new("user", %{"jid" => "1@s.whatsapp.net"}, [
          registration_node(2),
          Node.new("keys", %{}, [
            identity_node(identity),
            skey_node(3, skey_pub, skey_sig)
          ])
        ])

      assert {:ok, bundle} = PreKeyBundle.from_user_node(user)
      assert bundle.identity_pub == identity
      assert bundle.signed_pre_key_pub == skey_pub
    end
  end

  describe "from_user_node/1 — error surfaces" do
    test "explicit <error> child becomes {:server_error, …}" do
      user =
        Node.new("user", %{"jid" => "missing@s.whatsapp.net"}, [
          Node.new("error", %{"code" => "404", "text" => "item-not-found"}, nil)
        ])

      assert {:error, {:server_error, "item-not-found"}} = PreKeyBundle.from_user_node(user)
    end

    test "missing registration block returns :missing_registration" do
      user =
        Node.new("user", %{"jid" => "1@s.whatsapp.net"}, [
          identity_node(synthetic_pub()),
          skey_node(1, synthetic_pub(), synthetic_sig())
        ])

      assert {:error, :missing_registration} = PreKeyBundle.from_user_node(user)
    end

    test "missing skey returns :missing_signed_pre_key" do
      user =
        Node.new("user", %{"jid" => "1@s.whatsapp.net"}, [
          registration_node(1),
          identity_node(synthetic_pub())
        ])

      assert {:error, :missing_signed_pre_key} = PreKeyBundle.from_user_node(user)
    end

    test "wrong identity length is rejected" do
      user =
        Node.new("user", %{"jid" => "1@s.whatsapp.net"}, [
          registration_node(1),
          Node.new("identity", %{}, :crypto.strong_rand_bytes(31)),
          skey_node(1, synthetic_pub(), synthetic_sig())
        ])

      assert {:error, :missing_identity} = PreKeyBundle.from_user_node(user)
    end
  end

  describe "from_iq_response/1" do
    test "splits into per-user results, embedding the JID on success" do
      ok_user =
        Node.new("user", %{"jid" => "111@s.whatsapp.net"}, [
          registration_node(1),
          identity_node(synthetic_pub()),
          skey_node(1, synthetic_pub(), synthetic_sig())
        ])

      err_user =
        Node.new("user", %{"jid" => "222@s.whatsapp.net"}, [
          Node.new("error", %{"text" => "not-found"}, nil)
        ])

      iq = Node.new("iq", %{"type" => "result"}, [Node.new("list", %{}, [ok_user, err_user])])

      assert {:ok, [{%JID{}, %PreKeyBundle{}}, {%JID{}, {:error, _}}]} =
               PreKeyBundle.from_iq_response(iq)
    end
  end
end
