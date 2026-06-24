defmodule Whatsmeow.PreKeysTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.PreKeys
  alias Whatsmeow.Store.Schemas.Device

  describe "generate/2" do
    test "produces `count` distinct keys starting at `start_id`" do
      keys = PreKeys.generate(5, 10)
      assert length(keys) == 5
      assert Enum.map(keys, & &1.key_id) == [10, 11, 12, 13, 14]
      assert Enum.all?(keys, fn k -> byte_size(k.priv) == 32 and byte_size(k.pub) == 32 end)
      assert keys |> Enum.map(& &1.priv) |> Enum.uniq() |> length() == 5
    end

    test "pub matches Curve25519.public_for(priv)" do
      [%{priv: priv, pub: pub}] = PreKeys.generate(1, 1)
      assert Curve25519.public_for(priv) == pub
    end
  end

  describe "prekey_to_node/1" do
    test "encodes id as 3-byte BE and value as 32-byte raw pub" do
      {pub, priv} = Curve25519.generate_keypair()
      node = PreKeys.prekey_to_node(%{key_id: 0xABCDEF, priv: priv, pub: pub})

      assert %Node{tag: "key"} = node
      [id_node, val_node] = Node.children(node)
      assert %Node{tag: "id", content: <<0xAB, 0xCD, 0xEF>>} = id_node
      assert %Node{tag: "value", content: ^pub} = val_node
    end
  end

  describe "signed_pre_key_node/3" do
    test "wraps id + value + signature under <skey>" do
      pub = :crypto.strong_rand_bytes(32)
      sig = :crypto.strong_rand_bytes(64)

      node = PreKeys.signed_pre_key_node(7, pub, sig)

      assert %Node{tag: "skey"} = node

      assert [
               %Node{tag: "id", content: <<0, 0, 7>>},
               %Node{tag: "value", content: ^pub},
               %Node{tag: "signature", content: ^sig}
             ] = Node.children(node)
    end
  end

  describe "build_upload_iq/3" do
    setup do
      identity_priv = :crypto.strong_rand_bytes(32)
      spk_priv = :crypto.strong_rand_bytes(32)

      device = %Device{
        jid: "test@s.whatsapp.net",
        registration_id: 0x1234_5678,
        noise_key: :crypto.strong_rand_bytes(32),
        identity_key: identity_priv,
        signed_pre_key: spk_priv,
        signed_pre_key_id: 99,
        signed_pre_key_sig: :crypto.strong_rand_bytes(64),
        adv_key: :crypto.strong_rand_bytes(32),
        adv_details: <<>>,
        adv_account_sig: :crypto.strong_rand_bytes(64),
        adv_account_sig_key: :crypto.strong_rand_bytes(32),
        adv_device_sig: :crypto.strong_rand_bytes(64)
      }

      %{device: device}
    end

    test "wraps registration / DjbType / identity / list / skey under <iq xmlns=encrypt>", ctx do
      keys = PreKeys.generate(3, 1)
      iq = PreKeys.build_upload_iq(keys, ctx.device, "fixed-id")

      assert %Node{tag: "iq", attrs: attrs} = iq
      assert attrs["id"] == "fixed-id"
      assert attrs["xmlns"] == "encrypt"
      assert attrs["type"] == "set"
      assert attrs["to"] == "s.whatsapp.net"

      children = Node.children(iq)
      tags = Enum.map(children, & &1.tag)
      assert tags == ["registration", "type", "identity", "list", "skey"]

      [reg, type_n, identity, list, skey] = children
      assert reg.content == <<0x1234_5678::big-unsigned-32>>
      # 0x05 DjbType byte for X25519.
      assert type_n.content == <<0x05>>
      assert identity.content == Curve25519.public_for(ctx.device.identity_key)

      # <list> has one <key> per generated OPK.
      list_children = Node.children(list)
      assert length(list_children) == 3
      assert Enum.all?(list_children, &(&1.tag == "key"))

      # <skey> echoes the device's signed-pre-key state.
      assert %Node{tag: "skey"} = skey
      [id_n, val_n, sig_n] = Node.children(skey)
      assert id_n.content == <<99::big-unsigned-24>>
      assert val_n.content == Curve25519.public_for(ctx.device.signed_pre_key)
      assert sig_n.content == ctx.device.signed_pre_key_sig
    end

    test "auto-generates an IQ id when none is passed", ctx do
      iq = PreKeys.build_upload_iq([], ctx.device)
      assert is_binary(iq.attrs["id"]) and iq.attrs["id"] != ""
    end
  end

  describe "constants" do
    test "match upstream Go's published values" do
      assert PreKeys.wanted_count() == 50
      assert PreKeys.min_count() == 5
      assert PreKeys.initial_upload_count() == 812
    end
  end
end
