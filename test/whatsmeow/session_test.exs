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

  # The failure vocabulary now lives in `Whatsmeow.ConnectionEvents`, which is
  # doctested there. `Session.__failure_reason_atom__/1` was a second, competing
  # answer to "what does this failure mean" and is gone.

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

    test "401 is terminal: the identity itself was refused", ctx do
      node = Node.new("failure", %{"reason" => "401"})

      state = base_state(ctx.device_id) |> Session.__dispatch_node__(node)

      refute state.auto_reconnect?
      assert state.status == :stopping
      assert_receive {:whatsmeow, %Events.LoggedOut{reason: :logged_out}}, 200
    end

    # The regression this whole change is about. `<failure>` used to be
    # uniformly terminal, so a rate limit killed the session as thoroughly as an
    # unlinked device — and because the process is `:permanent`, it restarted at
    # `:idle`, dialing nothing, logging nothing. A paired number silently off the
    # air until somebody re-scanned a QR it never needed.
    test "503 retries instead of dying", ctx do
      node = Node.new("failure", %{"reason" => "503"})

      state = base_state(ctx.device_id) |> Session.__dispatch_node__(node)

      assert state.auto_reconnect?, "a rate limit is not an unlinked device"
      assert state.status == :disconnected
      assert state.failure_retries == 1
      refute_receive {:whatsmeow, %Events.LoggedOut{}}, 100
    end

    test "405 refreshes the client version and retries", ctx do
      node = Node.new("failure", %{"reason" => "405"})

      state = base_state(ctx.device_id) |> Session.__dispatch_node__(node)

      assert state.auto_reconnect?
      assert state.failure_retries == 1
    end

    # A ban in progress. Reconnecting into it is how a temporary ban becomes a
    # permanent one.
    test "a temporary ban is terminal", ctx do
      node = Node.new("failure", %{"reason" => "4264"})

      state = base_state(ctx.device_id) |> Session.__dispatch_node__(node)

      refute state.auto_reconnect?
      assert state.status == :stopping
      assert_receive {:whatsmeow, %Events.LoggedOut{reason: :temp_banned}}, 200
    end

    test "retries are bounded, and giving up says so", ctx do
      node = Node.new("failure", %{"reason" => "503"})

      state =
        Enum.reduce(1..11, base_state(ctx.device_id), fn _, acc ->
          Session.__dispatch_node__(acc, node)
        end)

      refute state.auto_reconnect?, "must stop knocking eventually"
      assert state.status == :stopping
      assert_receive {:whatsmeow, %Events.LoggedOut{reason: :service_unavailable}}, 200
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

      # `<stream:error>` used to be telemetry and nothing else — the state was
      # only torn down on the follow-up `<xmlstreamend>`. It is now acted on
      # directly, because waiting for a TCP close meant a deploy's `replaced`
      # conflict left two clients fighting over one Signal ratchet until the
      # socket happened to drop.
      #
      # A code nobody recognises is a *disconnection*: the session comes down
      # and the backoff brings it back. What it must never be is `:stopping`,
      # which is reserved for the two reasons that mean we are out — the device
      # removed from the account, and another socket taking it.
      assert state.status == :disconnected
      refute state.status == :stopping
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

  # A socket can stay open and writable long after the other end has stopped
  # listening. `send/2` succeeding proves the kernel took the bytes, not that
  # WhatsApp did — so counting only send failures let a session sit at
  # `:authenticated` for ever, reporting healthy to every screen while answering
  # nobody. The watchdog's repair was then dropped as a no-op, because the
  # status looked fine.
  describe "keepalive" do
    setup do
      device_id = "sess-test-#{System.unique_integer([:positive])}"
      :ok = Whatsmeow.Notifications.subscribe(device_id)
      on_exit(fn -> Whatsmeow.Notifications.unsubscribe(device_id) end)
      %{device_id: device_id}
    end

    test "an unanswered ping counts against the session", ctx do
      state =
        ctx.device_id
        |> base_state(status: :authenticated, pending: %{"ka-1" => :keepalive})
        |> Map.put(:keepalive_failures, 2)

      {:noreply, state} = Session.handle_info(:keepalive_tick, state)

      assert state.status == :disconnected,
             "three unanswered pings must force a reconnect, as the moduledoc has always claimed"

      assert_receive {:whatsmeow, %Events.Disconnected{reason: :keepalive_failed}}, 200
    end

    test "the missed ping is forgotten, so one miss is counted once", ctx do
      state =
        ctx.device_id
        |> base_state(status: :authenticated, pending: %{"ka-1" => :keepalive})

      {:noreply, state} = Session.handle_info(:keepalive_tick, state)

      refute Enum.any?(state.pending, fn {_id, tag} -> tag == :keepalive end),
             "a miss left in `pending` would be counted again on the next tick"
    end

    test "a session with nothing pending is not penalised", ctx do
      state = base_state(ctx.device_id, status: :authenticated)

      {:noreply, state} = Session.handle_info(:keepalive_tick, state)

      # The send itself fails here (no transport_conn), which is a separate,
      # already-tested path. What matters is that it was not charged twice.
      assert state.keepalive_failures == 1
    end
  end

  # `connect/1` is idempotent and ignores a request while the status says
  # connected — correct for a racing UI click, useless to a watchdog holding
  # evidence that the status is wrong.
  describe "force_reconnect" do
    test "tears down a session that believes it is connected" do
      device_id = "sess-test-#{System.unique_integer([:positive])}"
      state = base_state(device_id, status: :authenticated)

      {:noreply, state} = Session.handle_cast(:force_reconnect, state)

      assert state.status == :disconnected
    end

    test "plain connect leaves that same session alone" do
      device_id = "sess-test-#{System.unique_integer([:positive])}"
      state = base_state(device_id, status: :authenticated)

      {:noreply, after_connect} = Session.handle_cast(:connect, state)

      assert after_connect.status == :authenticated
    end
  end
end
