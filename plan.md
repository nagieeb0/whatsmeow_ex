# `whatsmeow_ex` — Pure-Elixir Port of [whatsmeow](https://github.com/tulir/whatsmeow)

A 1:1 port of the Go library `whatsmeow` to **pure Elixir/Erlang**. No Rust/C NIFs — only Erlang's stdlib `:crypto`. Backed by **Ecto + Postgres**. Target: production hex.pm library.

## Status at a glance

**537 tests, 0 failures.** Phase 9 — full receive AND send pipeline + group-cipher decrypt — is in. Phase 15 — fleet hardening (Registry partitions, per-device persona, opt-in firehose, cold-start jitter, version refresher, idle-session benchmark) — is in. The remaining items are operational polish (smoke-task auto-reconnect, dialyzer cleanup, hex publish, outbound group send), not protocol gaps.

🎉 **Live decrypt verified end-to-end 2026-05-12 against `web.whatsapp.com`** — a real text message ("Everything is ok") sent from a peer phone was decoded by the pure-Elixir Signal pipeline (responder X3DH + Double Ratchet + libsignal-MAC + AES-CBC-PKCS7 + WhatsApp padMessage + WaE2E proto decode).

**What's in the box today:**

* **1:1 inbound** — `<enc type="pkmsg">` (first-contact) + `<enc type="msg">` (steady-state) decrypted in `Whatsmeow.Session.handle_info/2`, broadcast as `%Events.Message{}` + per-attachment `%Events.MediaMessage{}` on PubSub. Sessions persist to `whatsmeow_sessions` so steady-state survives reconnects.
* **1:1 outbound** — `Whatsmeow.Send.{send_text, send_image, send_video, send_audio, send_voice, send_document}/3..4`. First-contact path fetches the peer's pre-key bundle (`Whatsmeow.PreKeyBundle`), runs `X3DH.initiator_agree/5`, and emits a `<enc type="pkmsg">`. Steady-state advances the persisted session.
* **Group inbound (`<enc type="skmsg">`)** — `Whatsmeow.Signal.GroupDecrypt.decrypt_envelope/2` does libsignal-wire-compatible XEdDSA signature verify + chain-key advance + HKDF "WhisperGroup" + AES-CBC + padding unwrap. `%GroupSession{}` state persists to `whatsmeow_sender_keys` keyed by `(our_jid, chat_id, sender_id)`. The session is seeded automatically from any `senderKeyDistributionMessage` inside a successfully-decrypted 1:1 message.
* **PreKey upload** — `Whatsmeow.PreKeys.upload/2` auto-runs on every `Session` post-login bootstrap (812-key initial vs 50-key top-up) so peers can do full X3DH against us, not signed-pre-key-only.
* **Media upload** — `Whatsmeow.Media.Upload.upload/3` encrypts + POSTs to the CDN host, returns `%{url, direct_path, media_key, file_sha256, file_enc_sha256, file_length}` ready for the protobuf. Conn refresh via `Whatsmeow.Media.Refresh.refresh/2`.
* **Media download** — `Whatsmeow.Media.Download.fetch_and_decrypt/2` resolves URL vs `direct_path` + media-conn host list, retries across hosts, verifies `file_sha256`.
* **Pair flow** — `Whatsmeow.Session.handle_info/2` dispatch tree for `<iq><pair-device>` (broadcasts `%Events.QR{}` + acks) / `<iq><pair-success>` (HMAC + account-sig + device-sig + ack + persist + broadcast) / `<success>` (LoggedIn + post-login bootstrap) / `<failure>` (LoggedOut, disables auto-reconnect) / `<stream:error>` (telemetry) / `<iq type="result">` (correlation).
* **Keepalive + reconnect** — 25 s ± 2.5 s jittered ping; 3 consecutive un-acked failures force a reconnect. Exponential backoff (1 s → 5 min) with 0–500 ms jitter. Cleared on `<success>`.
* **Telemetry** — `[:whatsmeow, :session, :connect, :start|:stop]`, `:stream_error`, `:pair_success`, `:logged_in`, `:message_decrypted`, `:message_undecryptable`.
* **Transport** — Mint TLS WSS to `wss://web.whatsapp.com/ws/chat`, HTTP CONNECT proxy with Basic auth (`{host, port}` / `{scheme, host, port, opts}` / URL forms), event-driven `process_message/2` callback so the GenServer mailbox stays responsive.
* **Version pinning** — `Whatsmeow.WAVersion` `:persistent_term`-cached live scrape of `web.whatsapp.com`, proxy-aware, refresh per IP-pool not per-session.

`mix whatsmeow.smoke` drives the whole pair / login / send / receive cycle against the real server; `--persist` writes Postgres, `--relogin` reconnects with `login_payload/1` after pair, `--load-jid <JID>` skips the QR phase entirely on subsequent runs.

For integration, cost estimates (incl. 100K-account RAM/CPU), CLI QR flow, and a feature-gap matrix vs Go `whatsmeow`, see [`GUIDE.md`](GUIDE.md).

| Phase | Status | Highlights |
| --- | --- | --- |
| 0 Bootstrap | ✅ Done | deps, format, credo, CI, OTP scaffolding |
| 1 Crypto | ✅ Done | RFC 7748 / 5869 / 7539 / NIST SP 800-38D vectors all lock in |
| 2 Types | ✅ Done | JID parser with atom-safety property test |
| 3 Protobuf | ⏸ Staged | `.proto`s vendored, `mix whatsmeow.protoc` task ready; needs `protoc` install |
| 4 Binary XML | ✅ Done | Decoder + Encoder + 236-single / 1024-double token tables; property round-trip |
| 5 Noise XX | ✅ Done | Handshake + post-handshake socket + Mint WS adapter, with X25519 round-trip |
| 6 Ecto + PG | ✅ Done | 17 tables migrated; 16 schemas with changesets |
| 7 Signal | ✅ Done | Ratchet, X3DH, Session, SessionCipher (with fixed skipped-key cache), SenderKey, GroupCipher — round-trips + out-of-order property test |
| 8 Session | ✅ Done | Live handshake driver + full pair-success flow + post-login `<success>` decoder + **`Whatsmeow.Session.handle_info/2` IQ dispatch (`<pair-device>` / `<pair-success>` / `<success>` / `<failure>` / `<stream:error>` / `<iq type="result">`)** + **keepalive timer with jitter + max-failures reconnect** + **exponential reconnect backoff** + telemetry events + `Whatsmeow.IQ` builders + event-driven `WebSocket.process_message/2`. |
| 9 Send/Recv | ✅ Done | Inbound pkmsg/msg/skmsg decrypt in Session → `%Events.Message{}` + per-attachment `%Events.MediaMessage{}`; outbound `Whatsmeow.Send.{send_text, send_image, send_video, send_audio, send_voice, send_document}` with first-contact bundle fetch + steady-state ratchet advance; PreKey auto-upload on every login; Signal session + sender-key persistence to Postgres. |
| 10 Media | ✅ Done | Upload + Download + Conn cache + Finch streaming helpers |
| 11 AppState | ✅ Done | LTHash + Keys + Hash + Encode + Decode + Recovery |
| 12 Groups | 🚧 Inbound done | Group decrypt (`skmsg`) via `GroupSession` + `GroupDecrypt` — XEdDSA signature verify, chain-key advance, skipped-key cache, SKDM auto-seed from inbound 1:1. Outbound group send + live participant management still missing. |
| 13 Argo etc | ✅ Mostly done | Argo varint/label/wire/self-describing codec + QueryID store; Armadillo envelope codec |
| 14 Polish | 🚧 Examples ready | README rewrite, Livebook notebook, echo bot scaffold, ExDoc groups updated |
| 15 Fleet hardening | ✅ Done | Registry partitions, per-device persona + HistorySyncConfig parity, signal_cache dead-code removed, WAVersion.Refresher supervisor child, all_topic firehose off by default, cold-start jitter, idle-session memory benchmark (2.7 KB/session BEAM-only measured) |

## Architecture in One Page

- **One `Whatsmeow.Session` GenServer per paired device.** Owns the WebSocket, Noise cipher state, IQ pending map, retry timers (`Process.send_after`), Signal `SessionCache` ETS, group cache.
- **Transient `Task.Supervisor` children** for outbound media uploads / long-running HTTP.
- **Vanilla Ecto + Postgres** for persistence (Ash considered, declined — see `.claude/plans/i-want-to-make-mellow-badger.md`).
- **`Phoenix.PubSub`** for event broadcasting; consumers subscribe to `{:device, id}`.
- **Pure-Elixir Signal protocol** in `Whatsmeow.Signal.*` (replaces `go.mau.fi/libsignal`).
- **`:protobuf`** for the 55 vendored `.proto` packages; **`:qqr`** (dannote/qqr) for QR rendering; **`:mint_web_socket`** for the transport; **`:finch`** for media streaming.
- **Dynamic WA version pinning** via `Whatsmeow.WAVersion` (proxy-aware scrape of `web.whatsapp.com` → `:persistent_term`) — avoids the `<stream:error 500>` trap from week-old hardcoded `client_revision`.
- **Per-tenant proxy routing** via `Whatsmeow.Transport.WebSocket.Mint`'s `:proxy` option (4-tuple, `{host, port}` shorthand, or `http(s)://user:pass@host:port` URL). Same spec is honored by `WAVersion.refresh/1` so the version scrape egresses from the same IP pool as the session.

## Phased Execution Tracker

### Phase 0 — Bootstrap ✅
- [x] `mix.exs` with full dep set (incl. `:qqr` from dannote)
- [x] `.formatter.exs`, `.credo.exs`, `.tool-versions`, `.dialyzer_ignore.exs`
- [x] `config/{config,dev,test,prod,runtime}.exs`
- [x] `Whatsmeow.Application`, `.Supervisor`, `.Repo`, `.Config`, `.Telemetry`, `.NotImplementedError`
- [x] `Whatsmeow.Sessions.Supervisor` (DynamicSupervisor) + `.Sessions.Registry`
- [x] `Whatsmeow` public facade
- [x] GitHub Actions CI workflow (Elixir 1.19 × OTP 27/28 + Postgres + dialyzer)
- [x] `mix deps.get` / `mix compile --warnings-as-errors` / `mix test` / `mix format` / `mix credo --strict` all clean

### Phase 1 — Crypto primitives ✅ (RFC-locked)
- [x] `Whatsmeow.Crypto.{AES.GCM, AES.CBC, HKDF, Curve25519, ChaCha20Poly1305}` + `Whatsmeow.Keys`
- [x] RFC 7748 X25519 Alice/Bob round-trip
- [x] RFC 5869 HKDF-SHA256 test cases 1/2/3
- [x] RFC 7539 ChaCha20-Poly1305 §2.8.2 (incl. tamper detection)
- [x] NIST SP 800-38D AES-256-GCM Test Case 16

### Phase 2 — Types ✅
- [x] `Whatsmeow.Types.JID` parser (Iron Law: no `String.to_atom`)
- [x] Atom-count property test
- [x] 100-run round-trip property test across 7 server forms
- [x] `Types.{Message, User, Group, Call, Presence, Newsletter}` + 12 `Types.Events.*` structs

### Phase 3 — Protobuf ✅
- [x] 55 `.proto` packages vendored to `priv/protos/`
- [x] `mix whatsmeow.protoc` task with `protoc` + `protoc-gen-elixir` prerequisite checks
- [x] Generated modules under `lib/whatsmeow/proto/` (200+ .ex files; WAAdv, WACert, WACompanionReg, WAWebProtobufsE2E, WAWebProtobufsWa6, ...)
- [ ] Vendor `signal-protocol` StorageRecord.proto

### Phase 4 — Binary XML codec ✅
- [x] `priv/binary/tokens.json` (236 single + 1024 double across 4 dicts, dict_version=3) extracted from Go source
- [x] `mix whatsmeow.gen.tokens` regenerator
- [x] `Whatsmeow.Binary.{Token, Node, Decoder, Encoder, Types}` + facade `Whatsmeow.Binary`
- [x] Tag/attr/child round-trips; nibble-packed and hex-packed strings; nested trees; JID encoding
- [x] StreamData property test on random Node trees

### Phase 5 — Noise XX + WebSocket transport ✅
- [x] `Whatsmeow.Transport.{Constants, Frame, NoiseHandshake, NoiseSocket, WebSocket, WebSocket.Mint}`
- [x] 3-byte BE length-prefix framing
- [x] X25519 ECDH + HKDF mixing round-trip
- [x] Noise XX handshake transcript hash matches Go semantics

### Phase 6 — Ecto schemas + Postgres ✅
- [x] One migration creating all 17 tables (`priv/repo/migrations/20260101000001_create_whatsmeow_schema.exs`)
- [x] 16 schema modules under `Whatsmeow.Store.Schemas.*` with changesets
- [x] `Whatsmeow.Store` behaviour + `Whatsmeow.Store.Postgres` Ecto impl
- [x] `Whatsmeow.Store.Container`
- [ ] `mix ecto.migrate` against a live DB (needs Postgres running locally)

### Phase 7 — Pure-Elixir Signal protocol ✅
- [x] `Whatsmeow.Signal.Ratchet` (KDF_RK + KDF_CK + derive_message_keys)
- [x] `Whatsmeow.Signal.X3DH` (initiator path)
- [x] `Whatsmeow.Signal.Session` (state struct, initiator + responder init)
- [x] `Whatsmeow.Signal.SessionCipher` (encrypt/decrypt with DH-ratchet step + skipped-key cache)
- [x] `Whatsmeow.Signal.SenderKey` + `.GroupCipher` (group v2 messaging)
- [x] `Whatsmeow.Signal.Store` behaviour
- [x] 1:1 encrypt → decrypt round-trip test
- [x] Group encrypt → decrypt round-trip test
- [x] Skipped-key cache property test for out-of-order delivery (caught & fixed counter-increment bug)
- [ ] Signal-Java test vectors (StorageRecord, SessionCipher, GroupCipher)
- [ ] CI cross-validator against `signal-cli`

### Phase 8 — Session GenServer + pair 🚧
- [x] `Whatsmeow.Session` GenServer with `%State{}` (Noise + transport conn + Signal ETS + pending map + reconnect_attempts)
- [x] `Whatsmeow.Pair` (QR-scan flow handler — handle_pair_device + handle_pair_success)
- [x] `Whatsmeow.PairCode` (phone-number pair code generator + validator)
- [x] `Whatsmeow.QRChannel` (canonical payload format + :qqr render integration)
- [x] `Whatsmeow.start_session/1` / `stop_session/1` / `list_sessions/0` wired through DynamicSupervisor (idempotent start; registered under `Whatsmeow.Sessions.Registry`)
- [x] `Whatsmeow.Store.find_or_new_device/1` (load-or-create by host-supplied `client_id`)
- [x] `Whatsmeow.Crypto.XEdDSA.verify/3` (birational map + Erlang Ed25519 verify)
- [x] `Whatsmeow.Crypto.Ed25519` (pure-Elixir twisted-Edwards point arithmetic) + `Whatsmeow.Crypto.XEdDSA.sign/3` (cross-validated by `:crypto.verify(:eddsa)` via 100-iter property test)
- [x] `Whatsmeow.ClientPayload` (registration + login wire payloads, round-trip tested)
- [x] `Whatsmeow.Transport.CertVerifier` (CertChain parse + structural + XEdDSA chain)
- [x] `Whatsmeow.Transport.Handshake.run/1` driver (locks the XX choreography client-side via in-memory loopback test)
- [x] `Whatsmeow.Session.handle_cast(:connect)` wired through the Handshake driver
- [x] `mix whatsmeow.smoke` — interactive live test: handshake → QR → consume `<pair-success>` → verify ADV HMAC + account sig → generate device sig → optional persist (`--persist`) → send ack IQ → optional reconnect with login_payload + assert `<success>` (`--relogin`)
- [x] `Whatsmeow.Pair.handle_pair_success/2` — decode + HMAC verify + account-sig verify + device-sig generate + ack IQ build (9 unit tests, incl. happy path + 4 error paths)
- [x] `Whatsmeow.Login.parse_first_node/1` — post-login `<success>` / `<failure>` / `<stream:error>` classifier; extracts `lid` (JID-coerced) and `t` (signed second offset). 9 unit tests cover all three stanza shapes plus malformed-attr tolerance.
- [x] `Whatsmeow.Types.Events.LoggedIn` — event struct for paired-device authentication (mirrors `Connected`, adds `lid` + `server_time_offset`)
- [x] Smoke task `--relogin` mode — after pair-ack, drains the server close, opens a fresh WSS, runs handshake with the now-paired device (which routes to `login_payload/1`), and verifies the first inbound stanza is `<success>`. Surfaces stream-error / failure paths with actionable error text. **Verifies the full pair → login cycle end-to-end against the real server in one command.**
- [x] `Whatsmeow.WAVersion` — `fetch_latest/1` + `parse_revision/1` + `cached/0` + `put_cached/1` + `refresh/1`; `:persistent_term`-cached; proxy-aware; 14 tests incl. 4 Bypass-driven end-to-ends
- [x] `Whatsmeow.ClientPayload.wa_version/0` now reads from the cache so refreshes propagate to every subsequent registration payload without a session restart
- [x] `Whatsmeow.Transport.WebSocket.Mint.parse_proxy/1` — HTTP CONNECT tunnel, 4-tuple / shorthand / URL with Basic auth (9 unit tests)
- [x] `Whatsmeow.QRChannel.render_terminal/1` — compact half-block (▀ ▄ █) with explicit ANSI fg/bg, ~½ the height of the prior 2-cells-per-module version
- [x] Live pair-device IQ → QR event publish from inside the GenServer — `Whatsmeow.Session.handle_info/2` now dispatches `<pair-device>` through `Pair.handle_pair_device/2` and broadcasts `%Events.QR{}` on PubSub before sending the ack
- [x] Keepalive timer on the GenServer — `Process.send_after(self(), :keepalive_tick, 25_000 ± 2_500)` plus `Whatsmeow.IQ.build_keepalive/1` (`<iq xmlns="w:p" type="get" to="s.whatsapp.net">`). Pending map parks the id as `:keepalive`; matching `<iq type="result">` clears it. Three consecutive un-acked pings force a reconnect.
- [x] Login-payload reconnect path — `Whatsmeow.Login` + smoke `--relogin` exercise it end-to-end; the GenServer's `handle_info` now routes `<success>` through `Login.parse_first_node/1` and emits `%Events.LoggedIn{}` directly.
- [x] Reconnect-with-backoff loop — exponential (`2^attempts * 1s`, capped at 5 min) plus a 0–500 ms jitter, cancellable, with stale-attempt drop semantics. `auto_reconnect?` defaults true; `<failure>` flips it off so we don't loop into a ban condition.
- [x] Telemetry — `[:whatsmeow, :session, :connect, {:start, :stop}]`, `[:whatsmeow, :session, :stream_error]`, `[:whatsmeow, :session, :pair_success]`, `[:whatsmeow, :session, :logged_in]`.
- [x] Event-driven WS transport — `Whatsmeow.Transport.WebSocket.process_message/2` callback so the GenServer can match raw `{:ssl, _, _}` mailbox messages from `handle_info/2` instead of blocking in `recv/2`. Backwards-compatible with the existing `recv/1` path used by the smoke task.

### Phase 9 — Send/receive pipeline 🚧
- [x] `Whatsmeow.Send` (message-id gen + build_text_node)
- [x] `Whatsmeow.Receipt` (from_node decoder for delivery/read/played/server-error/inactive/sender + **`build_ack/2`** + **`build_delivery_receipt/1`**)
- [x] `Whatsmeow.Retry` (exponential backoff helper + schedule)
- [x] `Whatsmeow.MsgSecret` (HKDF use-case key derivation + AAD for poll-vote / event-response)
- [x] `Whatsmeow.Notifications` (per-device + global PubSub broadcast/subscribe)
- [x] `Whatsmeow.IQ` — `generate_id/0` + `build_keepalive/1` + `build_prekeys_get/2`
- [x] **`Whatsmeow.PreKeyBundle`** — server-response decoder mirroring Go's `nodeToPreKeyBundle`. Handles the optional `<keys>` wrapper, optional one-time pre-key, explicit `<error>` children. 11 unit tests covering happy path, all error surfaces, and the `<list>`-of-users IQ shape.
- [x] **`Whatsmeow.MessagePadding`** — exact port of Go's `padMessage` / `unpadMessage` (low-nibble + non-zero invariant, `v=3` Armadillo passthrough). 200-iter pad+unpad round-trip property test + bad-padding rejections.
- [x] **`Whatsmeow.MessageInfo`** — extract `id`/`from`/`to`/`type`/`t`/`participant`/`push_name` from inbound `<message>` attrs. JID-coerced, group/DM detection, `is_from_me?` heuristic. 8 unit tests including malformed-attr rejections.
- [x] **Session-level IQ correlation** — `pending: %{id => :keepalive | {pid, ref}}` on the Session struct
- [x] **Inbound `<message>` dispatch** — `Session.handle_info/2` now routes `<message>` through `MessageInfo.from_node/2`, broadcasts `%Events.UndecryptableMessage{enc_type, enc_version, enc_payload}` per `<enc>` child, sends `<ack>` back to stop the server resending. **Inbound path verified end-to-end against the real server pending Signal-wire decode.**
- [x] **`<receipt>` / `<notification>` / `<call>` ack** — all three now ack via `Whatsmeow.Receipt.build_ack/2` so server traffic isn't stuck on resends.
- [x] **Smoke task post-`<success>` listen mode** — holds the WSS open, auto-pings, surfaces every `<message>` with id/from/type + per-`<enc>` ciphertext length. Run `mix whatsmeow.smoke --persist --relogin` and send yourself a WA message to validate.
- [x] **`Whatsmeow.Signal.Wire` — `SignalMessage` + `PreKeySignalMessage` protos** vendored from libsignal-protocol-java's `WhisperTextProtocol.proto`. Envelope codec: `<version(0x33) || proto || mac[0..7]>` for SignalMessage, `<version || proto>` for PreKeySignalMessage. Round-trip tested, MAC formula matches libsignal's `mac(macKey, sender_id || receiver_id || version || proto)`. 9 tests.
- [x] **`Whatsmeow.Signal.X3DH.responder_agree/5`** — mirror of `initiator_agree/5` for the receiver side. Initiator/responder symmetry verified (both derive the same 32-byte root key with and without OPK). 3 tests.
- [x] **`Whatsmeow.Signal.WireDecrypt`** — libsignal-wire-compatible decrypt pipeline. `decrypt_signal_envelope/4` for steady-state, `decrypt_prekey_envelope/4` for first-contact (runs responder X3DH → inits session → recursively decrypts inner SignalMessage). Reuses `SessionCipher`'s ratchet step + skip-keys via exposed seams. **End-to-end test: initiator generates X3DH + first ratchet + encrypts via libsignal wire format → responder decrypts → plaintext matches.** Plus MAC-mismatch + tampered-ciphertext rejections (4 tests). **Strips libsignal's 0x05 DjbType prefix from on-wire public keys (ratchetKey, baseKey, identityKey) and reconstructs it for MAC computation — matches libsignal's `Curve.decodePoint` + `IdentityKey.serialize()`.**
- [x] **X3DH discontinuity prefix** — `:binary.copy(<<0xFF>>, 32)` (32 bytes of 0xFF) per the Signal X3DH spec. Regression test guards against the Elixir bit-syntax trap where `<<0xFF::256>>` is the integer 255 zero-padded to 256 bits big-endian (= 31 zero bytes + one 0xFF) — that bug silently broke libsignal byte-compatibility while our internal tests stayed green.
- [x] **Smoke task `attempt_decrypt/2`** — on each inbound `<message>`, picks the first `<enc type="pkmsg">` and attempts decrypt with the paired Device's `identity_key` + `signed_pre_key`. Prints plaintext byte count, hex preview, and decodes as the `WAWebProtobufsE2E.Message` proto. Surfaces decrypt failure inline without aborting the listen loop. **Live-verified 2026-05-12 — peer-phone plaintext "Everything is ok" decoded successfully.**
- [x] **Outbound Signal-encrypt — wire codec landed** (`Whatsmeow.Signal.WireEncrypt`). `encrypt_signal_envelope/4` (steady-state) + `encrypt_prekey_envelope/5` (first-contact X3DH + first ratchet). **Initiator/responder round-trip locked by 4 tests** through both `pkmsg` and `msg` envelopes. `Whatsmeow.Send.build_text_message_node/4` wraps the envelope as `<message><enc v="2" type="msg|pkmsg">`. `Whatsmeow.Send.build_e2e_text_message/1` produces the inner WaE2E.Message bytes ready for the encrypt call. 7 unit tests on the builders.
- [x] Persist Signal sessions to Postgres — `Whatsmeow.Signal.Store.Postgres` with `put/3` + `get/2`. Sessions serialize via `:erlang.term_to_binary(sess, [:compressed])` and load with `[:safe]` to block atom-exhaustion on corrupt blobs. 3 integration tests.
- [x] Skip-QR re-login — `mix whatsmeow.smoke --load-jid <JID>` loads a persisted Device row and goes straight to login_payload. **Lifts the major dev-loop friction of re-scanning the QR on every run.**
- [x] Smoke task wires steady-state `<enc type="msg">` decrypt via the persisted session.
- [x] Sender identity-pub stashed in `whatsmeow_identity_keys` after first pkmsg decrypt — needed for MAC verification on subsequent msg envelopes from the same peer.
- [x] Smoke task FK fix — propagates `paired_device` into `state.device` across the post-pair relogin transition so session/identity inserts use the real WA JID (not the `smoke-XXX` placeholder) as the FK target.
- [x] Smoke task: empty-id `<iq type="get">` responses are now skipped instead of sending a malformed `<iq type="result" id="">` (server rejects those and may close).
- [x] Outbound `Whatsmeow.Send.send_text/3` end-to-end orchestration — `Send.send_text/3`, plus `send_image/4`, `send_video/4`, `send_audio/4`, `send_voice/4`, `send_document/4`. First-contact fetches the peer bundle through `Session.send_iq` and emits `<enc type="pkmsg">`; steady-state reuses the persisted session and emits `<enc type="msg">`. Advanced session is upserted to `whatsmeow_sessions`.
- [x] PreKey bundle **upload** (`Whatsmeow.PreKeys.upload/2`) — auto-runs on every `Session` post-login bootstrap via a `Task.Supervisor` task; needs-initial check picks 812-key initial vs 50-key top-up.
- [x] Decrypt in supervised Session — `Session.try_decrypt_and_broadcast/3` swaps `Events.UndecryptableMessage` for `Events.Message{message: %Types.Message{}, info, ...}` + per-attachment `%Events.MediaMessage{}` on success; sends `<receipt>` after the ack on every successful decrypt.
- [x] **Group `<enc type="skmsg">` decrypt** — `Whatsmeow.Signal.GroupSession` + `Whatsmeow.Signal.GroupDecrypt` implement libsignal-wire group cipher: XEdDSA signature verify on (version || proto) using the sender's signing pub, HKDF "WhisperGroup" derivation of `(iv, cipher_key)`, AES-256-CBC + WhatsApp padding. State persists to `whatsmeow_sender_keys`. SKDM extracted from successfully-decrypted 1:1 messages auto-seeds the matching sender-key row. 12 unit tests including out-of-order delivery, replay rejection, signature tamper rejection.

### Phase 10 — Media upload/download ✅
- [x] `Whatsmeow.Media.Upload` (HKDF media keys + AES-CBC + HMAC-SHA256)
- [x] `Whatsmeow.Media.Download` (reverse path with HMAC validation)
- [x] Round-trip tested for all 5 media types (image/video/audio/document/sticker)
- [x] Tampered-MAC detection test
- [x] `Whatsmeow.Media.Conn` (host cache + ttl + url_for/all_urls)
- [x] `Whatsmeow.Media.Finch` (stream_get/stream_put/collect_body for large payloads)

### Phase 11 — App state sync + LTHash ✅
- [x] `Whatsmeow.AppState.LTHash` — full pure-Elixir 64-slot u16 LE implementation
- [x] Homomorphic + commutativity + add-then-subtract identity tests
- [x] Wrap-on-overflow at 2^16
- [x] `Whatsmeow.AppState.Keys` — HKDF expansion to 5 sub-keys + patch-name constants
- [x] `Whatsmeow.AppState.Hash` — HashState struct, update_hash, snapshot/patch/content/index MAC helpers
- [x] `Whatsmeow.AppState.Encode` — mutation encryption + snapshot/patch MAC generation
- [x] `Whatsmeow.AppState.Decode` — mutation decryption + MAC verification (content/index/snapshot/patch)
- [x] `Whatsmeow.AppState.Recovery` — gzip-decompress + per-record index MAC computation
- [x] `Whatsmeow.AppState.Errors` — error atoms
- [x] Encode → Decode round-trip + tampered-ciphertext rejection
- [ ] 5000+ patch first-sync against server-reported hash (needs live server)
- [ ] Benchmark vs Go (10K-mutation account)

### Phase 12 — Groups, presence, calls 🚧
- [x] `Whatsmeow.Group` (build_create_iq)
- [x] `Whatsmeow.Presence` (build_presence)
- [x] `Whatsmeow.Call` (from_node decoder)
- [ ] Live group create / participant management
- [ ] Group message with SenderKey distribution
- [ ] Contact sync

### Phase 13 — Argo, newsletters, Armadillo ✅
- [x] `Whatsmeow.Argo` facade
- [x] `Whatsmeow.Newsletter` (build_subscribe_iq)
- [x] `Whatsmeow.Argo.Varint` (ULEB128 + ZigZag)
- [x] `Whatsmeow.Argo.Label` (sentinel-aware signed varints)
- [x] `Whatsmeow.Argo.Wire` (wire-type tags)
- [x] `Whatsmeow.Argo.SelfDescribing` + `Whatsmeow.Argo.SelfDescribingEncoder` (round-trip codec)
- [x] `Whatsmeow.Argo.Store` (query-id ↔ message-name lookup, persistent_term cache)
- [x] `Whatsmeow.Armadillo` (versioned SubProtocol envelope codec + FB/IG routing)
- [ ] Live newsletter subscribe + reporting (needs server)

### Phase 14 — Polish + hex publish
- [x] ExDoc grouping refreshed for new modules (Pairing/Messaging/Armadillo)
- [x] Livebook quickstart at `examples/livebook/quickstart.livemd`
- [x] CLI echo bot scaffold at `examples/echo_bot/echo_bot.exs`
- [x] `README.md` rewrite with locked-by-tests matrix + architecture diagram
- [x] `LICENSE` (MPL-2.0, matching upstream)
- [x] `GUIDE.md` — integration, cost analysis (100K accounts), CLI QR, gap-vs-Go matrix
- [x] **Phoenix bot scaffold** in `examples/phoenix_bot/README.md` — LiveView with QR-render-as-SVG + PubSub subscribe + status display + UndecryptableMessage counter + telemetry hookup
- [ ] `mix dialyzer` clean
- [ ] Publish `v0.1.0` to hex.pm
- [ ] Cut `v1.0.0-rc` after 7-day sandboxed-account uptime

### Phase 15 — Fleet hardening (50k+ accounts) ✅
- [x] **`Whatsmeow.Sessions.Registry` partitions** — `partitions: System.schedulers_online()` in `Whatsmeow.Application`; eliminates the single-write-lock bottleneck at scale where AshOban workers / Jido agents are issuing thousands of `Session.send_*` calls per second.
- [x] **`Whatsmeow.ClientPayload.Persona`** — per-device persona module driving `osVersion`, `manufacturer`, `device`, `localeLanguage`, `localeCountry`, plus `DeviceProps.os`. Replaces the upstream Go default of `"whatsmeow"` (a literal self-identifier in the registration payload) with `Mac OS` / 10.15.7 / `Apple Computer, Inc.` Built-in presets for `mac_os/0`, `windows/0`, `linux/0`. Resolution order: persisted `Device.persona` → `Application.get_env(:whatsmeow_ex, :persona)` → `Persona.default/0`.
- [x] **`HistorySyncConfig` parity with Go upstream** — `Whatsmeow.ClientPayload.default_device_props/1` now ships the full `historySyncConfig` block (storageQuotaMb, supportCallLogHistory, supportBizHostedMsg, supportFbidBotChatHistory, supportManusHistory, …) that Meta's web client emits. Absence of this block is itself a fingerprint signal.
- [x] **Per-device persona persistence** — new `persona :map` column on `whatsmeow_device` (migration `20260512000001_add_persona_to_whatsmeow_device.exs`). `Whatsmeow.Pair.handle_pair_success/2` writes the configured persona to the row once at pair time and never mutates it after (rotating UA across reconnects is itself suspicious).
- [x] **`signal_cache` ETS dead-code removed** — the per-Session private ETS table was allocated but never read/written. Removing it saves ~25 MB at 50k and removes a future unbounded-growth trap.
- [x] **`Whatsmeow.WAVersion.Refresher`** — periodic refresher GenServer in the supervision tree. Disabled by default; opt in via `config :whatsmeow_ex, Whatsmeow.WAVersion.Refresher, enabled?: true, interval_ms: :timer.hours(1), proxy: System.get_env(...)`. Hourly refresh + 5min jitter, per-IP-pool proxy aware. Drop-in replaceable by AshOban cron later.
- [x] **`Whatsmeow.Notifications` `all_topic` firehose off by default** — broadcasts only go to the per-device topic unless `config :whatsmeow_ex, Whatsmeow.Notifications, all_topic?: true`. At fleet scale a global subscriber becomes a memory amplifier and a bottleneck. 2 new tests cover the gate.
- [x] **Cold-start jitter** — new `config :whatsmeow_ex, :cold_start_jitter_ms, 30_000` config. First `:connect` cast on a freshly-started `:idle` session is deferred by `:rand.uniform(max)` ms so a fleet of 50k sessions doesn't thunder Meta's edge in one window on boot. Default 0 preserves immediate connect in tests.
- [x] **`bench/session_memory.exs`** — empirical idle-session memory benchmark. Spawns N sessions, samples `:erlang.process_info(pid, [:memory, …])`, reports min/mean/p50/p95/max. **Measured 2.7 KB/session BEAM-only at N=1000** — projects to ~134 MB at 50k (BEAM only), plus 16–32 KB/session for active TLS sockets → real-world ~1–2 GB at 50k, much lower than the original desk-audit estimate of 30 GB.

## What's locked-by-tests vs scaffolded

**Locked by tests (cryptographically critical paths):**
- All `:crypto` primitives against RFC vectors
- Binary codec round-trip on random Node trees
- Noise XX handshake symmetry (Alice + Bob → same keys after X25519+HKDF mix)
- Signal Ratchet KDF determinism
- 1:1 Session encrypt→decrypt round-trip
- Out-of-order delivery via skipped-key cache (property test, caught real counter-increment bug)
- Group SenderKey encrypt→decrypt round-trip
- Media upload→download for all 5 media types (incl. tamper detection)
- LTHash homomorphic + commutativity + wrap-at-2^16 property
- AppState Encode→Decode round-trip + snapshot/patch MAC verification + tamper rejection
- MsgSecret HKDF derivation + AAD for poll-vote / event-response
- Argo varint round-trip + self-describing encode/decode (nested objects, lists, all primitives)
- Armadillo envelope marshal/unmarshal + FB/IG version routing
- **XEdDSA sign+verify** round-trip (100-iter property, cross-validated by stdlib `:crypto.verify(:eddsa)`)
- **`<pair-success>` end-to-end** — HMAC verify, account-sig verify, device-sig generate, ack IQ shape (9 tests incl. 4 error paths)
- **`<success>` post-login decoder** — `Login.parse_first_node/1` for the three valid first-stanza shapes (success / failure / stream-error) plus malformed-attr tolerance (9 tests)
- **`Whatsmeow.IQ` builders** — `generate_id/0` uniqueness, `build_keepalive/1` shape (`xmlns="w:p"`, `type="get"`), `build_prekeys_get/2` per-user JID + reason child (7 tests)
- **`Whatsmeow.PreKeyBundle` decoder** — `<user>` → `%PreKeyBundle{}` extracting registration / identity / signed-pre-key / optional one-time-pre-key, tolerating the optional `<keys>` wrapper, surfacing `<error>` children, plus the `<list>`-of-users IQ wrapper. 11 unit tests.
- **`Whatsmeow.MessagePadding`** — Go-compatible padding scheme (200-iter pad+unpad round-trip property, low-nibble + non-zero invariant, bad-padding rejections, `v=3` Armadillo passthrough). 5 tests.
- **`Whatsmeow.MessageInfo`** — `<message>` envelope attr extraction (id/from/to/type/timestamp/participant/push_name), group vs DM detection, `is_from_me?` heuristic, malformed-attr rejections. 8 tests.
- **`Whatsmeow.Receipt.build_ack/2` + `build_delivery_receipt/1`** — covered indirectly by Session `<message>` dispatch test.
- **`Whatsmeow.Session` dispatch tree** — `<success>` → LoggedIn + keepalive, `<failure>` → LoggedOut + auto-reconnect-off, `<stream:error>` → telemetry, `<iq type="result">` → keepalive-id clears or caller-pid routing, **`<message>` → UndecryptableMessage broadcast + telemetry + ack**, failure-reason-atom mapping (no `String.to_atom`), backoff schedule shape + 5min cap (13 tests).
- **WAVersion fetch + parse + persist** — Bypass-driven HTTP scrape + revision regex + `:persistent_term` round-trip + no-cache-on-failure invariant
- **Mint proxy spec parser** — 4-tuple / shorthand / URL with Basic-auth userinfo

**Scaffolded (compileable + structurally complete, needs live wiring):**
- `Whatsmeow.Send` — wire path through `WAWebProtobufsE2E` is the remaining glue
- `Whatsmeow.Receipt` / `Retry` / `MsgSecret` — used internally by the Session GenServer when Phase 9 lands
- `Group` / `Presence` / `Call` — IQ builders + decoders ready; live exchange pending

**External prerequisites for next session:**
- Install `protoc` + run `mix whatsmeow.protoc` (Phase 3) — *done in this environment*
- Start Postgres + `mix ecto.setup` (Phase 6 live) — *done in this environment*
- Live revision pinning is now self-healing via `Whatsmeow.WAVersion.refresh/1`; no manual step required.

**Next concrete milestones (the remaining Phase 9 chunk):**
1. ~~Move pair-IQ + login-IQ dispatch from the smoke task into `Whatsmeow.Session.handle_info/2`~~ ✅ landed.
2. ~~Add `:keepalive` timer to `Whatsmeow.Session`~~ ✅ landed.
3. ~~Implement reconnect-with-login-payload after pair~~ ✅ landed.
4. ~~Exponential reconnect-backoff with jitter~~ ✅ landed.
5. ~~Telemetry events on connect / disconnect / stream-error / logged-in~~ ✅ landed.
6. ~~PreKey bundle fetch response decoder~~ ✅ landed (`Whatsmeow.PreKeyBundle`).
7. ~~Inbound `<message>` envelope dispatch + ack + UndecryptableMessage event~~ ✅ landed.
8. ~~Vendor the libsignal `SignalMessage` + `PreKeySignalMessage` protos~~ ✅ landed (`Whatsmeow.Signal.Wire`).
9. ~~Inbound Signal decrypt — first-contact `pkmsg` path~~ ✅ **landed AND live-verified** (`Whatsmeow.Signal.WireDecrypt.decrypt_prekey_envelope/4`).

**Open items (the next session of work):**

10. **Outbound group send (`<enc type="skmsg">`).** The inbound path is in (XEdDSA verify + chain advance + SKDM auto-seed). The outbound path needs: (a) `Whatsmeow.Send.send_text_to_group/3` that fans out the WaE2E payload to all member devices via `WireEncrypt.encrypt_signal_envelope/4` for the SKDM (one `<enc type="msg">` per member device carrying our `SenderKeyDistributionMessage`) AND a single `<enc type="skmsg">` for the body encrypted with `GroupDecrypt.encrypt_envelope/2`; (b) per-group SenderKey state cache so we don't re-distribute on every send; (c) `<usync>` member discovery to find every device JID in the group. `GroupDecrypt.encrypt_envelope/2` is already implemented and tested for outbound use — only the `<message>` framing + member fanout is missing.
11. **`mix dialyzer` clean.** Likely needs hours of `@spec` work across ~100 modules.
12. **Live group create / participant management / invite.** IQ builders exist (`Whatsmeow.Group`); the request/reply choreography against the server isn't wired.
13. **History sync replay** — schemas + `AppState.Recovery` are in tree; the trigger that drives a 5 000+ patch first-sync against server-reported hash isn't.
14. **`signal-cli` cross-validator in CI** — would lock our libsignal-wire format byte-for-byte against the reference implementation.
15. **Smoke task auto-reconnect** — `mix whatsmeow.smoke` currently exits on the post-success server rotation. Real apps use the supervised `Whatsmeow.Session` (which auto-reconnects with backoff); the tool just needs the same loop.

**Cannot be completed without external steps:**
- Live group create / participant management / SenderKey distribution — needs a paired sandbox account
- 5000+ patch AppState first-sync — needs a real account with history
- Newsletter live ops — needs server
- Benchmark vs Go — needs both runtimes on the same data
- `signal-cli` cross-validator — needs `signal-cli` installed + comprehensive vectors
- `mix dialyzer` clean — likely needs hours of type-spec work across 87 modules
- Publish `v0.1.0` to hex.pm — needs a hex API key
- Cut `v1.0.0-rc` after 7-day soak — needs 7 days of real time

## See Also

- Architectural rationale and risk analysis: `.claude/plans/i-want-to-make-mellow-badger.md`
- Source library (Go): `./whatsmeow-main/`
