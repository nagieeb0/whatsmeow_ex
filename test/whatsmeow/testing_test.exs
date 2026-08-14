defmodule Whatsmeow.TestingTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.{Content, Testing}
  alias Whatsmeow.Types.Events

  # A bot exactly like one a consumer would write: subscribe, match on inbound
  # text, reply. This is the thing the sandbox exists to make testable.
  defmodule PingBot do
    use GenServer

    def start_link(session), do: GenServer.start_link(__MODULE__, session)

    @impl true
    def init(session) do
      :ok = Whatsmeow.Testing.subscribe(session)
      {:ok, session}
    end

    @impl true
    def handle_info({:whatsmeow, %Events.Message{message: %{body: "ping", chat: chat}}}, session) do
      {:ok, _id} = Whatsmeow.send_text(session, chat, "pong")
      {:noreply, session}
    end

    def handle_info(_, session), do: {:noreply, session}
  end

  setup do
    # start_link/1 links the session to the test process, so it dies with the
    # test — no on_exit teardown needed (and racing one against the link only
    # produces spurious "no process" exits).
    {:ok, session} = Testing.start_offline()
    %{session: session}
  end

  test "an offline session sends without a socket", %{session: session} do
    assert Whatsmeow.Session.offline?(session)
    assert {:ok, msg_id} = Whatsmeow.send_text(session, "15551234567@s.whatsapp.net", "hello")
    assert is_binary(msg_id)

    assert [%{message: %{conversation: "hello"}, id: ^msg_id, to: to}] = Testing.sent(session)
    assert to.user == "15551234567"
  end

  test "the full receive → reply path runs against nothing", %{session: session} do
    {:ok, _bot} = PingBot.start_link(session)

    Testing.deliver_text(session, from: "15551234567@s.whatsapp.net", text: "ping")

    # The bot replies asynchronously; give its message a moment to land.
    assert eventually(fn -> Testing.sent(session) != [] end)
    assert [%{message: %{conversation: "pong"}, to: to}] = Testing.sent(session)
    assert to.user == "15551234567"
  end

  test "a message the bot doesn't match produces no reply", %{session: session} do
    {:ok, _bot} = PingBot.start_link(session)

    Testing.deliver_text(session, from: "15551234567@s.whatsapp.net", text: "something else")
    Process.sleep(50)

    assert Testing.sent(session) == []
  end

  test "any payload can be delivered, not just text", %{session: session} do
    :ok = Testing.subscribe(session)

    Testing.deliver(session, Content.location(30.0444, 31.2357, name: "Cairo"),
      from: "15551234567@s.whatsapp.net"
    )

    assert_receive {:whatsmeow, %Events.Message{message: %{raw: raw}}}
    assert raw.locationMessage.name == "Cairo"
  end

  test "group delivery sets is_group and the participant", %{session: session} do
    :ok = Testing.subscribe(session)

    Testing.deliver_text(session,
      from: "15551234567@s.whatsapp.net",
      chat: "120363000000000000@g.us",
      text: "hi all"
    )

    assert_receive {:whatsmeow, %Events.Message{message: msg, info: info}}
    assert msg.is_group
    assert info.is_group?
    assert info.participant.user == "15551234567"
  end

  test "clear_sent/1 resets between assertions", %{session: session} do
    {:ok, _} = Whatsmeow.send_text(session, "15551234567@s.whatsapp.net", "one")
    assert length(Testing.sent(session)) == 1

    :ok = Testing.clear_sent(session)
    assert Testing.sent(session) == []
  end

  test "sends are recorded oldest first", %{session: session} do
    for n <- ["one", "two", "three"] do
      {:ok, _} = Whatsmeow.send_text(session, "15551234567@s.whatsapp.net", n)
    end

    assert ["one", "two", "three"] = Enum.map(Testing.sent(session), & &1.message.conversation)
  end

  test "built payloads go through the same path", %{session: session} do
    msg = Content.location(30.0444, 31.2357, name: "Cairo")
    {:ok, _} = Whatsmeow.send_message(session, "15551234567@s.whatsapp.net", msg)

    assert [%{message: %{locationMessage: %{name: "Cairo"}}}] = Testing.sent(session)
  end

  defp eventually(fun, attempts \\ 20) do
    Enum.reduce_while(1..attempts, false, fn _, _ ->
      if fun.(), do: {:halt, true}, else: Process.sleep(10) && {:cont, false}
    end)
  end
end
