defmodule Whatsmeow.User.DeviceCacheTest do
  use ExUnit.Case, async: false

  alias Whatsmeow.Types.JID
  alias Whatsmeow.User.DeviceCache

  setup do
    DeviceCache.clear()
    :ok
  end

  defp dev(user, device), do: JID.new_ad(user, 0, device)

  test "a miss is a miss, not an empty list" do
    assert DeviceCache.get("15551234567@s.whatsapp.net") == :miss
  end

  test "stores and returns a device list" do
    devices = [dev("15551234567", 0), dev("15551234567", 3)]
    :ok = DeviceCache.put("15551234567@s.whatsapp.net", devices)

    assert {:ok, ^devices} = DeviceCache.get("15551234567@s.whatsapp.net")
  end

  test "keyed by person, not by device — any device JID hits the same entry" do
    devices = [dev("15551234567", 0)]
    :ok = DeviceCache.put(dev("15551234567", 3), devices)

    assert {:ok, ^devices} = DeviceCache.get("15551234567@s.whatsapp.net")
    assert {:ok, ^devices} = DeviceCache.get(dev("15551234567", 7))
  end

  test "put/2 will store an empty list if you explicitly ask it to" do
    :ok = DeviceCache.put("15551234567@s.whatsapp.net", [])
    assert {:ok, []} = DeviceCache.get("15551234567@s.whatsapp.net")
  end

  test "put_response/2 splits one USync reply across the users it asked about" do
    queried = [JID.parse!("111@s.whatsapp.net"), JID.parse!("222@s.whatsapp.net")]
    devices = [dev("111", 0), dev("111", 2), dev("222", 0)]

    :ok = DeviceCache.put_response(queried, devices)

    assert {:ok, [_, _]} = DeviceCache.get("111@s.whatsapp.net")
    assert {:ok, [_]} = DeviceCache.get("222@s.whatsapp.net")
  end

  test "a queried user the server said nothing about is NOT cached" do
    # Caching the emptiness would turn one incomplete reply into an hour of
    # :no_devices_resolved on every send to that contact.
    queried = [JID.parse!("111@s.whatsapp.net"), JID.parse!("333@s.whatsapp.net")]
    :ok = DeviceCache.put_response(queried, [dev("111", 0)])

    assert DeviceCache.get("333@s.whatsapp.net") == :miss
    assert {:ok, [_]} = DeviceCache.get("111@s.whatsapp.net")
  end

  test "invalidate/1 forces the next lookup back to the server" do
    :ok = DeviceCache.put("15551234567@s.whatsapp.net", [dev("15551234567", 0)])
    :ok = DeviceCache.invalidate("15551234567@s.whatsapp.net")

    assert DeviceCache.get("15551234567@s.whatsapp.net") == :miss
  end

  test "garbage in never raises" do
    assert DeviceCache.get(nil) == :miss
    assert DeviceCache.get("not a jid") == :miss
    assert DeviceCache.put(nil, []) == :ok
    assert DeviceCache.invalidate(nil) == :ok
  end
end
