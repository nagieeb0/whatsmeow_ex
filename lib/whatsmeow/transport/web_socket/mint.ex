defmodule Whatsmeow.Transport.WebSocket.Mint do
  @moduledoc """
  `Whatsmeow.Transport.WebSocket` implementation backed by `Mint.WebSocket`.

  Manages a single TLS WebSocket conn — Mint handles HTTP/1.1 → WS upgrade.
  Inbound frames are accumulated in the `buffer` field of the conn until
  the caller pulls them via `recv/1`.

  This module is intentionally minimal: connection management, pings, and
  reconnect logic belong to `Whatsmeow.Session`.
  """

  @behaviour Whatsmeow.Transport.WebSocket

  alias Whatsmeow.Transport.Constants

  defstruct [:conn, :websocket, :request_ref, buffer: []]

  @type conn :: %__MODULE__{
          conn: term(),
          websocket: term(),
          request_ref: reference(),
          buffer: [binary()]
        }

  @impl true
  def connect(opts) do
    url = Keyword.get(opts, :url, Constants.url())
    origin = Keyword.get(opts, :origin, Constants.origin())
    user_headers = Keyword.get(opts, :headers, [])
    uri = URI.parse(url)
    scheme = if uri.scheme == "wss", do: :https, else: :http
    port = uri.port || if(scheme == :https, do: 443, else: 80)

    connect_opts =
      [protocols: [:http1]]
      |> maybe_put_proxy(Keyword.get(opts, :proxy))

    with {:ok, mint_conn} <- Mint.HTTP.connect(scheme, uri.host, port, connect_opts),
         {:ok, mint_conn, ref} <-
           Mint.WebSocket.upgrade(
             ws_scheme(scheme),
             mint_conn,
             uri.path || "/",
             [{"origin", origin} | user_headers]
           ),
         {:ok, mint_conn, ws} <- complete_upgrade(mint_conn, ref) do
      {:ok, %__MODULE__{conn: mint_conn, websocket: ws, request_ref: ref}}
    end
  end

  @doc """
  Parse a flexible proxy spec into the `{scheme, host, port, opts}` tuple
  shape Mint's `connect/4` expects. Accepts:

  * `nil` — no proxy
  * `{host, port}` — shorthand for `{:http, host, port, []}`
  * `{scheme, host, port}` — `scheme` is `:http` or `:https`
  * `{scheme, host, port, opts}` — passed through verbatim
  * `"http://user:pass@host:port"` (or `https://…`) — parsed; basic-auth
    credentials encoded into a `Proxy-Authorization` header

  Returns `{:ok, mint_opts_keyword}` ready to merge into the connect opts,
  or `{:error, atom}` if the spec is malformed.

  This function is exposed so callers (e.g. `Whatsmeow.Session`) can
  validate proxy configuration eagerly at session start, rather than
  discovering it via a connect failure.
  """
  @spec parse_proxy(any()) :: {:ok, keyword()} | {:error, atom()}
  def parse_proxy(nil), do: {:ok, []}

  def parse_proxy({host, port}) when is_binary(host) and is_integer(port) do
    {:ok, [proxy: {:http, host, port, []}]}
  end

  def parse_proxy({scheme, host, port}) when scheme in [:http, :https] and is_binary(host) do
    {:ok, [proxy: {scheme, host, port, []}]}
  end

  def parse_proxy({scheme, host, port, proxy_opts})
      when scheme in [:http, :https] and is_binary(host) and is_integer(port) and
             is_list(proxy_opts) do
    {:ok, [proxy: {scheme, host, port, proxy_opts}]}
  end

  def parse_proxy(url) when is_binary(url) do
    case URI.parse(url) do
      %URI{scheme: s, host: host, port: port, userinfo: userinfo}
      when is_binary(host) and is_integer(port) and s in ["http", "https"] ->
        scheme = String.to_existing_atom(s)
        headers = userinfo_to_proxy_headers(userinfo)
        opts = if headers == [], do: [], else: [proxy_headers: headers]
        {:ok, [proxy: {scheme, host, port, []}] ++ opts}

      _ ->
        {:error, :bad_proxy_url}
    end
  end

  def parse_proxy(_), do: {:error, :bad_proxy_spec}

  defp maybe_put_proxy(opts, nil), do: opts

  defp maybe_put_proxy(opts, spec) do
    case parse_proxy(spec) do
      {:ok, proxy_opts} -> Keyword.merge(opts, proxy_opts)
      # If the spec is bad we'd rather hand it through and let Mint complain
      # with a clear error than silently drop it.
      {:error, _} -> opts
    end
  end

  defp userinfo_to_proxy_headers(nil), do: []
  defp userinfo_to_proxy_headers(""), do: []

  defp userinfo_to_proxy_headers(userinfo) do
    [{"proxy-authorization", "Basic " <> Base.encode64(userinfo)}]
  end

  @impl true
  def send_binary(%__MODULE__{conn: mint_conn, websocket: ws, request_ref: ref} = c, data) do
    with {:ok, ws, msg} <- Mint.WebSocket.encode(ws, {:binary, data}),
         {:ok, mint_conn} <- Mint.WebSocket.stream_request_body(mint_conn, ref, msg) do
      {:ok, %__MODULE__{c | conn: mint_conn, websocket: ws}}
    end
  end

  @impl true
  def recv(c), do: recv(c, 30_000)

  @doc """
  Like `recv/1` but with an explicit `timeout` in milliseconds. Note: the
  socket controller is the process that called `connect/1`, so `recv/2`
  must be called from that same process — calling it from a spawned Task
  or other process will not see the inbound SSL/TCP messages.
  """
  @spec recv(conn(), timeout()) :: {:ok, conn(), binary()} | :closed | {:error, term()}
  def recv(%__MODULE__{buffer: [frame | rest]} = c, _timeout) do
    {:ok, %__MODULE__{c | buffer: rest}, frame}
  end

  def recv(%__MODULE__{conn: mint_conn} = c, timeout) do
    receive do
      message ->
        case Mint.WebSocket.stream(mint_conn, message) do
          {:ok, mint_conn, http_messages} ->
            handle_http_messages(%__MODULE__{c | conn: mint_conn}, http_messages, timeout)

          :unknown ->
            recv(c, timeout)

          {:error, _conn, _reason, _resp} = err ->
            err
        end
    after
      timeout -> {:error, :timeout}
    end
  end

  @impl true
  def close(%__MODULE__{conn: mint_conn}) do
    _ = Mint.HTTP.close(mint_conn)
    :ok
  end

  @impl true
  def process_message(%__MODULE__{conn: mint_conn} = c, message) do
    case Mint.WebSocket.stream(mint_conn, message) do
      {:ok, mint_conn, http_messages} ->
        collect_frames(%__MODULE__{c | conn: mint_conn}, http_messages)

      :unknown ->
        :unknown

      {:error, _conn, reason, _resp} ->
        {:error, reason}
    end
  end

  # Drains the buffer + appends any new frames from this batch of HTTP messages.
  # Mirrors `handle_http_messages/3` but never blocks — purely synchronous.
  defp collect_frames(
         %__MODULE__{conn: mint_conn, websocket: ws, request_ref: ref, buffer: buffered} = c,
         http_messages
       ) do
    {mint_conn, ws, frames, closed?} =
      Enum.reduce(
        http_messages,
        {mint_conn, ws, [], false},
        &handle_http_message(&1, &2, ref)
      )

    all_frames = buffered ++ frames

    case {all_frames, closed?} do
      {[], true} ->
        :closed

      _ ->
        {:ok, %__MODULE__{c | conn: mint_conn, websocket: ws, buffer: []}, all_frames}
    end
  end

  # Reducer for one Mint HTTP message. Decodes the data into WS frames,
  # *replies to control frames in-band* (Mint.WebSocket does NOT
  # auto-pong WS pings — Go gets this for free from nhooyr.io/websocket,
  # but on Mint we must encode + send the pong ourselves or WhatsApp's
  # server closes the conn ~30s after the first un-ponged ping). Returns
  # the updated mint_conn + ws + appended frames + close-seen flag.
  defp handle_http_message({:data, _ref, data}, {mint_conn, ws, acc, closed?}, request_ref) do
    {:ok, ws, decoded} = Mint.WebSocket.decode(ws, data)

    {mint_conn, ws, binaries, saw_close?} =
      Enum.reduce(decoded, {mint_conn, ws, [], false}, fn
        {:binary, bin}, {mc, ws, bins, c?} ->
          {mc, ws, [bin | bins], c?}

        {:ping, payload}, {mc, ws, bins, c?} ->
          # Spec-mandated: reply with a pong carrying the same payload.
          {mc, ws} = send_pong(mc, ws, request_ref, payload)
          {mc, ws, bins, c?}

        {:close, _code, _reason}, {mc, ws, bins, _c?} ->
          {mc, ws, bins, true}

        # `:pong` / `:text` / anything else — ignored on purpose.
        _, acc ->
          acc
      end)

    {mint_conn, ws, acc ++ Enum.reverse(binaries), closed? or saw_close?}
  end

  defp handle_http_message({:done, _ref}, {mint_conn, ws, acc, _closed?}, _request_ref),
    do: {mint_conn, ws, acc, true}

  defp handle_http_message(_other, acc, _request_ref), do: acc

  # Encode + flush a `{:pong, payload}` over the existing stream. Any
  # error is logged and swallowed — losing a pong shouldn't crash the
  # transport; the next inbound frame (or our own keepalive IQ post-login)
  # will re-establish liveness, and dropping the conn loudly would be
  # worse than letting a flaky pong skip a beat.
  defp send_pong(mint_conn, ws, ref, payload) do
    with {:ok, ws, frame} <- Mint.WebSocket.encode(ws, {:pong, payload}),
         {:ok, mint_conn} <- Mint.WebSocket.stream_request_body(mint_conn, ref, frame) do
      {mint_conn, ws}
    else
      err ->
        require Logger
        Logger.warning("[whatsmeow.mint_ws] failed to send WS pong", reason: inspect(err))
        {mint_conn, ws}
    end
  end

  # --- internals ------------------------------------------------------------

  defp ws_scheme(:https), do: :wss
  defp ws_scheme(:http), do: :ws

  defp complete_upgrade(conn, ref), do: complete_upgrade(conn, ref, 10_000)

  defp complete_upgrade(conn, ref, timeout_ms) do
    deadline = System.monotonic_time(:millisecond) + timeout_ms
    loop_complete_upgrade(conn, ref, deadline)
  end

  # The receive loop must filter `Mint.WebSocket.stream/2`'s `:unknown`
  # return (= "this message isn't for this conn") and retry rather than
  # short-circuiting. Stray ssl/tcp messages routinely sit in the
  # GenServer's mailbox during a reconnect — leftover from the prior
  # transport's pending recv, or from a sibling Mint conn. Without this
  # loop, every reconnect after a transport blip falls through `else err`
  # in `Whatsmeow.Session.do_connect` with `reason=:unknown` and the
  # session is stuck in a backoff cycle even though WhatsApp is reachable.
  defp loop_complete_upgrade(conn, ref, deadline) do
    remaining = max(deadline - System.monotonic_time(:millisecond), 0)

    receive do
      message ->
        case Mint.WebSocket.stream(conn, message) do
          {:ok, conn, responses} ->
            with {:ok, status, headers} <- collect_status(responses, ref),
                 {:ok, conn, ws} <- Mint.WebSocket.new(conn, ref, status, headers) do
              {:ok, conn, ws}
            end

          :unknown ->
            loop_complete_upgrade(conn, ref, deadline)

          err ->
            err
        end
    after
      remaining -> {:error, :upgrade_timeout}
    end
  end

  defp collect_status(responses, ref) do
    status =
      Enum.find_value(responses, fn
        {:status, ^ref, s} -> s
        _ -> nil
      end)

    headers =
      Enum.find_value(responses, fn
        {:headers, ^ref, h} -> h
        _ -> nil
      end)

    cond do
      is_nil(status) -> {:error, :no_status}
      is_nil(headers) -> {:error, :no_headers}
      true -> {:ok, status, headers}
    end
  end

  defp handle_http_messages(%__MODULE__{request_ref: ref} = c, messages, timeout) do
    {mint_conn, ws, frames, closed?} =
      Enum.reduce(
        messages,
        {c.conn, c.websocket, [], false},
        &handle_http_message(&1, &2, ref)
      )

    case {frames, closed?} do
      {[frame | rest], _} ->
        {:ok, %__MODULE__{c | conn: mint_conn, websocket: ws, buffer: rest}, frame}

      {[], true} ->
        :closed

      {[], false} ->
        recv(%__MODULE__{c | conn: mint_conn, websocket: ws}, timeout)
    end
  end
end
