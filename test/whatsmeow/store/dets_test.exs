defmodule Whatsmeow.Store.DETSTest do
  use ExUnit.Case, async: false

  alias Whatsmeow.Store
  alias Whatsmeow.Store.DETS

  setup do
    dir = Path.join(System.tmp_dir!(), "whatsmeow_store_test_#{System.unique_integer([:positive])}")
    Application.put_env(:whatsmeow_ex, :store_dir, dir)
    Application.put_env(:whatsmeow_ex, :store, DETS)
    DETS.close()

    on_exit(fn ->
      DETS.close()
      Application.delete_env(:whatsmeow_ex, :store)
      Application.delete_env(:whatsmeow_ex, :store_dir)
      File.rm_rf(dir)
    end)

    %{dir: dir}
  end

  test "a device can be created and read back with no database" do
    assert {:ok, device} = Store.new_device(client_id: "bot-1")
    assert device.client_id == "bot-1"
    assert byte_size(device.identity_key) == 32
    assert byte_size(device.noise_key) == 32

    assert {:ok, loaded} = Store.get_device("bot-1")
    assert loaded.identity_key == device.identity_key
  end

  test "keys are generated the same way the Postgres store generates them" do
    # A raw strong_rand_bytes private is not RFC-7748 clamped; XEdDSA then signs
    # over the wrong public key and the server drops the pairing session with a
    # bare stream error. Both stores go through Store.build_device/1 so this
    # cannot drift between them.
    {:ok, device} = Store.new_device(client_id: "bot-1")

    spk_pub = Whatsmeow.Crypto.Curve25519.public_for(device.signed_pre_key)
    id_pub = Whatsmeow.Crypto.Curve25519.public_for(device.identity_key)

    assert Whatsmeow.Crypto.XEdDSA.verify(id_pub, <<5, spk_pub::binary>>, device.signed_pre_key_sig)
  end

  test "survives the table being closed and reopened" do
    {:ok, device} = Store.new_device(client_id: "bot-1")
    DETS.close()

    assert {:ok, loaded} = Store.get_device("bot-1")
    assert loaded.identity_key == device.identity_key
  end

  test "pairing rewrites the jid without leaving a second row" do
    # The bug this guards: a device starts as "bot-1" and pairing replaces its
    # jid with a real one. Keyed by jid, that writes a second row and the next
    # boot reads the unpaired one — so the user is asked to scan a fresh QR.
    {:ok, device} = Store.new_device(client_id: "bot-1")

    paired = %{device | jid: "15551234567:3@s.whatsapp.net", adv_details: <<1, 2, 3>>}
    assert :ok = Store.put_device(paired)

    assert length(Store.list_devices()) == 1
    assert {:ok, loaded} = Store.get_device("bot-1")
    assert loaded.jid == "15551234567:3@s.whatsapp.net"
    assert loaded.adv_details == <<1, 2, 3>>
  end

  test "a paired device is also findable by its new jid" do
    {:ok, device} = Store.new_device(client_id: "bot-1")
    :ok = Store.put_device(%{device | jid: "15551234567@s.whatsapp.net"})

    assert {:ok, loaded} = Store.get_device("15551234567@s.whatsapp.net")
    assert loaded.client_id == "bot-1"
  end

  test "get_device_by_client_id/1 finds it, and misses are :not_found" do
    {:ok, _} = Store.new_device(client_id: "bot-1")

    assert {:ok, %{client_id: "bot-1"}} = Store.get_device_by_client_id("bot-1")
    assert Store.get_device_by_client_id("nope") == {:error, :not_found}
    assert Store.get_device("nope") == {:error, :not_found}
  end

  test "several accounts coexist" do
    {:ok, _} = Store.new_device(client_id: "sales")
    {:ok, _} = Store.new_device(client_id: "support")

    assert length(Store.list_devices()) == 2
    assert {:ok, %{client_id: "sales"}} = Store.get_device("sales")
    assert {:ok, %{client_id: "support"}} = Store.get_device("support")
  end

  test "delete_device/1 removes it by client_id or by jid" do
    {:ok, device} = Store.new_device(client_id: "bot-1")
    :ok = Store.put_device(%{device | jid: "15551234567@s.whatsapp.net"})

    assert :ok = Store.delete_device("15551234567@s.whatsapp.net")
    assert Store.list_devices() == []
    assert Store.get_device("bot-1") == {:error, :not_found}
  end

  test "find_or_new_device/1 creates once and reuses after" do
    assert {:ok, first} = Store.find_or_new_device(client_id: "bot-1")
    assert {:ok, second} = Store.find_or_new_device(client_id: "bot-1")

    assert first.identity_key == second.identity_key
    assert length(Store.list_devices()) == 1
  end
end
