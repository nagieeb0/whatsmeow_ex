defmodule Whatsmeow.SessionTerminalStopTest do
  @moduledoc """
  A device WhatsApp has refused must stay refused.

  `on_failure/2` answers 401/403/406 by clearing `auto_reconnect?` and stopping
  with `:normal`, because retrying a deleted device is how a number gets banned
  rather than restored. But `auto_reconnect?` is per-process state, and under
  the default `:permanent` restart the supervisor brought the session straight
  back, `init/1` rebuilt that flag from opts — where it defaults to `true` — and
  `dial_on_boot?/1` saw the JID still in the row and dialled again.

  Measured on one device: 63 × `<failure reason=:logged_out>`, each followed by
  `connecting` three milliseconds later, and a device index that reached
  `:44@lid` — an account re-linked forty-four times.

  A stop is the only thing that outlives the process, so the restart policy is
  where the decision has to live.
  """
  use ExUnit.Case, async: true

  alias Whatsmeow.ConnectionEvents

  describe "the restart policy" do
    test "is :transient, so a deliberate :normal stop is not undone" do
      assert %{restart: :transient} = Whatsmeow.Session.child_spec(device_id: "d")
    end

    # The behaviour `5ff9ac5` added, and which :transient must not remove: a
    # session that crashes still comes back and still dials itself.
    test "still restarts on an abnormal exit" do
      spec = Whatsmeow.Session.child_spec(device_id: "d")

      refute spec.restart == :temporary
    end
  end

  describe "which stream errors end the session" do
    test "the server asking us to re-handshake is not the end" do
      assert ConnectionEvents.should_reconnect?(:auto_reconnect_515)
      assert ConnectionEvents.should_reconnect?(:server_restart_503)
    end

    # What an overlapping deploy produces: the old container still holds the
    # device while the new one boots, and the loser is told it was replaced.
    # Fighting over one Signal ratchet is what ends in the 401 above.
    test "being replaced or removed is" do
      refute ConnectionEvents.should_reconnect?(:replaced)
      refute ConnectionEvents.should_reconnect?(:device_removed)
    end
  end
end
