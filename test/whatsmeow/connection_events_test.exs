defmodule Whatsmeow.ConnectionEventsTest do
  use ExUnit.Case, async: true
  doctest Whatsmeow.ConnectionEvents

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.ConnectionEvents, as: CE

  describe "decode_stream_error/1" do
    test "code 515 → :auto_reconnect_515 (reconnect yes)" do
      n = Node.new("stream:error", %{"code" => "515"}, nil)
      assert CE.decode_stream_error(n) == :auto_reconnect_515
      assert CE.should_reconnect?(:auto_reconnect_515)
    end

    test "code 503 → :server_restart_503 (reconnect yes)" do
      n = Node.new("stream:error", %{"code" => "503"}, nil)
      assert CE.decode_stream_error(n) == :server_restart_503
    end

    test "401 + <conflict type=device_removed> → :device_removed (no reconnect)" do
      n =
        Node.new("stream:error", %{"code" => "401"}, [
          Node.new("conflict", %{"type" => "device_removed"}, nil)
        ])

      assert CE.decode_stream_error(n) == :device_removed
      refute CE.should_reconnect?(:device_removed)
    end

    test "<conflict type=replaced> → :replaced regardless of code" do
      n =
        Node.new("stream:error", %{"code" => "401"}, [
          Node.new("conflict", %{"type" => "replaced"}, nil)
        ])

      assert CE.decode_stream_error(n) == :replaced
      refute CE.should_reconnect?(:replaced)
    end

    # **An unknown code is a disconnection, not a verdict.**
    #
    # This asserted `refute`, which was harmless while nothing acted on the
    # answer and became "stop for ever" once `Session.act_on_stream_error/2`
    # used it to decide terminality: every code this module does not recognise
    # — including `500`, which the session's own client-outdated recovery is
    # written for — permanently stopped the session, and `restart: :transient`
    # kept it stopped.
    #
    # Only two reasons mean "we are out", and the server states both.
    test "unknown code → {:unknown, code}, and we still try again" do
      n = Node.new("stream:error", %{"code" => "9999"}, nil)
      assert CE.decode_stream_error(n) == {:unknown, "9999"}
      assert CE.should_reconnect?({:unknown, "9999"})
    end

    test "missing code → {:unknown, nil}" do
      n = Node.new("stream:error", %{}, nil)
      assert CE.decode_stream_error(n) == {:unknown, nil}
    end
  end

  describe "decode_failure/1" do
    test "401 → :logged_out" do
      n = Node.new("failure", %{"reason" => "401"}, nil)
      assert {:logged_out, _, %{}} = CE.decode_failure(n)
      assert CE.logged_out?(:logged_out)
    end

    test "405 → :client_outdated (terminal)" do
      n = Node.new("failure", %{"reason" => "405", "message" => "update needed"}, nil)
      assert {:client_outdated, "update needed", %{}} = CE.decode_failure(n)
      assert CE.logged_out?(:client_outdated)
    end

    test "4264 → :temp_banned + extras carry code + expire" do
      n =
        Node.new("failure", %{"reason" => "4264", "code" => "1", "expire" => "3600"}, nil)

      assert {:temp_banned, _, extras} = CE.decode_failure(n)
      assert extras == %{code: 1, expire_seconds: 3600}
    end

    test "419 → :cat_invalid (not terminal)" do
      n = Node.new("failure", %{"reason" => "419"}, nil)
      assert {:cat_invalid, _, _} = CE.decode_failure(n)
      refute CE.logged_out?(:cat_invalid)
    end

    test "unknown reason → {:unknown, n}" do
      n = Node.new("failure", %{"reason" => "9999"}, nil)
      assert {{:unknown, 9999}, _, _} = CE.decode_failure(n)
    end
  end

  describe "decode_ib/1" do
    test "offline_preview produces a counts map" do
      n =
        Node.new("ib", %{}, [
          Node.new(
            "offline_preview",
            %{
              "count" => "100",
              "appdata" => "5",
              "message" => "80",
              "notification" => "10",
              "receipt" => "5"
            },
            nil
          )
        ])

      assert [{:offline_preview, counts}] = CE.decode_ib(n)

      assert counts == %{
               total: 100,
               app_data_changes: 5,
               messages: 80,
               notifications: 10,
               receipts: 5
             }
    end

    test "offline → :offline_complete with count" do
      n = Node.new("ib", %{}, [Node.new("offline", %{"count" => "42"}, nil)])
      assert [{:offline_complete, 42}] = CE.decode_ib(n)
    end

    test "downgrade_webclient → :qr_scanned_without_multidevice" do
      n = Node.new("ib", %{}, [Node.new("downgrade_webclient", %{}, nil)])
      assert [:qr_scanned_without_multidevice] = CE.decode_ib(n)
    end

    test "dirty → {:dirty, type, ts}" do
      n =
        Node.new("ib", %{}, [
          Node.new("dirty", %{"type" => "account_sync", "timestamp" => "1715000000"}, nil)
        ])

      assert [{:dirty, "account_sync", 1_715_000_000}] = CE.decode_ib(n)
    end

    test "unknown children are dropped" do
      n =
        Node.new("ib", %{}, [
          Node.new("future_thing", %{}, nil),
          Node.new("offline", %{"count" => "1"}, nil)
        ])

      assert [{:offline_complete, 1}] = CE.decode_ib(n)
    end

    test "non-ib node → []" do
      assert CE.decode_ib(Node.new("other", %{}, nil)) == []
    end
  end
end
