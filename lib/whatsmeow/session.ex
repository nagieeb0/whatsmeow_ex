defmodule Whatsmeow.Session do
  @moduledoc """
  Per-device GenServer — owns the WebSocket, Noise cipher state, Signal
  session cache, IQ pending map, keepalive timer, and reconnect backoff.

  ## Lifecycle

  ```
      idle ──cast(:connect)──▶ connecting ──connect_ok──▶ handshaking
        ▲                                                    │
        │                                                    │ handshake_ok
        │                                                    ▼
        │                                                connected
        │                                                    │
        └──schedule_reconnect──── disconnected ◀──ws_closed──┘
  ```

  ## Inbound flow (post-handshake)

  Mint's TLS messages land directly in this GenServer's mailbox.
  `handle_info/2` matches `{:ssl, _, _}` / `{:tcp, _, _}` /
  `{:ssl_closed, _}` etc. and feeds them to
  `transport.process_message/2`. The returned WebSocket frames are
  length-prefix-peeled, AEAD-decrypted, binary-XML-decoded, and
  dispatched:

    * `<iq><pair-device>`  → `Whatsmeow.Pair.handle_pair_device/2`
      → broadcast `%Events.QR{}` → send `<iq type="result">` ack
    * `<iq><pair-success>` → `Whatsmeow.Pair.handle_pair_success/2`
      → broadcast `%Events.PairSuccess{}` → upsert device row via
      `Whatsmeow.Store` → send `<pair-device-sign>` ack
    * `<success>`          → `Whatsmeow.Login.parse_first_node/1`
      → broadcast `%Events.LoggedIn{}` → schedule keepalive
    * `<failure>`          → broadcast `%Events.LoggedOut{}` → stop
    * `<stream:error>`     → telemetry + schedule reconnect with backoff
    * `<iq type="result">` / `<iq type="error">` with a known `id`
      → reply to the caller in the pending map
    * anything else        → debug log, ignored (Phase 9 will fill the
      `<message>` / `<receipt>` / `<notification>` slots)

  ## Keepalive

  Server closes idle conns at ~30 s after the last frame. The Session
  schedules a `<iq xmlns="w:p" type="get"/>` every 20–25 s (jittered)
  via `Process.send_after(self(), :keepalive_tick, ms)`. The IQ id is
  parked in the pending map; the matching `<iq type="result"/>` clears
  it. If three consecutive pings go un-acked the session forces a
  reconnect (the lower-layer TCP rarely fails fast enough on its own).

  ## Reconnect backoff

  Exponential with jitter, capped at 5 min: `min(5min, 2^attempts * 1s)`
  plus a uniform 0–500 ms jitter. Cleared on a successful `<success>`.
  """

  # `:transient` — restart on a crash, stay down on a deliberate `:normal` stop.
  #
  # `on_failure/2` answers a refused identity (401/403/406) by clearing
  # `auto_reconnect?` and stopping with `:normal`, because retrying is
  # re-authenticating a deleted device in a loop. Under the default
  # `:permanent` the supervisor restarted it anyway, `init/1` rebuilt
  # `auto_reconnect?` from opts — where it defaults to `true` — and
  # `dial_on_boot?/1` saw a JID still in the row and dialled again. Measured on
  # one device: 63 × `<failure reason=:logged_out>` with the next `connecting`
  # three milliseconds later, and a device index that climbed to `:44@lid`.
  #
  # `auto_reconnect?: false` is per-process state. A stop is the only thing that
  # outlives the process, so the restart policy is where that decision has to
  # live. A crash still restarts and still self-dials — that is the behaviour
  # `5ff9ac5` added and it is untouched here; only the deliberate stop is now
  # honoured.
  use GenServer, restart: :transient

  require Logger

  alias Whatsmeow.Binary
  alias Whatsmeow.ConnectionEvents
  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.IQ
  alias Whatsmeow.Login
  alias Whatsmeow.Pair
  alias Whatsmeow.PairCode
  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.Transport.{Frame, Handshake, NoiseHandshake, NoiseSocket}
  alias Whatsmeow.Types.Events

  # 25 s ± 2.5 s — comfortably under the server's ~30 s idle close.
  # How long the server gets to answer the post-login `<active/>`. Fifteen
  # seconds is far beyond a healthy round trip and well inside the window in
  # which a clinic would notice nothing arriving.
  @active_iq_deadline_ms 15_000

  @keepalive_base_ms 25_000
  @keepalive_jitter_ms 2_500
  # After 3 consecutive un-acked pings, force a reconnect.
  @keepalive_max_consecutive_failures 3
  # Backoff: 1s, 2s, 4s, … capped.
  @reconnect_initial_ms 1_000
  @reconnect_max_ms 300_000

  # How many times a *retryable* `<failure>` may be answered with a reconnect
  # before we stop and say so. At the 5-minute backoff cap this is roughly half
  # an hour of trying — long enough to ride out a rate limit or a WhatsApp
  # deploy, short enough that a genuinely dead device stops knocking.
  @failure_retry_cap 10

  # Per-message-id retry counter ETS table. See `bump_retry_count/1`.
  @retry_count_table :whatsmeow_message_retries
  # Drop retry-count rows older than this on each sweep.
  @retry_count_ttl_s 86_400
  # Sweep cadence — every hour.
  @retry_count_sweep_ms 3_600_000

  # How many times we will answer a retry for one message id. The peer
  # decides how often to ask; this decides how often we pay a prekey fetch
  # for an answer that is evidently not landing.
  @retry_answer_cap 3

  defstruct [
    :device_id,
    :device,
    :transport,
    :transport_conn,
    :transport_opts,
    :noise_handshake,
    :noise_socket,
    :status,
    :reconnect_attempts,
    :reconnect_timer,
    :keepalive_timer,
    :keepalive_failures,
    # **Did the server agree to start sending us messages?**
    #
    # `:unsent` → `:pending` → `:answered` | `:refused`. Go's `SetPassive` uses
    # a blocking `sendIQ` and logs a failure; this port sent the same stanza
    # fire-and-forget, so a rejected or unanswered `<active/>` left a session
    # authenticated, keepalive-healthy, sending fine and receiving nothing —
    # with no log line anywhere. That state cost a clinic an evening.
    :active_iq,
    :auto_reconnect?,
    # QR-ref rotation: each `<pair-device>` IQ carries 4-6 refs.
    # The server expects the host UI to display them ONE AT A TIME,
    # advancing on a fixed cadence (60 s for the first, 20 s for
    # subsequent — matches Go's `qrchan.emitQRs`). Pre-Phase-15 we
    # broadcast all refs at once, which let the LV race through them
    # and only ever render the LAST one — so users scanned a ref the
    # server hadn't activated yet and pair-success silently never
    # fired. We now buffer the queue here and pop one at a time.
    :qr_emit_queue,
    :qr_emit_timer,
    # Cached PairCode.HelloResult while a phone-number ("link with phone")
    # pairing is mid-flight, between the companion_hello and the inbound
    # link_code_companion_reg notification. nil at all other times.
    :pair_code,
    # Offline/sandbox mode: no socket is ever opened and outbound messages are
    # recorded here instead of encrypted and sent. Exists so a consumer can test
    # their bot's receive→reply path without a WhatsApp connection — see
    # `Whatsmeow.Testing`. Always false in normal operation.
    offline?: false,
    # Failure-originated reconnect attempts, counted separately from
    # `reconnect_attempts` and reset only by a real `<success>`.
    #
    # They cannot share a counter. `reconnect_attempts` is zeroed the moment the
    # Noise handshake completes (`do_connect/1`), and a `<failure>` arrives
    # *after* that — it is an application-layer refusal on a socket that
    # connected fine. Reusing it would reset the backoff on every attempt and
    # turn a retryable failure into a one-second hammer loop against WhatsApp,
    # which is the ban shape this file is otherwise careful to avoid.
    failure_retries: 0,
    sent: [],
    pending: %{}
  ]

  @type status ::
          :idle
          | :connecting
          | :handshaking
          | :pairing
          | :connected
          | :authenticated
          | :disconnected
          | :stopping

  @type t :: %__MODULE__{
          device_id: String.t(),
          device: Device.t() | nil,
          transport: module(),
          transport_conn: term() | nil,
          transport_opts: keyword(),
          noise_handshake: NoiseHandshake.t() | nil,
          noise_socket: NoiseSocket.t() | nil,
          status: status(),
          reconnect_attempts: non_neg_integer(),
          reconnect_timer: reference() | nil,
          keepalive_timer: reference() | nil,
          keepalive_failures: non_neg_integer(),
          auto_reconnect?: boolean(),
          pending: %{optional(String.t()) => :keepalive | {pid(), reference()}},
          pair_code: PairCode.HelloResult.t() | nil
        }

  # --- Public API -----------------------------------------------------------

  @doc """
  Start a session for `device_id`. Registers under `Whatsmeow.Sessions.Registry`.

  Opts:

    * `:device` — `%Device{}` (required for `connect/1` to succeed)
    * `:transport` — module implementing `Whatsmeow.Transport.WebSocket`
      (default: `Whatsmeow.Config.transport()`)
    * `:transport_opts` — opts forwarded to `transport.connect/1` (e.g.
      `[proxy: "http://…"]`)
    * `:auto_reconnect?` — boolean (default `true`)
  """
  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(opts) do
    device_id = Keyword.fetch!(opts, :device_id)
    GenServer.start_link(__MODULE__, opts, name: via(device_id))
  end

  @doc "Look up a running session for `device_id`."
  @spec whereis(String.t()) :: pid() | :undefined
  def whereis(device_id) do
    case Registry.lookup(Whatsmeow.Sessions.Registry, device_id) do
      [{pid, _}] -> pid
      [] -> :undefined
    end
  end

  @doc "Initiate a connect attempt. Will trigger the Noise handshake."
  @spec connect(pid() | String.t()) :: :ok
  def connect(server), do: GenServer.cast(via_or_pid(server), :connect)

  @doc """
  Drop the socket and dial again, even if the session believes it is connected.

  For a caller holding evidence the session is wrong — a watchdog whose round
  trip timed out, say. `connect/1` is idempotent and ignores a request while
  the status is `:connected`/`:authenticated`, which is correct for a racing
  UI click and useless against a wedged socket.
  """
  @spec force_reconnect(pid() | String.t()) :: :ok
  def force_reconnect(server), do: GenServer.cast(via_or_pid(server), :force_reconnect)

  @doc "Synchronous snapshot of the session's status + bookkeeping. Cheap; use freely in tests/dashboards."
  @spec info(pid() | String.t()) :: %{
          status: status(),
          device_id: String.t(),
          reconnect_attempts: non_neg_integer(),
          keepalive_failures: non_neg_integer(),
          pending_count: non_neg_integer()
        }
  def info(server), do: GenServer.call(via_or_pid(server), :info)

  @doc "Send a pre-built binary-XML `Node` over the wire. Returns `:ok` or `{:error, reason}`."
  @spec send_node(pid() | String.t(), Binary.Node.t()) :: :ok | {:error, term()}
  def send_node(server, %Binary.Node{} = node),
    do: GenServer.call(via_or_pid(server), {:send_node, node})

  @doc """
  Send an IQ `node` and block until the matching `<iq type="result|error">`
  comes back, or `timeout` ms elapse.

  The caller is parked in the session's pending map keyed by the
  outbound IQ's `id`. The dispatch tree (`on_iq_response/2`) wakes the
  caller with `{:whatsmeow_iq, ref, response_node}`; this function
  unwraps and returns `{:ok, response}` or `{:error, :timeout}`.

  Used by the Send pipeline to fetch a peer's PreKey bundle before
  bootstrapping a Signal session.
  """
  @spec send_iq(pid() | String.t(), Binary.Node.t(), non_neg_integer()) ::
          {:ok, Binary.Node.t()} | {:error, term()}
  def send_iq(server, %Binary.Node{} = iq, timeout \\ 30_000) do
    ref = make_ref()
    caller = self()

    case GenServer.call(via_or_pid(server), {:send_iq, iq, caller, ref}) do
      :ok ->
        receive do
          {:whatsmeow_iq, ^ref, response} -> {:ok, response}
        after
          timeout -> {:error, :timeout}
        end

      {:error, _} = err ->
        err
    end
  end

  @doc "Read the device record this session is bound to (or `nil`)."
  @spec get_device(pid() | String.t()) :: {:ok, Device.t()} | {:error, :no_device}
  def get_device(server), do: GenServer.call(via_or_pid(server), :get_device)

  @doc """
  True when this session is in offline/sandbox mode — no socket, sends recorded
  rather than transmitted. See `Whatsmeow.Testing`.
  """
  @spec offline?(pid() | String.t()) :: boolean()
  def offline?(server), do: GenServer.call(via_or_pid(server), :offline?)

  @doc """
  Record `message` and return `:recorded` when this session is in sandbox mode,
  or `:live` when it is a real session and the caller should go on and send it.

  One call rather than an `offline?/1` check followed by a record — the send path
  runs this on every message.
  """
  @spec record_if_offline(pid() | String.t(), term(), term(), String.t()) :: :recorded | :live
  def record_if_offline(server, peer, message, msg_id) do
    GenServer.call(via_or_pid(server), {:record_if_offline, peer, message, msg_id})
  end

  @doc """
  Messages this offline session was asked to send, oldest first.

  Each entry is `%{to: peer_jid, message: %WAWebProtobufsE2E.Message{}, id: msg_id}`.
  Always empty for a normal session.
  """
  @spec sent_messages(pid() | String.t()) :: [map()]
  def sent_messages(server), do: GenServer.call(via_or_pid(server), :sent_messages)

  @doc "Drop the recorded outbound messages of an offline session."
  @spec clear_sent(pid() | String.t()) :: :ok
  def clear_sent(server), do: GenServer.call(via_or_pid(server), :clear_sent)

  @doc """
  Begin phone-number ("link with phone number") pairing.

  Sends the `companion_hello` IQ for `phone` (international format; non-digit
  characters are stripped) and returns the user-facing 8-character linking
  code (`"XXXX-XXXX"`). The user types it into WhatsApp on their primary
  phone under *Linked Devices → Link with phone number*.

  The handshake finishes automatically: the session catches the inbound
  `link_code_companion_reg` notification, derives the adv-secret, and replies
  with `companion_finish`. A normal `%Events.PairSuccess{}` is broadcast once
  the server confirms — identical to the QR flow from there on.

  Must be called from outside the session process (it blocks on `send_iq`),
  with the session already connected.
  """
  @spec pair_phone(pid() | String.t(), String.t(), keyword()) ::
          {:ok, String.t()} | {:error, term()}
  def pair_phone(server, phone, opts \\ []) when is_binary(phone) do
    with {:ok, %Device{noise_key: noise_key} = _device} <- get_device(server),
         noise_pub = Curve25519.public_for(noise_key),
         {:ok, code, %PairCode.HelloResult{} = hello} <-
           PairCode.start_link(server, phone, Keyword.put(opts, :noise_pub, noise_pub)) do
      :ok = GenServer.call(via_or_pid(server), {:set_pair_code, hello})
      {:ok, code}
    end
  end

  @doc "Stop the session (graceful)."
  @spec stop(pid() | String.t()) :: :ok
  def stop(server), do: GenServer.stop(via_or_pid(server), :normal)

  @doc """
  True when the session's WebSocket + Noise transport are up.

  Mirrors Go's `Client.IsConnected` (`client.go`).
  """
  @spec connected?(pid() | String.t()) :: boolean()
  def connected?(server) do
    case info(server) do
      %{status: status} -> status in [:connected, :authenticated]
      _ -> false
    end
  rescue
    _ -> false
  catch
    :exit, _ -> false
  end

  @doc """
  True when the session has completed auth (`<success>` received post-Noise).

  Mirrors Go's `Client.IsLoggedIn` (`client.go`).
  """
  @spec logged_in?(pid() | String.t()) :: boolean()
  def logged_in?(server) do
    case info(server) do
      %{status: :authenticated} -> true
      _ -> false
    end
  rescue
    _ -> false
  catch
    :exit, _ -> false
  end

  # --- Callbacks ------------------------------------------------------------

  @impl GenServer
  def init(opts) do
    device_id = Keyword.fetch!(opts, :device_id)
    device = reload_device(device_id, Keyword.get(opts, :device))
    transport = Keyword.get(opts, :transport, Whatsmeow.Config.transport())
    transport_opts = Keyword.get(opts, :transport_opts, [])
    auto_reconnect? = Keyword.get(opts, :auto_reconnect?, true)
    offline? = Keyword.get(opts, :offline?, false)

    Process.flag(:trap_exit, true)

    ensure_retry_table()
    Process.send_after(self(), :retry_count_sweep, @retry_count_sweep_ms)

    state = %__MODULE__{
      device_id: device_id,
      device: device,
      transport: transport,
      transport_opts: transport_opts,
      status: :idle,
      reconnect_attempts: 0,
      keepalive_failures: 0,
      auto_reconnect?: auto_reconnect?,
      offline?: offline?
    }

    # Dial ourselves, instead of waiting for somebody to remember to.
    #
    # This process is `:permanent` under a DynamicSupervisor, so it is restarted
    # after every crash — and after `on_failure/2`'s deliberate `{:stop, :normal}`.
    # The restarted process used to land here at `:idle` and simply sit there:
    # the host application casts `:connect` exactly once, at boot, and nothing
    # re-runs that. So the second crash of the day left a paired number silently
    # off the air, with no log line and no event — its only signature the
    # *absence* of "connecting". The operator's screen showed a healthy pairing
    # and the only button under it unlinked the device.
    #
    # Gated on the same question `ClientPayload.build/1` asks, deliberately: a
    # device we would send a login payload for is one we should dial, and a
    # device we would send a *registration* payload for must never dial itself —
    # that opens a pairing socket on every boot for every clinic that has not
    # got round to pairing yet. `Whatsmeow.Pairing`-style flows still connect
    # explicitly, and `handle_cast(:connect, …)` is idempotent.
    if dial_on_boot?(state) do
      {:ok, state, {:continue, :connect}}
    else
      {:ok, state}
    end
  end

  defp dial_on_boot?(%__MODULE__{offline?: true}), do: false
  defp dial_on_boot?(%__MODULE__{auto_reconnect?: false}), do: false
  defp dial_on_boot?(%__MODULE__{device: %{jid: jid}}), do: Whatsmeow.ClientPayload.paired?(jid)
  defp dial_on_boot?(_state), do: false

  @impl GenServer
  def handle_continue(:connect, state), do: handle_cast(:connect, state)

  # Re-read the device from the store instead of trusting the one in `opts`.
  #
  # `Whatsmeow.start_session/2` bakes the `%Device{}` into the child spec it
  # hands `DynamicSupervisor`, and a supervisor restarts a child from the spec
  # it was ORIGINALLY given. So `opts[:device]` is a snapshot frozen at the
  # moment the session was first started — which, for the case that matters, is
  # *before* pairing.
  #
  # Pairing writes the adv credentials (`adv_account_sig`, the real JID, the
  # identity/noise keys) to the store. It cannot write them back into a child
  # spec the supervisor is holding. So the crash path was:
  #
  #   pair → credentials in Postgres, session authenticated
  #   crash → supervisor restarts from the stale spec → unpaired device
  #        → handshake has no login payload → server sends <pair-device>
  #        → a QR appears and the user is asked to scan again
  #
  # while the store held a perfectly good paired device the whole time. That
  # defeats the entire point of persisting the device, and it is silent: the
  # logs show a normal connect, just into a pairing flow instead of a login.
  #
  # Observed downstream (imdent, 2026-08-12): killing a live, logged-in session
  # left it emitting QR codes for 11+ minutes with `adv_account_sig` present in
  # the row the whole time.
  #
  # Falls back to the passed struct when the store has nothing for this key —
  # a brand-new device on its very first start, and any host using an in-memory
  # or custom store that does not persist.
  defp reload_device(device_id, fallback) do
    with nil <- by_client_id(device_id),
         nil <- by_jid(device_id) do
      fallback
    else
      %Device{} = fresh ->
        if fallback && Map.get(fallback, :jid) != Map.get(fresh, :jid) do
          Logger.info(
            "[whatsmeow] session restarted with a stale device snapshot; " <>
              "reloaded from store (spec jid=#{inspect(Map.get(fallback, :jid))} " <>
              "store jid=#{inspect(Map.get(fresh, :jid))})",
            device_id: device_id
          )
        end

        fresh
    end
  end

  defp by_client_id(device_id) do
    case Whatsmeow.Store.get_device_by_client_id(device_id) do
      {:ok, %Device{} = d} -> d
      _ -> nil
    end
  rescue
    # A store that is not up yet must not stop the session from booting; the
    # fallback snapshot still lets it run exactly as it did before.
    _ -> nil
  end

  defp by_jid(device_id) do
    case Whatsmeow.Store.get_device(device_id) do
      {:ok, %Device{} = d} -> d
      _ -> nil
    end
  rescue
    _ -> nil
  end

  @impl GenServer
  def handle_call(:info, _from, state) do
    {:reply,
     %{
       status: state.status,
       device_id: state.device_id,
       reconnect_attempts: state.reconnect_attempts,
       keepalive_failures: state.keepalive_failures,
       pending_count: map_size(state.pending),
       active_iq: state.active_iq || :unsent
     }, state}
  end

  def handle_call({:send_node, node}, _from, %__MODULE__{status: status} = state)
      when status in [:connected, :authenticated] do
    case do_send_node(state, node) do
      {:ok, state2} -> {:reply, :ok, state2}
      {:error, _} = err -> {:reply, err, state}
    end
  end

  def handle_call({:send_node, _}, _from, state) do
    {:reply, {:error, {:not_connected, state.status}}, state}
  end

  def handle_call(:get_device, _from, %__MODULE__{device: nil} = state) do
    {:reply, {:error, :no_device}, state}
  end

  def handle_call(:get_device, _from, %__MODULE__{device: device} = state) do
    {:reply, {:ok, device}, state}
  end

  def handle_call(:offline?, _from, %__MODULE__{offline?: offline?} = state) do
    {:reply, offline?, state}
  end

  def handle_call({:record_if_offline, _peer, _message, _msg_id}, _from, %{offline?: false} = state) do
    {:reply, :live, state}
  end

  def handle_call({:record_if_offline, peer, message, msg_id}, _from, state) do
    entry = %{to: peer, message: message, id: msg_id}
    {:reply, :recorded, %{state | sent: [entry | state.sent]}}
  end

  def handle_call(:sent_messages, _from, state) do
    {:reply, Enum.reverse(state.sent), state}
  end

  def handle_call(:clear_sent, _from, state) do
    {:reply, :ok, %{state | sent: []}}
  end

  def handle_call({:set_pair_code, hello}, _from, state) do
    {:reply, :ok, %{state | pair_code: hello}}
  end

  def handle_call({:send_iq, iq, caller_pid, ref}, _from, %__MODULE__{status: status} = state)
      when status in [:connected, :authenticated] do
    id = Binary.Node.attr(iq, "id")
    xmlns = Binary.Node.attr(iq, "xmlns")
    iq_type = Binary.Node.attr(iq, "type")

    case do_send_node(state, iq) do
      {:ok, state2} when is_binary(id) and id != "" ->
        Logger.debug(
          fn ->
            "[whatsmeow] iq sent id=#{id} type=#{iq_type} xmlns=#{inspect(xmlns)} pending=#{map_size(state2.pending) + 1}"
          end,
          device_id: state.device_id
        )

        pending = Map.put(state2.pending, id, {caller_pid, ref})
        {:reply, :ok, %{state2 | pending: pending}}

      {:ok, _state2} ->
        Logger.warning("[whatsmeow] iq dropped: missing id", device_id: state.device_id)
        {:reply, {:error, :missing_iq_id}, state}

      {:error, reason} = err ->
        Logger.error("[whatsmeow] iq wire send failed reason=#{inspect(reason)}",
          device_id: state.device_id
        )

        {:reply, err, state}
    end
  end

  def handle_call({:send_iq, _iq, _caller, _ref}, _from, state) do
    Logger.warning("[whatsmeow] iq rejected: session #{state.status}",
      device_id: state.device_id
    )

    {:reply, {:error, {:not_connected, state.status}}, state}
  end

  @impl GenServer
  def handle_cast(:connect, %__MODULE__{device: nil} = state) do
    Logger.warning("[whatsmeow] connect requested but no device on state; ignoring",
      device_id: state.device_id
    )

    {:noreply, state}
  end

  # In-progress states: another `:connect` cast lands when the LV or
  # Autostart races a re-pair click. Treat as no-op — opening a fresh
  # socket would orphan the in-flight one, and any `<pair-device>` IQ
  # already in our mailbox would belong to the old conn and get dropped
  # by `transport.process_message/2` (returns `:unknown` for messages
  # from a different socket). That's the bug that made QR events
  # disappear in the LV when users clicked Connect a second time.
  def handle_cast(:connect, %__MODULE__{status: status} = state)
      when status in [:connecting, :handshaking, :pairing, :connected, :authenticated] do
    Logger.debug("[whatsmeow] :connect cast received while #{status} — ignoring",
      device_id: state.device_id
    )

    {:noreply, state}
  end

  # Tear the socket down first, then dial. For the caller who has *evidence*
  # that a session reporting `:connected` is not.
  #
  # `:connect` is deliberately idempotent, which makes it useless to a watchdog:
  # a session wedged at `:authenticated` on a socket that stopped answering is
  # exactly the case the watchdog exists to repair, and its `connect/1` was
  # being dropped by the clause above as a debug line. The one repair it had was
  # a no-op on the one failure it could detect.
  def handle_cast(:force_reconnect, %__MODULE__{status: status} = state)
      when status in [:connecting, :handshaking, :connected, :authenticated] do
    Logger.warning("[whatsmeow] forced reconnect while #{status}", device_id: state.device_id)

    {:noreply, handle_disconnect(state, :forced)}
  end

  # Not up in the first place: an ordinary dial.
  def handle_cast(:force_reconnect, %__MODULE__{} = state), do: handle_cast(:connect, state)

  def handle_cast(:connect, %__MODULE__{status: :idle} = state) do
    case cold_start_jitter_ms() do
      0 ->
        do_connect(state)

      max ->
        delay = :rand.uniform(max)

        Logger.debug("[whatsmeow] cold-start jitter",
          device_id: state.device_id,
          delay_ms: delay
        )

        Process.send_after(self(), :connect_after_cold_start, delay)
        {:noreply, state}
    end
  end

  # `:disconnected`, `:stopping`, or any future state — fresh connect.
  def handle_cast(:connect, %__MODULE__{} = state), do: do_connect(state)

  defp do_connect(%__MODULE__{} = state) do
    :telemetry.execute(
      [:whatsmeow, :session, :connect, :start],
      %{system_time: System.system_time()},
      %{device_id: state.device_id, attempt: state.reconnect_attempts}
    )

    Logger.info("[whatsmeow] connecting", device_id: state.device_id)
    state = %{state | status: :connecting}

    with {:ok, conn} <- state.transport.connect(state.transport_opts),
         state = %{state | status: :handshaking, transport_conn: conn},
         {:ok, conn, ns} <-
           Handshake.run(transport: state.transport, conn: conn, device: state.device) do
      Logger.info("[whatsmeow] handshake complete", device_id: state.device_id)

      :telemetry.execute(
        [:whatsmeow, :session, :connect, :stop],
        %{system_time: System.system_time()},
        %{device_id: state.device_id, outcome: :ok}
      )

      Whatsmeow.Notifications.broadcast(state.device_id, %Events.Connected{
        device_id: state.device_id
      })

      # `reconnect_attempts` is **not** zeroed here.
      #
      # It used to be, and the reasoning was that completing a Noise handshake
      # is evidence the connection works. It is evidence the *transport* works,
      # and the failure this backoff exists for is the one where the transport
      # works and login never happens: handshake fine, socket dropped before
      # `<success>`, redial. Zeroing here made every cycle `attempt=1`, so the
      # documented 1s → 5min ramp never engaged — 1,506 connect attempts, 1,500
      # handshakes and one `LoggedIn` in a single log.
      #
      # So it is zeroed on `<success>` instead, beside `failure_retries`, which
      # has always reset there for the same reason: authenticated, not merely
      # connected. `keepalive_failures` still resets here, because the keepalive
      # genuinely starts here (see below).
      state = %{
        state
        | transport_conn: conn,
          noise_socket: ns,
          status: :connected,
          keepalive_failures: 0
      }

      # CRITICAL: keepalive must run from the moment the handshake
      # completes, NOT just after `<success>`. Upstream Go starts
      # `keepAliveLoop` immediately after `doHandshake` returns
      # (`client.go:560`). On a fresh device this gap is the entire
      # pairing window — the server sits there sending pair-device
      # IQs every ~20 s and expects `<iq xmlns="w:p" type="get"/>`
      # pings back. With no pings, the server tears the socket down
      # after ~30 s of one-way traffic and the user never sees
      # `<pair-success>` even though they scanned in time.
      state = schedule_keepalive(state)

      # CRITICAL: drain any frames that arrived in the same TCP segment
      # as the final handshake response. Mint's WS decoder returns ALL
      # frames in that segment; `Handshake.run` only consumes the ones
      # it needs and the rest sit in `transport_conn.buffer`. Without
      # this drain, an immediately-following `<iq><pair-device>` IQ is
      # stranded — the next `:ssl` message won't arrive until we ack
      # pair-device, but we never see it because nothing dispatched the
      # buffered frame. This deadlock was the actual reason QR codes
      # never appeared in the Session path even though the smoke task
      # (synchronous `recv` loop that drains buffer-first) worked fine.
      drain_buffered_frames(state)
    else
      err ->
        # Reason inlined in the message body — the default Logger
        # formatter strips `:metadata` for everything except
        # `:request_id`, which made the old "connect failed" line a
        # mystery in production logs.
        Logger.error(
          "[whatsmeow] connect failed reason=#{inspect(err, limit: 6, printable_limit: 200)}",
          device_id: state.device_id
        )

        :telemetry.execute(
          [:whatsmeow, :session, :connect, :stop],
          %{system_time: System.system_time()},
          %{device_id: state.device_id, outcome: :failed, reason: err}
        )

        {:noreply, schedule_reconnect(%{state | status: :disconnected})}
    end
  end

  # Pop any frames buffered in `transport_conn` and dispatch them
  # through the normal pipeline. Mint's WS decoder may return multiple
  # frames in a single `:ssl` message; `Handshake.run` only consumes
  # what it needs and leaves the rest in `transport_conn.buffer`. This
  # is invariant across transports — the `Whatsmeow.Transport.WebSocket`
  # behaviour exposes a `buffer` field on the conn struct.
  defp drain_buffered_frames(%__MODULE__{transport_conn: conn} = state) do
    case Map.get(conn, :buffer, []) do
      [] ->
        {:noreply, state}

      buffered when is_list(buffered) ->
        Logger.debug("[whatsmeow] draining #{length(buffered)} post-handshake frames",
          device_id: state.device_id
        )

        cleared_conn = %{conn | buffer: []}
        state = %{state | transport_conn: cleared_conn}
        process_ws_frames(state, buffered)
    end
  end

  # --- handle_info ---------------------------------------------------------

  @impl GenServer
  def handle_info(:connect_after_cold_start, %__MODULE__{status: :idle} = state),
    do: do_connect(state)

  def handle_info(:connect_after_cold_start, state) do
    # State already moved past :idle (e.g. user called connect/1 again, or stop).
    {:noreply, state}
  end

  def handle_info(:keepalive_tick, %__MODULE__{status: status} = state)
      when status in [:connected, :authenticated, :pairing] do
    state = note_unanswered_keepalive(state)

    # `bump_keepalive_failure/1` may have just torn the socket down.
    if state.status in [:connected, :authenticated, :pairing] do
      case send_keepalive(state) do
        {:ok, state2} ->
          {:noreply, schedule_keepalive(state2)}

        {:error, reason} ->
          Logger.warning("[whatsmeow] keepalive send failed",
            device_id: state.device_id,
            reason: inspect(reason)
          )

          {:noreply, schedule_keepalive(bump_keepalive_failure(state))}
      end
    else
      {:noreply, state}
    end
  end

  def handle_info(:keepalive_tick, state) do
    # Not connected — drop the tick; will be rescheduled on next connect.
    {:noreply, %{state | keepalive_timer: nil}}
  end

  def handle_info({:reconnect, attempt}, %__MODULE__{reconnect_attempts: attempt} = state) do
    Logger.info("[whatsmeow] reconnect attempt", device_id: state.device_id, attempt: attempt)
    handle_cast(:connect, %{state | reconnect_timer: nil})
  end

  def handle_info({:reconnect, _stale}, state) do
    # Newer attempt scheduled; drop the stale firing.
    {:noreply, state}
  end

  # Pop the next QR ref from the queue, broadcast it to subscribers,
  # and schedule the following one. When the queue empties we just
  # park — a new `<pair-device>` IQ from the server will refill it.
  def handle_info(:emit_next_qr, %__MODULE__{qr_emit_queue: queue} = state)
      when is_list(queue) and queue != [] do
    [next_ref | rest] = queue
    broadcast_qr(state, next_ref)

    state = %{state | qr_emit_queue: rest, qr_emit_timer: nil}

    state =
      if rest == [] do
        state
      else
        ms = qr_ref_timeout_ms(length(rest) + 1, :rest)
        ref = Process.send_after(self(), :emit_next_qr, ms)
        %{state | qr_emit_timer: ref}
      end

    {:noreply, state}
  end

  def handle_info(:emit_next_qr, state), do: {:noreply, state}

  def handle_info({:send_hist_sync_receipt, message_id}, state) do
    case build_history_sync_receipt(state, message_id) do
      nil ->
        {:noreply, state}

      node ->
        {:ok, state2} = do_send_node(state, node) |> ok_or_keep(state)
        {:noreply, state2}
    end
  end

  def handle_info({:EXIT, _, _reason}, state), do: {:noreply, state}

  def handle_info(:retry_count_sweep, state) do
    deleted = __retry_count_sweep__()

    if deleted > 0 do
      Logger.debug(fn -> "[whatsmeow] retry-count sweep dropped #{deleted} stale rows" end,
        device_id: state.device_id
      )
    end

    Process.send_after(self(), :retry_count_sweep, @retry_count_sweep_ms)
    {:noreply, state}
  end

  def handle_info(:post_login_bootstrap, %__MODULE__{status: :authenticated} = state) do
    # Send the post-login set-passive(false) + presence. The server
    # quietly drops idle sessions if these don't show up shortly after
    # <success>. Mirrors Go's `SetPassive` + `SendPresence` calls in
    # `whatsmeow-main/connectionevents.go`.
    state =
      state
      |> send_active_iq()
      |> send_node_or_log(
        IQ.build_presence(:available, push_name(state.device)),
        "presence"
      )

    # Kick off async PreKey upload — runs in its own Task so the
    # blocking IQ round-trip doesn't stall the Session mailbox.
    server = self()
    initial? = needs_initial_prekey_upload?(state.device)

    _ =
      Task.Supervisor.start_child(Whatsmeow.Media.TaskSup, fn ->
        do_post_login_prekey_upload(server, initial?)
      end)

    {:noreply, state}
  end

  # The deadline fired. If the id is still pending, the server never answered —
  # which is not an error the protocol reports, and is the closest thing there
  # is to "this device is authenticated and will not be fed".
  def handle_info({:active_iq_deadline, id}, state) do
    case Map.pop(state.pending, id) do
      {:active_iq, pending} ->
        Logger.error(
          "[whatsmeow] the server never answered our post-login <active/> in " <>
            "#{@active_iq_deadline_ms}ms — this device may be authenticated and " <>
            "receive nothing",
          device_id: state.device_id
        )

        {:noreply, %{state | pending: pending, active_iq: :unanswered}}

      _ ->
        {:noreply, state}
    end
  end

  def handle_info(:post_login_bootstrap, state) do
    # Status changed before we got around to it — drop silently.
    {:noreply, state}
  end

  def handle_info(msg, %__MODULE__{transport: transport, transport_conn: conn} = state)
      when not is_nil(conn) do
    case transport.process_message(conn, msg) do
      {:ok, conn, frames} ->
        process_ws_frames(%{state | transport_conn: conn}, frames)

      :closed ->
        Logger.info("[whatsmeow] websocket closed by server", device_id: state.device_id)
        {:noreply, handle_disconnect(state, :closed)}

      :unknown ->
        # Not a Mint message for our conn — ignore (lets other transports
        # share the mailbox if needed, and avoids crashing on stray msgs).
        {:noreply, state}

      {:error, reason} ->
        Logger.warning("[whatsmeow] transport error",
          device_id: state.device_id,
          reason: inspect(reason)
        )

        {:noreply, handle_disconnect(state, {:transport, reason})}
    end
  end

  def handle_info(_msg, state), do: {:noreply, state}

  @impl GenServer
  def terminate(_reason, %__MODULE__{transport_conn: nil}), do: :ok

  def terminate(_reason, %__MODULE__{transport: transport, transport_conn: conn}) do
    _ = transport.close(conn)
    :ok
  end

  # --- frame → IQ dispatch -------------------------------------------------

  defp process_ws_frames(state, []), do: {:noreply, state}

  defp process_ws_frames(state, [ws_payload | rest]) do
    {framed, _rest_bytes} = Frame.read_frames(ws_payload)

    state = Enum.reduce(framed, state, &decrypt_and_dispatch/2)

    case state.status do
      :stopping -> {:stop, :normal, state}
      _ -> process_ws_frames(state, rest)
    end
  end

  defp decrypt_and_dispatch(ciphertext, %__MODULE__{noise_socket: ns} = state) do
    case NoiseSocket.decrypt(ns, ciphertext) do
      {:ok, plain, ns2} ->
        case unpack_and_decode(plain) do
          {:ok, %Binary.Node{} = node} ->
            dispatch_node(%{state | noise_socket: ns2}, node)

          {:error, reason} ->
            Logger.warning("[whatsmeow] binary-decode failed",
              device_id: state.device_id,
              reason: inspect(reason)
            )

            %{state | noise_socket: ns2}
        end

      {:error, :auth_failed} ->
        Logger.error("[whatsmeow] AEAD auth failed mid-stream — counter drift",
          device_id: state.device_id
        )

        handle_disconnect(state, :aead_auth_failed)
    end
  end

  defp dispatch_node(state, %Binary.Node{tag: "iq"} = iq) do
    cond do
      Binary.Node.get_child(iq, "pair-device") != nil ->
        on_pair_device(state, iq)

      Binary.Node.get_child(iq, "pair-success") != nil ->
        on_pair_success(state, iq)

      Binary.Node.attr(iq, "type") in ["result", "error"] ->
        on_iq_response(state, iq)

      # Server-initiated `<iq type="get"><ping/></iq>` and similar
      # liveness probes. Reply with a bare `<iq type="result">` echoing
      # the request id — same shape the upstream Go client and our
      # smoke task use. Without this the server escalates to a TCP
      # close after the keepalive deadline. We only reply when an `id`
      # attribute is present (an empty id triggers a `<stream:error>`).
      Binary.Node.attr(iq, "type") == "get" ->
        on_server_iq_get(state, iq)

      true ->
        # Anything else: log + ignore. Upstream Go also silently drops
        # unknown server-initiated iqs (`handleIQ` in pair.go only
        # branches on `pair-device` / `pair-success`). Sending a
        # generic ack here was confusing the server with malformed
        # replies and made things worse.
        log_unhandled_iq(state, iq)
        state
    end
  end

  defp dispatch_node(state, %Binary.Node{tag: "success"} = node) do
    on_success(state, node)
  end

  defp dispatch_node(state, %Binary.Node{tag: "failure"} = node) do
    on_failure(state, node)
  end

  defp dispatch_node(state, %Binary.Node{tag: "stream:error"} = node) do
    on_stream_error(state, node)
  end

  defp dispatch_node(state, %Binary.Node{tag: "xmlstreamend"}) do
    handle_disconnect(state, :stream_end)
  end

  # `<ib>` = "info broadcast" — server-pushed config (offline-sync
  # preview, dirty state, edge-routing hints, downgrade hints). Mirrors
  # upstream Go's `handleIB` in `connectionevents.go`: walks the
  # children and dispatches typed events for the ones we care about,
  # silently ignoring the rest. No ack required at protocol level.
  defp dispatch_node(state, %Binary.Node{tag: "ib"} = node) do
    on_ib(state, node)
  end

  defp dispatch_node(state, %Binary.Node{tag: "message"} = msg) do
    on_message(state, msg)
  end

  defp dispatch_node(state, %Binary.Node{tag: "receipt"} = node) do
    receipt = Whatsmeow.Receipt.from_node(state.device_id, node)

    if receipt do
      Logger.info(
        "[whatsmeow] receipt in type=#{inspect(receipt.type)} ids=#{inspect(receipt.message_ids)} from=#{inspect(receipt.from)}",
        device_id: state.device_id
      )

      # Sync broadcast — `Phoenix.PubSub.broadcast/3` is ~1 µs/subscriber
      # locally, and `send/2` itself is non-blocking (the only thing that
      # actually waits is enqueue, which is essentially instant). The
      # earlier async-via-Task wrapper hurt rather than helped: it added
      # ~15 µs of spawn overhead AND broke per-subscriber FIFO ordering,
      # because two Tasks from different pids have no message-ordering
      # guarantee to the same subscriber. Stay sync here so agents
      # (Jido, etc.) see messages in wire order.
      Whatsmeow.Notifications.broadcast(state.device_id, receipt)
    end

    # A retry receipt is not information, it is a request, and this library
    # answered it for a long time by broadcasting it and moving on.
    #
    # `<receipt type="retry">` means one of the recipient's devices could not
    # decrypt something we sent. Their screen says "في انتظار هذه الرسالة" and
    # ours says delivered. Measured live: one reply, three of the recipient's
    # devices — the laptop opened and read it, the phone asked twice, was never
    # answered, and the person never saw a word of it.
    #
    # See `Whatsmeow.Send.answer_retry/5` for why an ordinary re-send is the
    # wrong answer and what this does instead.
    state = maybe_answer_retry(state, receipt)

    ack = Whatsmeow.Receipt.build_ack(node)
    {:ok, state2} = do_send_node(state, ack) |> ok_or_keep(state)
    state2
  end

  defp dispatch_node(state, %Binary.Node{tag: "notification"} = node) do
    # Phone-number pairing: the primary phone's response arrives as a
    # `<notification>` carrying `<link_code_companion_reg>`. Finish the
    # handshake (derive the adv-secret, send `companion_finish`) before we
    # ack, so the follow-up `<pair-success>` verifies. Only when a pairing
    # is actually mid-flight (`pair_code` cached).
    state =
      if state.pair_code && Binary.Node.get_child(node, "link_code_companion_reg") do
        on_code_pair_notification(state, node)
      else
        # Some `<notification>` flavours carry data we want to persist
        # before we ack. The big one is `type="devices"` — it announces
        # LID ↔ phone pairings as peers add/remove linked devices. Without
        # snarfing these into `whatsmeow_lid_map`, every privacy-LID peer
        # arrives at the chatbot as an anonymous LID and the agent has to
        # ask "who are you?" even when we already know them by phone.
        _ = maybe_persist_lid_map(node)
        _ = maybe_persist_privacy_token(state, node)
        state
      end

    ack = Whatsmeow.Receipt.build_ack(node)
    {:ok, state2} = do_send_node(state, ack) |> ok_or_keep(state)
    state2
  end

  # `<ack>` is the server's word on a stanza we sent. A bare ack is routine and
  # ignorable; an ack carrying `error=` means the socket took the frame but the
  # application layer threw it away — the send "succeeded" and the message was
  # never delivered. That is the single most confusing failure in this protocol,
  # so it gets its own event rather than a debug log.
  defp dispatch_node(state, %Binary.Node{tag: "ack", attrs: attrs} = node) do
    case Map.get(attrs, "error") do
      nil ->
        state

      code ->
        code = to_string(code)

        Logger.warning(
          "[whatsmeow] send rejected: ack error=#{code} id=#{inspect(Map.get(attrs, "id"))} " <>
            "class=#{inspect(Map.get(attrs, "class"))}",
          device_id: state.device_id
        )

        _ = maybe_reissue_privacy_token(state, node, code)

        Whatsmeow.Notifications.broadcast(state.device_id, %Events.SendRejected{
          device_id: state.device_id,
          message_id: Map.get(attrs, "id"),
          code: code,
          from: Binary.Node.attr(node, "from"),
          class: Map.get(attrs, "class")
        })

        state
    end
  end

  defp dispatch_node(state, %Binary.Node{tag: "call"} = node) do
    ack = Whatsmeow.Receipt.build_ack(node)
    {:ok, state2} = do_send_node(state, ack) |> ok_or_keep(state)
    state2
  end

  defp dispatch_node(state, %Binary.Node{tag: tag} = node) do
    # Inline the tag + node skeleton in the message — the default dev
    # logger formatter drops keyword metadata, which made silent-drop
    # diagnostics impossible (IQ responses got lost here without anyone
    # seeing which tag was on the wire).
    Logger.debug(
      fn ->
        attrs_preview =
          case node do
            %Binary.Node{attrs: %{} = a} ->
              a |> Enum.take(5) |> Enum.map_join(",", fn {k, v} -> "#{k}=#{inspect(v)}" end)

            _ ->
              ""
          end

        "[whatsmeow] unhandled inbound tag=#{tag} attrs=#{attrs_preview}"
      end,
      device_id: state.device_id
    )

    state
  end

  # --- <message> dispatch ---------------------------------------------------

  defp on_message(state, %Binary.Node{} = msg) do
    own_jid = own_jid(state.device)

    # **Counted the instant the stanza arrives, before anything can reject it.**
    #
    # Every other signal about an inbound message fires after parsing and after
    # decrypt, so a stanza that dies in `MessageInfo.from_node/2` below is
    # indistinguishable from one the server never sent — and the two are
    # opposite problems. A host watching a device that announces thirty-five
    # queued messages and decrypts none has no way, without this, to tell
    # whether the bytes ever came.
    :telemetry.execute(
      [:whatsmeow, :session, :message_received],
      %{system_time: System.system_time()},
      %{device_id: state.device_id, from: Binary.Node.attr(msg, "from")}
    )

    case Whatsmeow.MessageInfo.from_node(msg, own_jid) do
      {:ok, info} ->
        # The server volunteers the sender's other address on some stanzas and
        # not others. Recording it the moment it appears is what makes the
        # quiet ones resolvable later, and it is the only live-path source of
        # the mapping outside the history sync that runs once at link time.
        learn_sender_alt(info)

        # Always ack first so the server doesn't resend on a slow decrypt.
        ack = Whatsmeow.Receipt.build_ack(msg)
        {:ok, state} = do_send_node(state, ack) |> ok_or_keep(state)

        case try_decrypt_and_broadcast(state, msg, info) do
          :ok ->
            # Always send the delivery receipt (double grey tick). The
            # READ receipt (double blue tick — "seen") is gated by the
            # host application via `:send_read_receipts` config. Hosts
            # that want the same privacy semantics as WhatsApp's
            # "Read receipts: off" setting can disable it without
            # affecting delivery confirmations.
            delivery = Whatsmeow.Receipt.build_delivery_receipt(msg)
            {:ok, state2} = do_send_node(state, delivery) |> ok_or_keep(state)

            state3 =
              if Application.get_env(:whatsmeow_ex, :send_read_receipts, true) do
                read = Whatsmeow.Receipt.build_read_receipt(msg)
                {:ok, s} = do_send_node(state2, read) |> ok_or_keep(state2)
                s
              else
                state2
              end

            state3

          {:retry, reason} ->
            # Signal-level decrypt failure. Mirrors Go's `sendRetryReceipt`
            # (`whatsmeow-main/retry.go:465`):
            #
            #   • Track the retry count per message id. After 5 attempts
            #     give up (peer's client is broken / message lost).
            #   • count == 1 → JUST `<retry/>` + `<registration/>`. No
            #     `<keys>` block. Go also fires `requestMessageFromPhone`
            #     here, asking the peer's PRIMARY device to re-send via
            #     the multi-device fanout path. We skip that for now —
            #     it requires the peer's app-state to be in sync.
            #   • count >= 2 → INCLUDE `<keys>` so the peer can do a
            #     fresh X3DH against our identity.
            #
            # The old code sent `count: 1` AND keys on every retry,
            # which the peer's libsignal apparently silently ignored —
            # they kept replaying the same stale ciphertext forever
            # because they never got "permission" to drop their session.
            msg_id = Whatsmeow.Binary.Node.attr(msg, "id")
            count = bump_retry_count(msg_id)

            if count > 5 do
              Logger.warning(
                "[whatsmeow] retry receipt cap reached id=#{msg_id} — abandoning",
                device_id: state.device_id
              )

              state
            else
              keys =
                if count >= 2,
                  do: build_retry_keys_tuple(state.device),
                  else: nil

              Logger.debug(
                "[whatsmeow] sending retry receipt count=#{count} reason=#{inspect(reason)} id=#{msg_id}"
              )

              retry =
                Whatsmeow.Receipt.build_retry_receipt(msg,
                  count: count,
                  # Coerce a missing registration_id to 0 — happens in
                  # test fixtures and on a not-yet-fully-paired device.
                  # `build_retry_receipt/2` documents `0` as the default
                  # already; we just enforce it here so a nil from an
                  # unfinished `%Device{}` doesn't blow the binary cons.
                  registration_id: state.device.registration_id || 0,
                  keys: keys
                )

              {:ok, state2} = do_send_node(state, retry) |> ok_or_keep(state)

              # On first failure, ALSO ask our primary phone to
              # re-forward the message via `PEER_DATA_OPERATION_REQUEST`.
              # The retry-receipt asks the SENDER to re-encrypt; this
              # peer-message asks OUR OWN primary phone to re-forward
              # the message it already has decrypted in its history.
              # Either path can recover the missed message — fire both
              # so we maximise chances of getting the content.
              # Mirrors Go's `delayedRequestMessageFromPhone`
              # (`whatsmeow-main/retry.go:417`).
              if count == 1, do: request_message_from_phone(state2, info)

              state2
            end

          :no_decrypt ->
            state
        end

      {:error, reason} ->
        # Telemetry as well as a log line: this is the one branch that consumes
        # a message without ever reaching a decrypt event, so a host counting
        # only decrypts sees the stanza vanish.
        :telemetry.execute(
          [:whatsmeow, :session, :message_rejected],
          %{system_time: System.system_time()},
          %{device_id: state.device_id, from: Binary.Node.attr(msg, "from"), reason: reason}
        )

        Logger.warning("[whatsmeow] inbound <message> rejected",
          device_id: state.device_id,
          reason: inspect(reason)
        )

        # Nack with code 1 so the server still stops resending.
        ack = Whatsmeow.Receipt.build_ack(msg, 1)
        {:ok, state2} = do_send_node(state, ack) |> ok_or_keep(state)
        state2
    end
  end

  # Returns :ok on successful decrypt + Events.Message broadcast,
  # :no_decrypt when we surfaced an UndecryptableMessage instead (so the
  # caller skips the post-decrypt <receipt>).
  defp try_decrypt_and_broadcast(state, %Binary.Node{} = msg, info) do
    case Whatsmeow.Signal.Decrypt.decrypt_message_node(msg, state.device, info) do
      {:ok, %{plaintext: plain}} ->
        case Whatsmeow.Signal.MessageBuilder.from_plaintext(plain, info) do
          {:ok, typed_msg, attachments} ->
            # Protocol bookkeeping runs BEFORE the pipeline and regardless of it.
            # A recv plugin decides what the *consumer* sees; it has no business
            # deciding whether we download our own chat history or keep the key
            # that later decrypts votes on a poll. Dropping a spam message must
            # not silently break history sync.
            _ = maybe_start_history_sync(state, typed_msg, info)
            _ = maybe_store_message_secret(state, typed_msg, info)

            # The receive pipeline runs before anything is broadcast, so a step
            # that halts means no subscriber ever learns the message existed.
            # It does NOT skip the ack — the server has already been told we got
            # this message, and must be, or it redelivers forever.
            case run_recv_pipeline(state, typed_msg, info) do
              {:halt, _reason} -> :ok
              {:ok, final} -> broadcast_decrypted(state, final, info, attachments, plain)
            end

          {:error, reason} ->
            Logger.warning("[whatsmeow] WaE2E.Message decode failed",
              device_id: state.device_id,
              reason: inspect(reason)
            )

            broadcast_undecryptable(state, msg, info, reason)
            :no_decrypt
        end

      {:error, reason} ->
        # Signal-layer decrypt failure — surface as `UndecryptableMessage`
        # AND tell the caller to send a `<receipt type="retry">` so the
        # peer drops its stale session and re-bootstraps. Returning
        # `{:retry, reason}` (not `:no_decrypt`) is what distinguishes a
        # recoverable Signal mismatch from an unrecoverable plaintext
        # decode error.
        broadcast_undecryptable(state, msg, info, reason)
        {:retry, reason}
    end
  end

  defp run_recv_pipeline(state, typed_msg, info) do
    ctx = %{from: info.from, message: typed_msg, info: info, device_id: state.device_id}

    case Whatsmeow.Plugin.run(:recv, ctx) do
      {:ok, %{message: %Whatsmeow.Types.Message{} = message}} ->
        {:ok, message}

      # A step handed back a ctx with no usable `:message`. Carry on with the
      # original rather than crashing the session — this runs in the receive
      # loop, and a plugin bug must not take the connection down with it.
      {:ok, _} ->
        {:ok, typed_msg}

      {:halt, reason} ->
        {:halt, reason}
    end
  end

  defp broadcast_decrypted(state, typed_msg, info, attachments, plain) do
    # Sync — see comment in receipt branch above. Per-chat ordering at the
    # subscriber depends on these being sent FROM THE SAME PID (the session
    # GenServer). Task-spawn broadcasts shatter that guarantee.
    Whatsmeow.Notifications.broadcast(state.device_id, %Events.Message{
      device_id: state.device_id,
      message: typed_msg,
      info: info
    })

    Enum.each(attachments, fn descriptor ->
      Whatsmeow.Notifications.broadcast(state.device_id, %Events.MediaMessage{
        device_id: state.device_id,
        info: info,
        message: typed_msg,
        descriptor: descriptor,
        kind: descriptor.kind
      })
    end)

    :telemetry.execute(
      [:whatsmeow, :session, :message_decrypted],
      %{system_time: System.system_time(), plaintext_bytes: byte_size(plain)},
      %{
        device_id: state.device_id,
        from: info.from,
        attachments: length(attachments)
      }
    )

    :ok
  end

  # Snarf any LID ↔ phone pairings out of a `<notification>` and
  # persist them to `whatsmeow_lid_map`. WhatsApp announces these
  # pairings whenever a peer adds / removes a linked device or our
  # device first learns about them. Without persisting, every
  # privacy-LID peer stays anonymous to us forever and downstream
  # patient resolution (Imdent.WhatsApp.Inbox.lookup_patient_id)
  # falls back to "I don't know who you are".
  #
  # Shape (per WhatsApp's multi-device protocol):
  #   <notification type="devices" from="<phone_jid>" lid="<lid_jid>">
  #     <add ...><device jid="<phone_jid>:N" lid="<lid>:N"/></add>
  #     ...
  #   </notification>
  defp maybe_persist_lid_map(%Binary.Node{tag: "notification", attrs: attrs} = node) do
    case Map.get(attrs, "type") do
      "devices" ->
        from = Map.get(attrs, "from")
        lid = Map.get(attrs, "lid")

        # Top-level pairing (the peer's primary phone ↔ primary LID).
        _ = persist_lid_pn(lid, from)

        # This notification IS the "their devices changed" signal. Drop the
        # cached list now instead of waiting out its TTL — otherwise we keep
        # encrypting to a device they removed, and a device they just added
        # sees nothing for up to an hour.
        _ = Whatsmeow.User.DeviceCache.invalidate(from)
        _ = Whatsmeow.User.DeviceCache.invalidate(lid)

        # Per-device pairings inside `<add>` / `<remove>` / `<update>`.
        node
        |> Binary.Node.children()
        |> List.wrap()
        |> Enum.each(fn child ->
          child
          |> Binary.Node.get_children("device")
          |> Enum.each(fn dev ->
            d_jid = Binary.Node.attr(dev, "jid")
            d_lid = Binary.Node.attr(dev, "lid")
            _ = persist_lid_pn(d_lid, d_jid)
          end)
        end)

        :ok

      _ ->
        :ok
    end
  rescue
    _ -> :ok
  end

  defp maybe_persist_lid_map(_), do: :ok

  # `<notification type="privacy_token">` carries the trusted-contact token the
  # server issued for a peer. Persisting it is what lets the *next* 1:1 send
  # attach a `<tctoken>` and avoid a silent 463 rejection. Without this write the
  # table stays empty forever and `Whatsmeow.PrivacyToken.fetch/2` never hits.
  defp maybe_persist_privacy_token(state, %Binary.Node{attrs: %{"type" => "privacy_token"}} = node) do
    our_jid = own_jid_string(state)

    if our_jid do
      node
      |> Whatsmeow.Notification.from_node()
      |> Enum.each(fn
        %Whatsmeow.Notification.PrivacyToken{} = ev ->
          _ = Whatsmeow.PrivacyToken.store_notification(our_jid, ev)

        _ ->
          :ok
      end)
    end

    :ok
  rescue
    _ -> :ok
  end

  defp maybe_persist_privacy_token(_state, _node), do: :ok

  # 463 = MessageAccountRestriction: we sent to a contact without a token they
  # trust. Ask the server to issue one so the *next* send lands. We deliberately
  # do not retry the rejected message — Baileys' `handleBadAck` notes that
  # retrying a 463 compounds the restriction.
  defp maybe_reissue_privacy_token(state, %Binary.Node{} = node, "463") do
    our_jid = own_jid_string(state)
    peer = Binary.Node.attr(node, "from")

    with true <- is_binary(our_jid),
         %Whatsmeow.Types.JID{} = peer_jid <- normalize_jid(peer) do
      # Runs in a Task so the IQ round-trip doesn't stall the receive loop it's
      # called from. `reissue_after_rejection/3` owns the debounce — a peer that
      # rejects a burst of messages must not produce one IQ per rejection.
      device_id = state.device_id

      Task.start(fn ->
        Whatsmeow.PrivacyToken.reissue_after_rejection(device_id, our_jid, peer_jid)
      end)
    end

    :ok
  rescue
    _ -> :ok
  end

  defp maybe_reissue_privacy_token(_state, _node, _code), do: :ok

  # --- History sync ---------------------------------------------------------

  # Your phone announces the chat-history blob with a `historySyncNotification`
  # inside a `protocolMessage`. Ignoring it (which is what we did before) leaves
  # the chat list permanently empty and the phone showing this device as
  # "Paused" — the live receive path only ever sees messages sent after linking.
  defp maybe_start_history_sync(state, %{raw: raw}, info) do
    # A history-sync notification is our own phone handing us our own chats. It
    # can only come from us. Go gates the whole protocol-message handler on
    # `info.IsFromMe` for this reason — without the check, any peer could point
    # us at an arbitrary CDN blob and have us download and decrypt it.
    with true <- info.is_from_me?,
         %WAWebProtobufsE2E.HistorySyncNotification{} = notif <- history_sync_notification(raw) do
      device_id = state.device_id
      our_jid = own_jid_string(state)

      Logger.info(
        "[whatsmeow] history sync announced: type=#{inspect(notif.syncType)} " <>
          "chunk=#{inspect(notif.chunkOrder)} progress=#{inspect(notif.progress)}",
        device_id: device_id
      )

      # The phone waits for this before it will move past "Paused" and sends the
      # next chunk. Acknowledges the notification, not the blob, so it goes out
      # whether or not the download succeeds — withholding it stalls the sync.
      #
      # Sent as a self-message rather than inline: writing a frame advances the
      # Noise cipher, and that advanced state has to be threaded back into the
      # GenServer. We are three calls deep in a path that returns `:ok`, with no
      # way to hand state back — dropping it would desynchronise the cipher and
      # break every frame after this one.
      send(self(), {:send_hist_sync_receipt, info.id})

      # Background: the blob can be tens of megabytes, and the media-conn IQ it
      # needs would deadlock if we called back into this process from here.
      Task.start(fn -> run_history_sync(device_id, our_jid, notif) end)
    end

    :ok
  rescue
    _ -> :ok
  end

  # `<receipt type="hist_sync" to="<our own jid>" id="<message id>"/>`.
  # Ports Go's `SendProtocolMessageReceipt` (`whatsmeow-main/message.go:853`).
  defp build_history_sync_receipt(state, message_id) when is_binary(message_id) do
    case own_jid(state.device) do
      %Whatsmeow.Types.JID{} = own ->
        Binary.Node.new(
          "receipt",
          %{
            "id" => message_id,
            "type" => "hist_sync",
            "to" => Whatsmeow.Types.JID.to_non_ad(own)
          },
          nil
        )

      _ ->
        nil
    end
  end

  defp build_history_sync_receipt(_state, _message_id), do: nil

  defp history_sync_notification(%WAWebProtobufsE2E.Message{
         protocolMessage: %WAWebProtobufsE2E.ProtocolMessage{
           historySyncNotification: %WAWebProtobufsE2E.HistorySyncNotification{} = notif
         }
       }),
       do: notif

  defp history_sync_notification(_), do: nil

  # --- Message secrets ------------------------------------------------------

  defp maybe_store_message_secret(state, %{raw: raw}, info) do
    with our_jid when is_binary(our_jid) <- own_jid_string(state),
         secret when is_binary(secret) and byte_size(secret) > 0 <- message_secret(raw) do
      chat = info.from && Whatsmeow.Types.JID.to_string(info.from)

      sender =
        cond do
          info.is_from_me? -> our_jid
          info.participant -> Whatsmeow.Types.JID.to_string(info.participant)
          true -> chat
        end

      Whatsmeow.MsgSecret.Store.put(our_jid, chat, sender, info.id, secret)
    else
      _ -> :ok
    end
  rescue
    _ -> :ok
  end

  defp message_secret(%WAWebProtobufsE2E.Message{
         messageContextInfo: %WAWebProtobufsE2E.MessageContextInfo{messageSecret: secret}
       }),
       do: secret

  defp message_secret(_), do: nil

  defp run_history_sync(device_id, our_jid, notif) do
    case Whatsmeow.HistorySync.download(notif, server: device_id) do
      {:ok, sync} ->
        Whatsmeow.Notifications.broadcast(device_id, %Events.HistorySync{
          device_id: device_id,
          sync: sync,
          sync_type: notif.syncType,
          progress: sync.progress || notif.progress,
          chunk_order: sync.chunkOrder || notif.chunkOrder
        })

        # After the consumer has the data — storing is best-effort and must not
        # delay delivery of the event they actually asked for.
        if our_jid, do: Whatsmeow.HistorySync.store_side_effects(our_jid, sync)

      {:error, reason} ->
        Logger.warning("[whatsmeow] history sync failed: #{inspect(reason)}", device_id: device_id)

        Whatsmeow.Notifications.broadcast(device_id, %Events.HistorySyncFailed{
          device_id: device_id,
          reason: reason,
          notification: notif
        })
    end
  end

  defp normalize_jid(%Whatsmeow.Types.JID{} = j), do: j

  defp normalize_jid(s) when is_binary(s) do
    case Whatsmeow.Types.JID.parse(s) do
      {:ok, %Whatsmeow.Types.JID{} = j} -> j
      _ -> nil
    end
  end

  defp normalize_jid(_), do: nil

  defp own_jid_string(%{device: %{jid: jid}}) when is_binary(jid) and jid != "", do: jid
  defp own_jid_string(_), do: nil

  # Delegates to `Whatsmeow.LIDMap`, which owns validation (both sides must be a
  # well-formed LID / PN) and normalisation (strip the device suffix — a pairing
  # is per person, not per device). The raw INSERT this used to do accepted
  # anything the attribute happened to contain, including device-suffixed JIDs
  # that then never matched a lookup.
  defp persist_lid_pn(lid, pn), do: Whatsmeow.LIDMap.put(lid, pn)

  # `LIDMap.put/2` validates which side is which, so this only has to decide
  # that there are two addresses to pair at all.
  defp learn_sender_alt(%Whatsmeow.MessageInfo{sender_alt: %Whatsmeow.Types.JID{} = alt} = info) do
    sender = if info.is_group?, do: info.participant, else: info.from

    case {sender, alt} do
      {%Whatsmeow.Types.JID{} = sender, alt} ->
        persist_lid_pn(sender, alt)
        persist_lid_pn(alt, sender)

      _ ->
        :ok
    end
  end

  defp learn_sender_alt(_info), do: :ok

  # Ask our PRIMARY phone (the device that paired us) to re-forward a
  # message our companion failed to decrypt. Runs as a fire-and-forget
  # `Task.start` so a slow IQ round-trip doesn't stall the receive
  # loop. Errors are intentionally swallowed — at worst the retry
  # receipt still works.
  defp request_message_from_phone(state, %Whatsmeow.MessageInfo{} = info) do
    server = self()
    chat = info.from
    sender = info.from
    msg_id = info.id

    Task.Supervisor.start_child(Whatsmeow.Media.TaskSup, fn ->
      try do
        peer_msg = Whatsmeow.Send.build_unavailable_message_request(chat, sender, msg_id)

        case Whatsmeow.Send.send_peer_message(server, peer_msg) do
          {:ok, peer_msg_id} ->
            Logger.debug(
              "[whatsmeow] requested missing message from phone — id=#{msg_id} peer_msg_id=#{peer_msg_id}",
              device_id: state.device_id
            )

          {:error, reason} ->
            Logger.debug(
              "[whatsmeow] peer-message request failed for #{msg_id}: #{inspect(reason)}",
              device_id: state.device_id
            )
        end
      rescue
        e ->
          Logger.debug(
            "[whatsmeow] peer-message request crashed for #{msg_id}: #{Exception.message(e)}",
            device_id: state.device_id
          )
      end
    end)

    :ok
  end

  # Per-message-id retry counter. Lives in a public named ETS table so
  # the count survives the next inbound (the same `<message id>` may
  # arrive multiple times — server replays until we successfully
  # decrypt). Initialised lazily on first use. Mirrors Go's
  # `cli.messageRetries` map.
  #
  # Tuple shape: `{msg_id, count, last_ts_seconds}`. The third element
  # is updated on every bump so the periodic `:retry_count_sweep` (see
  # `init/1`) can drop entries older than 24 h — without it the table
  # grew unboundedly under sustained load.

  defp bump_retry_count(nil), do: 1

  defp bump_retry_count(msg_id) when is_binary(msg_id) or is_tuple(msg_id) do
    ensure_retry_table()
    now = System.system_time(:second)
    count = :ets.update_counter(@retry_count_table, msg_id, {2, 1}, {msg_id, 0, now})
    _ = :ets.update_element(@retry_count_table, msg_id, {3, now})
    count
  end

  defp ensure_retry_table do
    case :ets.info(@retry_count_table) do
      :undefined ->
        try do
          :ets.new(@retry_count_table, [
            :public,
            :named_table,
            :set,
            read_concurrency: true,
            write_concurrency: true
          ])
        rescue
          # Two sessions starting at the same moment both see :undefined and both
          # try to create the table; the loser gets ArgumentError. The table
          # exists either way, which is all the caller needs. Without this, a
          # second session booting concurrently crashes in `init/1`.
          ArgumentError -> :ok
        end

        :ok

      _ ->
        :ok
    end
  end

  @doc false
  # Drop retry-count rows older than `@retry_count_ttl_s`. Public-ish for
  # tests; production callers should rely on the scheduled sweep.
  def __retry_count_sweep__(now \\ System.system_time(:second)) do
    ensure_retry_table()
    cutoff = now - @retry_count_ttl_s
    # `match_delete` with a guard would require `:ets.fun2ms` at compile
    # time; an `ets.select_delete` with a `>=` guard on the timestamp
    # field is simpler and just as fast for our table sizes.
    spec = [{{:_, :_, :"$1"}, [{:<, :"$1", cutoff}], [true]}]
    :ets.select_delete(@retry_count_table, spec)
  end

  # Build the 4-tuple consumed by `Whatsmeow.Receipt.build_retry_receipt`'s
  # `:keys` option. The tuple is
  #   {identity_pub, signed_prekey_node, prekey_node, device_identity_bytes}
  # and is rendered as the `<keys>` child of the retry receipt — the
  # bundle the peer needs to re-derive X3DH against our fresh identity
  # without an extra server round-trip. Picks an unused OPK from our
  # pool (generating one on the fly if the pool is empty). On any error
  # we return `nil` so the retry receipt is sent WITHOUT keys (still
  # better than no retry at all).
  defp build_retry_keys_tuple(%Whatsmeow.Store.Schemas.Device{} = device) do
    identity_pub = Whatsmeow.Crypto.Curve25519.public_for(device.identity_key)

    signed_prekey_pub =
      Whatsmeow.Crypto.Curve25519.public_for(device.signed_pre_key)

    signed_prekey_node =
      Whatsmeow.PreKeys.signed_pre_key_node(
        device.signed_pre_key_id,
        signed_prekey_pub,
        device.signed_pre_key_sig
      )

    prekey_node =
      case Whatsmeow.PreKeys.get_or_generate(device.jid, 1) do
        {:ok, [prekey | _]} -> Whatsmeow.PreKeys.prekey_to_node(prekey)
        _ -> nil
      end

    device_identity_bytes =
      %WAAdv.ADVSignedDeviceIdentity{
        details: device.adv_details,
        accountSignature: device.adv_account_sig,
        accountSignatureKey: device.adv_account_sig_key,
        deviceSignature: device.adv_device_sig
      }
      |> WAAdv.ADVSignedDeviceIdentity.encode()
      |> IO.iodata_to_binary()

    if is_nil(prekey_node) do
      nil
    else
      {identity_pub, signed_prekey_node, prekey_node, device_identity_bytes}
    end
  rescue
    e ->
      Logger.warning("[whatsmeow] build_retry_keys_tuple failed: #{Exception.message(e)}")
      nil
  end

  defp broadcast_undecryptable(state, %Binary.Node{} = msg, info, reason) do
    enc_children = Binary.Node.get_children(msg, "enc")

    Enum.each(enc_children, fn enc ->
      Whatsmeow.Notifications.broadcast(state.device_id, %Events.UndecryptableMessage{
        device_id: state.device_id,
        info: info,
        reason: undecryptable_reason(reason),
        enc_type: Binary.Node.attr(enc, "type"),
        enc_version: Binary.Node.attr(enc, "v"),
        enc_payload: enc.content
      })
    end)

    :telemetry.execute(
      [:whatsmeow, :session, :message_undecryptable],
      %{system_time: System.system_time(), enc_count: length(enc_children)},
      %{device_id: state.device_id, from: info.from, reason: undecryptable_reason(reason)}
    )

    :ok
  end

  defp undecryptable_reason(:no_session), do: :no_session
  defp undecryptable_reason(:no_identity_pub), do: :no_identity_pub
  defp undecryptable_reason(:no_repo), do: :no_repo
  defp undecryptable_reason(:no_store), do: :no_store
  defp undecryptable_reason(:no_enc), do: :no_enc
  defp undecryptable_reason(:mac_mismatch), do: :mac_mismatch
  defp undecryptable_reason(:bad_padding), do: :bad_padding
  defp undecryptable_reason(:missing_prekey), do: :missing_prekey
  defp undecryptable_reason(:no_group_session), do: :no_group_session
  defp undecryptable_reason(:no_chat), do: :no_chat
  defp undecryptable_reason(:no_sender), do: :no_sender
  defp undecryptable_reason(:bad_signature), do: :bad_signature
  defp undecryptable_reason(:duplicate_message), do: :duplicate_message
  defp undecryptable_reason(:iteration_too_far_ahead), do: :iteration_too_far_ahead
  defp undecryptable_reason({:proto_decode, _}), do: :proto_decode
  defp undecryptable_reason({:wire_decode, _}), do: :wire_decode
  defp undecryptable_reason({:aes, _}), do: :aes
  defp undecryptable_reason({:crash, _}), do: :crash
  defp undecryptable_reason(_), do: :no_signal_wire_proto

  defp own_jid(%Device{jid: jid}) when is_binary(jid) do
    case Whatsmeow.Types.JID.parse(jid) do
      {:ok, j} -> j
      _ -> nil
    end
  end

  defp own_jid(_), do: nil

  # --- pair-device → QR ----------------------------------------------------

  # Each `<pair-device>` IQ carries 4-6 ref strings, each pre-issued
  # by the server with its own activation window. Upstream Go's
  # `emitQRs` (qrchan.go:62) emits them ONE AT A TIME with a 60 s wait
  # for the first and 20 s for the rest — so the host UI rotates
  # through them in step with the server's expectations. If we
  # broadcast them all at once (the previous behavior) the LV's
  # `qr_code_base64` is overwritten N times in milliseconds and only
  # the LAST ref is ever rendered; the user scans an "early" ref the
  # server hasn't activated yet, and pair-success silently never fires.
  defp on_pair_device(state, iq) do
    refs = Pair.handle_pair_device(iq, state.device)

    # ACK the IQ first (matches upstream Go's ordering — pair.go:51).
    ack = Pair.build_pair_device_ack(iq)
    {:ok, state2} = do_send_node(state, ack) |> ok_or_keep(state)

    state2
    |> Map.put(:status, :pairing)
    |> start_qr_emitter(refs)
  end

  # Replace any in-flight QR emitter with one driven by the latest
  # ref batch. The new pair-device IQ supersedes the old refs, so any
  # pending `:emit_next_qr` timer must be cancelled first.
  defp start_qr_emitter(state, []), do: state

  defp start_qr_emitter(state, [first_ref | rest]) do
    state =
      state
      |> cancel_qr_emit_timer()
      |> Map.put(:qr_emit_queue, rest)

    broadcast_qr(state, first_ref)

    if rest == [] do
      %{state | qr_emit_timer: nil}
    else
      ms = qr_ref_timeout_ms(length([first_ref | rest]), :first)
      ref = Process.send_after(self(), :emit_next_qr, ms)
      %{state | qr_emit_timer: ref}
    end
  end

  defp cancel_qr_emit_timer(%__MODULE__{qr_emit_timer: ref} = state) when is_reference(ref) do
    _ = Process.cancel_timer(ref)
    %{state | qr_emit_timer: nil}
  end

  defp cancel_qr_emit_timer(state), do: state

  defp broadcast_qr(state, payload) do
    Whatsmeow.Notifications.broadcast(state.device_id, %Events.QR{
      device_id: state.device_id,
      code: payload
    })
  end

  # Upstream timing (qrchan.go:80): the first ref of a 6-ref batch
  # gets a 60 s window; subsequent refs get 20 s. Smaller batches use
  # 20 s for every ref.
  defp qr_ref_timeout_ms(6, :first), do: 60_000
  defp qr_ref_timeout_ms(_, _), do: 20_000

  # --- pair-success → device-sig + ack -------------------------------------

  defp on_pair_success(state, iq) do
    case Pair.handle_pair_success(iq, state.device) do
      {:ok, %Pair.Result{} = result} ->
        :telemetry.execute(
          [:whatsmeow, :session, :pair_success],
          %{system_time: System.system_time()},
          %{device_id: state.device_id, jid: result.jid}
        )

        # Persist if the store is reachable; tolerate absent Repo (tests).
        _ = maybe_persist_device(result.device)

        # Update in-memory device so the next reconnect uses login_payload.
        state = %{state | device: result.device}

        Whatsmeow.Notifications.broadcast(state.device_id, %Events.PairSuccess{
          device_id: state.device_id,
          jid: parse_jid_or_nil(result.jid),
          business_name: result.business_name,
          platform: result.platform
        })

        {:ok, state2} = do_send_node(state, result.ack_iq) |> ok_or_keep(state)
        state2

      {:error, reason} ->
        req_id = Binary.Node.attr(iq, "id", "")
        err_iq = Pair.build_pair_error_iq(req_id, pair_error_code(reason), pair_error_text(reason))
        _ = do_send_node(state, err_iq)

        Logger.error("[whatsmeow] pair-success rejected — sent <iq type=error> to server",
          device_id: state.device_id,
          reason: inspect(reason),
          code: pair_error_code(reason)
        )

        Whatsmeow.Notifications.broadcast(state.device_id, %Events.PairError{
          device_id: state.device_id,
          reason: reason
        })

        state
    end
  end

  # --- phone-number pairing → companion_finish -----------------------------

  # The primary phone just sent its wrapped ephemeral pub + identity pub.
  # Derive the ephemeral + identity shared secrets, set our adv-secret to the
  # derived value (so the upcoming `<pair-success>` HMAC verifies against it),
  # and reply with `companion_finish`. The derived adv-secret rides along on
  # `state.device` and gets persisted by `on_pair_success`.
  # Mirrors Go's `handleCodePairNotification` (`pair-code.go:150`).
  defp on_code_pair_notification(state, node) do
    %PairCode.HelloResult{keypair: {_pub, eph_priv}, linking_code: code, jid: jid} =
      state.pair_code

    device = state.device

    with {:ok, parsed} <- PairCode.parse_pair_notification(node),
         {:ok, eph_shared} <-
           PairCode.unwrap_primary_ephemeral_pub(parsed.wrapped_primary_pub, code, eph_priv) do
      identity_shared = Curve25519.agree(device.identity_key, parsed.primary_identity_pub)
      adv_random = :crypto.strong_rand_bytes(32)
      adv_secret = PairCode.derive_adv_secret(eph_shared, identity_shared, adv_random)
      our_identity_pub = Curve25519.public_for(device.identity_key)

      wrapped_bundle =
        PairCode.wrap_key_bundle(
          eph_shared,
          our_identity_pub,
          parsed.primary_identity_pub,
          adv_random
        )

      finish_iq =
        PairCode.build_finish_iq(jid, wrapped_bundle, our_identity_pub, parsed.pairing_ref)

      new_state = %{state | device: %{device | adv_key: adv_secret}, pair_code: nil}
      {:ok, state2} = do_send_node(new_state, finish_iq) |> ok_or_keep(new_state)
      state2
    else
      error ->
        Logger.error("[whatsmeow] phone-pair finish failed reason=#{inspect(error)}",
          device_id: state.device_id
        )

        %{state | pair_code: nil}
    end
  end

  # --- success → LoggedIn + keepalive --------------------------------------

  defp on_success(state, node) do
    case Login.parse_first_node(node) do
      {:ok, %Login.Result{lid: lid, server_time_offset: dt}} ->
        :telemetry.execute(
          [:whatsmeow, :session, :logged_in],
          %{system_time: System.system_time()},
          %{device_id: state.device_id, lid: lid}
        )

        Whatsmeow.Notifications.broadcast(state.device_id, %Events.LoggedIn{
          device_id: state.device_id,
          lid: lid,
          server_time_offset: dt
        })

        # Schedule post-login bootstrap (active IQ + PreKey top-up).
        # Done off-stack so the GenServer's <success> handling stays
        # cheap; bootstrap is allowed to take a few seconds.
        Process.send_after(self(), :post_login_bootstrap, 0)

        state
        |> Map.put(:status, :authenticated)
        |> Map.put(:keepalive_failures, 0)
        # Authenticated, not merely connected — the only evidence that whatever
        # the server was refusing has stopped. `reconnect_attempts` joins it
        # here for the same reason: a handshake that never becomes a login is
        # not a connection that is working.
        |> Map.put(:failure_retries, 0)
        |> Map.put(:reconnect_attempts, 0)
        |> schedule_keepalive()

      {:error, reason} ->
        # parse_first_node was given a <success> node — shouldn't error,
        # but if it does, treat as a stream-level failure.
        Logger.warning("[whatsmeow] parse_first_node rejected <success>",
          device_id: state.device_id,
          reason: inspect(reason)
        )

        handle_disconnect(state, {:bad_success, reason})
    end
  end

  # Not every `<failure>` means the device was unlinked.
  #
  # This used to treat all of them as terminal: clear `auto_reconnect?`, stop.
  # The process is `:permanent`, so it restarted immediately and sat at `:idle`
  # dialing nothing — a paired number silently off the air with no log line and
  # no event, until a human re-scanned a QR it never needed. A rate limit and a
  # stale client version are transient; only a refused identity is not.
  #
  # The classifier already existed, written and doctested, and nothing called
  # it: `Whatsmeow.ConnectionEvents.decode_failure/1`.
  defp on_failure(state, node) do
    {reason, message, extras} = ConnectionEvents.decode_failure(node)

    Logger.warning(
      "[whatsmeow] <failure> reason=#{inspect(reason)} message=#{inspect(message)} " <>
        "extras=#{inspect(extras)} attrs=#{inspect(node.attrs)}",
      device_id: state.device_id
    )

    case failure_policy(reason) do
      :terminal ->
        broadcast_logged_out(state, reason)
        %{state | auto_reconnect?: false, status: :stopping}

      :refresh_version ->
        # 405 is "your client build is too old", and the cure is already in this
        # file — it was simply wired to `<stream:error code=500>` instead, which
        # is `:internal_server_error`. So the one failure with a known automatic
        # fix was the one that never got it.
        trigger_wa_version_refresh_async(state.device_id)
        retry_after_failure(state, reason)

      :retry ->
        retry_after_failure(state, reason)
    end
  end

  # 401/403/406 — the identity itself is refused. Retrying is re-authenticating a
  # deleted device in a loop, which is how a number gets banned rather than
  # restored. 4264 is a ban already in progress; hammering it is strictly worse.
  defp failure_policy(:logged_out), do: :terminal
  defp failure_policy(:temp_banned), do: :terminal
  defp failure_policy(:client_outdated), do: :refresh_version
  defp failure_policy(_transient), do: :retry

  defp retry_after_failure(state, reason) do
    attempts = state.failure_retries + 1

    if attempts > @failure_retry_cap do
      # Give up, but give up *loudly*. Dying quietly is the bug this whole
      # change is about: the screen said "paired" and the only button under it
      # deleted the identity.
      Logger.error(
        "[whatsmeow] giving up after #{attempts - 1} reconnects against " <>
          "<failure reason=#{inspect(reason)}>",
        device_id: state.device_id
      )

      broadcast_logged_out(state, reason)
      %{state | auto_reconnect?: false, status: :stopping}
    else
      # Through the ordinary disconnect path, so the existing exponential
      # backoff (1s → 5min cap, with jitter) applies unchanged. At the cap this
      # is twelve handshakes an hour — less traffic than the keepalive.
      %{state | failure_retries: attempts}
      |> handle_disconnect({:failure, reason})
    end
  end

  defp broadcast_logged_out(state, reason) do
    Whatsmeow.Notifications.broadcast(state.device_id, %Events.LoggedOut{
      device_id: state.device_id,
      on_connect: state.status in [:connecting, :handshaking, :connected],
      reason: reason
    })
  end

  defp on_stream_error(state, node) do
    code = Binary.Node.attr(node, "code")
    child_tags = stream_error_child_tags(node)

    # Put the diagnostic detail in the message body, not just metadata —
    # the default Logger formatter strips `:metadata` for everything
    # except `:request_id`, so the old log line was empty of clues.
    # Codes worth knowing about:
    #   401  unauthorized   — bad payload, identity rejected
    #   403  forbidden      — account flagged / banned
    #   500  client-outdated — WAVersion drifted, refresh
    #   503  rate-limited   — back off harder
    #   515  stream replace — another session for this device just opened
    Logger.warning(
      "[whatsmeow] <stream:error> code=#{inspect(code)} attrs=#{inspect(node.attrs)} children=#{inspect(child_tags)}",
      device_id: state.device_id
    )

    :telemetry.execute(
      [:whatsmeow, :session, :stream_error],
      %{system_time: System.system_time()},
      %{device_id: state.device_id, code: code, child_tags: child_tags}
    )

    # Auto-recovery: code 500 = client-outdated, which means our pinned
    # `client_revision` has drifted past the server's tolerance window.
    # Kick a synchronous WAVersion refresh in a Task so the next
    # reconnect's ClientPayload picks up the live revision. Without this
    # the session loops forever inside the reconnect backoff while
    # WAVersion.Refresher waits for its next hourly tick.
    if code == "500", do: trigger_wa_version_refresh_async(state.device_id)

    act_on_stream_error(state, ConnectionEvents.decode_stream_error(node))
  end

  # The classifier was written, documented and doctested, and nothing outside
  # its own test file ever called it. So `<stream:error>` produced a log line, a
  # telemetry event, and no action whatsoever — for every code.
  #
  # The two that matter most are the two a deploy produces:
  #
  #   * `515` is the server *asking* us to re-handshake. It is the normal first
  #     reconnect after a pair, and ignoring it meant recovery only arrived
  #     later and indirectly, via a TCP close or the keepalive.
  #   * `conflict type="replaced"` is another socket having taken this device —
  #     which is exactly what an overlapping deploy produces on CranL, where the
  #     old container is still serving while the new one boots. Ignoring it left
  #     two clients on one Signal ratchet fighting, and that flapping is what
  #     ends in the 401 this file is otherwise careful to avoid.
  #
  # `device_removed` and `replaced` are terminal in the same sense `on_failure/2`
  # means it: stop, and let the restart policy keep us stopped.
  defp act_on_stream_error(state, reason) do
    if ConnectionEvents.should_reconnect?(reason) do
      handle_disconnect(state, {:stream_error, reason})
    else
      broadcast_logged_out(state, reason)

      %{state | auto_reconnect?: false}
      |> handle_disconnect({:stream_error, reason})
      |> Map.put(:status, :stopping)
    end
  end

  defp trigger_wa_version_refresh_async(device_id) do
    Task.Supervisor.start_child(Whatsmeow.Media.TaskSup, fn ->
      Logger.warning(
        "[whatsmeow] forcing WAVersion.refresh/1 (client-outdated auto-recovery)",
        device_id: device_id
      )

      case Whatsmeow.WAVersion.refresh(timeout: 30_000) do
        {:ok, version} ->
          Logger.warning(
            "[whatsmeow] WAVersion refreshed to #{inspect(version)} after stream:error 500",
            device_id: device_id
          )

        {:error, reason} ->
          Logger.warning(
            "[whatsmeow] WAVersion refresh FAILED (#{inspect(reason)}); next reconnect will retry the stale pin",
            device_id: device_id
          )
      end
    end)
  end

  defp stream_error_child_tags(%Binary.Node{content: children}) when is_list(children) do
    Enum.map(children, fn
      %Binary.Node{tag: t} -> t
      _ -> :non_node
    end)
  end

  defp stream_error_child_tags(_), do: []

  defp on_iq_response(state, iq) do
    req_id = Binary.Node.attr(iq, "id", "")
    iq_type = Binary.Node.attr(iq, "type")

    case Map.pop(state.pending, req_id) do
      {:keepalive, pending} ->
        # Server acked our ping. Reset the failure counter.
        %{state | pending: pending, keepalive_failures: 0}

      {:active_iq, pending} ->
        outcome = if iq_type == "error", do: :refused, else: :answered

        if outcome == :refused do
          Logger.error(
            "[whatsmeow] the server refused our post-login <active/> — this device " <>
              "may stay authenticated and receive nothing",
            device_id: state.device_id
          )
        else
          Logger.info("[whatsmeow] post-login <active/> accepted", device_id: state.device_id)
        end

        %{state | pending: pending, active_iq: outcome}

      {{caller_pid, ref}, pending} when is_pid(caller_pid) ->
        Logger.debug(
          "[whatsmeow] iq response routed id=#{req_id} type=#{iq_type} pending=#{map_size(pending)}",
          device_id: state.device_id
        )

        send(caller_pid, {:whatsmeow_iq, ref, iq})
        %{state | pending: pending}

      {nil, _} ->
        Logger.debug(
          "[whatsmeow] iq response with no matching pending id=#{req_id} type=#{iq_type}",
          device_id: state.device_id
        )

        state
    end
  end

  # Reply to a server-initiated `<iq type="get">` (typically a ping).
  # Mirrors `cli.smoke` and upstream Go's request.go behavior: bare
  # `<iq type="result" id=<same> to=<from>/>`. Skips the reply when the
  # id is missing (empty-id replies trigger `<stream:error>`).
  defp on_server_iq_get(state, iq) do
    case Binary.Node.attr(iq, "id") do
      id when is_binary(id) and id != "" ->
        # `from` from a decoded iq is already a `%JID{}` (the decoder
        # parses jid-shaped attrs). Use that directly so the reply's
        # `to` attr serialises with the `@jid_pair` opcode. Fall back
        # to a typed JID literal — never a plain string — to keep the
        # encoding consistent with what Go produces.
        from =
          case Binary.Node.attr(iq, "from") do
            %Whatsmeow.Types.JID{} = jid ->
              jid

            _ ->
              %Whatsmeow.Types.JID{user: "", server: Whatsmeow.Types.JID.default_user_server()}
          end

        reply =
          Binary.Node.new(
            "iq",
            %{"to" => from, "type" => "result", "id" => id},
            nil
          )

        case do_send_node(state, reply) do
          {:ok, state2} ->
            state2

          {:error, reason} ->
            Logger.warning("[whatsmeow] failed to reply to server <iq type=get>",
              device_id: state.device_id,
              reason: inspect(reason)
            )

            state
        end

      _ ->
        Logger.debug("[whatsmeow] <iq type=get> with no id — skipping reply",
          device_id: state.device_id,
          attrs: inspect(iq.attrs)
        )

        state
    end
  end

  # Answering a retry receipt, off this process.
  #
  # `Send.answer_retry/5` fetches a prekey bundle, which is an IQ round trip,
  # which is a `GenServer.call` back into **this** process. Called inline it
  # deadlocks the session on the first retry receipt it ever sees — every
  # clinic's socket wedged by the one code path added to un-wedge them. So it
  # runs on the same task supervisor the post-login prekey upload uses, for
  # the same reason.
  #
  # Bounded by `@retry_answer_cap`: the peer decides how many times to ask,
  # and a device that cannot open anything would otherwise have us fetching a
  # fresh bundle and re-encrypting for ever. Go caps this too
  # (`whatsmeow-main/retry.go`).
  #
  # Never at the cost of the ack — a raise here would leave the stanza
  # unacknowledged and the server would replay it for ever, which is the
  # failure this whole area is about.
  defp maybe_answer_retry(state, %{type: :retry, message_ids: ids, from: %{} = from} = receipt)
       when is_list(ids) do
    server = self()

    # In a group the receipt names the group in `from` and the device that
    # could not decrypt in `participant`. Re-encrypting to the group JID would
    # build a session against an address that has no Signal identity, so the
    # device that asked would go on seeing "waiting for this message" through
    # all three retries. 1:1 receipts carry no `participant` and `from` is
    # already the right device.
    asker = Map.get(receipt, :participant) || from

    for msg_id <- ids,
        is_binary(msg_id),
        bump_retry_count({:answered, msg_id}) <= @retry_answer_cap do
      device = state.device
      device_id = state.device_id

      Task.Supervisor.start_child(Whatsmeow.Media.TaskSup, fn ->
        Whatsmeow.Send.answer_retry(server, device, device_id, asker, msg_id)
      end)
    end

    state
  rescue
    error ->
      Logger.warning("[whatsmeow] could not answer a retry receipt: #{inspect(error)}",
        device_id: state.device_id
      )

      state
  end

  defp maybe_answer_retry(state, _receipt), do: state

  # Walk an `<ib>` info-broadcast and dispatch typed events for the children we
  # recognise. Upstream Go (`connectionevents.go::handleIB`) silently ignores
  # unknown children — we do the same. Protocol-level: no ack required.
  #
  # **This logged at `:debug` and broadcast nothing**, and the comment here said
  # a future patch could send `%Events.OfflineSyncPreview{}` "when the host
  # needs them". A host needed them: a clinic's number went deaf for hours with
  # every other signal green, and the single number that would have settled it —
  # how many messages WhatsApp thought it was delivering — was being written to
  # a log the host could not read.
  #
  # `offline_preview` is the server's own statement of what it queued. A host
  # that is told seven and then writes no rows knows the loss is on its side of
  # the socket; one that is told zero knows the server had nothing to give it.
  # Those have opposite fixes, and nothing else distinguishes them.
  defp on_ib(state, %Binary.Node{} = node) do
    notices = Whatsmeow.ConnectionEvents.decode_ib(node)

    Logger.info("[whatsmeow] <ib> received",
      device_id: state.device_id,
      from: Binary.Node.attr(node, "from"),
      notices: inspect(notices)
    )

    Enum.each(notices, &announce_ib(state, &1))

    state
  end

  defp announce_ib(state, {:offline_preview, counts}) do
    Whatsmeow.Notifications.broadcast(
      state.device_id,
      struct(Events.OfflineSyncPreview, Map.put(counts, :device_id, state.device_id))
    )
  end

  defp announce_ib(state, {:offline_complete, count}) do
    Whatsmeow.Notifications.broadcast(state.device_id, %Events.OfflineSyncCompleted{
      device_id: state.device_id,
      count: count
    })
  end

  # `dirty` and `downgrade_webclient` are decoded and deliberately not
  # broadcast: Go ignores the first and the second is about a pairing mode this
  # library does not support.
  defp announce_ib(_state, _other), do: :ok

  # Log helper for unknown server iqs. Promoted from debug → info
  # because "unhandled <iq>" is rare and worth seeing once during
  # bring-up; if it becomes noisy in production we can demote and
  # add a real handler for whatever child tag is appearing.
  defp log_unhandled_iq(state, %Binary.Node{} = iq) do
    children =
      case iq.content do
        list when is_list(list) ->
          Enum.map(list, fn
            %Binary.Node{tag: t} -> t
            _ -> :non_node
          end)

        _ ->
          []
      end

    Logger.info("[whatsmeow] unhandled <iq> — silently ignored (Go does the same)",
      device_id: state.device_id,
      attrs: inspect(iq.attrs),
      children: inspect(children)
    )

    :ok
  end

  # --- keepalive helpers ---------------------------------------------------

  defp schedule_keepalive(%__MODULE__{keepalive_timer: prior} = state) do
    if is_reference(prior), do: Process.cancel_timer(prior)
    jitter = :rand.uniform(2 * @keepalive_jitter_ms + 1) - @keepalive_jitter_ms - 1
    ms = max(1_000, @keepalive_base_ms + jitter)
    ref = Process.send_after(self(), :keepalive_tick, ms)
    %{state | keepalive_timer: ref}
  end

  defp send_keepalive(state) do
    id = IQ.generate_id()
    iq = IQ.build_keepalive(id)

    case do_send_node(state, iq) do
      {:ok, state2} -> {:ok, %{state2 | pending: Map.put(state2.pending, id, :keepalive)}}
      err -> err
    end
  end

  # A ping the server never answered.
  #
  # The moduledoc has promised this check since before it existed: three
  # consecutive un-acked pings force a reconnect. What was implemented counted
  # only failures of the *send*, and a send into a dead-but-open socket
  # succeeds — the kernel takes the bytes whether or not WhatsApp is still
  # listening. So a session could sit at `:authenticated` indefinitely,
  # reporting healthy to every screen we own while answering nobody, and the
  # watchdog's repair was dropped as a no-op because the status looked fine.
  #
  # `on_iq_response/2` pops the id and zeroes the counter when a ping comes
  # back, so an id still in `pending` one tick later was never answered. Forget
  # it either way: one miss, one count.
  defp note_unanswered_keepalive(state) do
    case Enum.find(state.pending, fn {_id, tag} -> tag == :keepalive end) do
      nil ->
        state

      {id, _tag} ->
        Logger.warning("[whatsmeow] keepalive went unanswered", device_id: state.device_id)

        %{state | pending: Map.delete(state.pending, id)}
        |> bump_keepalive_failure()
    end
  end

  defp bump_keepalive_failure(state) do
    failures = state.keepalive_failures + 1

    if failures >= @keepalive_max_consecutive_failures do
      Logger.warning("[whatsmeow] keepalive failed #{failures} times — forcing reconnect",
        device_id: state.device_id
      )

      handle_disconnect(state, :keepalive_failed)
    else
      %{state | keepalive_failures: failures}
    end
  end

  # --- disconnect + reconnect ---------------------------------------------

  defp handle_disconnect(state, reason) do
    if is_reference(state.keepalive_timer), do: Process.cancel_timer(state.keepalive_timer)

    # `state.transport` is a module atom — guard the close call with
    # `function_exported?/3`. The old form `is_function(state.transport.close, 1)`
    # parses as `(state.transport).close()` on Elixir 1.19 (a remote
    # call with no parens, now disallowed) and crashes the GenServer
    # with `UndefinedFunctionError` every time a disconnect fires —
    # which means QR pairing loops forever (fresh session on every
    # crash → new QR → stale scan).
    if function_exported?(state.transport, :close, 1) and not is_nil(state.transport_conn) do
      _ = state.transport.close(state.transport_conn)
    end

    Whatsmeow.Notifications.broadcast(state.device_id, %Events.Disconnected{
      device_id: state.device_id,
      reason: reason
    })

    state =
      state
      |> cancel_qr_emit_timer()
      |> Map.merge(%{
        transport_conn: nil,
        noise_socket: nil,
        noise_handshake: nil,
        status: :disconnected,
        keepalive_timer: nil,
        qr_emit_queue: nil
      })

    if state.auto_reconnect?, do: schedule_reconnect(state), else: state
  end

  defp schedule_reconnect(state) do
    attempt = state.reconnect_attempts + 1
    delay = backoff_ms(attempt)

    Logger.info("[whatsmeow] scheduling reconnect",
      device_id: state.device_id,
      attempt: attempt,
      delay_ms: delay
    )

    if is_reference(state.reconnect_timer), do: Process.cancel_timer(state.reconnect_timer)
    ref = Process.send_after(self(), {:reconnect, attempt}, delay)

    %{state | reconnect_attempts: attempt, reconnect_timer: ref}
  end

  defp backoff_ms(attempt) when attempt > 0 do
    base = min(@reconnect_max_ms, @reconnect_initial_ms * trunc(:math.pow(2, attempt - 1)))
    jitter = :rand.uniform(500)
    base + jitter
  end

  # Max random delay before the *first* connect attempt for a freshly-started
  # session. Spreads a fleet cold-start over `[1, max]` ms so 50k boots don't
  # thunder Meta's edge in one window. 0 (default) preserves immediate connect
  # — required by the existing test suite. Set to e.g. 30_000 in production.
  defp cold_start_jitter_ms do
    Application.get_env(:whatsmeow_ex, :cold_start_jitter_ms, 0)
  end

  # --- wire helpers --------------------------------------------------------

  defp do_send_node(%__MODULE__{noise_socket: nil}, _node), do: {:error, :not_connected}

  defp do_send_node(state, %Binary.Node{} = node) do
    plain = Binary.encode(node)
    {ct, ns2} = NoiseSocket.encrypt(state.noise_socket, plain)
    framed = Frame.wrap(ct)

    case state.transport.send_binary(state.transport_conn, framed) do
      {:ok, conn2} -> {:ok, %{state | noise_socket: ns2, transport_conn: conn2}}
      {:error, _} = err -> err
    end
  end

  defp ok_or_keep({:ok, state2}, _orig), do: {:ok, state2}
  defp ok_or_keep({:error, _}, orig), do: {:ok, orig}

  # **The one stanza that says "start sending me messages", and it was shouted
  # into the dark.**
  #
  # Go's `SetPassive` is a blocking `sendIQ` that logs `"Failed to send
  # post-connect passive IQ"`. This port used `send_node_or_log/3`, which only
  # reports that the bytes left the socket — so a server that rejected the IQ,
  # or never answered it, produced no line at all, and the session sat
  # authenticated and unrouted looking perfectly healthy from every angle.
  #
  # Tracked now, so `info/1` can say `:answered`, `:pending` or `:refused`, and
  # so a host with a deaf number has something to read other than silence. Not
  # blocking: the bootstrap runs on the session's own mailbox and a server that
  # never answers must not stall the process that reconnects it.
  defp send_active_iq(state) do
    id = IQ.generate_id()

    case do_send_node(state, IQ.build_set_passive(false, id)) do
      {:ok, state2} ->
        Process.send_after(self(), {:active_iq_deadline, id}, @active_iq_deadline_ms)
        %{state2 | active_iq: :pending, pending: Map.put(state2.pending, id, :active_iq)}

      {:error, reason} ->
        Logger.warning("[whatsmeow] post-login send failed",
          device_id: state.device_id,
          node: "active IQ",
          reason: inspect(reason)
        )

        %{state | active_iq: :refused}
    end
  end

  # Send a node and log any transport error — used by bootstrap helpers
  # where we don't want a single failure to crash the GenServer.
  defp send_node_or_log(state, %Binary.Node{} = node, label) do
    case do_send_node(state, node) do
      {:ok, state2} ->
        state2

      {:error, reason} ->
        Logger.warning("[whatsmeow] post-login send failed",
          device_id: state.device_id,
          node: label,
          reason: inspect(reason)
        )

        state
    end
  end

  defp push_name(%Device{push_name: name}) when is_binary(name) and name != "", do: name
  defp push_name(_), do: "whatsmeow_ex"

  # First-upload detection: if we have no rows in `whatsmeow_pre_keys`
  # for our_jid, treat this as a fresh device and upload the big
  # initial batch (812 keys). Otherwise it's a top-up.
  defp needs_initial_prekey_upload?(%Device{jid: jid}) when is_binary(jid) do
    # Through the Signal store seam rather than a direct query: with a non-Repo
    # adapter this used to answer `false` unconditionally, so a fresh device
    # skipped its initial 812-key upload and every peer's first message failed.
    Whatsmeow.Signal.Store.Adapter.available?() and
      Whatsmeow.Signal.Store.Adapter.max_prekey_id(jid) == 0
  rescue
    _ -> false
  end

  defp needs_initial_prekey_upload?(_), do: false

  defp do_post_login_prekey_upload(server, initial?) do
    case Whatsmeow.PreKeys.upload(server, initial?: initial?) do
      {:ok, %{uploaded: n}} ->
        Logger.info("[whatsmeow] post-login prekey upload OK", uploaded: n, initial?: initial?)

      {:error, reason} when reason in [:no_repo, :no_store] ->
        Logger.debug("[whatsmeow] skipping prekey upload — Repo not started")

      {:error, reason} ->
        Logger.warning("[whatsmeow] post-login prekey upload failed", reason: inspect(reason))
    end
  rescue
    e -> Logger.warning("[whatsmeow] prekey upload crashed", reason: Exception.message(e))
  end

  defp unpack_and_decode(plain) do
    with {:ok, payload} <- unpack(plain) do
      case Binary.decode(payload, strip_flag?: false) do
        {:ok, node} -> {:ok, node}
        {:error, reason} -> {:error, {:binary_decode, reason}}
      end
    end
  end

  defp unpack(<<flag, rest::binary>>) do
    if Bitwise.band(flag, 2) > 0 do
      try do
        {:ok, :zlib.uncompress(rest)}
      rescue
        e -> {:error, {:zlib, Exception.message(e)}}
      end
    else
      {:ok, rest}
    end
  end

  defp unpack(<<>>), do: {:error, :empty_frame}

  # --- store + helpers -----------------------------------------------------

  defp maybe_persist_device(%Device{} = device) do
    if Code.ensure_loaded?(Whatsmeow.Repo) and Process.whereis(Whatsmeow.Repo) do
      do_persist_device(device)
    else
      :skipped
    end
  rescue
    e ->
      Logger.warning("[whatsmeow] device persist crashed", reason: Exception.message(e))
      :error
  end

  # When pairing rewrites `device.jid` (e.g. "user-42" → "12345@s.whatsapp.net"),
  # we want to UPDATE the existing row keyed by `client_id`, not insert a
  # second one. The FK cascade (`on_update: :update_all`) then migrates all
  # signal/prekey/session rows to the new jid. We fall back to a plain
  # insert when no row matches the client_id yet (or when the device has
  # no client_id at all — older test fixtures).
  defp do_persist_device(%Device{} = device) do
    # Through `Whatsmeow.Store.impl/0` so a non-Postgres store sees pairing
    # results too. Writing straight to the Repo here meant the credentials
    # written at pair time went somewhere the configured store never reads,
    # and the next boot asked for a fresh QR.
    case Whatsmeow.Store.put_device(device) do
      :ok ->
        :ok

      {:error, reason} ->
        Logger.warning("[whatsmeow] device persist failed", errors: inspect(reason))
        :error
    end
  end

  defp parse_jid_or_nil(nil), do: nil

  defp parse_jid_or_nil(s) when is_binary(s) do
    case Whatsmeow.Types.JID.parse(s) do
      {:ok, jid} -> jid
      _ -> nil
    end
  end

  defp pair_error_code(:hmac_mismatch), do: 401
  defp pair_error_code(:account_signature_invalid), do: 401
  defp pair_error_code(:missing_account_signature), do: 401
  defp pair_error_code(:missing_account_signature_key), do: 401
  defp pair_error_code(_), do: 500

  defp pair_error_text(:hmac_mismatch), do: "hmac-mismatch"
  defp pair_error_text(:account_signature_invalid), do: "signature-mismatch"
  defp pair_error_text(:missing_account_signature), do: "signature-mismatch"
  defp pair_error_text(:missing_account_signature_key), do: "signature-mismatch"
  defp pair_error_text(_), do: "internal-error"

  defp via(device_id), do: {:via, Registry, {Whatsmeow.Sessions.Registry, device_id}}

  defp via_or_pid(pid) when is_pid(pid), do: pid
  defp via_or_pid(device_id) when is_binary(device_id), do: via(device_id)

  # --- test seams ----------------------------------------------------------

  @doc false
  # Exposes the private dispatch tree for unit tests so we can lock the
  # routing logic without standing up a full mock transport. Production
  # callers go through `handle_info/2`.
  def __dispatch_node__(state, %Binary.Node{} = node), do: dispatch_node(state, node)

  @doc false
  def __backoff_ms__(attempt), do: backoff_ms(attempt)

  @doc false
  def __pair_error__(reason), do: {pair_error_code(reason), pair_error_text(reason)}
end
