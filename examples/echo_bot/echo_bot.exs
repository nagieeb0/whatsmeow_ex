## Echo bot — replies "echo: <text>" to every inbound text message.
##
## Run via `mix run examples/echo_bot/echo_bot.exs`.

alias Whatsmeow.Notifications
alias Whatsmeow.Types.Events.{Connected, Message, PairSuccess, QR}

defmodule EchoBot do
  @moduledoc false

  def loop(session_pid) do
    receive do
      {:whatsmeow, %QR{code: code}} ->
        IO.puts("\n=== Scan this QR with WhatsApp ===\n")
        IO.puts(Whatsmeow.QRChannel.render_terminal(code))
        loop(session_pid)

      {:whatsmeow, %PairSuccess{jid: jid}} ->
        IO.puts("Paired as #{jid}. Waiting for messages.")
        loop(session_pid)

      {:whatsmeow, %Connected{}} ->
        IO.puts("Connected to WhatsApp.")
        loop(session_pid)

      {:whatsmeow, %Message{from: from, text: text}} when is_binary(text) ->
        IO.puts("[<-] #{from}: #{text}")
        Whatsmeow.send_text(session_pid, from, "echo: #{text}")
        loop(session_pid)

      {:whatsmeow, other} ->
        IO.inspect(other, label: "[event]")
        loop(session_pid)
    after
      30_000 ->
        IO.puts(".")
        loop(session_pid)
    end
  end
end

device_id = System.get_env("WHATSMEOW_DEVICE_ID") || "echo-bot"
{:ok, device} = Whatsmeow.Store.find_or_new_device(client_id: device_id)
{:ok, pid} = Whatsmeow.start_session(device)
:ok = Notifications.subscribe(device.id)

IO.puts("EchoBot started for device #{device.id}. Press Ctrl+C twice to quit.")
EchoBot.loop(pid)
