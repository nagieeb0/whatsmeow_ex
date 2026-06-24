defmodule Whatsmeow.NotificationsTest do
  use ExUnit.Case, async: false

  alias Whatsmeow.Notifications
  alias Whatsmeow.Types.Events.Connected

  test "broadcast/2 reaches per-device subscribers" do
    :ok = Notifications.subscribe("dev-A")

    :ok = Notifications.broadcast("dev-A", %Connected{device_id: "dev-A"})
    assert_receive {:whatsmeow, %Connected{device_id: "dev-A"}}, 200

    # Non-subscriber gets nothing.
    refute_received {:whatsmeow, _}

    :ok = Notifications.unsubscribe("dev-A")
  end

  test "subscribe_all/0 receives every device's events (when enabled)" do
    prev = Application.get_env(:whatsmeow_ex, Notifications, [])
    Application.put_env(:whatsmeow_ex, Notifications, Keyword.put(prev, :all_topic?, true))

    try do
      :ok = Notifications.subscribe_all()

      :ok = Notifications.broadcast("dev-X", %Connected{device_id: "dev-X"})
      :ok = Notifications.broadcast("dev-Y", %Connected{device_id: "dev-Y"})

      assert_receive {:whatsmeow, %Connected{device_id: "dev-X"}}, 200
      assert_receive {:whatsmeow, %Connected{device_id: "dev-Y"}}, 200

      :ok = Notifications.unsubscribe_all()
    after
      Application.put_env(:whatsmeow_ex, Notifications, prev)
    end
  end

  test "all_topic is off by default — subscribe_all receives nothing" do
    :ok = Notifications.subscribe_all()
    :ok = Notifications.broadcast("dev-quiet", %Connected{device_id: "dev-quiet"})
    refute_receive {:whatsmeow, _}, 50
    :ok = Notifications.unsubscribe_all()
  end

  test "after unsubscribe, no further messages arrive" do
    :ok = Notifications.subscribe("dev-Z")
    :ok = Notifications.unsubscribe("dev-Z")

    :ok = Notifications.broadcast("dev-Z", %Connected{device_id: "dev-Z"})
    refute_receive {:whatsmeow, _}, 50
  end
end
