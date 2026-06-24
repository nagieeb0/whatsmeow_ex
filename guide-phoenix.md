# `whatsmeow_ex` + Phoenix — LiveView pairing, real-time UI, and HTTP webhooks

This guide is for hosts integrating the library into a **Phoenix** application. It covers the three integration surfaces a typical Phoenix app needs:

1. **LiveView for pairing** — render the QR code as it rotates, react to PairSuccess.
2. **LiveView for chat UI** — subscribe to the device topic, stream messages in real time.
3. **HTTP** — incoming webhooks from third parties that need to be sent to WhatsApp, or outbound webhooks fired when WhatsApp messages arrive.

Companions: [`guide-jido.md`](guide-jido.md) (agent brain) and [`guide-ash.md`](guide-ash.md) (declarative domain). This guide is the view + controller layer that wraps either of them.

---

## 1. Application + supervision tree

The library already brings its own supervisor (`Whatsmeow.Supervisor`). In a Phoenix app, just add the library — don't try to insert its children into your own supervisor.

```elixir
# lib/my_app/application.ex
def start(_type, _args) do
  children = [
    MyApp.Repo,
    {Phoenix.PubSub, name: MyApp.PubSub},
    MyAppWeb.Endpoint,
    {Finch, name: Whatsmeow.Finch},               # the library uses this for media
    # Whatsmeow.Application starts here automatically (it's in your deps)
  ]
  Supervisor.start_link(children, strategy: :one_for_one, name: MyApp.Supervisor)
end
```

The library starts:

* `Whatsmeow.Repo` (skip with `config :whatsmeow_ex, :start_repo?, false` if sharing yours)
* `Whatsmeow.PubSub` (a separate `Phoenix.PubSub` instance from yours — that's fine; many apps run multiple)
* `Whatsmeow.Sessions.Registry`, `Whatsmeow.Sessions.Supervisor`, `Whatsmeow.Sessions.TaskSup`, `Whatsmeow.Media.TaskSup`, `Whatsmeow.Media.HKDFCache`, `Whatsmeow.Retry.RecentCache`, `Whatsmeow.WAVersion.Refresher`

If you'd rather share PubSub:

```elixir
config :whatsmeow_ex, :pubsub, MyApp.PubSub
```

Then the library publishes to your PubSub and you don't need to manage a second one.

---

## 2. Pairing LiveView — the QR experience

The most common entry point. User clicks "Connect WhatsApp", you start a session, render the QR until they scan, react to PairSuccess.

```elixir
defmodule MyAppWeb.PairLive do
  use MyAppWeb, :live_view
  alias Whatsmeow.Types.Events

  @impl true
  def mount(_params, %{"user_id" => user_id}, socket) do
    # 1) Find-or-create a device row keyed on a stable client_id.
    {:ok, device} =
      Whatsmeow.Store.find_or_new_device(client_id: "user-#{user_id}")

    # 2) Start the session (idempotent — restarts if already up).
    {:ok, _pid} = Whatsmeow.start_session(device)

    # 3) Subscribe to the device topic BEFORE connect, so we don't miss QR events.
    :ok = Whatsmeow.subscribe(device.jid || device.client_id)

    # 4) Kick the session into :connecting.
    if connected?(socket), do: Whatsmeow.Session.connect(device.jid || device.client_id)

    {:ok,
     assign(socket,
       device_id: device.jid || device.client_id,
       status: :connecting,
       qr_code: nil,
       error: nil
     )}
  end

  @impl true
  def handle_info({:whatsmeow, %Events.Connected{}}, socket) do
    {:noreply, assign(socket, status: :handshake_ok)}
  end

  def handle_info({:whatsmeow, %Events.QR{code: code}}, socket) do
    # The library buffers the QR queue and emits one ref at a time on the
    # correct cadence — render whatever it sends, don't try to rotate yourself.
    svg = Whatsmeow.QRChannel.render_svg(code)
    {:noreply, assign(socket, status: :awaiting_scan, qr_code: svg)}
  end

  def handle_info({:whatsmeow, %Events.PairSuccess{jid: jid}}, socket) do
    {:noreply,
     socket
     |> assign(status: :paired, qr_code: nil)
     |> put_flash(:info, "WhatsApp linked as #{jid}")
     |> push_navigate(to: ~p"/conversations")}
  end

  def handle_info({:whatsmeow, %Events.PairError{reason: reason}}, socket) do
    {:noreply, assign(socket, status: :pair_error, error: inspect(reason))}
  end

  def handle_info({:whatsmeow, %Events.LoggedIn{}}, socket) do
    # Fires post-relogin after PairSuccess. Treat as "fully ready."
    {:noreply, assign(socket, status: :ready)}
  end

  def handle_info({:whatsmeow, _}, socket), do: {:noreply, socket}
end
```

The matching `.heex`:

```heex
<div class="pair-flow">
  <%= case @status do %>
    <% :connecting -> %>
      <p>Opening connection to WhatsApp…</p>

    <% :handshake_ok -> %>
      <p>Handshake done. Waiting for QR…</p>

    <% :awaiting_scan -> %>
      <h2>Scan this with WhatsApp → Linked devices</h2>
      <div class="qr">{Phoenix.HTML.raw(@qr_code)}</div>
      <p class="hint">Codes rotate every ~20-60s. Keep the page open.</p>

    <% :paired -> %>
      <p>Paired. Redirecting…</p>

    <% :pair_error -> %>
      <p class="error">Pairing failed: {@error}</p>

    <% :ready -> %>
      <p>Connected.</p>
  <% end %>
</div>
```

> **The one critical trap:** subscribe **before** `connect/1`. If you flip the order, the first `<pair-device>` IQ may arrive (and its `%Events.QR{}` may broadcast) before your LiveView subscribes — and the user sees a blank screen until the next ref rotation 20 s later. Subscription is free; do it first.

> **Why `Whatsmeow.QRChannel.render_svg/1` is safe with `raw/1`:** the function generates the SVG itself from the code string; nothing inbound is rendered as HTML. Don't `raw/1` `code` directly — it's a URL-encoded payload, not HTML.

---

## 3. Chat LiveView — real-time message stream

Once paired, render messages as they arrive. The pattern that works at scale:

```elixir
defmodule MyAppWeb.ChatLive do
  use MyAppWeb, :live_view
  alias Whatsmeow.Types.Events

  @impl true
  def mount(%{"peer" => peer_jid}, %{"device_id" => device_id}, socket) do
    if connected?(socket), do: :ok = Whatsmeow.subscribe(device_id)

    # Hydrate history from your Repo (not from the library — it doesn't store messages).
    history = MyApp.WhatsApp.list_messages(device_id, peer_jid, limit: 50)

    {:ok,
     socket
     |> assign(device_id: device_id, peer: peer_jid)
     |> stream(:messages, history)}
  end

  @impl true
  def handle_info({:whatsmeow, %Events.Message{info: %{from: from}} = evt}, socket) do
    if Whatsmeow.Types.JID.to_string(from) == socket.assigns.peer do
      # Persist to your store, then stream to the UI.
      {:ok, persisted} = MyApp.WhatsApp.record_inbound(socket.assigns.device_id, evt)
      {:noreply, stream_insert(socket, :messages, persisted, at: 0)}
    else
      {:noreply, socket}
    end
  end

  def handle_info({:whatsmeow, %Events.Receipt{}}, socket), do: {:noreply, socket}
  def handle_info({:whatsmeow, _}, socket), do: {:noreply, socket}

  @impl true
  def handle_event("send", %{"body" => body}, socket) do
    case MyApp.WhatsApp.send_text(socket.assigns.device_id, socket.assigns.peer, body) do
      {:ok, _id} -> {:noreply, socket}
      {:error, reason} -> {:noreply, put_flash(socket, :error, "Send failed: #{inspect(reason)}")}
    end
  end
end
```

Key choices:

* **`stream/3` instead of `assign` for the list** — LiveView only sends diffs, not the whole list, even with 10k messages on screen.
* **Filter by `peer_jid` in `handle_info`** — the device topic carries every chat's events. A 100-conversation user opens one LiveView per chat; each filters to its own peer.
* **Persistence happens server-side** — the library doesn't store message bodies. You do, in your own Repo or via the Ash domain.

### Memory cost per chat LiveView

A LiveView holds a copy of socket assigns. With `stream/3`, the message list is **not** in assigns — it's tracked as a delta against the DOM. So 1000 concurrent chat LiveViews ≈ 1000 × (LiveView process + your stream metadata), roughly **30-50 MB** total. Linear, predictable.

---

## 4. Telemetry → Phoenix.LiveDashboard

The library emits `:telemetry` events. Wire them into the Dashboard for live ops visibility.

```elixir
# lib/my_app_web/telemetry.ex
def metrics do
  [
    counter("whatsmeow.session.connect.start.system_time"),
    counter("whatsmeow.session.connect.stop.system_time", tags: [:outcome]),
    counter("whatsmeow.session.stream_error.system_time", tags: [:code]),
    counter("whatsmeow.session.pair_success.system_time"),
    counter("whatsmeow.session.logged_in.system_time"),
    counter("whatsmeow.session.message_decrypted.system_time"),
    counter("whatsmeow.session.message_undecryptable.system_time", tags: [:reason]),
    summary("whatsmeow.session.message_decrypted.plaintext_bytes", unit: :byte),
    last_value("vm.memory.total", unit: :byte)
  ]
end
```

Mount the dashboard with `live_dashboard "/dashboard", metrics: MyAppWeb.Telemetry` and you have a live ops view of every paired account.

**The single signal to alert on** (from [`usage-rules.md`](usage-rules.md) §9): `[:whatsmeow, :session, :stream_error]` rate grouped by `code`. A code-500 spike from one egress pool = a stale WAVersion or a flagged IP range. A code-401 spike = accounts being unlinked.

---

## 5. HTTP webhooks — inbound and outbound

### Inbound webhook (something else wants WhatsApp to send a message)

```elixir
defmodule MyAppWeb.WhatsAppController do
  use MyAppWeb, :controller

  def send(conn, %{"account_id" => acc, "peer" => peer, "body" => body}) do
    case MyApp.WhatsApp.send_text(acc, peer, body) do
      {:ok, message_id} -> json(conn, %{ok: true, message_id: message_id})
      {:error, reason}  -> conn |> put_status(502) |> json(%{ok: false, error: inspect(reason)})
    end
  end
end
```

Rate-limit at the router with `Plug.RateLimiter` or `Hammer` — at minimum **per account**. Don't rely on the per-fanout concurrency to throttle for you; it parallelises within one send call, but doesn't pace external callers.

### Outbound webhook (notify a third-party when a WhatsApp message arrives)

A dedicated GenServer per account subscribes to the device topic and POSTs:

```elixir
defmodule MyApp.WhatsApp.Webhook do
  use GenServer

  def start_link(opts), do: GenServer.start_link(__MODULE__, opts, name: via(opts[:device_id]))

  def init(opts) do
    :ok = Whatsmeow.subscribe(opts[:device_id])
    {:ok, opts}
  end

  def handle_info({:whatsmeow, %Whatsmeow.Types.Events.Message{} = msg}, state) do
    # Spawn — don't block the subscriber on HTTP.
    Task.Supervisor.start_child(MyApp.WebhookTaskSup, fn ->
      MyApp.HTTP.post(state.webhook_url, %{
        from: Whatsmeow.Types.JID.to_string(msg.info.from),
        body: msg.message.body,
        ts: msg.info.timestamp
      })
    end)
    {:noreply, state}
  end

  def handle_info({:whatsmeow, _}, state), do: {:noreply, state}
  defp via(id), do: {:via, Registry, {MyApp.WebhookRegistry, id}}
end
```

Why a dedicated GenServer (not a LiveView): webhooks must survive the user closing their browser tab.

---

## 6. Multi-tenant — one Endpoint, many accounts

For a SaaS product where each tenant has their own paired WhatsApp account:

* **Auth** — your existing `Plug` auth pipeline already gates LiveView mount.
* **Scoping** — store `account_id` on the user; on every LiveView mount, verify the user owns the account before subscribing.
* **Topic isolation** — `Whatsmeow.subscribe(account.client_id)` only delivers events for that account; one user can't snoop on another's stream.

The library partitions `Whatsmeow.Sessions.Registry` by `System.schedulers_online()` — session lookups don't bottleneck even at 10k+ tenants on one node.

**Memory cost at scale** (measured, see `bench/fleet_simulation.exs`):

| Tenants | BEAM session memory | Add for live WSS | Total BEAM-side |
|---:|---:|---:|---:|
| 1 000 | ~3 MB | ~20 MB | ~25 MB |
| 10 000 | ~27 MB | ~200 MB | ~230 MB |
| 50 000 | ~133 MB | ~1 GB | ~1.2 GB |
| 100 000 | ~270 MB | ~2-3 GB | ~3-4 GB |

A 16 GB box runs 100k tenants comfortably; a 4 GB box runs 10k. Distribute across nodes with libcluster + `Phoenix.PubSub.PG2` when you cross 50k.

---

## 7. Cold-start storms

A fleet boot that brings up 10k sessions in the same millisecond would all hit Meta's edge simultaneously — and you'd lose the IPs.

The library has built-in jitter; you just have to enable it:

```elixir
# config/runtime.exs (production)
config :whatsmeow_ex, :cold_start_jitter_ms, 30_000
```

Each Session's first connect attempt is delayed by `:rand.uniform(jitter)` ms. With `30_000` and 10k sessions, your boot storm spreads over 30 s instead of 0 s.

For dev/test, leave it at the default (0) so test feedback is fast.

---

## 8. Asset pipeline — QR codes in the wild

The library's `Whatsmeow.QRChannel.render_svg/1` produces a complete SVG. Render it inline with `Phoenix.HTML.raw/1` (it's not user-provided HTML — it's library-generated and audited).

For a non-LiveView page (Plug controller HTML):

```elixir
def show(conn, %{"device_id" => id}) do
  case Whatsmeow.Notifications.latest_qr(id) do  # hypothetical helper; or cache it yourself
    {:ok, code} -> render(conn, :qr, svg: Whatsmeow.QRChannel.render_svg(code))
    :error -> conn |> put_status(404) |> json(%{error: "no_qr_yet"})
  end
end
```

For mobile apps that take a PNG, use the terminal renderer's underlying matrix and a PNG encoder — out of scope here.

---

## 9. Background jobs — Oban

If you don't want to use `AshOban` (no Ash, just Phoenix + Oban):

```elixir
defmodule MyApp.Workers.WAReply do
  use Oban.Worker, queue: :wa, max_attempts: 3, unique: [period: 60]

  def perform(%Oban.Job{args: %{"device_id" => d, "peer" => p, "body" => b}}) do
    case Whatsmeow.Send.send_text(d, p, b) do
      {:ok, _id} -> :ok
      {:error, :not_connected} -> {:snooze, 30}    # Session reconnecting — retry soon
      {:error, reason} -> {:error, reason}
    end
  end
end
```

Pair with a Throttle GenServer (see [`guide-jido.md`](guide-jido.md) §5) so Oban concurrency doesn't blow your per-account rate limit.

---

## 10. End-to-end test pattern

Phoenix's test suite + LiveView's test helpers let you exercise the pair flow without standing up a real WSS:

```elixir
defmodule MyAppWeb.PairLiveTest do
  use MyAppWeb.ConnCase
  import Phoenix.LiveViewTest
  alias Whatsmeow.Types.Events

  test "shows QR and reacts to pair-success", %{conn: conn} do
    {:ok, view, _html} = live(conn, ~p"/pair")

    # The session is running but no real wire — emit the events directly.
    device_id = "user-test-1"
    Whatsmeow.Notifications.broadcast(device_id, %Events.QR{code: "encoded-qr-payload"})

    assert render(view) =~ "Scan this"

    Whatsmeow.Notifications.broadcast(device_id, %Events.PairSuccess{jid: "12025550100@s.whatsapp.net"})

    assert_redirect(view, ~p"/conversations")
  end
end
```

For full-stack integration tests against a real account, see `mix whatsmeow.smoke` — it's the synchronous CLI walkthrough the library ships with.

---

## 11. Production checklist (Phoenix-specific)

- [ ] `Finch` named `Whatsmeow.Finch` is in your supervision tree (or your own Finch + `config :whatsmeow_ex, :finch, MyApp.Finch`).
- [ ] LiveViews subscribe **before** triggering `connect/1`.
- [ ] Chat LiveView uses `stream/3` for messages, not `assign/3`.
- [ ] Plug auth pipeline gates every LiveView mount on `account_id` ownership.
- [ ] `LiveDashboard` mounted with `whatsmeow.*` telemetry.
- [ ] `cold_start_jitter_ms` set in production config.
- [ ] HTTP send endpoints rate-limited per-account.
- [ ] Outbound webhook GenServer per account in a DynamicSupervisor.
- [ ] CSP allows inline SVG (or scope `unsafe-inline` to the QR page only).
- [ ] `Endpoint` configured with `force_ssl` for production — the QR represents pairing material.

---

## 12. Where Phoenix fits in the overall picture

```
              ┌────────────────────────────┐
              │   Phoenix LiveView / API   │  ← user-facing
              │      (this guide)          │
              └─────────────┬──────────────┘
                            │ Ash actions / Jido tools
              ┌─────────────▼──────────────┐
              │   Jido agent  /  Ash       │  ← brain & domain
              │ (guide-jido.md / -ash.md)  │
              └─────────────┬──────────────┘
                            │ Whatsmeow.Send / subscribe
              ┌─────────────▼──────────────┐
              │   whatsmeow_ex library     │  ← wire & protocol
              │     (GUIDE.md / this)      │
              └────────────────────────────┘
```

Phoenix is the **edge**: pairing UI, real-time chat UI, HTTP integration points. It doesn't make decisions about messages; it surfaces them. Use Jido for the decisions and Ash for the durable domain. Or pick one of the two — they're complementary, not exclusive.
