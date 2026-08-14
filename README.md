# whatsmeow_ex

Pure-Elixir port of the [whatsmeow](https://github.com/tulir/whatsmeow) Go library — a multi-device WhatsApp Web client.

[![CI](https://github.com/nagieeb/whatsmeow_ex/actions/workflows/ci.yml/badge.svg)](https://github.com/nagieeb/whatsmeow_ex/actions)
[![Hex.pm](https://img.shields.io/hexpm/v/whatsmeow_ex.svg)](https://hex.pm/packages/whatsmeow_ex)

> **Status:** API surfaces compiling, cryptographically critical paths covered by RFC-vector and round-trip tests. Live wire pairing depends on protoc-generated modules (Phase 3) — see `plan.md`.

## Design

- **Pure Elixir/Erlang.** No Rust/C NIFs — only Erlang's stdlib `:crypto`.
- **One `Whatsmeow.Session` GenServer per paired device** owns the WebSocket, Noise cipher state, Signal session cache (ETS), retry timers (`Process.send_after`), and reconnect backoff.
- **Pure-Elixir Signal protocol** — Double Ratchet + X3DH + SenderKey, no `libsignal` dependency.
- **Ecto + Postgres** for persistence — 17 tables, 16 schemas, one migration.
- **`Phoenix.PubSub`** publishes `{:whatsmeow, event_struct}` to per-device topics or the global `"all"` topic.

## Architecture in one page

```
┌─────────────────────────────────┐
│   Whatsmeow.Sessions.Supervisor │  (DynamicSupervisor)
└──────────────┬──────────────────┘
               │ one per device
               ▼
┌─────────────────────────────────┐
│  Whatsmeow.Session   (GenServer)│
│  • Noise XX state               │
│  • Mint WebSocket conn          │
│  • Signal.SessionCache (ETS)    │
│  • IQ pending map               │
│  • PairCode/QRChannel handler   │
└────┬─────────────────────┬──────┘
     │                     │
     ▼                     ▼
 Phoenix.PubSub        Whatsmeow.Repo
 (events fan-out)      (Postgres)
```

## Installation

```elixir
def deps do
  [
    {:whatsmeow_ex, "~> 0.1.0"}
  ]
end
```

Then run the one-shot installer in your host app (Phoenix, Ash, or Jido — same flow for all three):

```bash
mix deps.get
mix whatsmeow_ex.install
mix ecto.create -r Whatsmeow.Repo
mix ecto.migrate -r Whatsmeow.Repo
```

`mix whatsmeow_ex.install` is idempotent and:

- creates `config/whatsmeow.exs` with `Whatsmeow.Repo` defaults and `import_config`s it from your `config/config.exs`,
- adds a `config_env() == :prod` block to `config/runtime.exs` that reads `DATABASE_URL` (or pass `--separate-db` to use `WHATSMEOW_DATABASE_URL` for an isolated DB),
- prints the `aliases/0` snippet to paste so `mix ecto.migrate` / `mix ecto.reset` include `-r Whatsmeow.Repo` automatically.

No supervision-tree edits — `Whatsmeow.Application` self-starts because `:whatsmeow_ex` is listed in its `extra_applications`. That brings up `Whatsmeow.Repo`, `Whatsmeow.PubSub`, `Whatsmeow.Sessions.Supervisor`, the Finch pool, and `Whatsmeow.WAVersion.Refresher` for you.

### Sharing the host's Repo instead of running ours

If you'd rather keep WhatsApp tables inside your host's own Repo (single DB, single connection pool):

```bash
mix whatsmeow_ex.gen.migrations           # copies migrations into priv/repo/migrations/
# edit config/whatsmeow.exs → start_repo?: false
mix ecto.migrate                          # uses your host Repo
```

The generator timestamps fresh migration filenames and rewrites the module namespace to `<HostApp>.Repo.Migrations.*`.

### Ash / Jido integration

The library does not (yet) ship Ash resources or Jido agents. Use the plain Elixir API:

- **Inbound events** — `Whatsmeow.Notifications.subscribe(:all)` then handle `{:whatsmeow, %Whatsmeow.Events.Message{}}` etc. in your `GenServer` / `Ash.Notifier` / `Jido.Agent`.
- **Outbound** — `Whatsmeow.Send.send_text(jid, "hello", opts)`, `Whatsmeow.Send.send_media/3`, `Whatsmeow.Group.*`.

## Quick start

```elixir
# 1. Create or load a device.
{:ok, device} = Whatsmeow.Store.new_device(client_id: "user-42")

# 2. Start the session GenServer.
{:ok, pid} = Whatsmeow.start_session(device)

# 3. Subscribe to events for this device.
:ok = Whatsmeow.Notifications.subscribe(device.id)

# 4. Receive the QR payload from the first event.
receive do
  {:whatsmeow, %Whatsmeow.Types.Events.QR{code: code}} ->
    IO.puts("Scan this with WhatsApp mobile app:")
    IO.puts(Whatsmeow.QRChannel.render_terminal(code))
end

# 5. After scanning:
receive do
  {:whatsmeow, %Whatsmeow.Types.Events.PairSuccess{jid: jid}} ->
    IO.puts("Paired as #{jid}")
end

# 6. Send messages.
:ok = Whatsmeow.send_text(pid, "1234567890@s.whatsapp.net", "hello")
```

## Sending

One generic entry point; `Whatsmeow.Content` builds the payloads.

```elixir
# Text, media
{:ok, id} = Whatsmeow.send_text(pid, peer, "hello")
{:ok, id} = Whatsmeow.send_image(pid, peer, bytes, media_conn: conn, caption: "hi")
{:ok, id} = Whatsmeow.send_sticker(pid, peer, webp_bytes, media_conn: conn)

# Acting on a previous message
{:ok, _} = Whatsmeow.send_reaction(pid, chat, sender, msg_id, "👍")
{:ok, _} = Whatsmeow.send_edit(pid, chat, msg_id, "fixed typo")
{:ok, _} = Whatsmeow.send_revoke(pid, chat, nil, msg_id)

# Everything else — build a payload, then send it
alias Whatsmeow.Content

{:ok, _} = Whatsmeow.send_message(pid, peer, Content.location(30.0444, 31.2357, name: "Cairo"))
{:ok, _} = Whatsmeow.send_message(pid, peer, Content.contact("Ahmed", Content.vcard("Ahmed", "201001234567")))
{:ok, _} = Whatsmeow.send_message(pid, peer, Content.pin(chat, nil, msg_id, 604_800))

# Other builders: link_preview/3, group_invite/5, unpin/3, keep/3, unkeep/3,
# event/3, live_location/4, contacts/2, album/2

# Voting needs the poll's secret, so it goes through the session
{:ok, _} = Whatsmeow.send_poll_vote(pid, %{chat: chat, sender: sender, id: poll_id}, ["Yes"])

# Composable wrappers — chain in any order
Content.text("look")
|> Content.reply(quoted_key, quoted)
|> Content.mention([jid])
|> Content.view_once()
|> then(&Whatsmeow.send_message(pid, peer, &1))

# Media can't be composed beforehand (the payload only exists after the upload),
# so it gets the same treatment through :decorate
Whatsmeow.send_image(pid, peer, bytes,
  media_conn: conn,
  decorate: &Content.reply(&1, quoted_key, quoted))
```

## Contacts and identity

```elixir
# Send to the JID this returns, not the number you typed — the server canonicalises.
{:ok, [%{jid: jid, is_in?: true}]} = Whatsmeow.on_whatsapp(pid, ["201001234567"])

{:ok, info} = Whatsmeow.fetch_status(pid, [jid])
{:ok, [%{lid: lid, pn: pn}]} = Whatsmeow.resolve_lid(pid, [jid])

# LID ↔ PN, from the local cache only
Whatsmeow.LIDMap.pn_for("123456789@lid")
Whatsmeow.LIDMap.resolve(some_jid)
```

## Plugins

Middleware on both directions, applied to every path:

```elixir
Whatsmeow.Plugin.attach(:send, :blocklist, fn ctx ->
  if ctx.to.user in banned(), do: {:halt, :blocked}, else: {:cont, ctx}
end)

Whatsmeow.Plugin.attach(:recv, :drop_spam, fn ctx ->
  if spam?(ctx.message.body), do: {:halt, :spam}, else: {:cont, ctx}
end)
```

A halted send returns `{:error, {:halted, reason}}`; a halted receive is never broadcast.

## Testing your bot

`Whatsmeow.Testing` gives you a real session that never opens a socket:

```elixir
{:ok, session} = Whatsmeow.Testing.start_offline()
{:ok, _bot}    = MyBot.start_link(session)

Whatsmeow.Testing.deliver_text(session, from: "15551234567@s.whatsapp.net", text: "ping")

assert [%{message: %{conversation: "pong"}}] = Whatsmeow.Testing.sent(session)
```

No database, no QR, no network. Your receive→reply path runs unchanged.

## Declarative supervision

For a fixed set of accounts known at boot:

```elixir
children = [
  MyApp.WhatsAppRouter,
  {Whatsmeow, client_id: "sales"},
  {Whatsmeow, client_id: "support"}
]
```

The device is loaded from the store at start, so a restart after pairing doesn't ask for a new QR.

## Running without Postgres

The Signal layer can go to disk instead:

```elixir
config :whatsmeow_ex, signal_store: Whatsmeow.Signal.Store.DETS
config :whatsmeow_ex, signal_store_dir: "./whatsmeow_data"
```

Covers everything the Signal layer needs — sessions, sender keys, peer identity keys, and one-time prekeys — so an account can pair and decrypt with no database.

Single-node only, and **without a Repo the session lock is a no-op**, so send and receive can still interleave on the same record within one node. Fine for a quiet bot; use Postgres for anything busy. Device records, app-state, contacts, and chat settings still require the Repo either way.

## Things that fail silently without them

Three protocol details where "it looked like it worked" is the failure mode:

| | What breaks without it | Where |
|---|---|---|
| **tctoken** | Send is acked, message never delivered (error 463) | `Whatsmeow.PrivacyToken` |
| **History sync** | Chat list stays empty; phone shows the device as Paused | `Whatsmeow.HistorySync` |
| **Session lock** | Concurrent send/receive clobber the Signal session; chats stick on "Waiting for this message" | `Whatsmeow.Signal.Lock` |

A rejected send is surfaced as `%Whatsmeow.Types.Events.SendRejected{}` — subscribe to it, since `send_text/4` has already returned `{:ok, id}` by the time the ack lands.

## What's locked-by-tests

The cryptographically critical paths are covered against RFC test vectors or property tests:

| Surface | Coverage |
|---|---|
| Curve25519 / X25519 | RFC 7748 Alice/Bob round-trip |
| HKDF-SHA256 | RFC 5869 test cases 1/2/3 |
| ChaCha20-Poly1305 | RFC 7539 §2.8.2 + tamper detection |
| AES-256-GCM | NIST SP 800-38D Test Case 16 |
| Binary XML codec | StreamData round-trip on random Node trees |
| Noise XX handshake | Alice + Bob → same keys after HKDF mix |
| Signal Ratchet KDFs | Determinism |
| Double Ratchet (1:1) | encrypt → decrypt + out-of-order via skipped-key cache (property test) |
| Group SenderKey | encrypt → decrypt round-trip |
| Media | upload → download round-trip × 5 media types + tamper detection |
| LTHash | homomorphic + commutativity + wrap-at-2^16 property |
| AppState | Encode → Decode + snapshot/patch MAC verify |
| MsgSecret | use-case key derivation + AAD |
| Argo | varint round-trip + self-describing encode/decode |

## Examples

- [`examples/echo_bot/`](examples/echo_bot/) — minimal CLI echo bot
- [`examples/livebook/`](examples/livebook/) — interactive Livebook notebook

## Development

Requires Elixir 1.19+ and OTP 27+. Postgres 14+ for tests.

```bash
mix deps.get
mix ecto.setup       # creates DB and runs migrations
mix test             # unit tests
mix test.all         # unit + integration
mix check            # format + credo + dialyzer + test
```

## License

MPL-2.0, matching the upstream `whatsmeow` Go library.

## See also

- [`plan.md`](plan.md) — phased roadmap, status, and what's done vs scaffolded
- [`whatsmeow-main/`](whatsmeow-main/) — vendored Go source, for reference
# whatsmeow_ex
