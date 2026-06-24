defmodule Whatsmeow.Transport.WebSocket do
  @moduledoc """
  Behaviour describing the WebSocket transport surface.

  Implementations: `Whatsmeow.Transport.WebSocket.Mint` (default), plus a
  Mox-based mock for tests.

  Lifecycle:

  * `connect/1` opens the WS upgrade.
  * `send_binary/2` sends a binary frame.
  * `recv/1` returns the next inbound binary frame (or `:closed`).
  * `close/1` closes the conn.

  All callbacks are synchronous from the caller's view; concurrency is
  handled inside the `Whatsmeow.Session` GenServer that owns the conn.
  """

  @type conn :: term()

  @typedoc """
  Connection options.

  * `:url` — override the default `wss://web.whatsapp.com/ws/chat`.
  * `:origin` — override the default `Origin:` header.
  * `:headers` — extra HTTP headers for the upgrade.
  * `:proxy` — optional proxy spec. Accepts any of:
    * `{host, port}` (shorthand for an `:http` CONNECT proxy)
    * `{scheme, host, port}` where `scheme` is `:http` or `:https`
    * `{scheme, host, port, mint_opts}`
    * `"http://user:pass@host:port"` URL string
    See `Whatsmeow.Transport.WebSocket.Mint.parse_proxy/1`.
  * `:recv_timeout` — millisecond timeout for `recv/2`.
  """
  @type proxy_spec ::
          nil
          | {String.t(), :inet.port_number()}
          | {:http | :https, String.t(), :inet.port_number()}
          | {:http | :https, String.t(), :inet.port_number(), keyword()}
          | String.t()

  @type opts :: [
          url: String.t(),
          origin: String.t(),
          headers: [{String.t(), String.t()}],
          proxy: proxy_spec(),
          recv_timeout: timeout()
        ]

  @callback connect(opts) :: {:ok, conn} | {:error, term()}
  @callback send_binary(conn, binary()) :: {:ok, conn} | {:error, term()}
  @callback recv(conn) :: {:ok, conn, binary()} | :closed | {:error, term()}
  @callback close(conn) :: :ok

  @doc """
  Process a single raw inbound message (e.g. `{:ssl, port, data}` or
  `{:ssl_closed, port}`) that arrived in the controlling process's
  mailbox without consuming the mailbox itself. Returns any decoded
  WebSocket binary frames extracted from this message plus the prior
  per-conn buffer.

  This is the **event-driven** counterpart to `recv/2` — call it from a
  GenServer's `handle_info/2` when the WS conn is owned by the
  GenServer. `:unknown` means the message wasn't addressed to this
  conn (callers should leave it for some other handler).
  """
  @callback process_message(conn, term()) ::
              {:ok, conn, [binary()]} | :closed | :unknown | {:error, term()}
end
