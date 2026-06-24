# Phoenix bot example — `whatsmeow_ex` integration sketch

A minimal Phoenix LiveView dashboard that wires `whatsmeow_ex` into a
host application. The scaffold in this directory is **not** a runnable
mix project — it's a copy-paste reference for integrating into your own
Phoenix app.

What it demonstrates:

1. **Subscribing** to `whatsmeow_ex` events via `Phoenix.PubSub`
2. **Rendering the QR code** as inline SVG inside a LiveView
3. **Surfacing `UndecryptableMessage` events** to the dashboard
4. **Per-device session info** via `Whatsmeow.Session.info/1`

The four files below all live inside your existing Phoenix app
alongside the rest of your LiveView code — no separate OTP app needed.

## 1. `mix.exs` additions

```elixir
defp deps do
  [
    # your existing deps …
    {:whatsmeow_ex, path: "../whatsmeow_ex"},  # or {:whatsmeow_ex, "~> 0.1.0"} once published
    {:finch, "~> 0.20"}
  ]
end
```

## 2. Supervision tree (`lib/my_app/application.ex`)

```elixir
def start(_type, _args) do
  children = [
    MyApp.Repo,
    MyAppWeb.Endpoint,
    {Finch, name: Whatsmeow.Finch}
    # Whatsmeow.Application starts itself via :whatsmeow_ex's `mod` entry
  ]

  Supervisor.start_link(children, strategy: :one_for_one, name: MyApp.Supervisor)
end
```

## 3. LiveView (`lib/my_app_web/live/whatsmeow_dashboard_live.ex`)

```elixir
defmodule MyAppWeb.WhatsmeowDashboardLive do
  use MyAppWeb, :live_view

  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.Types.Events

  @impl Phoenix.LiveView
  def mount(%{"client_id" => client_id}, _session, socket) do
    # Subscribe BEFORE we touch the session so we never miss the first QR.
    # The session broadcasts on the device's stable `client_id` — the same
    # key passed to `find_or_new_device/1` below. That key never changes,
    # even after `<pair-success>` rewrites the WhatsApp JID.
    if connected?(socket) do
      :ok = Whatsmeow.Notifications.subscribe(client_id)
    end

    socket =
      socket
      |> assign(:client_id, client_id)
      |> assign(:status, :idle)
      |> assign(:qr_svg, nil)
      |> assign(:logged_in_lid, nil)
      |> assign(:undecryptable_count, 0)
      |> assign(:last_message_at, nil)

    {:ok, socket}
  end

  @impl Phoenix.LiveView
  def handle_event("start", _params, socket) do
    # Boot (or look up) the per-device session. `find_or_new_device/1`
    # looks the row up by `client_id` — so reconnects after pairing still
    # resolve to the same row even though `device.jid` has been rewritten
    # by the server to the real WhatsApp JID.
    {:ok, device} = Whatsmeow.Store.find_or_new_device(client_id: socket.assigns.client_id)
    {:ok, pid} = Whatsmeow.start_session(device)
    :ok = Whatsmeow.Session.connect(pid)
    {:noreply, assign(socket, :status, :connecting)}
  end

  def handle_event("stop", _params, socket) do
    :ok = Whatsmeow.stop_session(socket.assigns.client_id)
    {:noreply, assign(socket, :status, :idle) |> assign(:qr_svg, nil)}
  end

  @impl Phoenix.LiveView
  def handle_info({:whatsmeow, %Events.QR{code: payload}}, socket) do
    # Render the QR as inline SVG and stash it on the socket. The QR
    # payload comes from our trusted code, so raw/1 is safe here.
    svg = Whatsmeow.QRChannel.render_svg(payload)
    {:noreply, assign(socket, :qr_svg, svg) |> assign(:status, :pairing)}
  end

  def handle_info({:whatsmeow, %Events.Connected{}}, socket),
    do: {:noreply, assign(socket, :status, :connected)}

  def handle_info({:whatsmeow, %Events.PairSuccess{}}, socket),
    do: {:noreply, assign(socket, :status, :pair_success) |> assign(:qr_svg, nil)}

  def handle_info({:whatsmeow, %Events.LoggedIn{lid: lid}}, socket),
    do: {:noreply, assign(socket, :status, :logged_in) |> assign(:logged_in_lid, lid)}

  def handle_info({:whatsmeow, %Events.Disconnected{reason: reason}}, socket) do
    {:noreply,
     socket
     |> assign(:status, :disconnected)
     |> put_flash(:error, "Disconnected: #{inspect(reason)}")}
  end

  def handle_info({:whatsmeow, %Events.UndecryptableMessage{} = msg}, socket) do
    # Phase 9 in-flight: we get the encrypted bytes but the Signal-wire
    # decode isn't online yet. Count them so the dashboard shows the
    # inbound path is alive end-to-end.
    {:noreply,
     socket
     |> update(:undecryptable_count, &(&1 + 1))
     |> assign(:last_message_at, msg.info.timestamp)}
  end

  def handle_info({:whatsmeow, _other_event}, socket) do
    {:noreply, socket}
  end

  @impl Phoenix.LiveView
  def render(assigns) do
    ~H"""
    <div class="space-y-4">
      <h1 class="text-2xl font-bold">WhatsApp Session: {@client_id}</h1>

      <p>Status: <strong>{@status}</strong></p>
      <p :if={@logged_in_lid}>LID: <code>{@logged_in_lid}</code></p>

      <div class="space-x-2">
        <button phx-click="start" class="px-3 py-1 bg-green-600 text-white rounded">Start</button>
        <button phx-click="stop" class="px-3 py-1 bg-red-600 text-white rounded">Stop</button>
      </div>

      <div :if={@qr_svg} class="p-4 bg-white inline-block rounded shadow">
        {raw(@qr_svg)}
        <p class="text-sm text-gray-600 mt-2">
          Open WhatsApp → Settings → Linked Devices → Link a Device, then scan.
        </p>
      </div>

      <div :if={@status in [:logged_in, :pair_success]} class="p-4 bg-green-50 border border-green-200 rounded">
        <p>Paired and authenticated.</p>
        <p>Inbound messages received (undecryptable for now): <strong>{@undecryptable_count}</strong></p>
        <p :if={@last_message_at}>Last message: <code>{@last_message_at}</code></p>
      </div>
    </div>
    """
  end
end
```

## 4. Router (`lib/my_app_web/router.ex`)

```elixir
scope "/", MyAppWeb do
  pipe_through :browser

  live "/whatsmeow/:client_id", WhatsmeowDashboardLive
end
```

## Operational notes

- **One paired account per `client_id`.** Treat `client_id` as your
  tenant key. It is the stable identifier — `device.jid` is rewritten
  during `<pair-success>` to the real WhatsApp JID, but `client_id`
  never changes. PubSub topics, the Sessions registry, and
  `find_or_new_device/1` all key off `client_id`.
- **Run migrations.** The schema requires the `client_id` column added
  by migration `20260513000001_add_client_id_to_whatsmeow_device.exs`.
  Run `mix ecto.migrate` against your app's repo before first connect.
- **Subscribe before connect.** `connected?(socket)` gates this so we
  don't subscribe in the initial dead-render — otherwise the LiveView
  process would leak a subscription to a dead pid.
- **Don't put the QR through any pipe that escapes HTML.** It's an SVG
  string from `Whatsmeow.QRChannel.render_svg/1` — `raw/1` is safe here
  because the input came from `:qqr`, not from a user.
- **Phase 9 status.** Until the Signal-wire decode lands, decrypted
  message bodies aren't available. The dashboard counts
  `UndecryptableMessage` events as proof the inbound path itself works
  end-to-end; the bytes are on the event struct (`enc_payload`) for
  inspection.
- **Per-tenant proxy.** Pass `transport_opts: [proxy: "http://…"]` to
  `Whatsmeow.start_session/2` (once exposed) or wire it through
  `Whatsmeow.Session.start_link/1` directly.

## Telemetry hookup

Add to your `Telemetry` supervision setup to track session health
across all paired accounts:

```elixir
events = [
  [:whatsmeow, :session, :connect, :start],
  [:whatsmeow, :session, :connect, :stop],
  [:whatsmeow, :session, :stream_error],
  [:whatsmeow, :session, :pair_success],
  [:whatsmeow, :session, :logged_in],
  [:whatsmeow, :session, :message_undecryptable]
]

:telemetry.attach_many(
  "my-app-whatsmeow",
  events,
  fn event, measurements, metadata, _ ->
    Logger.info("whatsmeow telemetry",
      event: Enum.join(event, "."),
      measurements: inspect(measurements),
      metadata: inspect(metadata)
    )
  end,
  nil
)
```
