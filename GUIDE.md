# `whatsmeow_ex` — Production Integration Guide

A 1:1 pure-Elixir port of Go's [`whatsmeow`](https://github.com/tulir/whatsmeow). No NIFs, no Rust, no C — just OTP `:crypto` + Mint + Ecto + Postgres. This document is the **operator's guide** for running `whatsmeow_ex` in a real production system.

**Audience:** an SRE / platform-engineer adopting the library, or a developer integrating it into a Phoenix app.

**Status as of 2026-05-12:** 537 tests, 0 failures. Live pair + login + 1:1 receive + 1:1 send + group receive all verified against `web.whatsapp.com`. Fleet hardening landed (partitioned Registry, per-device persona, cold-start jitter, opt-in firehose, periodic version refresher, empirical 2.7 KB/idle-session memory benchmark). The library is suitable for managed-account products today.

---

## Table of contents

1. [Quickstart](#1-quickstart)
2. [Installation & dependencies](#2-installation--dependencies)
3. [Configuration](#3-configuration)
4. [Supervision tree integration](#4-supervision-tree-integration)
5. [Lifecycle of a session](#5-lifecycle-of-a-session)
6. [Pairing a new device](#6-pairing-a-new-device)
7. [Receiving messages](#7-receiving-messages)
8. [Sending messages](#8-sending-messages)
9. [Media (upload & download)](#9-media-upload--download)
10. [Groups](#10-groups)
11. [Events & telemetry](#11-events--telemetry)
12. [Multi-tenant & fleet operation](#12-multi-tenant--fleet-operation)
13. [Cost model & capacity planning](#13-cost-model--capacity-planning)
14. [Failure modes & recovery](#14-failure-modes--recovery)
15. [Security model](#15-security-model)
16. [Testing strategy](#16-testing-strategy)
17. [Comparison with Go upstream](#17-comparison-with-go-upstream)
18. [What's still missing](#18-whats-still-missing)
19. [Verification: this really is pure Elixir](#19-verification-this-really-is-pure-elixir)

---

## 1. Quickstart

```bash
# 1. Add to deps, then:
mix deps.get
mix ecto.setup       # creates whatsmeow_* tables in your Postgres
mix whatsmeow.smoke  # interactive: prints a QR, you scan it on the phone app

# Subsequent runs — skip the QR phase entirely:
mix whatsmeow.smoke --load-jid 12025550100:1@s.whatsapp.net --persist --relogin
```

The smoke task is the fastest "is it working" check. It exercises every code path: version scrape → WSS → Noise XX → pair → optional persist → relogin → receive → decrypt → optional outbound. See [§6](#6-pairing-a-new-device) for what each flag does.

For your own application, the public API is rooted at `Whatsmeow`:

```elixir
{:ok, _} = Whatsmeow.WAVersion.refresh()                              # boot-time
{:ok, device} = Whatsmeow.Store.find_or_new_device(client_id: "abc")  # persistent
{:ok, session} = Whatsmeow.start_session(device)                       # GenServer
:ok = Whatsmeow.subscribe(device.id)                                  # PubSub
Whatsmeow.Session.connect(session)                                     # cast → WSS
# … wait for {:whatsmeow, %Events.QR{}} … render … wait for %Events.PairSuccess{} …
{:ok, _id} = Whatsmeow.Send.send_text(session, "12025550101@s.whatsapp.net", "hi")
```

---

## 2. Installation & dependencies

### 2.1 The `mix.exs` entry

```elixir
defp deps do
  [
    {:whatsmeow_ex, "~> 0.1.0"},

    # The library expects a Finch instance named `Whatsmeow.Finch` for
    # streaming media. If you already use Finch elsewhere you can reuse it
    # by passing the name explicitly; otherwise the simplest is to add one.
    {:finch, "~> 0.20"}
  ]
end
```

`whatsmeow_ex` pulls these transitively, all pure-Elixir / pure-Erlang:

| Dep | Purpose |
|---|---|
| `:mint` + `:mint_web_socket` | TLS WebSocket transport |
| `:castore` | TLS CA bundle |
| `:finch` | Streaming HTTP for media |
| `:protobuf` | Generated message types (55 packages) |
| `:gen_state_machine` | Internal state machines |
| `:ecto_sql` + `:postgrex` | Default persistence layer |
| `:phoenix_pubsub` | Event fanout |
| `:telemetry` | Observability |
| `:nimble_options` | Option validation |
| `:jason` | JSON (server version scrape) |
| `:qqr` | Pure-Elixir QR rendering |

### 2.2 Postgres

The library ships **one migration** at `priv/repo/migrations/20260101000001_create_whatsmeow_schema.exs`. It creates 17 tables prefixed `whatsmeow_*`. If you want them in a non-default schema, set `prefix: "whatsmeow"` in your Repo config before migrating.

The hot tables under sustained load are:

* `whatsmeow_sessions` — Signal Double-Ratchet state, one row per peer
* `whatsmeow_sender_keys` — group cipher state, one row per (chat, sender)
* `whatsmeow_identity_keys` — peer identity pubs (needed for MAC verify on `<enc type="msg">`)
* `whatsmeow_pre_keys` — published one-time pre-keys (~50–812 per device)
* `whatsmeow_app_state_mutation_macs` — write-heavy if you opt into AppState sync

For ~100 K accounts plan **50–100 GB** allocated and `pool_size: 50–100` per BEAM node.

---

## 3. Configuration

```elixir
# config/config.exs
config :whatsmeow_ex, Whatsmeow.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: 10,
  ssl: true,
  ssl_opts: [verify: :verify_peer, cacertfile: System.get_env("PG_CA_PATH")]

# Library can be told NOT to start its own Repo if you're sharing one:
config :whatsmeow_ex,
  start_repo?: true,   # default
  pubsub: Whatsmeow.PubSub,   # default — you can point at your own Phoenix.PubSub
  finch: Whatsmeow.Finch      # default — you can point at your own Finch

# Fleet-hardening knobs (all opt-in; safe defaults preserve dev/test behaviour):

# Cold-start jitter — spreads first-connect of a freshly-supervised session
# over [1, max] ms so a 50k-account fleet doesn't thunder Meta's edge on
# boot. 0 = immediate connect (default; required by the test suite).
config :whatsmeow_ex, :cold_start_jitter_ms, 30_000

# Per-device persona used when registering a fresh device. Resolution order
# at runtime: `Device.persona` (persisted at pair time) → this config →
# `Whatsmeow.ClientPayload.Persona.default/0` (Mac OS / 10.15.7 / en-US).
# Pick a stable persona per tenant; never rotate per reconnect.
config :whatsmeow_ex, :persona, Whatsmeow.ClientPayload.Persona.mac_os()

# Periodic WA-version scrape. Disabled by default. Enable per pool/proxy:
config :whatsmeow_ex, Whatsmeow.WAVersion.Refresher,
  enabled?: true,
  interval_ms: :timer.hours(1),
  proxy: System.get_env("WHATSMEOW_PROXY")

# Global firehose PubSub topic ("all"). OFF by default — every Notifications
# broadcast goes to the per-device topic only. At fleet scale, a global
# subscriber becomes a memory amplifier and a bottleneck. Enable only for
# tests / dashboards:
config :whatsmeow_ex, Whatsmeow.Notifications, all_topic?: false
```

### 3.1 Sharing the Repo with your host app

```elixir
config :whatsmeow_ex, start_repo?: false
config :whatsmeow_ex, :ecto_repos, [MyApp.Repo]
```

Then copy the `whatsmeow_*` migration into your repo's `priv/repo/migrations/`. The schemas reference `Whatsmeow.Repo` by name — to retarget, wrap the schemas in a thin adapter (see `Whatsmeow.Store` behaviour at [§4.3](#43-overriding-persistence)).

### 3.2 Live-version refresher

WhatsApp Web's `client_revision` increments roughly weekly. A stale pin gets you `<stream:error code="500">` within days. The library ships `Whatsmeow.WAVersion.Refresher` as a supervisor child — disabled by default, flip on per-IP-pool:

```elixir
# config/runtime.exs
config :whatsmeow_ex, Whatsmeow.WAVersion.Refresher,
  enabled?: true,
  interval_ms: :timer.hours(1),
  proxy: System.get_env("WHATSMEOW_PROXY")
```

When `enabled?: true`, the refresher fires once at boot (`send(self(), :refresh)` from `init/1`) and re-fires on `interval_ms ± up to 5 minutes` jitter — so a fleet of N nodes doesn't synchronise scrapes. Failures are logged but don't update the cache (readers continue to see the previous successful pin).

Force an out-of-band refresh:

```elixir
Whatsmeow.WAVersion.Refresher.refresh_now()
# => {:ok, {2, 3000, 1_057_xxx}}
```

Do **not** call `refresh/1` per session — it's a fleet-wide concern. For multi-pool patterns where different IP ranges may see different revisions, see [§12.2](#122-version-pinning-per-ip-pool). When you adopt AshOban for orchestration, drop the `Refresher` child and schedule `Whatsmeow.WAVersion.refresh/1` as a cron worker instead.

---

## 4. Supervision tree integration

### 4.1 Default — let the library start itself

If `:start_repo?` is `true` (default), `Whatsmeow.Application` brings up its own supervision tree under `Whatsmeow.Supervisor`:

```
Whatsmeow.Supervisor (rest_for_one)
├── Whatsmeow.Repo                        # Ecto.Repo
├── Whatsmeow.Telemetry                   # default :telemetry attachments
├── Phoenix.PubSub (name: Whatsmeow.PubSub)
├── Whatsmeow.Sessions.Registry           # Registry, keys: :unique,
│                                         # partitions: schedulers_online()
├── Whatsmeow.Sessions.Supervisor         # DynamicSupervisor, one_for_one
├── Task.Supervisor (name: Whatsmeow.Media.TaskSup)
├── Whatsmeow.Retry.RecentCache           # ETS-backed retry de-dup cache
└── Whatsmeow.WAVersion.Refresher         # disabled by default; opt-in via
                                          # config (§3.2)
```

The Registry uses `partitions: System.schedulers_online()` — multiple lookup tables sharded by hash of the key — so concurrent `via(device_id)` resolutions don't contend on a single write lock. This matters once you have AshOban workers or Jido agents issuing thousands of `Session.send_*` per second.

You only need to add a Finch instance:

```elixir
def start(_type, _args) do
  children = [
    MyApp.Repo,
    MyAppWeb.Endpoint,
    {Finch, name: Whatsmeow.Finch}
  ]
  Supervisor.start_link(children, strategy: :one_for_one, name: MyApp.Supervisor)
end
```

### 4.2 Owning your own supervision tree

Set `start_repo?: false` and assemble it yourself if you want full control:

```elixir
children = [
  MyApp.Repo,
  {Phoenix.PubSub, name: Whatsmeow.PubSub},
  {Registry, keys: :unique, name: Whatsmeow.Sessions.Registry},
  {DynamicSupervisor, strategy: :one_for_one, name: Whatsmeow.Sessions.Supervisor},
  {Task.Supervisor, name: Whatsmeow.TaskSupervisor},
  {Finch, name: Whatsmeow.Finch},
  MyApp.TenantSupervisor
]
```

### 4.3 Overriding persistence

`Whatsmeow.Store` is a behaviour. The default impl is `Whatsmeow.Store.Postgres`. To plug a different durable store (e.g. SQLite for embedded use), implement:

```elixir
@callback find_or_new_device(keyword()) :: {:ok, Device.t()} | {:error, term()}
@callback new_device(map()) :: {:ok, Device.t()} | {:error, term()}
@callback get_device(String.t()) :: Device.t() | nil
@callback persist_device(Device.t()) :: :ok | {:error, term()}
```

…and configure `config :whatsmeow_ex, :store, MyApp.WhatsmeowStore`.

For **Signal session** persistence specifically, `Whatsmeow.Signal.Store.Postgres` is called directly from `Whatsmeow.Signal.Decrypt.persist_session/3`. Override by re-pointing the call sites; there's no behaviour split-out yet (PR welcome).

---

## 5. Lifecycle of a session

```
            ┌─────────────────────────┐
            │  Whatsmeow.start_session │
            └────────────┬────────────┘
                         │ spawn GenServer
                         ▼
       ┌───────────────────────────────────────┐
       │  Whatsmeow.Session (per device)        │
       └───────────────────────────────────────┘
                         │ connect/1
                         ▼
              Mint TLS WSS upgrade ──────► wss://web.whatsapp.com/ws/chat
                         │
                         ▼
              Noise XX handshake
              (ClientHello → ServerHello →
               ClientFinish + ClientPayload)
                         │
                         ▼
              ┌──────────────────────────┐
              │ branch on device.jid     │
              │  • placeholder/no-@      │──► registration payload
              │  • numeric WA JID        │──► login payload
              └──────────────────────────┘
                         │
        ┌────────────────┼──────────────────┐
        ▼ unpaired       ▼ paired           ▼ failure
  <iq pair-device>   <success>          <stream:error|failure>
        │                │                  │
        ▼                ▼                  ▼
   render QR       LoggedIn event       Disconnected + backoff
        │                │
   wait for scan    post-login bootstrap
        │           ─ PreKeys auto-upload
        ▼           ─ keepalive timer
  <iq pair-success>
        │
   PairSuccess event
   + persist device
        │
   (server closes)
        │
   reconnect with login_payload
        │
        ▼
  steady state
        │
  ┌─────┴─────┬──────────┬───────────┬────────────┐
  ▼           ▼          ▼           ▼            ▼
inbound    outbound   keepalive   iq result   stream error
<message>  send_text  ping/pong   correlation  → backoff
```

Every step above is implemented and verified against the real server.

### 5.1 Start, observe, stop

```elixir
{:ok, session} = Whatsmeow.start_session(device)
Whatsmeow.Session.info(session)
# => %{
#   device_id: "...",
#   jid: "12025550100:1@s.whatsapp.net",
#   connected?: true,
#   keepalive_failures: 0,
#   reconnect_attempts: 0,
#   pending_iqs: 0
# }
Whatsmeow.stop_session(session)
```

Sessions register themselves under `Whatsmeow.Sessions.Registry`. To look up a session by device id:

```elixir
case Whatsmeow.Session.whereis(device.id) do
  pid when is_pid(pid) -> pid
  :undefined -> :not_running
end
```

### 5.2 Reconnect semantics

* On `<failure>` (account banned, device removed) — `auto_reconnect?` is set to `false` to avoid hammering and earning a ban. The application must intervene (re-pair or accept the loss).
* On `<stream:error>` / TCP close — exponential backoff (1 s → 5 min, +0–500 ms jitter), capped. Older `{:reconnect, n}` messages are dropped (stale-safe).
* On 3 consecutive un-acked keepalive pings — force a reconnect.

The reconnect loop is built into the GenServer. Your app code never needs to retry manually.

### 5.3 Cold-start jitter

Backoff jitter handles reconnects. For the **first** connect of a freshly-supervised session, set `:cold_start_jitter_ms` so a node bringing up 50k sessions doesn't hit Meta's edge in one window:

```elixir
config :whatsmeow_ex, :cold_start_jitter_ms, 30_000
```

With this set, the very first `:connect` cast on an `:idle` session schedules `Process.send_after(self(), :connect_after_cold_start, :rand.uniform(30_000))` and returns immediately — the session stays `:idle` until the timer fires. Subsequent reconnects use the standard exponential backoff path. Default is `0` (immediate connect) to preserve test-suite determinism.

---

## 6. Pairing a new device

### 6.1 The interactive flow

```
1. Operator runs Whatsmeow.start_session(device) for a *fresh* device
   (no JID yet — Whatsmeow.Store.find_or_new_device returns one).
2. Session connects, sends a registration ClientPayload.
3. Server replies <iq><pair-device><ref>STR1</ref><ref>STR2</ref>...</iq>
4. Session broadcasts %Events.QR{code: canonical_payload} on
   "whatsmeow:device:<id>". Your LiveView renders it.
5. User scans on the WhatsApp phone app.
6. Server replies <iq><pair-success><device-identity .../>...</iq>.
7. Session decodes, HMAC-verifies, account-sig-verifies, generates
   our device signature, builds and sends the <pair-device-sign> ack.
8. Session broadcasts %Events.PairSuccess{jid, lid, business_name, ...}.
9. Server closes the WSS. Session auto-reconnects with login_payload.
10. Server replies <success lid="..." t="...">.
11. Session broadcasts %Events.LoggedIn{lid, server_time_offset}.
12. Post-login bootstrap: PreKeys.upload (812 OPKs on first run).
13. Steady state — keepalive on a 25s timer.
```

### 6.2 Rendering the QR in Phoenix LiveView

```elixir
defmodule MyAppWeb.WhatsAppLive do
  use Phoenix.LiveView

  def mount(%{"device_id" => device_id}, _session, socket) do
    if connected?(socket), do: Whatsmeow.subscribe(device_id)

    {:ok,
     socket
     |> assign(:device_id, device_id)
     |> assign(:qr_svg, nil)
     |> assign(:status, :idle)}
  end

  def handle_info({:whatsmeow, %Whatsmeow.Types.Events.QR{code: payload}}, socket) do
    {:noreply, assign(socket, qr_svg: Whatsmeow.QRChannel.render_svg(payload), status: :pairing)}
  end

  def handle_info({:whatsmeow, %Whatsmeow.Types.Events.PairSuccess{jid: jid}}, socket) do
    {:noreply, assign(socket, jid: jid, status: :paired, qr_svg: nil)}
  end

  def handle_info({:whatsmeow, %Whatsmeow.Types.Events.LoggedIn{}}, socket) do
    {:noreply, assign(socket, status: :online)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h2>Status: <%= @status %></h2>
      <%= if @qr_svg do %>
        <div phx-hook="QRTimer" id={"qr-#{@device_id}"}>
          <%= Phoenix.HTML.raw(@qr_svg) %>
        </div>
      <% end %>
    </div>
    """
  end
end
```

The SVG comes from `Whatsmeow.QRChannel.render_svg/1` (pure function, your code, no untrusted input) so `Phoenix.HTML.raw/1` is safe here.

### 6.3 Pairing via CLI (no UI)

```elixir
:ok = Whatsmeow.subscribe(device.id)
{:ok, _} = Whatsmeow.start_session(device)
Whatsmeow.Session.connect(_session)

receive do
  {:whatsmeow, %Whatsmeow.Types.Events.QR{code: payload}} ->
    IO.puts(Whatsmeow.QRChannel.render_terminal(payload))
end

receive do
  {:whatsmeow, %Whatsmeow.Types.Events.PairSuccess{jid: jid}} ->
    IO.puts("Paired: #{jid}")
end
```

The terminal renderer uses half-block Unicode (▀ ▄ █) so it scans on any background.

### 6.4 Phone-number pair code (alternative)

`Whatsmeow.PairCode` builds and validates phone-number pair codes (the "Link with phone number" flow). The IQ exchange against the server isn't wired yet — see [§18](#18-whats-still-missing).

### 6.5 Persona stamped at pair time

`Whatsmeow.Pair.handle_pair_success/2` stamps the configured persona onto the `Device.persona` JSONB column once, at pair time:

```elixir
device.persona
# => %{
#   "os" => "Mac OS",
#   "os_version" => [10, 15, 7],
#   "manufacturer" => "Apple Computer, Inc.",
#   "device" => "Desktop",
#   "locale_language" => "en",
#   "locale_country" => "US",
#   "mcc" => "000",
#   "mnc" => "000"
# }
```

This persona drives `ClientPayload.userAgent` and `DeviceProps.os` for every subsequent registration and login payload from this device. **Never mutate it after pair** — rotating UA across reconnects is itself a fingerprint signal. To use a different persona for a different tenant / region, change `config :whatsmeow_ex, :persona, …` *before* the first pair; existing rows keep their original value.

Built-in presets: `Whatsmeow.ClientPayload.Persona.mac_os/0` (default), `windows/0`, `linux/0`. Build your own:

```elixir
%Whatsmeow.ClientPayload.Persona{
  os: "Mac OS",
  os_version: {14, 4, 0},
  manufacturer: "Apple Computer, Inc.",
  device: "Desktop",
  locale_language: "fr",
  locale_country: "FR"
}
```

---

## 7. Receiving messages

### 7.1 1:1 text

```elixir
def handle_info({:whatsmeow, %Whatsmeow.Types.Events.Message{message: msg, info: info}}, socket) do
  Logger.info("From #{Whatsmeow.Types.JID.to_string(info.from)}: #{msg.body}")

  msg.body                 # plaintext text (or nil)
  msg.is_from_me           # echoed-from-self?
  msg.is_group             # is this a group chat?
  msg.timestamp            # server-side unix seconds
  msg.raw                  # the decoded %WAWebProtobufsE2E.Message{} for advanced cases
  msg.attachments          # [%{kind, mime_type, url, media_key, ...}]

  {:noreply, socket}
end
```

Behind the scenes:

* The Session GenServer received `<message>` over the WSS.
* `Whatsmeow.MessageInfo.from_node/2` parsed the envelope attrs.
* `Whatsmeow.Signal.Decrypt.decrypt_message_node/3` picked the first viable `<enc>`:
  * `<enc type="pkmsg">` (first contact) → responder X3DH + first ratchet step → persist new `%Signal.Session{}`.
  * `<enc type="msg">` (steady state) → load `(our_jid, their_id)` row → advance ratchet → persist.
  * `<enc type="skmsg">` (group) → load `(our_jid, chat_id, sender_id)` row → XEdDSA verify + chain advance → persist.
* On success the session sends `<receipt>` to the server (the double-tick) and broadcasts `%Events.Message{}` + per-attachment `%Events.MediaMessage{}`.
* On failure the session broadcasts `%Events.UndecryptableMessage{}` with the specific reason atom (`:no_session`, `:bad_signature`, `:mac_mismatch`, `:bad_padding`, etc.).

### 7.2 Group messages — the SKDM mechanic

Group messages arrive as `<enc type="skmsg">`. Decryption requires a `%GroupSession{}` already seeded in `whatsmeow_sender_keys` for `(our_jid, chat_jid, sender_jid)`. The seeding happens automatically:

1. When **any** group member sends a group message, they first send a 1:1 `<enc>` to your device containing a `senderKeyDistributionMessage` inside the WaE2E.Message.
2. `Whatsmeow.Signal.Decrypt.decrypt_message_node/3` peeks the decrypted plaintext for `senderKeyDistributionMessage`, calls `Whatsmeow.Signal.GroupSession.from_distribution/1`, and upserts the row.
3. Subsequent `<enc type="skmsg">` from the same `(chat, sender)` decrypt directly.

If you see `%Events.UndecryptableMessage{reason: :no_group_session}` it means we received an `skmsg` before any seeding 1:1 SKDM. Send a retry receipt; the peer will redistribute (Go upstream does this automatically — we don't yet; see [§18](#18-whats-still-missing)).

### 7.3 Media

Each attachment in `msg.attachments` is also published as its own event so a downloader worker can handle them in isolation:

```elixir
def handle_info({:whatsmeow, %Whatsmeow.Types.Events.MediaMessage{descriptor: d, kind: kind}}, _)
    when kind in [:image, :video, :audio, :voice, :document, :sticker] do
  # `d` carries url, direct_path, media_key, file_sha256, file_enc_sha256, file_length.
  # `Whatsmeow.Media.Refresh.refresh/2` first to get a live media-conn:
  with {:ok, conn} <- Whatsmeow.Media.Refresh.refresh(session),
       {:ok, bytes} <- Whatsmeow.Media.Download.fetch_and_decrypt(d, media_conn: conn) do
    File.write!("/tmp/received-#{:erlang.unique_integer([:positive])}", bytes)
  end
end
```

### 7.4 Receipts

The Session sends `<ack>` for every inbound `<message>`, `<receipt>`, `<notification>`, `<call>` automatically — server-side resend stops. On successful decrypt of a `<message>`, it additionally sends `<receipt>` (the double-tick).

**Read receipts** (the blue check) are NOT sent automatically — the caller decides when. Build with `Whatsmeow.Receipt.build_delivery_receipt/1` and send via `Whatsmeow.Session.send_node/2`.

---

## 8. Sending messages

### 8.1 Text

```elixir
{:ok, message_id} =
  Whatsmeow.Send.send_text(session, "12025550101@s.whatsapp.net", "hello!")
```

The orchestration:

1. `Send.send_text/3` derives the WaE2E.Message bytes: `%Message{conversation: text}`.
2. Looks up the persisted Signal session for `(our_jid, peer_jid)` in `whatsmeow_sessions`.
3. **If found**: `Whatsmeow.Signal.WireEncrypt.encrypt_signal_envelope/4` produces a `<enc type="msg">` envelope and advances the session.
4. **If not found** (first contact): fetches the peer's pre-key bundle via `Session.send_iq` + `Whatsmeow.IQ.build_prekeys_get/2`, runs `X3DH.initiator_agree/5`, initialises a new initiator session, encrypts via `WireEncrypt.encrypt_prekey_envelope/5` → `<enc type="pkmsg">`.
5. Wraps with `Send.build_text_message_node/4` and submits via `Session.send_node/2`.
6. Persists the advanced session to Postgres.

You get back the message id for matching delivery receipts.

### 8.2 Image

```elixir
bytes = File.read!("/tmp/picture.jpg")
{:ok, conn} = Whatsmeow.Media.Refresh.refresh(session)
{:ok, _id} = Whatsmeow.Send.send_image(session, peer, bytes, media_conn: conn, caption: "look")
```

`send_video/4`, `send_audio/4`, `send_voice/4`, `send_document/4` follow the same shape. They take care of: `Whatsmeow.Media.Upload.upload/3` → AES-CBC + HMAC + POST → embed `(url, direct_path, media_key, file_sha256, …)` into the WaE2E proto → encrypt + frame as above.

For very large files, prefer `Whatsmeow.Media.Finch.stream_put/4` (streaming) — see `Whatsmeow.Media.Finch.@moduledoc`.

### 8.3 Outbound rate-limiting

WhatsApp will ban accounts that send too fast. Apply per-account token-bucket rate limiting **before** calling `send_text/3` — the library does not throttle for you. A typical pattern:

```elixir
defmodule MyApp.WAGate do
  use GenServer
  def cast(device_id, fun), do: GenServer.call(via(device_id), {:cast, fun}, :infinity)
  # token bucket: 1 msg / 1.5 s, burst 3, recover at 2/s
  # ...
end
```

### 8.4 Sending to groups (not yet wired)

Outbound `<enc type="skmsg">` works at the cipher layer (`Whatsmeow.Signal.GroupDecrypt.encrypt_envelope/2` produces signed wire envelopes), but the surrounding orchestration — member discovery via `<usync>`, SKDM fanout to every member device, single `<message>` framing with both `<enc type="skmsg">` and per-member `<enc>` SKDMs — isn't in `Whatsmeow.Send` yet. See [§18](#18-whats-still-missing).

---

## 9. Media (upload & download)

### 9.1 Upload pipeline

```elixir
{:ok, %{
  url: url,
  direct_path: direct_path,
  media_key: media_key,            # 32 bytes — pass with the proto
  file_sha256: file_sha256,
  file_enc_sha256: file_enc_sha256,
  file_length: file_length
}} = Whatsmeow.Media.Upload.upload(plaintext_bytes, :image, media_conn: conn)
```

Internally: `HKDF(media_key, "WhatsApp Image Keys", 112) → iv(16) || cipher_key(32) || mac_key(32) || sha256_seed(32)`. AES-256-CBC encrypt, HMAC-SHA256(mac_key, iv ‖ ciphertext) tail-10-bytes. POST `(iv ciphertext mac10)` to a CDN host from the media-conn list.

### 9.2 Download pipeline

```elixir
{:ok, plaintext} =
  Whatsmeow.Media.Download.fetch_and_decrypt(descriptor, media_conn: conn)
```

Walks the media-conn host list with retries, GETs (with `direct_path` if present), strips MAC, verifies HMAC, verifies SHA-256 of the encrypted body matches `file_enc_sha256`, AES-CBC decrypts, verifies plaintext SHA-256 matches `file_sha256`.

### 9.3 Conn refresh

`Whatsmeow.Media.Conn` caches the host list + auth token with TTL. `Whatsmeow.Media.Refresh.refresh/2` sends `<iq xmlns="w:m" type="set"><media_conn/></iq>` and parses the reply. Run lazily — the cache is per-session and clears on disconnect.

---

## 10. Groups

| Operation | Status | Notes |
|---|---|---|
| Receive group message (`<enc type="skmsg">`) | ✅ live | XEdDSA verify + chain advance + skipped-key cache + SKDM auto-seed |
| Group create (`<iq type="set"><create>`) | ✅ builder | `Whatsmeow.Group.build_create_iq/N`; live exchange untested |
| Participant add / remove / promote / demote | 🚧 builders | live exchange untested |
| Send group message | ❌ | cipher layer in (`GroupDecrypt.encrypt_envelope/2`); member-fanout orchestration TODO |
| Contact sync | ❌ | |

### 10.1 Receiving a group message

No special setup. The first inbound 1:1 message from a group member carries a SKDM inside its plaintext; `Whatsmeow.Signal.Decrypt.decrypt_message_node/3` auto-seeds the `whatsmeow_sender_keys` row. The next `<enc type="skmsg">` decrypts to a normal `%Events.Message{is_group: true, sender: %JID{}}`.

### 10.2 Building a group create IQ

```elixir
iq = Whatsmeow.Group.build_create_iq("subject", ["12025550101@s.whatsapp.net", "..."])
:ok = Whatsmeow.Session.send_node(session, iq)
```

The reply `<iq type="result">` is delivered to the caller via `Session.send_iq` correlation (see [§11.2](#112-iq-correlation)). Parsing the reply into a `%Group{}` struct is on you for now — `Whatsmeow.Types.Group` defines the shape.

---

## 11. Events & telemetry

### 11.1 PubSub events

`Whatsmeow` ships `Phoenix.PubSub` (the instance is named `Whatsmeow.PubSub` by default). Subscribe per-device:

```elixir
Whatsmeow.subscribe(device_id)
# ==  Phoenix.PubSub.subscribe(Whatsmeow.PubSub, "whatsmeow:device:" <> device_id)
```

You receive `{:whatsmeow, event_struct}` for any of:

| Event | Fired by | Carries |
|---|---|---|
| `Events.Connected` | Noise handshake finished | `:device_id` |
| `Events.QR` | `<iq><pair-device>` | `:code` (canonical payload string) |
| `Events.PairSuccess` | `<iq><pair-success>` after ack | `:jid`, `:lid`, `:business_name`, `:platform` |
| `Events.PairError` | malformed pair-success | `:reason` (atom), `:detail` |
| `Events.LoggedIn` | `<success>` after relogin | `:lid`, `:server_time_offset` |
| `Events.LoggedOut` | `<failure>` (account unlinked) | `:reason` |
| `Events.Disconnected` | TCP/WS lost | `:reason` |
| `Events.Message` | successful 1:1 or group decrypt | `:message`, `:info` |
| `Events.MediaMessage` | one per attachment | `:descriptor`, `:kind`, `:message`, `:info` |
| `Events.UndecryptableMessage` | decrypt failed | `:reason`, `:enc_type`, `:enc_version`, `:enc_payload`, `:info` |
| `Events.Receipt` | `<receipt>` from peer | `:type`, `:message_ids`, `:from` |
| `Events.Presence` | `<presence>` | (stub today) |
| `Events.GroupInfo` | `<notification>` group ops | (stub today) |
| `Events.CallEvent` | `<call>` | (decoder only) |
| `Events.Contact` | contact-changed notification | (stub today) |

**Per-device only by default.** Every broadcast goes to `"whatsmeow:device:<id>"`. The library also supports a global `"all"` firehose topic — **off by default at fleet scale**. To enable for tests / dashboards:

```elixir
config :whatsmeow_ex, Whatsmeow.Notifications, all_topic?: true

Whatsmeow.Notifications.subscribe_all()
# now receives every device's events
```

Never enable in tenant-facing production — one subscriber to that topic becomes a memory amplifier as the fleet grows.

### 11.2 IQ correlation

`Whatsmeow.Session.send_iq(session, node, timeout)` returns `{:ok, reply_node}` synchronously — internally it allocates an `id`, parks `{caller_pid, ref}` in the `pending` map, and waits for `<iq type="result" id={id}>` to arrive.

### 11.3 Telemetry events

`whatsmeow_ex` emits the following `:telemetry` events. Attach handlers in your boot code:

```elixir
:telemetry.attach_many(
  "wa-telemetry",
  [
    [:whatsmeow, :session, :connect, :start],
    [:whatsmeow, :session, :connect, :stop],
    [:whatsmeow, :session, :stream_error],
    [:whatsmeow, :session, :pair_success],
    [:whatsmeow, :session, :logged_in],
    [:whatsmeow, :session, :message_decrypted],
    [:whatsmeow, :session, :message_undecryptable]
  ],
  &MyApp.Telemetry.handle/4,
  nil
)
```

Each carries `measurements: %{system_time: ..., ...}` and `metadata: %{device_id, ...}`.

---

## 12. Multi-tenant & fleet operation

### 12.1 Proxy routing

Meta correlates IP addresses with stable account identifiers; a single IP opening hundreds of paired sessions will earn the IP a flag. Pin **one IP per tenant** (or per geographic region):

```elixir
{:ok, session} =
  Whatsmeow.start_session(
    device,
    transport: [proxy: "http://user:pass@residential-pool.example:8080"]
  )
```

Accepted forms (`Whatsmeow.Transport.WebSocket.Mint.parse_proxy/1`):

* `{host, port}`
* `{scheme, host, port}` — `scheme` is `:http` or `:https`
* `{scheme, host, port, opts}` — `opts` are forwarded to Mint
* `"http(s)://user:pass@host:port"` — URL form; userinfo becomes a `Proxy-Authorization: Basic …` header

SOCKS5 is not supported by Mint. Almost all residential-proxy providers offer HTTPS endpoints — use those.

Userinfo is **redacted** before logging (`http://***@host:port`).

### 12.2 Version pinning per IP-pool

The `client_revision` WhatsApp serves can differ per CDN PoP. For a single egress pool, the shipped `Whatsmeow.WAVersion.Refresher` (§3.2) handles refresh + jitter for you — just enable it in config.

For **multi-pool** fleets where different IP ranges may see different revisions, the bundled refresher is single-instance. Roll your own per pool, mirroring the shipped one's shape:

```elixir
defmodule MyApp.WAPoolVersioner do
  use GenServer

  def start_link(opts), do: GenServer.start_link(__MODULE__, opts, name: name(opts[:pool]))

  def init(opts) do
    send(self(), :refresh)
    {:ok, opts}
  end

  def handle_info(:refresh, opts) do
    _ = Whatsmeow.WAVersion.refresh(proxy: opts[:proxy])
    Process.send_after(self(), :refresh, :timer.minutes(60) + :rand.uniform(:timer.minutes(5)))
    {:noreply, opts}
  end

  defp name(pool), do: :"wa_version_#{pool}"
end
```

Note: the current `:persistent_term` cache is global. If pools genuinely diverge in revision, scope per-pool by including the proxy hash in your cache key (small follow-up on `Whatsmeow.WAVersion`).

### 12.3 Per-tenant device isolation

Each device runs in its own GenServer with private ETS for the Signal session cache. A crash in one session **cannot** corrupt another. Use `Process.alive?(pid)` + telemetry to surface unhealthy sessions to a dashboard.

### 12.4 Clustering

For >50K sessions per node, shard with `libcluster` + `Horde.Registry` (or migrate `Sessions.Registry` to `Horde.Registry`). The persistence layer is the source of truth — losing a node's BEAM ETS only loses the Signal-cache hot path, which is rebuilt lazily on first peer contact.

### 12.5 Operational telemetry to wire up

When Meta flags an account the visible signals are:

* `<stream:error code="…">` shortly after handshake → emit `[:whatsmeow, :session, :stream_error]` (already done; tag with proxy_id + tenant_id)
* `<failure>` IQ on outbound sends
* WSS close-without-goodbye

Aggregate `:stream_error` per `proxy_id`. A sudden spike from one pool = burnt IP range. Rotate the **pool**, not the accounts — re-pairing destroys peer trust.

### 12.6 Persona per tenant (UA fingerprinting)

Meta fingerprints on `ClientPayload.userAgent` and `DeviceProps.os`. Upstream Go ships `"whatsmeow"` as `DeviceProps.os`, which is a literal self-identifier in every registration payload. `whatsmeow_ex` replaces that with `Whatsmeow.ClientPayload.Persona` (Mac OS by default) and persists the resolved persona on `Device.persona` at pair time (§6.5).

Two patterns at fleet scale:

```elixir
# Pattern A — one persona for everything (simplest, fine for most fleets):
config :whatsmeow_ex, :persona, Whatsmeow.ClientPayload.Persona.mac_os()

# Pattern B — pick a persona per tenant at create_device time:
defp persona_for_tenant(%Tenant{region: "EU"}), do: %Persona{
  os: "Mac OS",
  os_version: {14, 4, 0},
  locale_language: "de",
  locale_country: "DE"
}

defp persona_for_tenant(_), do: Persona.mac_os()

# Stuff it into the Device before pair:
device = %Whatsmeow.Store.Schemas.Device{
  device | persona: Persona.to_map(persona_for_tenant(tenant))
}
```

The stamped value never changes after pair. To roll out a new persona for new tenants, change the config — existing devices keep theirs.

### 12.7 Cold-start jitter

When a node boots and brings 50k sessions out of `:idle`, every `Session.connect/1` cast would otherwise hit Meta's edge in the same ~10ms window. Spread them out:

```elixir
# config/runtime.exs
config :whatsmeow_ex, :cold_start_jitter_ms, 30_000
```

Now every fresh session defers its first connect by `:rand.uniform(30_000)` ms. 50k sessions distributed over 30 s = ~1700 connects/s mean, which is a reasonable rate to ask of Meta's edge and your egress IP pool. Tune up if your reconnect-storm SLA allows it; tune down if you want sessions online faster.

This only applies to the **first** connect after `start_link/1`. Reconnect cadence is governed by the existing exponential backoff with `±500 ms` jitter (§5.2) — that's tuned for reconnects, not cold-starts.

---

## 13. Cost model & capacity planning

### 13.1 Memory per session

Measured with `bench/session_memory.exs` at N=1000:

| Component | Footprint |
|---|---|
| GenServer process (heap + struct + supervisor accounting), `:idle` | **2.7 KB** (min/mean/p50/p95/max all 2.7 KB — very tight distribution) |
| Noise cipher state (after handshake) | < 1 KB |
| Mint WS conn + TLS socket buffers (after connect) | 16–32 KB |
| IQ pending map | < 1 KB typical |
| Process mailbox slack (transient, GCs back) | 5–20 KB during decode bursts |
| **Per idle authenticated session (steady state)** | **~20–40 KB** |
| **Per active-chat session (during burst)** | spikes to 100–300 KB, GCs back to ~40 KB |

Repro the bench yourself:

```bash
N=1000 mix run bench/session_memory.exs
```

Projection:

| Sessions | BEAM-only (sessions × 2.7 KB) | With TLS sockets (× ~25 KB) |
|---|---|---|
| 1 000 | ~3 MB | ~25 MB |
| 10 000 | ~27 MB | ~250 MB |
| 50 000 | ~135 MB | ~1.25 GB |
| 100 000 | ~270 MB | ~2.5 GB |

Budget **6–10 GB total BEAM heap** at 100k sessions to leave headroom for DB pool, Mint internals, group caches, retry cache, decode bursts, and GC slack.

Caveat: the bench is `:idle` sessions — no transport handshake. TLS state ships with Mint and `:ssl`. Production figures depend on `:ssl` cipher choice (AES-GCM is leaner) and OTP version. Validate on your runtime before sizing infra.

### 13.2 CPU

WhatsApp clients are mostly idle. Per-session steady-state CPU is dominated by:

* Keepalives: 100K × 1 frame / 30 s = ~3 300 frames/s aggregate — trivial.
* Inbound messages: assume 1 msg/sess/h avg → ~28 msgs/s. Each = ~1 HKDF + 1 AES-GCM-decrypt + 1 ratchet step ≈ ~200 µs on modern x86 → ~5.6 ms CPU/s total. Budget 10× burst headroom.

A 16-core box / 16–32 GB RAM / NVMe Postgres on a separate machine **should** comfortably hold 50K sessions. 100K with active conversations: 32 cores / 32–64 GB RAM, or shard across two smaller nodes. Bottleneck at scale is `Registry` contention (mitigated by partitioning — §4.1) and Postgres write fanout (§13.3), not memory.

### 13.3 Postgres

* Pre-keys: ~50–812 per device → up to 80 M rows for 100K accounts.
* Signal sessions: ~5 per device → 500K rows.
* Sender keys: highly variable; depends on group membership.
* AppState mutations: 10K+ for power users.

Provision a **dedicated Postgres** with 50–100 GB allocated, `pool_size: 50–100` per BEAM node. Replicate at the DB level; the device-row table is high-value (losing it destroys peer trust forever — see [§14.2](#142-the-single-most-damaging-mistake)).

### 13.4 Bandwidth

Steady-state per-session: ~30s keepalive of <1 KB → trivial. Message bursts: <2 KB. Media uploads/downloads are the expensive byte traffic — budget separately.

### 13.5 What this does NOT account for

* Meta's rate limits and behavioural fingerprinting. Apply per-account token-bucket rate limits at the `Whatsmeow.Send` layer.
* A burnt residential pool — once an IP range is flagged, no amount of careful sending rehabilitates it. Budget for periodic pool rotation.
* Account bans for automation patterns. Test with throwaway numbers; never send synthetic-looking traffic from real customer accounts.

---

## 14. Failure modes & recovery

### 14.1 `<stream:error code="500">` immediately after handshake

Two distinct causes — both manifest identically:

1. **Stale `client_revision`** — fix: ensure `Whatsmeow.WAVersion.refresh/1` ran recently for the right IP pool.
2. **Random bytes used as `signed_pre_key_sig`** — fix: `Whatsmeow.Crypto.XEdDSA.sign(identity_priv, <<5, spk_pub::binary>>)`. `Whatsmeow.Store.Postgres.new_device/1` does this automatically when no `signed_pre_key_sig` is supplied.

### 14.2 The single most damaging mistake

**Losing a paired device row.** Re-pairing destroys peer trust — every contact sees "security number changed". Treat encrypted device rows as high-value secrets, replicate them, snapshot Postgres regularly.

### 14.3 `bad_signature` on a `<enc type="skmsg">`

Means we have a `%GroupSession{}` row for `(chat, sender)` but with the wrong `signing_pub`. The peer rotated their sender key without re-distributing. Send a retry receipt; on receipt of the next SKDM the row is replaced.

### 14.4 `no_session` on a `<enc type="msg">`

Means the steady-state session was lost (Postgres row deleted, peer rotated identity). Reply with a retry receipt so the peer falls back to `<enc type="pkmsg">` (full X3DH).

### 14.5 Server-side ban detection signals

* Repeated `<stream:error 500>` from the same pool → IP burnt.
* `<failure reason="device_removed">` → user revoked the link. Mark the device unrecoverable.
* `<failure reason="bad_user_agent">` → version pin stale (rare).

---

## 15. Security model

### 15.1 Iron Laws (enforced across the codebase)

1. **No `String.to_atom/1` on wire data.** Atom exhaustion is a real DoS vector for protocol parsers. Every decoder pattern-matches strings.
2. **All `:erlang.binary_to_term/2` calls use `[:safe]`** — for persisted Signal sessions and group sessions, atom-exhaustion via a corrupt row is blocked at the runtime level.
3. **Repo writes use Ecto changesets with explicit casts** — no SQL string interpolation anywhere.
4. **TLS verify enabled by default** on the WSS upgrade (`Whatsmeow.Transport.WebSocket.Mint`).
5. **HTTP CONNECT proxy userinfo is redacted before logging.**
6. **Persona is stable per paired Device.** Set once at `pair_success`, never mutated. Rotating UA across reconnects for the same JID is a fingerprint signal on its own.
7. **Cold-start jitter must be set in production.** A 50k-fleet boot without `:cold_start_jitter_ms` will look identical to a coordinated reconnect-storm to Meta's edge.

### 15.2 What the library does NOT defend against

* **Compromised Postgres** — device rows include the identity private key. An attacker with read access can impersonate the device end-to-end. Encrypt at the column level if your threat model includes that.
* **Compromised BEAM node** — ditto for the process heap. Use disk encryption + node hardening.
* **Behavioral fingerprinting by Meta** — see [§12.5](#125-operational-telemetry-to-wire-up). The library will not pace your messages for you.
* **Cert chain MITM** — XEdDSA verify of the WA cert chain is off by default in `mix whatsmeow.smoke` until a known-good capture lands. The structural verifier is locked but the live signature path has not been smoke-tested end-to-end. Production: leave off; trust the TLS chain.

### 15.3 Key handling

* **Identity key** — never leaves the device row. Used for ADV signing (XEdDSA), MAC computation, X3DH.
* **Signed pre-key** — rotates on `WAVersion.refresh/0` boundary if the host application chooses. Currently no auto-rotation.
* **One-time pre-keys** — generated in batches of 50–812 by `Whatsmeow.PreKeys`, marked `uploaded: true` after `<iq type="set" xmlns="encrypt">` succeeds.
* **Signal session keys** — rotated by the Double Ratchet on every send / DH key exchange. Persisted compressed.
* **Sender key chain key** — rotated per group message. Skipped keys cached up to 2 000 iterations ahead.

---

## 16. Testing strategy

### 16.1 Unit tests (the 352)

```bash
mix test                          # ~2s, no DB needed
mix test --include integration    # requires Postgres
mix test test/whatsmeow/signal/   # one subtree
mix coveralls.html                # coverage report
```

The crypto-critical surfaces are locked by tests against RFC vectors:

| Surface | Vector source |
|---|---|
| X25519 | RFC 7748 §6.1 Alice/Bob |
| HKDF-SHA256 | RFC 5869 cases 1, 2, 3 |
| ChaCha20-Poly1305 | RFC 7539 §2.8.2 |
| AES-256-GCM | NIST SP 800-38D Test Case 16 |
| XEdDSA sign/verify | 100-iter property cross-validated by stdlib `:crypto.verify(:eddsa)` |

Round-trip + property tests:

* Binary XML codec — StreamData random trees
* Noise XX handshake — Alice + Bob derive same key
* Signal Ratchet KDF determinism
* 1:1 encrypt → decrypt (round-trip + out-of-order via skipped-key cache, found a real counter-increment bug during port)
* Group SenderKey encrypt → decrypt + signature tamper + replay rejection + out-of-order
* Media upload→download × 5 types + tamper detection
* LTHash homomorphic + commutativity + wrap-at-2^16
* AppState Encode→Decode + tampered-ciphertext rejection
* Argo varint + self-describing nested encode/decode
* Armadillo envelope marshal/unmarshal + FB/IG version routing

### 16.2 Live smoke (manual)

```bash
# First time: scan with your phone:
mix whatsmeow.smoke --persist --relogin

# Subsequent runs: no QR, just connect + listen:
mix whatsmeow.smoke --load-jid 12025550100:1@s.whatsapp.net --persist --relogin
```

Listen mode auto-pings, surfaces every inbound `<message>`, attempts decrypt against the persisted Signal session, and pretty-prints the decoded WaE2E.Message. See `lib/mix/tasks/whatsmeow.smoke.ex` for the playbook.

### 16.3 The CI gap

Not in CI:

* Any test that talks to `web.whatsapp.com` (use `mix whatsmeow.smoke`)
* Postgres integration tests requiring a running DB (gated behind `:integration`)
* A `signal-cli` cross-validator (planned)
* A multi-day soak test (the `v1.0.0-rc` gate)

### 16.4 Recommended bring-up before going live

1. Pair one sandbox account; verify pair → success → keepalive holds for 1 h.
2. Send 100 messages to a peer; verify all delivery receipts arrive < 10 s.
3. Restart the BEAM node; verify session resumes without re-pair.
4. Crash the session GenServer manually (`Process.exit(pid, :kill)`); verify supervisor restart + Postgres-driven recovery + first message decrypts.
5. Kill Postgres for 30 s; verify session backoff/retry survives, sessions resume.

---

## 17. Comparison with Go upstream

| Aspect | Go `whatsmeow` | `whatsmeow_ex` |
|---|---|---|
| Process model | one `*Client` per device, goroutines internally | one `GenServer` per device, supervised |
| Signal | `go.mau.fi/libsignal` | pure-Elixir Double Ratchet + X3DH + SenderKey + GroupCipher (re-implemented from spec) |
| Persistence | pluggable; default sqlite | pluggable behaviour; default Ecto/Postgres |
| Crypto | stdlib `crypto/*` | Erlang `:crypto` + pure-Elixir Ed25519 (XEdDSA) |
| Transport | `gorilla/websocket` | `mint_web_socket` |
| Protobuf | `google.golang.org/protobuf` | `:protobuf` (hex) |
| Eventing | callback channels | `Phoenix.PubSub` topics |
| Process isolation | shared goroutines; panic = process death | crash-restart per device for free |
| QR rendering | `mdp/qrterminal` | pure-Elixir `:qqr` |
| Live status | production-ready | pair + login + receive + send + group receive ✅; outbound group send + dialyzer clean + hex publish pending |

The Elixir version benefits from BEAM process isolation — a bug in session 47 cannot crash session 48. Where Go ships outbound group send today, Elixir does not yet (see [§18](#18-whats-still-missing)).

---

## 18. What's still missing

Relative to upstream Go:

1. **Outbound group send** (`<enc type="skmsg">` emit + SKDM fanout to every member device + `<usync>` device discovery). The cipher layer is in (`GroupDecrypt.encrypt_envelope/2`); the `Whatsmeow.Send.send_text_to_group/3` orchestration is not.
2. **Live group create / participant management / invite** — IQ builders exist; live exchange isn't tested.
3. **History sync replay** — codec is in (`Whatsmeow.AppState.{Decode, Encode, Recovery}`); the trigger for a 5 000+ patch first-sync isn't.
4. **Newsletter live ops** — subscribe IQ builder exists; no end-to-end test.
5. **Call IQ end-to-end** — decoder only.
6. **WhatsApp Business catalog / order** — not started.
7. **Pair-code (phone-number, not QR) flow** — `Whatsmeow.PairCode` builder exists; live IQ exchange not wired.
8. **Cross-device sync via app-state patches** — codec done, triggers not.
9. **`signal-cli` cross-validator in CI** — planned, not implemented.
10. **Smoke task auto-reconnect** — the tool exits when the server rotates the connection; the supervised GenServer does the right thing automatically.
11. **`mix dialyzer` clean** — ~100 modules; hours of `@spec` polish.
12. **Retry receipt on `:no_group_session`** — server-side retry-receipt protocol that triggers a peer-side SKDM redistribution.

---

## 19. Verification: this really is pure Elixir

Run this in the repo root and confirm zero hits:

```bash
grep -rE ':erlang\.(nif|load_nif)|@on_load|Rustler|Port\.open' lib/ --include="*.ex"
```

The only `System.cmd` in the tree is build-time `mix whatsmeow.protoc` — it shells to `protoc` to **generate** sources at build time. There is no runtime NIF, port, or external native dependency.

All cryptography uses Erlang's stdlib `:crypto` (`crypto_one_time_aead`, `crypto_one_time`, `mac`, `hash`, `strong_rand_bytes`, `compute_key/4`, `generate_key/3`, `sign/5`, `verify/5`). Ed25519 point arithmetic for XEdDSA signing is in `Whatsmeow.Crypto.Ed25519` (~170 LOC of pure-Elixir twisted-Edwards math, cross-validated by 100-iter property test against `:crypto.verify(:eddsa)`).

QR rendering is `:qqr` (pure Elixir). WebSocket transport is `:mint_web_socket` (pure Elixir on top of `:mint` / `:ssl`).

This is a deliberate constraint, not an accident — it makes the library trivial to deploy (no compiled artefacts, no NIF mismatch with the BEAM ABI, no `:erlang.load_nif/2` failures on Alpine, no Rust toolchain in your Dockerfile).
