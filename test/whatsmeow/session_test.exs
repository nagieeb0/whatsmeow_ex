defmodule Whatsmeow.SessionTest do
  use ExUnit.Case, async: false

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Session
  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.Types.Events

  # Hand-rolled minimal state — enough to drive the dispatch tree without
  # spinning up a transport or NoiseSocket. The dispatch helpers under test
  # don't hit the transport for <success>, <failure>, <stream:error>, or IQ
  # responses, so transport_conn / noise_socket can stay nil.
  defp base_state(device_id, opts \\ []) do
    %Session{
      device_id: device_id,
      device: Keyword.get(opts, :device, %Device{jid: "smoke-#{device_id}"}),
      transport: Whatsmeow.Transport.WebSocket.Mint,
      transport_conn: nil,
      noise_socket: nil,
      status: Keyword.get(opts, :status, :connected),
      reconnect_attempts: 0,
      keepalive_failures: 0,
      auto_reconnect?: true,
      pending: Keyword.get(opts, :pending, %{})
    }
  end

  describe "__failure_reason_atom__/1" do
    test "maps known WhatsApp failure codes to typed atoms" do
      assert Session.__failure_reason_atom__("401") == :unauthorized
      assert Session.__failure_reason_atom__("403") == :forbidden
      assert Session.__failure_reason_atom__("405") == :not_allowed
      assert Session.__failure_reason_atom__("503") == :service_unavailable
    end

    test "unknown reasons collapse to :failure (no atom-exhaustion path)" do
      assert Session.__failure_reason_atom__("999") == :failure
      assert Session.__failure_reason_atom__("anything-here") == :failure
      assert Session.__failure_reason_atom__(nil) == :failure
    end
  end

  describe "__backoff_ms__/1 (reconnect schedule)" do
    test "doubles each attempt (with up to +500 ms jitter)" do
      # 1s, 2s, 4s, 8s, 16s, 32s, …
      for n <- 1..6 do
        base = 1_000 * trunc(:math.pow(2, n - 1))
        ms = Session.__backoff_ms__(n)
        assert ms >= base and ms <= base + 500
      end
    end

    test "caps at 5 minutes (+jitter)" do
      ms = Session.__backoff_ms__(20)
      assert ms >= 300_000 and ms <= 300_500
    end
  end

  describe "__pair_error__/1" do
    test "HMAC + signature errors map to 401 / signature-mismatch wire reasons" do
      assert {401, "hmac-mismatch"} = Session.__pair_error__(:hmac_mismatch)
      assert {401, "signature-mismatch"} = Session.__pair_error__(:account_signature_invalid)
      assert {500, "internal-error"} = Session.__pair_error__(:anything_else)
    end
  end

  describe "dispatch <success>" do
    setup do
      device_id = "sess-test-#{System.unique_integer([:positive])}"
      :ok = Whatsmeow.Notifications.subscribe(device_id)
      on_exit(fn -> Whatsmeow.Notifications.unsubscribe(device_id) end)
      %{device_id: device_id}
    end

    test "broadcasts LoggedIn + transitions to :authenticated + schedules keepalive", ctx do
      t = System.system_time(:second) + 3
      node = Node.new("success", %{"lid" => "111.0:1@lid", "t" => Integer.to_string(t)})

      state = base_state(ctx.device_id) |> Session.__dispatch_node__(node)

      assert state.status == :authenticated
      assert state.keepalive_failures == 0
      assert is_reference(state.keepalive_timer)

      assert_receive {:whatsmeow, %Events.LoggedIn{lid: "111.0:1@lid", server_time_offset: dt}}, 200
      assert is_integer(dt)

      # Clean up the timer the dispatcher scheduled.
      _ = Process.cancel_timer(state.keepalive_timer)
    end
  end

  describe "dispatch <failure>" do
    setup do
      device_id = "sess-test-#{System.unique_integer([:positive])}"
      :ok = Whatsmeow.Notifications.subscribe(device_id)
      on_exit(fn -> Whatsmeow.Notifications.unsubscribe(device_id) end)
      %{device_id: device_id}
    end

    test "broadcasts LoggedOut with typed reason + disables auto_reconnect", ctx do
      node = Node.new("failure", %{"reason" => "401"})

      state = base_state(ctx.device_id) |> Session.__dispatch_node__(node)

      refute state.auto_reconnect?
      assert state.status == :stopping
      assert_receive {:whatsmeow, %Events.LoggedOut{reason: :unauthorized}}, 200
    end
  end

  describe "dispatch <stream:error>" do
    test "emits telemetry without disconnecting the in-memory state" do
      device_id = "sess-test-#{System.unique_integer([:positive])}"

      _ =
        :telemetry.attach(
          "stream-error-test-#{device_id}",
          [:whatsmeow, :session, :stream_error],
          fn _, _, meta, pid -> send(pid, {:telemetry, meta}) end,
          self()
        )

      node = Node.new("stream:error", %{"code" => "500"})
      state = base_state(device_id) |> Session.__dispatch_node__(node)

      # <stream:error> alone doesn't tear the local state down — that happens
      # on the follow-up <xmlstreamend> from the server.
      assert state.status == :connected
      assert_receive {:telemetry, %{code: "500"}}, 200

      :telemetry.detach("stream-error-test-#{device_id}")
    end
  end

  describe "IQ response routing" do
    test "<iq type=\"result\"> with a parked keepalive id clears the pending entry" do
      device_id = "sess-test-#{System.unique_integer([:positive])}"

      state =
        base_state(device_id,
          status: :authenticated,
          pending: %{"keep-1" => :keepalive}
        )
        |> Session.__dispatch_node__(Node.new("iq", %{"type" => "result", "id" => "keep-1"}))

      assert state.pending == %{}
      assert state.keepalive_failures == 0
    end

    test "<iq type=\"result\"> with a parked caller routes the node back via send" do
      device_id = "sess-test-#{System.unique_integer([:positive])}"
      ref = make_ref()

      iq = Node.new("iq", %{"type" => "result", "id" => "iq-7"})

      state =
        base_state(device_id,
          status: :authenticated,
          pending: %{"iq-7" => {self(), ref}}
        )
        |> Session.__dispatch_node__(iq)

      assert state.pending == %{}
      assert_receive {:whatsmeow_iq, ^ref, %Node{tag: "iq"}}, 200
    end

    test "unknown IQ id is silently dropped (no atom growth, no crash)" do
      device_id = "sess-test-#{System.unique_integer([:positive])}"
      iq = Node.new("iq", %{"type" => "result", "id" => "no-such-id"})
      assert %Session{} = base_state(device_id) |> Session.__dispatch_node__(iq)
    end
  end

  describe "dispatch <message> (no Signal-wire decode yet)" do
    setup do
      device_id = "sess-test-#{System.unique_integer([:positive])}"
      :ok = Whatsmeow.Notifications.subscribe(device_id)
      on_exit(fn -> Whatsmeow.Notifications.unsubscribe(device_id) end)
      %{device_id: device_id}
    end

    test "broadcasts UndecryptableMessage with the raw <enc> payload and emits telemetry",
         ctx do
      _ =
        :telemetry.attach(
          "msg-undec-test-#{ctx.device_id}",
          [:whatsmeow, :session, :message_undecryptable],
          fn _, _, meta, pid -> send(pid, {:telemetry, meta}) end,
          self()
        )

      msg =
        Node.new(
          "message",
          %{
            "id" => "3EB0CAFE",
            "from" => "11111@s.whatsapp.net",
            "type" => "text",
            "t" => "1715000000"
          },
          [
            Node.new("enc", %{"v" => "2", "type" => "msg"}, <<1, 2, 3, 4, 5>>)
          ]
        )

      device = %Whatsmeow.Store.Schemas.Device{jid: "9999@s.whatsapp.net"}

      # Note: we pass status: :authenticated and a nil transport_conn so
      # do_send_node returns {:error, :not_connected} for the ack — that's
      # fine, the broadcast still fires before the ack attempt.
      state =
        base_state(ctx.device_id, status: :authenticated, device: device)
        |> Whatsmeow.Session.__dispatch_node__(msg)

      assert state.status == :authenticated

      # Without a running Repo this becomes :no_session (we tried to look
      # up the persisted Signal state for an `<enc type="msg">` and got
      # nothing). The pre-Phase 9 code surfaced `:no_signal_wire_proto`
      # unconditionally — that's been replaced now that decrypt actually
      # runs.
      assert_receive {:whatsmeow,
                      %Whatsmeow.Types.Events.UndecryptableMessage{
                        reason: :no_session,
                        enc_type: "msg",
                        enc_version: "2",
                        enc_payload: <<1, 2, 3, 4, 5>>,
                        info: %Whatsmeow.MessageInfo{id: "3EB0CAFE"}
                      }},
                     200

      assert_receive {:telemetry,
                      %{from: %Whatsmeow.Types.JID{user: "11111"}, reason: :no_session}},
                     200

      :telemetry.detach("msg-undec-test-#{ctx.device_id}")
    end
  end

  describe "info/1 + start/stop lifecycle (smoke)" do
    test "newly-started session is :idle with no timers + zero pending" do
      device_id = "sess-lifecycle-#{System.unique_integer([:positive])}"
      {:ok, pid} = Session.start_link(device_id: device_id)

      assert %{
               status: :idle,
               device_id: ^device_id,
               reconnect_attempts: 0,
               keepalive_failures: 0,
               pending_count: 0
             } = Session.info(pid)

      :ok = Session.stop(pid)
    end
  end

  describe "cold-start jitter" do
    test "with jitter configured, :connect on idle defers and leaves status :idle" do
      device_id = "sess-jitter-#{System.unique_integer([:positive])}"

      prev = Application.get_env(:whatsmeow_ex, :cold_start_jitter_ms, 0)
      Application.put_env(:whatsmeow_ex, :cold_start_jitter_ms, 60_000)

      # Give the session a Device so handle_cast doesn't bail via the
      # `device: nil` clause — we want to reach the :idle + jitter clause.
      device = %Device{
        jid: "smoke-#{device_id}",
        registration_id: 0,
        noise_key: <<0::256>>,
        identity_key: <<0::256>>,
        signed_pre_key: <<0::256>>,
        signed_pre_key_id: 1,
        signed_pre_key_sig: <<0::512>>,
        adv_key: <<0::256>>
      }

      try do
        {:ok, pid} = Session.start_link(device_id: device_id, device: device)
        :ok = Session.connect(pid)
        # With jitter ON, the connect is scheduled for ~30s out (median).
        # No transport call yet, status stays :idle.
        Process.sleep(50)
        assert %{status: :idle} = Session.info(pid)
        :ok = Session.stop(pid)
      after
        Application.put_env(:whatsmeow_ex, :cold_start_jitter_ms, prev)
      end
    end
  end
end
