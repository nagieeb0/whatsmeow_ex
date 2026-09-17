defmodule Mix.Tasks.Whatsmeow.Repl do
  @shortdoc "Interactive: pair (if needed), then send/receive with full event logs"

  @moduledoc """
  End-to-end interactive walkthrough. Drives the full supervised
  `Whatsmeow.Session` GenServer (so reconnect/backoff/stream-replace
  retries happen automatically — no manual `--relogin` needed).

  ## Usage

      # Fresh client_id (will pair via QR on the phone)
      mix whatsmeow.repl

      # Reuse an already-paired device row
      mix whatsmeow.repl --client-id smoke-2

      # Send a message inline (after the session is LoggedIn)
      mix whatsmeow.repl --client-id smoke-2 --send 201068010145@s.whatsapp.net "test body"

  ## Output

      * QR code rendered in the terminal when pairing is required
      * Every event from the device topic printed as it arrives
      * Session telemetry (connect/handshake/login)
      * If `--send` is provided: timed send, message_id, then keeps listening

  Ctrl-C twice to exit.
  """

  use Mix.Task

  alias Whatsmeow.QRChannel
  alias Whatsmeow.Repo
  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.Types.Events

  @impl Mix.Task
  def run(argv) do
    Application.ensure_all_started(:whatsmeow_ex)

    {opts, _, _} =
      OptionParser.parse(argv,
        switches: [
          client_id: :string,
          send: :string
        ]
      )

    client_id = opts[:client_id] || "repl-#{System.unique_integer([:positive])}"
    IO.puts("== whatsmeow.repl == client_id=#{client_id}")

    {:ok, device} = load_or_create_device(client_id)

    IO.puts("device.jid          = #{device.jid}")
    IO.puts("device.client_id    = #{device.client_id}")
    IO.puts("device.business     = #{device.business_name}")
    IO.puts("")

    # Subscribe BEFORE start_session/connect so we don't miss the first
    # QR / Connected event.
    Whatsmeow.Notifications.subscribe(device.client_id)

    # Start the supervised session and kick it into :connecting.
    {:ok, _pid} = Whatsmeow.start_session(device)
    Whatsmeow.Session.connect(device.client_id)

    # If the user passed --send, schedule that after we see LoggedIn.
    pending_send =
      case opts[:send] do
        nil ->
          nil

        s ->
          case String.split(s, " ", parts: 2) do
            [jid, body] -> {jid, body}
            _ -> nil
          end
      end

    receive_loop(device, %{logged_in?: false, pending_send: pending_send})
  end

  defp load_or_create_device(client_id) do
    case Repo.get_by(Device, client_id: client_id) do
      nil ->
        IO.puts("(no row for #{inspect(client_id)} — creating fresh device, will QR-pair)")
        Whatsmeow.Store.find_or_new_device(client_id: client_id)

      %Device{} = device ->
        IO.puts("(loaded existing paired device)")
        {:ok, device}
    end
  end

  defp receive_loop(device, state) do
    receive do
      {:whatsmeow, %Events.QR{code: code}} ->
        IO.puts("\n>>> QR (scan with WhatsApp → Settings → Linked devices):\n")
        IO.puts(QRChannel.render_terminal(code))
        IO.puts("")
        receive_loop(device, state)

      {:whatsmeow, %Events.Connected{}} ->
        IO.puts("[event] Connected (Noise handshake complete)")
        receive_loop(device, state)

      {:whatsmeow, %Events.PairSuccess{} = ev} ->
        IO.puts("[event] PairSuccess  jid=#{inspect(ev.jid)}  biz=#{inspect(ev.business_name)}")
        receive_loop(device, state)

      {:whatsmeow, %Events.PairError{} = ev} ->
        IO.puts("[event] PairError  reason=#{inspect(ev.reason)}")
        receive_loop(device, state)

      {:whatsmeow, %Events.LoggedIn{} = ev} ->
        IO.puts(
          "[event] LoggedIn  lid=#{inspect(ev.lid)}  server_dt=#{inspect(ev.server_time_offset)}s  ✅ ready to send"
        )

        state = %{state | logged_in?: true}
        state = maybe_do_pending_send(device, state)
        receive_loop(device, state)

      {:whatsmeow, %Events.LoggedOut{reason: r}} ->
        IO.puts("[event] LoggedOut  reason=#{inspect(r)}  — terminal, exiting")
        :ok

      {:whatsmeow, %Events.Disconnected{reason: r}} ->
        IO.puts("[event] Disconnected  reason=#{inspect(r)}  (auto-reconnect in progress)")
        receive_loop(device, state)

      {:whatsmeow, %Events.Message{info: info, message: msg}} ->
        from = Whatsmeow.Types.JID.to_string(info.from)
        body = (msg && Map.get(msg, :body)) || inspect(Map.from_struct(msg || %{}))

        IO.puts("[event] Message  from=#{from}  id=#{info.id}  body=#{inspect(body)}")
        receive_loop(device, state)

      {:whatsmeow, %Events.Receipt{type: type, from: from, message_ids: ids}} ->
        IO.puts(
          "[event] Receipt  type=#{inspect(type)}  from=#{inspect(from)}  ids=#{inspect(ids)}"
        )

        receive_loop(device, state)

      {:whatsmeow, %Events.UndecryptableMessage{reason: r, info: info}} ->
        IO.puts(
          "[event] UndecryptableMessage  from=#{inspect(info && info.from)}  reason=#{inspect(r)}"
        )

        receive_loop(device, state)

      {:whatsmeow, other} ->
        IO.puts("[event] #{inspect(other, limit: 4)}")
        receive_loop(device, state)

      msg ->
        IO.puts("[msg]   #{inspect(msg, limit: 4)}")
        receive_loop(device, state)
    end
  end

  defp maybe_do_pending_send(_device, %{pending_send: nil} = state), do: state

  defp maybe_do_pending_send(device, %{pending_send: {jid, body}} = state) do
    IO.puts("\n>>> sending: to=#{jid}  body=#{inspect(body)}")

    {us, result} =
      :timer.tc(fn ->
        Whatsmeow.Send.send_text(device.client_id, jid, body)
      end)

    IO.puts(">>> send took #{Float.round(us / 1000, 1)} ms")
    IO.puts(">>> result: #{inspect(result)}\n")

    %{state | pending_send: nil}
  end
end
