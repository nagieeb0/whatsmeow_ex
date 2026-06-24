defmodule Whatsmeow.WAVersion.Refresher do
  @moduledoc """
  Periodic `Whatsmeow.WAVersion.refresh/1` driver.

  Boot-time + hourly scrape of `web.whatsapp.com` to keep the cached
  `client_revision` fresh. WhatsApp ships a new revision roughly weekly;
  if our `ClientPayload.userAgent.appVersion` drifts more than a couple
  of revisions, the server replies `<stream:error code="500">` and we
  never reach `<success>`.

  Disabled by default in dev/test (the scrape would hit the network on
  every `mix test`). Enable in `config/runtime.exs`:

      config :whatsmeow_ex, Whatsmeow.WAVersion.Refresher,
        enabled?: true,
        interval_ms: :timer.hours(1),
        proxy: System.get_env("WHATSMEOW_PROXY")

  When AshOban is wired up, drop this child from the supervisor and
  schedule `Whatsmeow.WAVersion.refresh/1` as a cron worker instead.
  """

  use GenServer

  require Logger

  @default_interval :timer.hours(1)
  # Jitter the periodic refresh so a fleet of nodes doesn't synchronise scrapes.
  @max_jitter_ms :timer.minutes(5)
  # WAVersion.refresh/1 defaults to 15s — too tight on slow links / TLS
  # handshakes through a proxy. Bump to 30s and try a couple times before
  # giving up so a transient blip doesn't leave us pinned to the stale
  # hardcoded fallback for an hour.
  @refresh_timeout_ms :timer.seconds(30)
  @retry_attempts 3
  @retry_backoff_ms 1_500

  @spec start_link(keyword()) :: GenServer.on_start()
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, name: Keyword.get(opts, :name, __MODULE__))
  end

  @doc "Force an out-of-band refresh. Returns `{:ok, version}` or `{:error, reason}`."
  @spec refresh_now(GenServer.server()) :: {:ok, tuple()} | {:error, term()}
  def refresh_now(server \\ __MODULE__),
    do: GenServer.call(server, :refresh_now, :timer.seconds(30))

  @impl GenServer
  def init(opts) do
    config = config(opts)

    state = %{
      enabled?: config.enabled?,
      interval_ms: config.interval_ms,
      proxy: config.proxy,
      timer: nil
    }

    if state.enabled? do
      send(self(), :refresh)
    end

    {:ok, state}
  end

  @impl GenServer
  def handle_call(:refresh_now, _from, state) do
    {:reply, do_refresh(state), state}
  end

  @impl GenServer
  def handle_info(:refresh, state) do
    _ = do_refresh(state)
    {:noreply, schedule_next(state)}
  end

  defp do_refresh(state) do
    base_opts = [timeout: @refresh_timeout_ms]
    opts = if state.proxy, do: [{:proxy, state.proxy} | base_opts], else: base_opts

    refresh_with_retries(opts, @retry_attempts)
  end

  # The scrape hits an external host (`web.whatsapp.com`) over TLS and
  # is sensitive to packet loss / proxy hiccups. A single 15s timeout
  # would silently leave us on the hardcoded fallback for the next
  # hour. Retry a few times with a short backoff before giving up.
  defp refresh_with_retries(opts, attempts_left) when attempts_left > 0 do
    case Whatsmeow.WAVersion.refresh(opts) do
      {:ok, version} = ok ->
        Logger.info("[wa_version] refreshed → #{format_version(version)}")
        ok

      {:error, reason} when attempts_left > 1 ->
        Logger.warning(
          "[wa_version] refresh attempt failed (#{inspect(reason)}); " <>
            "retrying in #{@retry_backoff_ms}ms (#{attempts_left - 1} left)"
        )

        Process.sleep(@retry_backoff_ms)
        refresh_with_retries(opts, attempts_left - 1)

      {:error, reason} = err ->
        Logger.warning("[wa_version] refresh giving up: #{inspect(reason)}")
        err
    end
  end

  defp schedule_next(state) do
    delay = state.interval_ms + :rand.uniform(@max_jitter_ms)
    timer = Process.send_after(self(), :refresh, delay)
    %{state | timer: timer}
  end

  defp config(opts) do
    env = Application.get_env(:whatsmeow_ex, __MODULE__, [])

    %{
      enabled?: Keyword.get(opts, :enabled?, Keyword.get(env, :enabled?, false)),
      interval_ms:
        Keyword.get(opts, :interval_ms, Keyword.get(env, :interval_ms, @default_interval)),
      proxy: Keyword.get(opts, :proxy, Keyword.get(env, :proxy))
    }
  end

  defp format_version({a, b, c}), do: "#{a}.#{b}.#{c}"
end
