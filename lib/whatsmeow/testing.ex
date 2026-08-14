defmodule Whatsmeow.Testing do
  @moduledoc """
  Test support for **consumers** of this library — drive your bot with synthetic
  inbound messages, with no WhatsApp connection.

  ## The problem

  A bot built on this library subscribes with `Whatsmeow.Notifications.subscribe/1`,
  receives `{:whatsmeow, %Whatsmeow.Types.Events.Message{}}`, and replies with
  `Whatsmeow.send_text/4`. Testing "when a message like X arrives, does my bot
  reply with Y?" normally means either mocking out half the library or standing
  up a real WhatsApp session — which needs a phone, a QR scan, and a number you
  are willing to get banned.

  ## The sandbox

  `start_offline/1` gives you a real `Whatsmeow.Session` process that never opens
  a socket. Inbound messages are the ones you `deliver`; outbound sends
  short-circuit to `{:ok, msg_id}` and are recorded instead of encrypted. Your
  bot's full receive→reply path runs, unchanged, against nothing.

      {:ok, session} = Whatsmeow.Testing.start_offline()

      # The bot under test, subscribed and running.
      {:ok, _bot} = MyBot.start_link(session: session)

      Whatsmeow.Testing.deliver_text(session,
        from: "15551234567@s.whatsapp.net",
        text: "ping"
      )

      assert [%{message: %{conversation: "pong"}}] =
               Whatsmeow.Testing.sent(session)

  ## What is and isn't exercised

  Real: your event handling, your reply logic, message-id generation, the
  payload builders in `Whatsmeow.Content`, and the shape of what you send.

  Not real: Signal encryption, device fanout, the wire codec, and the server.
  A message that would be rejected by WhatsApp is accepted here. This tests
  *your* code, not the protocol — the protocol has its own tests.
  """

  alias Whatsmeow.Types.{Events, JID, Message}

  @doc """
  Start an offline session.

  ## Options

    * `:device_id` — defaults to a unique generated id, so parallel tests don't
      collide
    * `:device` — a `%Whatsmeow.Store.Schemas.Device{}` to use; one with a
      plausible JID is fabricated if omitted, so no database is needed
    * `:jid` — our own JID, when you only want to override that
  """
  @spec start_offline(keyword()) :: {:ok, pid()} | {:error, term()}
  def start_offline(opts \\ []) do
    device_id = Keyword.get_lazy(opts, :device_id, &generate_device_id/0)
    device = Keyword.get_lazy(opts, :device, fn -> fake_device(device_id, opts) end)

    Whatsmeow.Session.start_link(
      device_id: device_id,
      device: device,
      offline?: true,
      auto_reconnect?: false
    )
  end

  @doc """
  Deliver a synthetic inbound text message to everything subscribed to `session`.

  ## Options

    * `:from` — sender JID (required)
    * `:text` — message body (required)
    * `:id` — message id; generated if omitted
    * `:chat` — the chat, when it differs from `:from` (i.e. a group)
    * `:push_name` — the sender's display name
    * `:timestamp` — a `DateTime`; defaults to now
  """
  @spec deliver_text(pid() | String.t(), keyword()) :: :ok
  def deliver_text(session, opts) do
    from = opts |> Keyword.fetch!(:from) |> to_jid!()
    text = Keyword.fetch!(opts, :text)

    deliver(session, %WAWebProtobufsE2E.Message{conversation: text}, Keyword.put(opts, :from, from))
  end

  @doc """
  Deliver an arbitrary payload — anything from `Whatsmeow.Content`.

      Whatsmeow.Testing.deliver(session, Whatsmeow.Content.location(30.0, 31.0),
        from: "15551234567@s.whatsapp.net")

  Takes the same options as `deliver_text/2` minus `:text`.
  """
  @spec deliver(pid() | String.t(), WAWebProtobufsE2E.Message.t(), keyword()) :: :ok
  def deliver(session, %WAWebProtobufsE2E.Message{} = payload, opts) do
    from = opts |> Keyword.fetch!(:from) |> to_jid!()
    chat = opts |> Keyword.get(:chat, from) |> to_jid!()
    id = Keyword.get_lazy(opts, :id, fn -> Whatsmeow.Send.generate_message_id() end)
    device_id = device_id(session)

    info = %Whatsmeow.MessageInfo{
      id: id,
      from: from,
      participant: if(group?(chat), do: from, else: nil),
      push_name: Keyword.get(opts, :push_name),
      timestamp: Keyword.get(opts, :timestamp, DateTime.utc_now()),
      is_group?: group?(chat),
      is_from_me?: false
    }

    message = %Message{
      id: id,
      from: from,
      chat: chat,
      sender: from,
      timestamp: info.timestamp,
      push_name: info.push_name,
      body: payload.conversation,
      raw: payload,
      is_from_me: false,
      is_group: info.is_group?,
      is_ephemeral: false,
      is_view_once: false,
      attachments: []
    }

    # Through the receive pipeline, exactly as the live path does — a sandbox
    # that skipped it would let a plugin that drops messages in production look
    # fine in tests.
    ctx = %{from: from, message: message, info: info, device_id: device_id}

    case Whatsmeow.Plugin.run(:recv, ctx) do
      {:ok, %{message: final}} ->
        Whatsmeow.Notifications.broadcast(device_id, %Events.Message{
          device_id: device_id,
          message: final,
          info: info
        })

      {:halt, _reason} ->
        :ok
    end
  end

  @doc """
  Everything the session was asked to send, oldest first.

  Each entry is `%{to: %JID{}, message: %WAWebProtobufsE2E.Message{}, id: msg_id}`.
  """
  @spec sent(pid() | String.t()) :: [map()]
  defdelegate sent(session), to: Whatsmeow.Session, as: :sent_messages

  @doc "Forget everything sent so far — useful between assertions in one test."
  @spec clear_sent(pid() | String.t()) :: :ok
  defdelegate clear_sent(session), to: Whatsmeow.Session

  @doc """
  Subscribe the calling process to `session`'s events.

  Convenience for asserting on what a bot emits without wiring up
  `Whatsmeow.Notifications` by hand.
  """
  @spec subscribe(pid() | String.t()) :: :ok | {:error, term()}
  def subscribe(session), do: Whatsmeow.Notifications.subscribe(device_id(session))

  # --- Helpers ---------------------------------------------------------------

  defp device_id(session) when is_binary(session), do: session

  defp device_id(session) when is_pid(session) do
    {:ok, device} = Whatsmeow.Session.get_device(session)
    device.client_id || device.jid
  end

  defp generate_device_id do
    "test-" <> Base.encode16(:crypto.strong_rand_bytes(8), case: :lower)
  end

  # A device plausible enough for the send path, built without touching the
  # database — the whole point of the sandbox is that it needs no infrastructure.
  defp fake_device(device_id, opts) do
    jid = Keyword.get(opts, :jid, "15550000000:1@s.whatsapp.net")

    %Whatsmeow.Store.Schemas.Device{
      client_id: device_id,
      jid: jid,
      registration_id: 1234,
      identity_key: :crypto.strong_rand_bytes(32),
      noise_key: :crypto.strong_rand_bytes(32),
      signed_pre_key: :crypto.strong_rand_bytes(32)
    }
  end

  defp group?(%JID{server: server}), do: server == JID.group_server()

  defp to_jid!(%JID{} = j), do: j

  defp to_jid!(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, %JID{} = j} -> j
      _ -> raise ArgumentError, "not a valid JID: #{inspect(s)}"
    end
  end
end
