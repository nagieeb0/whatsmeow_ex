defmodule WhatsmeowTest do
  use ExUnit.Case, async: true

  describe "version/0" do
    test "matches mix.exs" do
      assert Whatsmeow.version() == "0.1.0"
    end
  end

  describe "subscribe/1" do
    test "subscribes the caller to the device topic" do
      device_id = "test-device-#{System.unique_integer([:positive])}"
      assert {:ok, _ref} = Whatsmeow.subscribe(device_id)

      Phoenix.PubSub.broadcast(Whatsmeow.PubSub, Whatsmeow.topic_for(device_id), :ping)
      assert_receive :ping, 200
    end
  end

  describe "session lifecycle" do
    test "start_session/1 boots a Session under the DynamicSupervisor and registers it" do
      device_id = "test-device-#{System.unique_integer([:positive])}"
      device = %{id: device_id}

      {:ok, pid} = Whatsmeow.start_session(device)
      assert is_pid(pid)
      assert Whatsmeow.Session.whereis(device_id) == pid

      # idempotent: starting again returns the same pid
      {:ok, ^pid} = Whatsmeow.start_session(device)

      assert pid in Whatsmeow.list_sessions()

      :ok = Whatsmeow.stop_session(pid)
      Process.sleep(20)
      assert Whatsmeow.Session.whereis(device_id) == :undefined
    end

    test "stop_session/1 by device_id is a no-op when nothing is running" do
      assert :ok = Whatsmeow.stop_session("nonexistent-device")
    end

    # Regression: a real %Device{} has no `:id` field — only `:jid` and the
    # new `:client_id`. The earlier `%{id: device_id}` clause raised a
    # FunctionClauseError as soon as a Phoenix app fed a real Device row
    # into the facade, which is exactly what the LiveView README does.
    test "start_session/1 accepts a real %Device{} via its client_id" do
      client_id = "regression-cid-#{System.unique_integer([:positive])}"

      device = %Whatsmeow.Store.Schemas.Device{
        jid: "regression-jid-#{System.unique_integer([:positive])}",
        client_id: client_id
      }

      {:ok, pid} = Whatsmeow.start_session(device)
      assert Whatsmeow.Session.whereis(client_id) == pid

      :ok = Whatsmeow.stop_session(pid)
      Process.sleep(20)
    end

    test "start_session/1 falls back to jid when client_id is unset" do
      jid = "fallback-jid-#{System.unique_integer([:positive])}"
      device = %Whatsmeow.Store.Schemas.Device{jid: jid}

      {:ok, pid} = Whatsmeow.start_session(device)
      assert Whatsmeow.Session.whereis(jid) == pid

      :ok = Whatsmeow.stop_session(pid)
      Process.sleep(20)
    end
  end

  describe "placeholders" do
    test "send_text/3 raises NotImplementedError pointing at Phase 9" do
      assert_raise Whatsmeow.NotImplementedError, ~r/Phase 9/, fn ->
        Whatsmeow.send_text(self(), "x@s.whatsapp.net", "hi")
      end
    end
  end
end
