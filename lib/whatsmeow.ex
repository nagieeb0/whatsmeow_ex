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
  Send a plain text message to a JID. Will be implemented in Phase 9.
  """
  @spec send_text(session, String.t(), String.t()) :: :ok | {:error, term()}
  def send_text(_pid, _jid, _text) do
    raise Whatsmeow.NotImplementedError, phase: 9, feature: "send_text/3"
  end

  @doc false
  def topic_for(device_id), do: "whatsmeow:device:" <> device_id
end
