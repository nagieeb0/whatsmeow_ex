defmodule Whatsmeow.ConnectionEvents do
  @moduledoc """
  Pure decoders for the post-login stream-event nodes WhatsApp sends:

  * `<stream:error code=…>` — fatal: bad CAT, replaced session, device removed,
    503 (server restart), client outdated, etc.
  * `<failure>` — auth-time refusal carrying a numeric `reason` code.
  * `<ib>` — "in-band" notices: offline preview, downgrade webclient,
    dirty-account-sync hints.

  These functions normalise the inbound shapes into atom-typed reasons the
  Session dispatch tree can pattern-match on (and route to PubSub /
  reconnect / store-delete actions).

  Pure — no I/O. Lives separately from `Whatsmeow.Session` so the rules
  are testable without spinning a session up.

  Mirrors `whatsmeow-main/connectionevents.go`.
  """

  alias Whatsmeow.Binary.Node

  @typedoc "Why the server tore the stream down."
  @type stream_error_reason ::
          :auto_reconnect_515
          | :device_removed
          | :replaced
          | :server_restart_503
          | :cat_invalid
          | :cat_expired
          | {:unknown, code :: String.t() | nil}

  @typedoc "Result of a parsed `<failure>` (auth-time refusal)."
  @type failure_reason ::
          :logged_out
          | :temp_banned
          | :client_outdated
          | :cat_invalid
          | :cat_expired
          | :service_unavailable
          | :internal_server_error
          | {:unknown, reason :: integer() | nil}

  # --- <stream:error> --------------------------------------------------------

  @doc """
  Decode a `<stream:error>` node into a typed reason atom.

  Mirrors Go's `handleStreamError` switch (`connectionevents.go:19`).

  ## Examples

      iex> alias Whatsmeow.Binary.Node
      iex> Whatsmeow.ConnectionEvents.decode_stream_error(
      ...>   Node.new("stream:error", %{"code" => "515"}, nil))
      :auto_reconnect_515

      iex> alias Whatsmeow.Binary.Node
      iex> Whatsmeow.ConnectionEvents.decode_stream_error(
      ...>   Node.new("stream:error", %{"code" => "401"},
      ...>     [Node.new("conflict", %{"type" => "device_removed"}, nil)]))
      :device_removed
  """
  @spec decode_stream_error(Node.t()) :: stream_error_reason()
  def decode_stream_error(%Node{tag: "stream:error"} = node) do
    code = Node.attr(node, "code")

    conflict_type =
      case Node.get_child(node, "conflict") do
        %Node{} = c -> Node.attr(c, "type")
        _ -> nil
      end

    cond do
      code == "515" -> :auto_reconnect_515
      code == "401" and conflict_type == "device_removed" -> :device_removed
      conflict_type == "replaced" -> :replaced
      code == "503" -> :server_restart_503
      code == "419" -> :cat_invalid
      code == "421" -> :cat_expired
      true -> {:unknown, code}
    end
  end

  def decode_stream_error(%Node{} = _other), do: {:unknown, nil}

  @doc """
  Should the Session auto-reconnect after this stream error?

  Roughly: yes for `515` (server asking us to re-handshake) and `503`
  (server restart); no for `device_removed` and `replaced` (we're out).
  """
  @spec should_reconnect?(stream_error_reason()) :: boolean()
  def should_reconnect?(:auto_reconnect_515), do: true
  def should_reconnect?(:server_restart_503), do: true
  def should_reconnect?(:cat_invalid), do: true
  def should_reconnect?(:cat_expired), do: true
  def should_reconnect?(:device_removed), do: false
  def should_reconnect?(:replaced), do: false

  # **An unknown code is not a verdict.**
  #
  # This returned `false`, which was harmless while nothing acted on it and
  # became "stop for ever" the moment `Session.act_on_stream_error/2` started
  # using this function to decide terminality. Every `<stream:error>` this
  # module does not recognise — including `500`, which the session's own
  # `client-outdated` recovery path is written for — permanently stopped the
  # session, and `restart: :transient` kept it stopped.
  #
  # Only two reasons mean "we are out": the device was removed from the
  # account, and another socket took it. Both are stated by the server in so
  # many words. Anything else is a disconnection, and a disconnection is
  # something to retry — the backoff is what stops a retry loop being
  # expensive, not a refusal to try at all.
  def should_reconnect?(_unrecognised), do: true

  # --- <failure> -------------------------------------------------------------

  @doc """
  Decode a `<failure>` node (auth-time refusal). Returns `{reason_atom,
  message}` where `message` is the optional `message` attr or `nil`.

  Reasons map to WhatsApp's documented ConnectFailureReason enum:

      401  → :logged_out
      403  → :logged_out  (legal/regional)
      405  → :client_outdated
      406  → :logged_out
      419  → :cat_invalid
      421  → :cat_expired
      500  → :internal_server_error
      503  → :service_unavailable
      4264 → :temp_banned (with `:code`, `:expire_seconds` extras)

  Mirrors Go's `handleConnectFailure` (`connectionevents.go:102`).
  """
  @spec decode_failure(Node.t()) ::
          {failure_reason(), String.t() | nil, extras :: map()}
  def decode_failure(%Node{} = node) do
    reason_int = coerce_int(Node.attr(node, "reason"))
    message = Node.attr(node, "message")
    extras = failure_extras(node, reason_int)

    reason =
      case reason_int do
        401 -> :logged_out
        403 -> :logged_out
        405 -> :client_outdated
        406 -> :logged_out
        419 -> :cat_invalid
        421 -> :cat_expired
        500 -> :internal_server_error
        503 -> :service_unavailable
        4264 -> :temp_banned
        n -> {:unknown, n}
      end

    {reason, message, extras}
  end

  defp failure_extras(node, 4264) do
    %{
      code: coerce_int(Node.attr(node, "code")),
      expire_seconds: coerce_int(Node.attr(node, "expire"))
    }
  end

  defp failure_extras(_, _), do: %{}

  @doc "Is this failure terminal (delete the device store, don't retry)?"
  @spec logged_out?(failure_reason()) :: boolean()
  def logged_out?(:logged_out), do: true
  def logged_out?(:client_outdated), do: true
  def logged_out?(_), do: false

  # --- <ib> (in-band notices) ------------------------------------------------

  @doc """
  Decode `<ib>` children into a list of typed notices.

  Recognised tags:

      <offline_preview count=N appdata=A message=M notification=… receipt=…/>
        → {:offline_preview, %{total, app_data_changes, messages, notifications, receipts}}
      <offline count=N/>
        → {:offline_complete, count}
      <downgrade_webclient/>
        → :qr_scanned_without_multidevice
      <dirty type="account_sync" timestamp=…/>
        → {:dirty, type, ts}

  Unknown children are dropped.

  Mirrors Go's `handleIB` (`connectionevents.go:72`).
  """
  @spec decode_ib(Node.t()) :: [term()]
  def decode_ib(%Node{tag: "ib"} = node) do
    node
    |> Node.children()
    |> Enum.flat_map(&decode_ib_child/1)
  end

  def decode_ib(_), do: []

  defp decode_ib_child(%Node{tag: "downgrade_webclient"}) do
    [:qr_scanned_without_multidevice]
  end

  defp decode_ib_child(%Node{tag: "offline_preview"} = n) do
    [
      {:offline_preview,
       %{
         total: coerce_int(Node.attr(n, "count")) || 0,
         app_data_changes: coerce_int(Node.attr(n, "appdata")) || 0,
         messages: coerce_int(Node.attr(n, "message")) || 0,
         notifications: coerce_int(Node.attr(n, "notification")) || 0,
         receipts: coerce_int(Node.attr(n, "receipt")) || 0
       }}
    ]
  end

  defp decode_ib_child(%Node{tag: "offline"} = n) do
    [{:offline_complete, coerce_int(Node.attr(n, "count")) || 0}]
  end

  defp decode_ib_child(%Node{tag: "dirty"} = n) do
    [{:dirty, Node.attr(n, "type"), coerce_int(Node.attr(n, "timestamp"))}]
  end

  defp decode_ib_child(_), do: []

  # --- Coercion helpers ------------------------------------------------------

  defp coerce_int(nil), do: nil
  defp coerce_int(n) when is_integer(n), do: n

  defp coerce_int(bin) when is_binary(bin) do
    case Integer.parse(bin) do
      {n, ""} -> n
      _ -> nil
    end
  end
end
