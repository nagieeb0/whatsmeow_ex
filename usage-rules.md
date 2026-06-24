# `whatsmeow_ex` — Usage Rules

Pure-Elixir port of `whatsmeow` for WhatsApp. These rules tell an AI assistant (or a new contributor) how to *use* the library correctly. For deep operator concerns see [`GUIDE.md`](GUIDE.md). For implementation status see [`plan.md`](plan.md).

> **Read first:** every rule below is grounded in code that exists today. Verify the file path or function before recommending it — these rules are a contract for *current* shape, not a wishlist.

---

## 1. Quick-reference public API

| Need | Module/function | Returns |
|---|---|---|
| Subscribe to a device's events | `Whatsmeow.subscribe(device_id)` | `:ok` |
| Find or create a Device row | `Whatsmeow.Store.find_or_new_device(client_id: id)` | `{:ok, %Device{}}` |
| Spawn the per-device GenServer | `Whatsmeow.start_session(device)` | `{:ok, pid}` |
| Look up an existing session | `Whatsmeow.Session.whereis(device_id)` | `pid \| :undefined` |
| Connect (cast) | `Whatsmeow.Session.connect(session)` | `:ok` |
| Send a 1:1 text | `Whatsmeow.Send.send_text(session, peer_jid, body)` | `{:ok, message_id}` |
| Send media | `Whatsmeow.Send.{send_image,send_video,send_audio,send_voice,send_document}/4` | `{:ok, message_id}` |
| Synchronous IQ | `Whatsmeow.Session.send_iq(session, node, timeout)` | `{:ok, reply_node}` |
| Send a raw Node | `Whatsmeow.Session.send_node(session, node)` | `:ok` |
| Stop a session | `Whatsmeow.stop_session(session)` | `:ok` |
| Force WA-version scrape | `Whatsmeow.WAVersion.refresh(proxy: …)` | `{:ok, {2, 3000, n}}` |
| Read cached version | `Whatsmeow.WAVersion.cached()` | `{2, 3000, n}` |
| Render QR for the user | `Whatsmeow.QRChannel.render_svg/1` or `render_terminal/1` | string |

The receiving side is **event-driven**: subscribe with `Whatsmeow.subscribe/1` and pattern-match `{:whatsmeow, %Events.Foo{}}` in your consumer's `handle_info/2`. The library never calls back into your code synchronously.

---

## 2. Required setup (do these once)

1. **Migration:** `mix ecto.migrate` — runs the 18 migrations under `priv/repo/migrations/` (17-table schema + persona JSONB on `whatsmeow_device`).
2. **Finch:** start a `Finch` named `Whatsmeow.Finch` in your supervision tree (the media pipeline reuses it).
3. **WAVersion refresh:** boot-time scrape OR enable the periodic refresher — never both, never per-session:

   ```elixir
   # Boot-time one-shot:
   {:ok, _} = Whatsmeow.WAVersion.refresh()

   # Or periodic (recommended for long-running processes):
   config :whatsmeow_ex, Whatsmeow.WAVersion.Refresher,
     enabled?: true,
     interval_ms: :timer.hours(1)
   ```
4. **Cold-start jitter** (production only): `config :whatsmeow_ex, :cold_start_jitter_ms, 30_000` before bringing 1000+ sessions out of `:idle`.

---

## 2.5 Performance — what the library does for you (and what it expects you to *not* do)

The 2026-05-19 perf pass made these guarantees. The rules in §3/§4 below pre-date that pass; this section is the **specific** advice for using the new behavior.

* **Fanout is already parallel.** `Whatsmeow.Send.send_text/3`, `send_image/4` (and friends), `Whatsmeow.Send.Group.send_text/4`, and `Whatsmeow.Send.send_peer_message/2` all use `Task.async_stream` with `:send_concurrency` (default 8). **You don't need to wrap calls in your own `Task.async`** — that adds pool pressure without throughput.
* **Broadcasts are synchronous AND ordered.** Inbound `%Events.Message{}`, `%Events.MediaMessage{}`, `%Events.Receipt{}`, `%Events.UndecryptableMessage{}` are emitted from the session GenServer's pid via `Phoenix.PubSub.broadcast/3`. Same-session messages arrive at a subscriber in **wire order** because Erlang's `send/2` is FIFO from a single sender. This matters for agent frameworks (Jido, etc.) that update state per-message — your `handle_info/2` clauses see events in the order WhatsApp sent them.
  * `Notifications.broadcast_async/2` exists but **does NOT preserve order** (verified — see `bench/recv_path.exs`). Don't call it on the inbound path.
* **Media downloads share an HKDF cache.** `Whatsmeow.Media.HKDFCache` is supervised; entries time out 5 min after their last use. Multiple downloads of the same `media_key` reuse the 112-byte expansion. **DO NOT** add a competing cache layer — `:erlang.binary_to_term` on a session blob is the only repeated heavy crypto path left, and it is intentionally not cached cross-message.
* **Initial pairing's 812 prekeys ship in one transaction.** `Whatsmeow.PreKeys.upload/2` (called by the post-login bootstrap) batches `Repo.insert_all` in chunks of 200. **DO NOT** wrap it in your own transaction — the chunking is designed to stay under Postgres's parameter limit by itself.
* **Tune fanout when you genuinely need it.** Default `:send_concurrency` is 8 — conservative for small VMs. If your typical group is >100 participants AND the box is multi-core, set to `System.schedulers_online()`:

  ```elixir
  config :whatsmeow_ex,
    send_concurrency: System.schedulers_online(),
    fanout_task_timeout_ms: 60_000
  ```
* **Run the perf-indexes migration on upgrade.** `priv/repo/migrations/20260519000001_perf_indexes.exs`. Without it, app-state patch apply and contact reverse-lookups full-scan.
* **The retry-count ETS table self-sweeps.** Hourly sweep drops rows older than 24 h. Logs at `:debug` only when there's anything to drop. Don't touch `:whatsmeow_message_retries` from the host app — it's a private cache.
* **`skipped_keys` on group sessions is capped at 500.** The 2000-iteration jump tolerance still applies, but only the most-recent 500 keys are retained. Don't assume an out-of-order message older than ~500 iterations will still decrypt.

---

## 3. DOs

* **DO subscribe per-device.** `Whatsmeow.subscribe(device_id)` parks you on the per-device PubSub topic. Match `{:whatsmeow, %Events.Message{} = msg}` etc. in `handle_info/2`.
* **DO let the supervisor restart sessions.** `Whatsmeow.start_session/1` registers under `Whatsmeow.Sessions.Registry` and supervises under `Whatsmeow.Sessions.Supervisor` (DynamicSupervisor). On crash, the device row is the source of truth — recovery is automatic.
* **DO call `Whatsmeow.WAVersion.refresh/1` once per IP-pool, not per session.** Use the bundled `Whatsmeow.WAVersion.Refresher` (§3.2 in GUIDE.md) or roll your own per-pool versioner.
* **DO set a persona before pair time** if you want anything other than the macOS default. `config :whatsmeow_ex, :persona, Whatsmeow.ClientPayload.Persona.windows()` etc.
* **DO use `Whatsmeow.Session.send_iq/3`** when you need a synchronous reply. The session correlates `<iq>` request ids automatically and parks the caller until the reply arrives or `timeout` ms elapse.
* **DO rate-limit outbound `send_text`/`send_*` per-account.** The library does NOT throttle for you — apply a token bucket in front of `Whatsmeow.Send` (rule of thumb: 1 msg / 1.5 s, burst 3).
* **DO use the proxy spec for per-tenant egress isolation:** `Whatsmeow.start_session(device, transport: [proxy: "http://user:pass@host:8080"])`. Accepts `{host, port}`, `{scheme, host, port}`, `{scheme, host, port, opts}`, or URL strings.
* **DO acknowledge events promptly.** The library `<ack>`s inbound `<message>`/`<receipt>`/`<notification>`/`<call>` automatically. Your consumer just decides what to *do* with the broadcast.
* **DO check `whereis/1` before sending** if the session may have crashed: `case Whatsmeow.Session.whereis(device_id) do pid when is_pid(pid) -> Whatsmeow.Send.send_text(pid, …) end`.
* **DO listen for `%Events.UndecryptableMessage{}`** as a first-class signal. It carries a typed `reason` atom (`:no_session`, `:bad_signature`, `:mac_mismatch`, `:bad_padding`, `:no_group_session`). Issue a retry receipt or log per `reason`.
* **DO read media on a separate worker.** `Whatsmeow.Media.Download.fetch_and_decrypt/2` is blocking and disk-heavy — never call it in the same process that decodes Session events.

---

## 4. DON'Ts

* **DON'T call `Whatsmeow.WAVersion.refresh/1` per session.** It scrapes `web.whatsapp.com` over HTTPS — at scale you'll get rate-limited or burn an IP. One refresher per pool.
* **DON'T enable `Whatsmeow.Notifications` `all_topic?: true` in production.** It's a global firehose; one subscriber becomes a bottleneck at fleet scale. Per-device subscribe is what you want 99% of the time.
* **DON'T mutate `Device.persona` after pair.** Rotating UA across reconnects for the same JID is a fingerprint signal. To change personas, re-pair (and accept the peer-trust loss).
* **DON'T persist `Whatsmeow.Session` state to disk.** Only the `whatsmeow_device` row + `whatsmeow_sessions` (Signal session) + `whatsmeow_sender_keys` (group state) + `whatsmeow_identity_keys` rows are persistent. Everything else lives in the GenServer.
* **DON'T pre-bundle a `Phoenix.PubSub` instance under the name `Whatsmeow.PubSub` unless you mean it.** If you want to share your app's PubSub, set `config :whatsmeow_ex, :pubsub, MyApp.PubSub` — don't reuse the name.
* **DON'T use `String.to_atom/1` on wire data anywhere downstream.** Atom-exhaustion is a DoS vector. The library follows this rule internally; your consumer must too.
* **DON'T use `Phoenix.HTML.raw/1` on arbitrary fields from inbound `%Events.Message{}`**. Treat `msg.body` and `msg.raw` as untrusted strings. Only `Whatsmeow.QRChannel.render_svg/1` is pre-sanitised for `raw/1`.
* **DON'T re-pair a working device.** The single most damaging operational mistake. Every contact sees "security number changed" and you've destroyed peer trust forever. Treat the `whatsmeow_device` row like a private key.
* **DON'T retry on `<failure>`** with `auto_reconnect?` left on. The Session already flips it off — overriding it = ban risk.
* **DON'T modify the `whatsmeow_*` schema modules directly.** They're 1:1 with the migration. If you need adjacent state, add a new table in your app's repo.

---

## 5. Event lifecycle — what to expect, in order

For a **first-ever pair**:

```
{:whatsmeow, %Events.Connected{}}        # Noise handshake done
{:whatsmeow, %Events.QR{code: "..."}}    # render to user, wait for scan
{:whatsmeow, %Events.PairSuccess{jid}}   # server's pair-success processed
# (server closes WSS; library auto-reconnects with login_payload)
{:whatsmeow, %Events.Connected{}}        # second handshake
{:whatsmeow, %Events.LoggedIn{lid, dt}}  # paired-and-authenticated
# (post-login bootstrap: PreKeys.upload runs in a Task)
{:whatsmeow, %Events.Message{} | %Events.MediaMessage{} | …}
```

For a **subsequent reconnect** (a previously-paired Device row loaded from disk):

```
{:whatsmeow, %Events.Connected{}}
{:whatsmeow, %Events.LoggedIn{lid, dt}}
{:whatsmeow, %Events.Message{} | …}
```

For a **failure path**:

```
{:whatsmeow, %Events.LoggedOut{reason}}      # account unlinked, reason atom
# OR
{:whatsmeow, %Events.Disconnected{reason}}   # transport lost, will reconnect
```

`%Events.PairError{reason, detail}` fires if `<pair-success>` is malformed (HMAC mismatch, bad signature, etc.). Treat as terminal for that pairing attempt.

---

## 6. Common patterns

### 6.1 Send-on-receive bot

```elixir
def handle_info({:whatsmeow, %Events.Message{message: %{body: body}, info: info}}, state) do
  if not info.is_from_me and body do
    {:ok, _id} = Whatsmeow.Send.send_text(state.session, info.from, "echo: #{body}")
  end
  {:noreply, state}
end
```

### 6.2 Fetch a peer's pre-key bundle synchronously

```elixir
iq = Whatsmeow.IQ.build_prekeys_get(
  Whatsmeow.IQ.generate_id(),
  [peer_jid]
)
{:ok, reply} = Whatsmeow.Session.send_iq(session, iq, 10_000)
{:ok, [bundle]} = Whatsmeow.PreKeyBundle.from_iq(reply)
```

### 6.3 Download media from a `%Events.MediaMessage{}`

```elixir
def handle_info({:whatsmeow, %Events.MediaMessage{descriptor: d, kind: :image}}, %{session: s} = st) do
  Task.Supervisor.start_child(MyApp.MediaTaskSup, fn ->
    with {:ok, conn} <- Whatsmeow.Media.Refresh.refresh(s),
         {:ok, bytes} <- Whatsmeow.Media.Download.fetch_and_decrypt(d, media_conn: conn) do
      File.write!(out_path(d), bytes)
    end
  end)
  {:noreply, st}
end
```

### 6.4 Per-tenant persona at pair time

```elixir
# Set the configured default for the pool:
config :whatsmeow_ex, :persona, Whatsmeow.ClientPayload.Persona.linux()

# Or override per-device before pair:
device = Whatsmeow.Store.find_or_new_device!(client_id: tenant_id)
device = %{device | persona: Whatsmeow.ClientPayload.Persona.to_map(persona_for(tenant))}
{:ok, _} = Whatsmeow.Store.persist_device(device)
{:ok, session} = Whatsmeow.start_session(device)
```

### 6.5 Graceful pause for outbound rate limiting

```elixir
defmodule MyApp.WAGate do
  use GenServer
  # token bucket: 1 msg / 1.5 s, burst 3
  def send_text(device_id, peer, body) do
    GenServer.call(via(device_id), {:send, peer, body}, :infinity)
  end

  def handle_call({:send, peer, body}, _from, state) do
    state = wait_for_token(state)
    pid = Whatsmeow.Session.whereis(state.device_id)
    {:reply, Whatsmeow.Send.send_text(pid, peer, body), consume_token(state)}
  end
end
```

---

## 7. Anti-patterns (will hurt you in production)

### Anti-pattern A: per-session WAVersion refresh

```elixir
# DON'T:
def init(opts) do
  Whatsmeow.WAVersion.refresh()  # ← scrapes web.whatsapp.com on every session boot
  {:ok, opts}
end
```

Scrapes `web.whatsapp.com` from every BEAM process. At 50k sessions = 50k HTTPS requests on cold boot, all hitting the same IP. Use `Whatsmeow.WAVersion.Refresher` once per pool.

### Anti-pattern B: cold-start without jitter

```elixir
# DON'T (when starting 1000+ sessions):
for device <- devices do
  {:ok, session} = Whatsmeow.start_session(device)
  Whatsmeow.Session.connect(session)  # ← all hit Meta's edge in the same ms
end
```

Set `:cold_start_jitter_ms` and the library spreads the storm for you. With jitter unset, you're indistinguishable from a botnet.

### Anti-pattern C: subscribing to `all_topic`

```elixir
# DON'T at scale:
Whatsmeow.Notifications.subscribe_all()
```

One subscriber inflates your mailbox by `fleet_size × event_rate`. At 50k sessions and 1 event/s, that's a 50k-msg/s mailbox on one process. Subscribe per-device.

### Anti-pattern D: synchronous send loop

```elixir
# DON'T:
Enum.each(peers, fn p -> Whatsmeow.Send.send_text(session, p, "hi") end)
```

Each `send_text` does X3DH lookup, ratchet step, Postgres write, IQ correlation. **The per-device fanout INSIDE one `send_text/3` is already parallelised** (`Task.async_stream` with `:send_concurrency`); what is NOT parallelised — and never should be — is sending to **different peers** from a hot loop. That looks bot-like to Meta no matter how fast it is. Use a token-bucketed gate (§6.5) and let it pace you.

### Anti-pattern D2: wrapping `send_text` in your own Task

```elixir
# DON'T:
Enum.each(devices, fn d -> Task.async(fn -> Whatsmeow.Send.send_text(session, d, "hi") end) end)
```

The library already runs the per-device-encrypt fanout under `Task.async_stream` internally. Adding an outer `Task.async` per device just shifts work to a different pool — the session's GenServer is still the single writer for the WSS, and you've now spawned 2× as many processes for no win. Trust the library's concurrency; tune `:send_concurrency` instead.

### Anti-pattern E: trusting `:ets` for durable state

```elixir
# DON'T assume:
data = :ets.lookup(:my_session_cache, peer_jid)  # ← lost on session crash
```

The Sessions.Registry is ETS-backed and ephemeral. Signal session state is Postgres-backed and persistent. Anything you want to survive a Session restart goes through `Whatsmeow.Signal.Store.Postgres` or your own Repo table.

### Anti-pattern F: mutating persona post-pair

```elixir
# DON'T:
Whatsmeow.Repo.update_all(Device, set: [persona: new_persona])
```

The persona is the device's fingerprint to Meta. Changing it across reconnects looks more suspicious than a stale persona. To migrate, accept the peer-trust loss and re-pair.

---

## 8. Iron Laws (enforced in the codebase; your code must match)

1. **No `String.to_atom/1` on wire data.** Atom-exhaustion is a real DoS surface.
2. **Use `[:safe]` with `:erlang.binary_to_term/2`** when reading persisted Signal state. The library does this internally; if you copy the pattern, copy the flag.
3. **Ecto changesets for all writes.** Never string-interpolate SQL.
4. **TLS verify on by default.** If you override `transport_opts` in `start_session/2`, keep `verify: :verify_peer`.
5. **Redact proxy userinfo before logging.** `Whatsmeow.Transport.WebSocket.Mint.parse_proxy/1` already does this for you — don't unwrap and log.
6. **Persona is stable per Device.** Set at pair; never change.
7. **Cold-start jitter required at fleet scale.** Production config must include `:cold_start_jitter_ms`.
8. **Hot-path broadcasts stay synchronous from the session pid.** Per-subscriber FIFO ordering relies on this — don't wrap broadcasts in `Task.async`/`Task.Supervisor` or call `broadcast_async/2` on inbound events. Benchmark on this codebase showed broadcast is ~1 µs/sub and `send/2` is non-blocking, so the cost was never the issue people expected.
9. **Per-fanout work goes through `Task.async_stream`, not `Enum.each`.** The library follows this for DM-multi-device, group SKDM, peer-message, and prekey-gen. Any new per-recipient pipeline you add inside the library MUST use the same pattern with `Whatsmeow.Config.send_concurrency/0`.
10. **Use `Repo.insert_all` for bulk writes >50 rows.** Per-row `Repo.insert/2` was the cause of the 800 ms initial-pairing stall; the rule applies to any future bulk path too. Chunk at ≤200 rows × ≤4 cols to stay under the 65 535-parameter Postgres limit.

---

## 9. Operational signals you must wire up

Attach these telemetry events in your boot code:

```elixir
:telemetry.attach_many("wa-telemetry", [
  [:whatsmeow, :session, :connect, :start],
  [:whatsmeow, :session, :connect, :stop],
  [:whatsmeow, :session, :stream_error],
  [:whatsmeow, :session, :pair_success],
  [:whatsmeow, :session, :logged_in],
  [:whatsmeow, :session, :message_decrypted],
  [:whatsmeow, :session, :message_undecryptable]
], &MyApp.Telemetry.handle/4, nil)
```

**The single signal you must alert on:** `[:whatsmeow, :session, :stream_error]` rate, grouped by `metadata.proxy_id` or tenant. A spike from one pool = burnt IP range. Rotate the **pool**, not the accounts — re-pairing destroys peer trust.

---

## 10. When in doubt

* **Where does X persist?** Read `priv/repo/migrations/20260101000001_create_whatsmeow_schema.exs` — 17 tables, all schema there.
* **Does the library send Y automatically?** Grep `lib/whatsmeow/session.ex` for `send_node` or `Notifications.broadcast` — every wire-side and event-side emission is in one file.
* **What's a real production smoke?** `mix whatsmeow.smoke --load-jid <JID> --persist --relogin` — pairs OR reuses a paired device, reconnects with `login_payload`, holds the WSS, decrypts every inbound message. The fastest "is it working" check.
* **Is this safe at 50k accounts?** Run `N=1000 mix run bench/session_memory.exs` first. If the per-session memory has drifted from ~2.7 KB, something has been added to the Session struct — investigate before scaling.

If the rule above conflicts with the current code, the code wins — file an issue or update this document. These rules are a contract for the shape of the library as of `2026-05-19 / 542 tests / post perf pass`.
