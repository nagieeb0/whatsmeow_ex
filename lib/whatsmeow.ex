defmodule Whatsmeow do
  @moduledoc """
  Pure-Elixir port of the [whatsmeow](https://github.com/tulir/whatsmeow) Go
  library — a multi-device WhatsApp Web client.

  This module is the public facade. It is intentionally thin: it delegates to
  `Whatsmeow.Sessions.Supervisor` for lifecycle, to `Whatsmeow.Session` for
  per-device operations, and to `Whatsmeow.Store` for persistence.

  ## Quick start

      {:ok, device} = Whatsmeow.Store.new_device(client_id: "user-42")
      {:ok, pid}    = Whatsmeow.start_session(device)
      {:ok, _ref}   = Whatsmeow.subscribe(device.id)
      {:ok, qr}     = Whatsmeow.Pair.qr(pid)
      # ... user scans the QR ...
      :ok = Whatsmeow.send_text(pid, "1234567890@s.whatsapp.net", "hello")

  ## Process model

  Exactly **one `Whatsmeow.Session` GenServer per paired device**. The session
  owns its WebSocket, Noise cipher state, Signal `SessionCache` ETS table, IQ
  pending map, retry timers, and reconnect backoff. Crashes restart the entire
  session; durable state is recovered from Postgres.

  See `plan.md` at the project root for the phased implementation roadmap and
  `.claude/plans/i-want-to-make-mellow-badger.md` for architecture rationale.
  """

  @typedoc "A device record persisted in the store."
  @type device :: struct()

  @typedoc "A running session process for a paired device."
  @type session :: pid()

  @doc """
  Library version, taken from `mix.exs` at compile time.
  """
  @spec version() :: String.t()
  def version do
    Application.spec(:whatsmeow_ex, :vsn) |> to_string()
  end

  @doc """
  Start (or look up) the session GenServer for the given device.

  Returns `{:ok, pid}` on success. If a session is already running for the
  device, returns `{:ok, existing_pid}`.

  The session is keyed by the device's stable identifier — `client_id` if
  set (the host-application's tenant key), otherwise `jid`, otherwise `id`
  (for plain test fixtures). PubSub topics and the Sessions registry both
  use this same key, so subscribers should pass the **same** value to
  `Whatsmeow.Notifications.subscribe/1`.

  ## Options

    * `:transport_opts` — forwarded to `transport.connect/1`. Use this to
      pin a per-tenant egress proxy: `[transport_opts: [proxy: "http://…"]]`.
    * `:transport` — override the transport module (defaults to
      `Whatsmeow.Config.transport/0`). Mainly for tests.
    * `:auto_reconnect?` — disable the GenServer's reconnect loop. Defaults
      to `true`.

  Any extra options are forwarded verbatim to `Whatsmeow.Session.init/1`.
  """
  @spec start_session(device, keyword()) :: {:ok, session} | {:error, term()}
  def start_session(device, opts \\ []) do
    case session_key(device) do
      key when is_binary(key) and key != "" ->
        session_opts = Keyword.merge(opts, device_id: key, device: device)
        spec = {Whatsmeow.Session, session_opts}

        case DynamicSupervisor.start_child(Whatsmeow.Sessions.Supervisor, spec) do
          {:ok, pid} -> {:ok, pid}
          {:error, {:already_started, pid}} -> {:ok, pid}
          {:error, _} = err -> err
        end

      _ ->
        {:error, :no_device_key}
    end
  end

  @doc """
  Child spec for declaring sessions in your own supervision tree.

  For a **fixed set of accounts known at boot**, this is better than calling
  `start_session/2` by hand: each child comes up with your application and is
  restarted with it, and the device is loaded (or created) from the store at
  start rather than baked into a spec that goes stale the moment pairing writes
  new credentials.

      children = [
        MyApp.Repo,
        MyApp.WhatsAppRouter,
        {Whatsmeow, client_id: "sales"},
        {Whatsmeow, client_id: "support"}
      ]

      Supervisor.start_link(children, strategy: :one_for_one)

  Each child's id is `{Whatsmeow, client_id}`, so several coexist.

  ## Options

    * `:client_id` — required. Your stable name for this account; the device is
      looked up by it and created if absent.
    * `:device` — an existing `%Device{}` to use instead of a store lookup.
    * everything else is passed to `Whatsmeow.Session`.

  For an unbounded set of accounts your users add at runtime, keep using
  `start_session/2` under `Whatsmeow.Sessions.Supervisor` — a supervision tree
  is the wrong shape for a list that changes.
  """
  @spec child_spec(keyword()) :: Supervisor.child_spec()
  def child_spec(opts) do
    client_id = Keyword.fetch!(opts, :client_id)

    %{
      id: {__MODULE__, client_id},
      start: {__MODULE__, :start_supervised_session, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 5_000
    }
  end

  @doc false
  @spec start_supervised_session(keyword()) :: {:ok, pid()} | {:error, term()}
  def start_supervised_session(opts) do
    client_id = Keyword.fetch!(opts, :client_id)
    session_opts = Keyword.drop(opts, [:client_id, :device])

    with {:ok, device} <- resolve_device(client_id, Keyword.get(opts, :device)) do
      Whatsmeow.Session.start_link(
        Keyword.merge(session_opts, device_id: client_id, device: device)
      )
    end
  end

  # Load the device by client_id, creating one on first boot. Doing this at start
  # rather than at spec-build time is the point: a spec built once holds a device
  # snapshot from before pairing, and a restart from that spec asks the user to
  # scan a QR for an account that is already paired.
  defp resolve_device(client_id, nil) do
    case Whatsmeow.Store.get_device_by_client_id(client_id) do
      {:ok, device} -> {:ok, device}
      {:error, :not_found} -> Whatsmeow.Store.new_device(client_id: client_id)
      {:error, _} = err -> err
    end
  end

  defp resolve_device(_client_id, device), do: {:ok, device}

  defp session_key(%{client_id: id}) when is_binary(id) and id != "", do: id
  defp session_key(%{jid: id}) when is_binary(id) and id != "", do: id
  defp session_key(%{id: id}) when is_binary(id) and id != "", do: id
  defp session_key(_), do: nil

  @doc "Stop the running session for `device_id` (no-op if not running)."
  @spec stop_session(String.t() | session) :: :ok
  def stop_session(pid) when is_pid(pid) do
    DynamicSupervisor.terminate_child(Whatsmeow.Sessions.Supervisor, pid)
  end

  def stop_session(device_id) when is_binary(device_id) do
    case Whatsmeow.Session.whereis(device_id) do
      :undefined -> :ok
      pid -> stop_session(pid)
    end
  end

  @doc "List all running session pids."
  @spec list_sessions() :: [session]
  def list_sessions do
    Whatsmeow.Sessions.Supervisor
    |> DynamicSupervisor.which_children()
    |> Enum.map(fn {_, pid, _, _} -> pid end)
    |> Enum.filter(&is_pid/1)
  end

  @doc """
  Subscribe the calling process to events for the given device id.

  Events are published over `Whatsmeow.PubSub` on the topic
  `"whatsmeow:device:" <> device_id`. Returns `{:ok, reference}` and sends
  typed event structs (`Whatsmeow.Types.Events.*`) to the caller.
  """
  @spec subscribe(String.t() | binary()) :: {:ok, reference()} | {:error, term()}
  def subscribe(device_id) when is_binary(device_id) do
    Phoenix.PubSub.subscribe(Whatsmeow.PubSub, topic_for(device_id))
    {:ok, make_ref()}
  end

  @doc """
  Send a plain text message to `jid`.

  Returns `{:ok, message_id}` — keep the id if you want to correlate the delivery
  receipt, edit the message later, or react to it.

  Delegates to `Whatsmeow.Send.send_text/4`; `opts` is passed straight through.
  """
  @spec send_text(session | String.t(), Whatsmeow.Types.JID.t() | String.t(), String.t(), keyword()) ::
          {:ok, String.t()} | {:error, term()}
  defdelegate send_text(session, jid, text, opts \\ []), to: Whatsmeow.Send

  @doc """
  Send an already-built message payload — anything from `Whatsmeow.Content` or
  the `Whatsmeow.Send.build_*` helpers.

      Whatsmeow.Content.location(30.0444, 31.2357, name: "Cairo")
      |> then(&Whatsmeow.send_message(pid, peer, &1))
  """
  @spec send_message(
          session | String.t(),
          Whatsmeow.Types.JID.t() | String.t(),
          struct(),
          keyword()
        ) :: {:ok, String.t()} | {:error, term()}
  defdelegate send_message(session, jid, message, opts \\ []), to: Whatsmeow.Send

  @doc "Send an image. Requires a `:media_conn` (see `Whatsmeow.Media.Refresh.refresh/2`)."
  defdelegate send_image(session, jid, bytes, opts \\ []), to: Whatsmeow.Send

  @doc "Send a video. Requires a `:media_conn`."
  defdelegate send_video(session, jid, bytes, opts \\ []), to: Whatsmeow.Send

  @doc "Send audio. Requires a `:media_conn`."
  defdelegate send_audio(session, jid, bytes, opts \\ []), to: Whatsmeow.Send

  @doc "Send a voice note (PTT-flagged audio). Requires a `:media_conn`."
  defdelegate send_voice(session, jid, bytes, opts \\ []), to: Whatsmeow.Send

  @doc "Send a document. Requires a `:media_conn`, plus `:file_name` and `:mime_type`."
  defdelegate send_document(session, jid, bytes, opts \\ []), to: Whatsmeow.Send

  @doc "Send a WebP sticker. Requires a `:media_conn`."
  defdelegate send_sticker(session, jid, bytes, opts \\ []), to: Whatsmeow.Send

  @doc """
  React to a message with an emoji. Pass `""` to remove your reaction.

  `sender` is who sent the message being reacted to — `nil` for your own.
  """
  @spec send_reaction(
          session | String.t(),
          Whatsmeow.Types.JID.t() | String.t(),
          Whatsmeow.Types.JID.t() | nil,
          String.t(),
          String.t(),
          keyword()
        ) :: {:ok, String.t()} | {:error, term()}
  def send_reaction(session, chat, sender, message_id, emoji, opts \\ []) do
    send_message(
      session,
      chat,
      Whatsmeow.Send.build_reaction(chat, sender, message_id, emoji),
      opts
    )
  end

  @doc """
  Delete a message for everyone.

  Pass `nil` as `sender` to revoke your own; pass their JID to revoke someone
  else's as a group admin.
  """
  @spec send_revoke(
          session | String.t(),
          Whatsmeow.Types.JID.t() | String.t(),
          Whatsmeow.Types.JID.t() | nil,
          String.t(),
          keyword()
        ) :: {:ok, String.t()} | {:error, term()}
  def send_revoke(session, chat, sender, message_id, opts \\ []) do
    send_message(session, chat, Whatsmeow.Send.build_revoke(chat, sender, message_id), opts)
  end

  @doc """
  Edit a message you sent.

  WhatsApp enforces a 20-minute window; past it the server drops the edit
  without an error.
  """
  @spec send_edit(
          session | String.t(),
          Whatsmeow.Types.JID.t() | String.t(),
          String.t(),
          String.t(),
          keyword()
        ) :: {:ok, String.t()} | {:error, term()}
  def send_edit(session, chat, message_id, new_text, opts \\ []) when is_binary(new_text) do
    new_content = %WAWebProtobufsE2E.Message{conversation: new_text}
    send_message(session, chat, Whatsmeow.Send.build_edit(chat, message_id, new_content), opts)
  end

  @doc """
  Cast a vote in a poll.

  `poll` identifies the poll message — `%{chat:, sender:, id:}`, the same fields
  you get from the `%Whatsmeow.Types.Events.Message{}` that carried it.
  `option_names` must match the poll's options exactly; they are matched by hash,
  so a typo counts as no vote rather than raising.

  Votes are encrypted under the *poll's* secret, which arrived with the poll and
  nowhere else. If this device never received the poll (and never recovered it
  through history sync) the answer is `{:error, :no_message_secret}` — there is
  no way to produce a valid vote without it.
  """
  @spec send_poll_vote(
          session | String.t(),
          %{chat: term(), sender: term(), id: String.t()},
          [String.t()],
          keyword()
        ) :: {:ok, String.t()} | {:error, term()}
  def send_poll_vote(session, %{chat: chat} = poll, option_names, opts \\ []) do
    with {:ok, device} <- Whatsmeow.Session.get_device(session),
         {:ok, vote} <- Whatsmeow.Content.poll_vote(device.jid, poll, option_names) do
      send_message(session, chat, vote, opts)
    end
  end

  # --- Contacts -------------------------------------------------------------

  @doc """
  Check which of `phones` are on WhatsApp, and get the JID to actually send to.

  **Send to the JID this returns, not to the number you typed.** The server
  canonicalises numbers, and the two are not always the same string. Brazilian
  mobile numbers are the classic trap — the extra "9" may or may not be part of
  the canonical address, so probe both forms and use whichever resolves.

  `phones` are E.164 digits, with or without a leading `+`.
  """
  @spec on_whatsapp(session | String.t(), [String.t()], keyword()) ::
          {:ok, [Whatsmeow.User.IsOnWhatsAppResponse.t()]} | {:error, term()}
  defdelegate on_whatsapp(session, phones, opts \\ []), to: Whatsmeow.User, as: :is_on_whatsapp

  @doc """
  Fetch each contact's status ("about") text.

  Returns a map of JID string to `%Whatsmeow.User.Info{}`; the text is on
  `:status`. Also carries the verified business name, profile-picture id, device
  list, and LID.
  """
  @spec fetch_status(session | String.t(), [Whatsmeow.Types.JID.t() | String.t()], keyword()) ::
          {:ok, %{String.t() => Whatsmeow.User.Info.t()}} | {:error, term()}
  defdelegate fetch_status(session, jids, opts \\ []), to: Whatsmeow.User, as: :get_user_info

  @doc """
  Resolve contacts to their `{lid, pn}` pair — see `Whatsmeow.User.resolve_lid/3`.
  """
  @spec resolve_lid(session | String.t(), [Whatsmeow.Types.JID.t() | String.t()], keyword()) ::
          {:ok, [%{lid: Whatsmeow.Types.JID.t() | nil, pn: Whatsmeow.Types.JID.t() | nil}]}
          | {:error, term()}
  defdelegate resolve_lid(session, jids, opts \\ []), to: Whatsmeow.User

  @doc "Resolve the device list for `jids`. Cached — see `Whatsmeow.User.DeviceCache`."
  defdelegate get_user_devices(session, jids, opts \\ []), to: Whatsmeow.User

  @doc false
  def topic_for(device_id), do: "whatsmeow:device:" <> device_id
end
