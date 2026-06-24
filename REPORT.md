# whatsmeow_ex — Full Library Report

**Status:** active development, pre-1.0. **Pair + login + inbound 1:1 + inbound group + outbound 1:1 + media verified live against `web.whatsapp.com`** (2026-05-12 — a real text "Everything is ok" was decoded by the pure-Elixir Signal pipeline). Outbound group send is the largest remaining gap relative to upstream Go.

**Counts at time of writing:**
- 104 hand-written `.ex` files in `lib/` (≈ 11 800 LOC), 55 auto-generated protobuf modules
- 47 test files → **4 doctests, 5 StreamData properties, 352 tests, 0 failures**
- Version `0.1.0` in `mix.exs`; Elixir `~> 1.19`; OTP 27/28 in CI
- 13 production dependencies, **zero NIFs / Rust / C** — verified by `grep -rE ':erlang\.(nif|load_nif)|@on_load|Rustler|Port\.open' lib/` (no hits)

---

## 1. Identity & philosophy

`whatsmeow_ex` is a 1:1 pure-Elixir port of [`go.mau.fi/whatsmeow`](https://github.com/tulir/whatsmeow), the de-facto reference WhatsApp Web multi-device client outside Meta. The port preserves Go upstream's wire-level behaviour byte-for-byte where it matters (Noise XX state machine, ADV signatures, ClientPayload field layout, binary-XML token tables, Signal Double Ratchet) and re-implements only the surrounding glue in Elixir-native idioms (process model, supervision, persistence, eventing).

Design constraints, in order of priority:

1. **Pure-Elixir crypto.** Erlang stdlib `:crypto` only. Ed25519 point arithmetic for XEdDSA signing is ≈ 170 lines of pure-Elixir twisted-Edwards math in `Whatsmeow.Crypto.Ed25519`, cross-validated by 100-iter property tests against `:crypto.verify(:eddsa)`. No `libsignal`, no `libqrencode`, no Rustler.
2. **One BEAM process per device.** `Whatsmeow.Session` is a `GenServer` registered under `Whatsmeow.Sessions.Registry` (`keys: :unique`) and supervised by `Whatsmeow.Sessions.Supervisor` (a `DynamicSupervisor`, `one_for_one`). Crashing session 47 cannot affect session 48 — exactly the property BEAM was built for and the Go version pays panic-recovery overhead to approximate.
3. **Durable state in Postgres.** 17 tables, 16 Ecto schemas, one migration. The Signal session cache is per-session **private** ETS that's rebuilt lazily on first peer contact after a crash; everything else (device row, identity keys, pre-keys, signed-pre-keys, app-state hashes, history) is on disk.
4. **Iron Law: no `String.to_atom/1` on wire data.** Atom-exhaustion DoS is a real failure mode for protocol parsers. Verified by inspection across `Whatsmeow.Binary.Decoder`, `Whatsmeow.Types.JID.parse/1`, `Whatsmeow.Pair`, and `Whatsmeow.Login`.
5. **No silent fallbacks.** Where Go would log and continue, `whatsmeow_ex` returns `{:error, atom}` so the caller decides. The `<pair-success>` and `<success>` decoders never throw on malformed input — they surface a specific atom (`:hmac_mismatch`, `:account_signature_invalid`, `{:stream_error, code}`, etc.).

---

## 2. Architecture in one diagram

```
                       ┌───────────────────────────────┐
                       │  Host application             │
                       │  (Phoenix, mix task, daemon)  │
                       └──────────────┬────────────────┘
                                      │
              Phoenix.PubSub          │  start_session/1
              "whatsmeow:device:<id>" │
                                      ▼
   ┌──────────────────────────────────────────────────────────────┐
   │ Whatsmeow.Application                                         │
   │  ├─ Whatsmeow.Repo                  (Ecto + Postgres)         │
   │  ├─ Whatsmeow.PubSub                (Phoenix.PubSub)          │
   │  ├─ Whatsmeow.Sessions.Registry     (Registry, keys: :unique) │
   │  └─ Whatsmeow.Sessions.Supervisor   (DynamicSupervisor)       │
   │       ├─ Whatsmeow.Session(device_1)                          │
   │       ├─ Whatsmeow.Session(device_2)                          │
   │       └─ Whatsmeow.Session(device_N)                          │
   └──────────────────────────────────────────────────────────────┘
                              │
              one mint_web_socket conn + Noise XX state
                              │
                              ▼
                  wss://web.whatsapp.com/ws/chat
```

Each `Whatsmeow.Session` owns:
- one Mint WebSocket connection (optionally through an HTTP CONNECT proxy)
- the Noise XX cipher state (`NoiseHandshake` while handshaking, `NoiseSocket` after)
- a **private** ETS table for the Signal session cache (`:private, :set`)
- the IQ pending map (`request_id → {caller_pid, ref}`)
- retry timers via `Process.send_after/3`
- reconnect-backoff state

---

## 3. Component inventory

### 3.1 Transport — `lib/whatsmeow/transport/`

| Module | Capability | Status |
|---|---|---|
| `WebSocket.Mint` | TLS WSS to `wss://web.whatsapp.com/ws/chat`. `connect/1` accepts a `:proxy` option in four forms: `{host, port}`, `{scheme, host, port}`, `{scheme, host, port, opts}`, or a URL string `"http(s)://user:pass@host:port"`. URL userinfo is converted to a `Proxy-Authorization: Basic …` header on the HTTP CONNECT, and the CLI redactor scrubs it from output. `recv/2` distinguishes server-close (`:closed`) from "still waiting" (`{:error, :timeout}`) — important for the post-pair reconnect drain. | ✅ |
| `WebSocket.Mint.parse_proxy/1` | Eager validation of the proxy spec so misconfig surfaces at session-start rather than mid-connect. 9 unit tests cover all four input shapes. | ✅ |
| `Frame` | 3-byte big-endian length-prefix wrap / peel. `read_frames/1` handles multiple framed messages within a single WS payload (necessary for the post-handshake transport). | ✅ |
| `NoiseHandshake` | Full XX three-message handshake. HKDF-mixed chaining key, transcript hash. Round-trip property test proves Alice and Bob derive the same key after X25519 + HKDF mix. | ✅ |
| `NoiseSocket` | Post-handshake AEAD channel — AES-GCM-256 with per-direction monotonic counters. The `decrypt/2` path increments the read counter; the smoke-test "AEAD auth failed mid-stream" diagnostic catches counter-drift bugs deterministically. | ✅ |
| `CertVerifier` | Server cert-chain parser + XEdDSA chain verification. Structurally locked by malformed-input tests; **live verification against the real WA cert is off by default in `mix whatsmeow.smoke`** until a known-good capture is folded into tests. The cryptographic primitives (XEdDSA verify, sign-bit zeroing) are independently locked, so the only risk is structural mismatch. | ✅ structural; ⚠ off-by-default for live |
| `Handshake.run/1` | Orchestrator that drives steps 1–10 of the XX choreography (send ClientHello → recv ServerHello → decrypt server static + cert → encrypt our static → encrypt ClientPayload → send ClientFinish → derive keys). Locked client-side via an in-memory loopback test that simulates the server side of the dance. | ✅ |
| `Constants` | The 4-byte `WA` connection header, Noise start pattern (`Noise_XX_25519_AESGCM_SHA256`). | ✅ |

### 3.2 Cryptography — `lib/whatsmeow/crypto/`

| Module / function | Capability | Test vector source |
|---|---|---|
| `Curve25519.{generate_keypair,agree,public_for}` | X25519 ECDH — `:crypto.generate_key(:ecdh, :x25519)` + `:crypto.compute_key/4`. | RFC 7748 §6.1 Alice/Bob |
| `HKDF.expand/3`, `extract/2`, `expand_and_extract/3` | HKDF-SHA256 / HKDF-SHA512. Used by Noise, Signal Ratchet, MsgSecret, AppState, media keys. | RFC 5869 cases 1, 2, 3 |
| `ChaCha20Poly1305.{encrypt,decrypt}` | AEAD with tamper detection. | RFC 7539 §2.8.2 |
| `AES.GCM.{encrypt,decrypt}` | AES-256-GCM (NoiseSocket transport). | NIST SP 800-38D Test Case 16 |
| `AES.CBC.{encrypt,decrypt}` | AES-256-CBC (media path). | (round-trip + tamper) |
| `Ed25519` | Pure-Elixir twisted-Edwards: `scalar_mult_base/1`, `compress/1`, `x_sign/1`, `point_negate/1`, `mod_l/1`. ≈ 170 LOC. | XEdDSA spec |
| `XEdDSA.verify/3` | Birational map (Montgomery u → Edwards y), sign-bit forced to 0, then `:crypto.verify(:eddsa, :sha512, …)`. | Signal XEdDSA spec |
| `XEdDSA.sign/3` | Hash1 prefix `0xFE‖0xFF×31`, normalized keypair (forces `sign(A)=0` by scalar negation when needed), `R ‖ s` output. Optional deterministic nonce for tests. | Signal XEdDSA spec — **100-iter property test cross-validated by stdlib `:crypto.verify(:eddsa)`** |

### 3.3 Versioning — `lib/whatsmeow/wa_version.ex`

WhatsApp's `client_revision` increments roughly weekly. A hardcoded pin gets you `<stream:error code="500">` within days. `Whatsmeow.WAVersion` solves drift without manual maintenance:

- `fetch_latest/1` — GET `https://web.whatsapp.com/` (Mint, Chrome-mimicking headers matching upstream Go's `GetLatestVersion`). Regex `"client_revision":(\d+),` extracts the embedded JS field.
- `parse_revision/1` — pure function for offline diagnostics; paste a captured body in tests.
- `refresh/1` — atomic fetch + cache. On failure the cache is **not** modified.
- `cached/0` / `put_cached/1` / `clear_cache/0` — `:persistent_term` keyed `{:whatsmeow_ex, :wa_version}`. O(1) reads, writes block briefly.
- `Whatsmeow.ClientPayload.wa_version/0` reads from the cache on every build, so a refresh propagates to every subsequent registration payload **without restarting sessions**.

Honors the same `:proxy` spec as the transport so multi-tenant fleets can scrape from the same IP pool the session will egress from. **14 tests including 4 Bypass-driven end-to-end fetches.**

### 3.4 Binary XML codec — `lib/whatsmeow/binary/`

WhatsApp's wire format is a binary-XML dialect with 4 dictionaries (single 8-bit + three 8-bit double-dictionaries, `dict_version=3`) extracted from the Go source:

- **`Token`** — 236 single + 1024 double tokens, regenerable via `mix whatsmeow.gen.tokens`. The token table lives in `priv/binary/tokens.json` and is regenerated from `whatsmeow-main/binary/token/*.go` so dict drift is one command away.
- **`Decoder`** — handles all wire features: nibble-packed strings (BCD-like 4-bit encoding for phone numbers + hex), hex-packed strings, JID encoding (regular + AD-JID), nested children, the 1-byte compression-flag prefix (zlib-deflate when bit 1 is set).
- **`Encoder`** — round-trip symmetric with the decoder.
- **`Node`** — `%Node{tag: String.t(), attrs: %{String.t() => term()}, content: nil | binary() | [t()]}` with `get_child/2`, `get_children/2`, `attr/3`. **Iron Law honoured here:** `tag` and attr keys remain strings forever.
- **Property test** — StreamData-generated random `Node` trees round-trip through `Encoder → Decoder` losslessly.

### 3.5 Protobuf bindings — `lib/whatsmeow/proto/` (auto-generated)

| Coverage | Source |
|---|---|
| 55 `.proto` packages vendored from upstream Go | `priv/protos/` |
| ≈ 200 generated `.ex` files | `lib/whatsmeow/proto/` |
| Packages | `WAAdv`, `WACert`, `WACompanionReg`, `WAWebProtobufsE2E`, `WAWebProtobufsWa6`, `WAMmsRetry`, `WAHistorySync`, `WAMediaTransport`, … |
| Build tool | `mix whatsmeow.protoc` shells out to `protoc` + `protoc-gen-elixir` |

The format-check on these files fails because `protoc-gen-elixir` emits non-Elixir-formatter style; this is a known cosmetic gap that doesn't affect compilation or tests.

### 3.6 Signal protocol — `lib/whatsmeow/signal/` (no `libsignal` dependency)

| Module | Capability | Test |
|---|---|---|
| `Ratchet` | KDF_RK + KDF_CK + `derive_message_keys`. | Determinism unit tests |
| `X3DH` | Initiator + responder paths: DH1 ‖ DH2 ‖ DH3 ‖ DH4 → HKDF → shared secret. | Round-trip with synthetic bundle, symmetry verified |
| `Session` | State struct + initiator/responder init. | — |
| `SessionCipher` | Encrypt/decrypt with DH-ratchet step + **skipped-key cache for out-of-order delivery**. | **StreamData property test on random reorderings — caught a real counter-increment bug during port** |
| `Wire` | libsignal `SignalMessage` + `PreKeySignalMessage` envelope codecs + MAC computation (DJB-prefix prepending). | 14 tests |
| `WireDecrypt` / `WireEncrypt` | libsignal-wire-compatible 1:1 decrypt/encrypt — version byte + proto + MAC + DJB type stripping. | 4 + 4 tests + live-validated 2026-05-12 |
| `MessageBuilder` | WaE2E.Message → `%Whatsmeow.Types.Message{}` + attachment descriptors; unwraps ephemeral / view-once / device-sent envelopes. | Round-trip |
| `Decrypt` | Glue: routes pkmsg / msg / skmsg → wire decrypt → persistence; auto-seeds SenderKey rows from SKDM in 1:1 plaintext. | Used by Session in 12 dispatch tests |
| `SenderKey` + `GroupCipher` | Home-grown group v2 messaging (kept for internal round-trip tests). | Round-trip |
| `SenderKeyWire` | libsignal `SenderKeyMessage` + `SenderKeyDistributionMessage` envelope codecs (version byte, trailing signature). | 4 tests |
| **`GroupSession`** *(new)* | libsignal-wire-compatible group cipher state — `(id, chain_key, iteration, signing_pub, signing_priv?, skipped_keys)`. `from_distribution/1` seeds receive-side from an SKDM (strips 0x05 DjbType from `signingKey`); `to_distribution/1` produces the matching distribution message for outbound use. `new/1` mints an outbound session with a fresh Curve25519 signing keypair. | 4 tests |
| **`GroupDecrypt`** *(new)* | libsignal-wire skmsg decrypt: XEdDSA signature verify (using sender's signing pub), chain-key advance (libsignal HMAC pattern), HKDF "WhisperGroup" derivation of `(iv, cipher_key)`, AES-256-CBC + WhatsApp padding unwrap. Skipped-key cache for out-of-order delivery, capped at 2 000 iterations ahead. `encrypt_envelope/2` is the symmetric outbound function. | 12 tests — round-trip, multi-message, out-of-order, replay-rejection, signature-tamper, wrong-signer, wire-shape, keypair-sanity |
| **`GroupSession.Store.Postgres`** *(new)* | Persistence for `%GroupSession{}` keyed by `(our_jid, chat_id, sender_id)` in `whatsmeow_sender_keys`. Same `term_to_binary([:compressed])` / `binary_to_term([:safe])` pattern as `Signal.Store.Postgres`. | Used in Decrypt integration paths |
| `Store` | Behaviour for per-session storage abstraction. | — |

### 3.7 Pairing — QR-scan flow

| Module / function | Capability | Status |
|---|---|---|
| `Pair.handle_pair_device/2` | Parse `<pair-device>` IQ, extract `<ref>` strings, render canonical QR payloads. | ✅ |
| `Pair.build_pair_device_ack/1` | `<iq type="result">` ack — sent every ~20 s until scan. | ✅ |
| `Pair.handle_pair_success/2` | **End-to-end:** decode `ADVSignedDeviceIdentityHMAC` → HMAC-verify with `adv_key` → decode `ADVSignedDeviceIdentity` + `ADVDeviceIdentity` → XEdDSA-verify the **server's** account signature (`6,0 ‖ details ‖ ourIdentityPub`) → XEdDSA-**sign** our device signature (`6,1 ‖ details ‖ ourIdentityPub ‖ accountSignatureKey`) → strip `accountSignatureKey` → build `<iq><pair-device-sign><device-identity key-index="N">…</></></>`. Returns `{:ok, %Pair.Result{device, ack_iq, jid, lid, business_name, platform, req_id}}` with **zero I/O** — the caller persists and sends. | ✅ 9 unit tests (happy + 4 error paths) |
| `Pair.build_pair_error_iq/3` | `<failure>` reply with numeric `code` + textual `text`. Routes pair errors to standard XMPP-style failure stanzas. | ✅ |
| `QRChannel.build_payload/2` | Canonical 4-field payload `<ref>,<base64 noise_pub>,<base64 identity_pub>,<base64 adv_secret>`. | ✅ |
| `QRChannel.render_terminal/1` | **Compact half-block QR** using `▀ ▄ █` plus space, wrapped with `ESC[30;107m` (black-on-bright-white). Scans on any terminal background; roughly half the height of full-block renders. | ✅ |
| `QRChannel.render_svg/1` | SVG render via `:qqr` (`github.com/dannote/qqr`). Paste into a LiveView or save to disk. | ✅ |
| `PairCode` | Phone-number pair-code builder + validator (alternative to QR). | 🚧 builder only; live IQ exchange not wired |

### 3.8 Login (post-handshake auth) — `lib/whatsmeow/login.ex` *(new in 2026-05-12)*

After the Noise XX handshake completes for an already-paired device (one whose `ClientPayload` was a `login_payload`), the server replies with exactly one of three first-stanzas:

- `<success ... lid="user.0:N@lid" t="1715000000" />` — authenticated.
- `<failure reason="…" code="…" />` — login refused (account locked, device removed remotely).
- `<stream:error code="…" />` followed by `<xmlstreamend />` — server bailed before authentication (usually ClientPayload / version mismatch).

`Login.parse_first_node/1` classifies the parsed `%Binary.Node{}` into one of these three (plus `:unexpected_node`):

- On `<success>`: returns `%Login.Result{lid, server_time_offset}` where `lid` is normalized to canonical string form (handles both JID-typed and string-typed attrs from the binary decoder), and `server_time_offset` is `t − System.system_time(:second)` — the signed second offset between server and local clocks.
- On `<stream:error>`: `{:error, {:stream_error, code}}`.
- On `<failure>`: `{:error, {:failure, reason, code}}`.

Pure / no I/O. **9 unit tests** covering all three stanza shapes plus malformed-attr tolerance (missing `t`, empty `lid`, non-integer timestamp).

### 3.9 ClientPayload — `lib/whatsmeow/client_payload.ex`

`ClientPayload.build/1` branches on `paired?(device.jid)`:

- **Registration payload** for unpaired devices (placeholder JIDs like `smoke-…`, `device-…`, anything without an `@`): includes `eRegid`, `eKeytype`, `eIdent` (identity pubkey), `eSkeyID`, `eSkeyVal`, **`eSkeySig`** (XEdDSA signature of `<<5>> ‖ signed_pre_key.pub` with the identity key — random bytes here produce immediate `<stream:error code="500">` from the server), `buildHash` (MD5 of the dot-version), `deviceProps`.
- **Login payload** for paired devices (numeric WA JID): `username` (UserInt), `device` (device id), `passive: true`, `pull: true`, `lidDbMigrated: true`, `lc: 1`.

`base_user_agent/0` reads the live cached version from `WAVersion.cached/0` on every call, so a refresh on the long-running `:timer.apply_interval(:timer.minutes(30), …)` propagates to every subsequent registration payload without bouncing sessions.

### 3.10 Storage — `lib/whatsmeow/store/`

| Component | Status |
|---|---|
| `Whatsmeow.Repo` (Ecto/Postgres) | ✅ |
| 17 tables, 16 schemas + changesets | ✅ |
| `Whatsmeow.Store` behaviour | ✅ |
| `Whatsmeow.Store.Postgres` default implementation | ✅ |
| Migration `priv/repo/migrations/20260101000001_create_whatsmeow_schema.exs` | ✅ |
| `--persist` in smoke task → upsert paired device row | ✅ |
| `Whatsmeow.Store.Container` (find-or-create by host-supplied `client_id`) | ✅ |

`Store.Postgres.new_device/1` derives `signed_pre_key_sig` via `XEdDSA.sign(identity_priv, <<5, spk_pub::binary>>)` when the caller doesn't supply one — mirrors Go's `keys.KeyPair.Sign` and prevents the random-bytes-by-default trap that produces `<stream:error 500>` on first connect.

### 3.11 Media — `lib/whatsmeow/media/`

| Module | Capability | Status |
|---|---|---|
| `Media.Upload` | HKDF media keys + AES-CBC + HMAC-SHA256 — produces ciphertext + MAC for the upload endpoint. | ✅ |
| `Media.Download` | Reverse path; verifies HMAC before returning plaintext. | ✅ |
| `Media.Conn` | Host cache + TTL + URL rotation (`url_for/2`, `all_urls/1`). | ✅ |
| `Media.Finch` | `stream_get/3`, `stream_put/4`, `collect_body/1` — Finch-backed streaming for large payloads. Expects a Finch instance named `Whatsmeow.Finch`. | ✅ |
| Round-trip tests | image / video / audio / document / sticker | ✅ |
| Tamper-MAC rejection | flipped MAC byte → decrypt error | ✅ |

### 3.12 App state sync — `lib/whatsmeow/app_state/`

| Module | Capability | Status |
|---|---|---|
| `LTHash` | Full pure-Elixir 64-slot u16-LE homomorphic hash. Used by WhatsApp to commit to an unordered set of mutations. | ✅ |
| `Keys` | HKDF expansion to 5 sub-keys + patch-name constants. | ✅ |
| `Hash` | `HashState` struct, `update_hash/3`, snapshot/patch/content/index MAC helpers. | ✅ |
| `Encode` | Mutation encryption + snapshot/patch MAC generation. | ✅ |
| `Decode` | Mutation decryption + MAC verification (content / index / snapshot / patch). | ✅ |
| `Recovery` | gzip-decompress + per-record index MAC computation. | ✅ |
| `Errors` | Error atom catalogue. | ✅ |
| Property tests | LTHash homomorphism + commutativity + wrap-at-2^16; Encode→Decode round-trip; tampered-ciphertext rejection | ✅ |
| Live | 5000+ patch first-sync against server-reported hash | ❌ needs live server |

### 3.13 Argo / Newsletters / Armadillo — `lib/whatsmeow/argo/`, `armadillo.ex`, `newsletter.ex`

| Module | Capability | Status |
|---|---|---|
| `Argo.Varint` | ULEB128 + ZigZag | ✅ |
| `Argo.Label` | Sentinel-aware signed varints | ✅ |
| `Argo.Wire` | Wire-type tags | ✅ |
| `Argo.SelfDescribing` + `SelfDescribingEncoder` | Round-trip codec for the self-describing wire format | ✅ |
| `Argo.Store` | Query-id ↔ message-name lookup, `:persistent_term` cache | ✅ |
| `Armadillo` | Versioned SubProtocol envelope codec + FB/IG version routing | ✅ |
| `Newsletter.build_subscribe_iq/N` | IQ builder | ✅ |
| Live newsletter subscribe + reporting | | ❌ needs server |

### 3.14 Send / Receive — `lib/whatsmeow/`

| Module | Capability | Status |
|---|---|---|
| `Send` | Message-ID generator + `build_text_node/3`. | ✅ builder |
| `Receipt` | `from_node/2` decoder for delivery / read / played / server-error / inactive / sender receipts + **`build_ack/2`** + **`build_delivery_receipt/1`** | ✅ |
| `Retry` | Exponential backoff scheduler. | ✅ |
| `MsgSecret` | HKDF use-case key derivation + AAD construction for poll-vote / event-response. | ✅ |
| `Notifications` | Per-device + global `Phoenix.PubSub` broadcast/subscribe. | ✅ |
| **`PreKeyBundle`** | `<iq type="result"><list><user>` → `%PreKeyBundle{}` decoder. Tolerates the optional `<keys>` wrapper, optional one-time pre-key, surfaces `<error>` children. Mirrors Go's `nodeToPreKeyBundle`. | ✅ 11 unit tests |
| **`MessagePadding`** | Pre-encryption padding scheme — `pad/1` writes 1-15 random repeated bytes (low-nibble, non-zero); `unpad/2` enforces the invariant. `v=3` (Armadillo) is a passthrough. Direct port of Go's `padMessage` / `unpadMessage`. | ✅ 200-iter property + bad-padding rejections |
| **`MessageInfo`** | Parse inbound `<message>` envelope attrs into `%MessageInfo{id, from, to, type, timestamp, participant, push_name, is_group?, is_from_me?}`. JID-coerced. Mirrors Go's `types.MessageInfo`. | ✅ 8 unit tests |
| **Inbound `<message>` dispatch in `Whatsmeow.Session`** | `handle_info/2` routes `<message>` through `MessageInfo.from_node/2`, broadcasts `%Events.UndecryptableMessage{enc_type, enc_version, enc_payload}` per `<enc>` child, emits `[:whatsmeow, :session, :message_undecryptable]` telemetry, sends `<ack>` so the server stops resending. | ✅ unit-tested + live-verifiable |
| **`<receipt>` / `<notification>` / `<call>` ack** | All three now ack via `Receipt.build_ack/2`; the server stops resending. | ✅ |
| **Smoke task `--relogin` listen mode** | After `<success>`, holds the WSS open, auto-pings every 25 s, surfaces inbound `<message>` with id/from/type + per-`<enc>` ciphertext length. | ✅ live-test ready |
| **`Whatsmeow.Send.send_text/3`** | First-contact (`<enc type="pkmsg">`) and steady-state (`<enc type="msg">`) orchestration. Looks up persisted Signal session; on miss fetches the peer's pre-key bundle via `Session.send_iq` + `IQ.build_prekeys_get/2`, runs `X3DH.initiator_agree/5`, encrypts via `WireEncrypt.encrypt_prekey_envelope/5`, persists the advanced session. | ✅ |
| **`Whatsmeow.Send.send_image/4` / `send_video/4` / `send_audio/4` / `send_voice/4` / `send_document/4`** | Media upload (HKDF media-keys + AES-CBC + HMAC + CDN POST) → embed `(url, direct_path, media_key, file_sha256, file_enc_sha256, file_length)` into the WaE2E proto → Signal encrypt → `<message><enc>` framing. | ✅ |
| **Inbound `<message>` Signal decrypt** | `Session.try_decrypt_and_broadcast/3` routes pkmsg/msg/skmsg through `Whatsmeow.Signal.Decrypt`, broadcasts `%Events.Message{message: %Types.Message{}, info}` on success (plus one `%Events.MediaMessage{}` per attachment), or `%Events.UndecryptableMessage{}` with a typed reason on failure. Sends `<receipt>` (the double-tick) on success. | ✅ live-validated 2026-05-12 |
| **Inbound `<enc type="skmsg">` (group)** | `Whatsmeow.Signal.GroupDecrypt.decrypt_envelope/2` with auto-seeded `%GroupSession{}` from any SKDM in a preceding 1:1 message. | ✅ |
| **PreKey bundle upload** | `Whatsmeow.PreKeys.upload/2` auto-runs on every `Session` post-login bootstrap. 812-key initial vs 50-key top-up. | ✅ |

### 3.15 Groups / Presence / Calls — `lib/whatsmeow/group.ex`, `presence.ex`, `call.ex`

| Surface | Status |
|---|---|
| `Group.build_create_iq/N` | ✅ builder |
| `Presence.build_presence/N` | ✅ builder |
| `Call.from_node/1` | ✅ decoder |
| **Inbound group `<enc type="skmsg">` decrypt** | ✅ `GroupSession` + `GroupDecrypt` + auto-seeding from inbound SKDM in 1:1 plaintext |
| Outbound group `<enc type="skmsg">` send | ❌ cipher layer ready (`GroupDecrypt.encrypt_envelope/2`); `<usync>` member discovery + SKDM fanout to every member device in `Whatsmeow.Send` TODO |
| Live group create / participant management | ❌ |
| Contact sync | ❌ |

### 3.16 Process model — `lib/whatsmeow/{session,application,iq}.ex` + `lib/whatsmeow.ex`

| Surface | Status |
|---|---|
| `Whatsmeow.Application` — Starts Repo, PubSub, Registry, DynamicSupervisor, Task.Supervisor | ✅ |
| `Whatsmeow.Sessions.Supervisor` (DynamicSupervisor, `one_for_one`) | ✅ |
| `Whatsmeow.Sessions.Registry` (Registry, `keys: :unique`) | ✅ |
| `Whatsmeow.Session` — `start_link/1`, `connect/1`, `stop/1`, `whereis/1`, **`info/1`**, **`send_node/2`** | ✅ |
| `handle_cast(:connect)` driving `Whatsmeow.Transport.Handshake.run/1` | ✅ |
| **`handle_info/2` dispatch tree** — routes raw `{:ssl, _, _}` mailbox messages through `process_message/2` → `Frame.read_frames/1` → `NoiseSocket.decrypt/2` → `Binary.decode/1` → tag-dispatch tree (`<iq><pair-device>`, `<iq><pair-success>`, `<success>`, `<failure>`, `<stream:error>`, `<iq type="result">`, `<xmlstreamend>`) | ✅ |
| **Keepalive timer** — `<iq xmlns="w:p" type="get" to="s.whatsapp.net">` every 25 s ± 2.5 s (jittered); 3 consecutive un-acked pings force a reconnect | ✅ |
| **Reconnect-with-backoff** — exponential `2^attempts × 1s`, capped at 5 min, +0–500 ms jitter; cancellable; stale-firing-safe (older `{:reconnect, n}` messages are dropped) | ✅ |
| **`<failure>` disables auto-reconnect** — prevents looping into ban conditions on `401`/`403`/`405` | ✅ |
| **IQ correlation** — `pending: %{id => :keepalive \| {caller_pid, ref}}` on the Session struct; matching `<iq type="result">` either clears keepalive failure counter or sends `{:whatsmeow_iq, ref, node}` back to the caller | ✅ |
| **Telemetry events** — `[:whatsmeow, :session, :connect, {:start, :stop}]`, `:stream_error`, `:pair_success`, `:logged_in` | ✅ |
| **Auto-persist device row** after `<pair-success>` (tolerates absent Repo for tests) | ✅ |
| `Whatsmeow.IQ` — `generate_id/0` (16-char lowercase hex), `build_keepalive/1` (`xmlns="w:p"` ping), `build_prekeys_get/2` (`<iq xmlns="encrypt"><key><user jid=… reason=…/>`) | ✅ |
| `WebSocket.process_message/2` callback — event-driven counterpart to `recv/2`; lets the GenServer mailbox stay responsive instead of blocking | ✅ |
| `Whatsmeow.start_session/1` / `stop_session/1` / `list_sessions/0` / `subscribe/1` | ✅ |
| `Whatsmeow.Store.find_or_new_device/1` (host-supplied `client_id`) | ✅ |

### 3.17 Eventing — `lib/whatsmeow/types/events.ex`

`Phoenix.PubSub` topic `"whatsmeow:device:" <> device_id`. Subscribers receive `{:whatsmeow, event_struct}` messages. Defined event structs:

- `Connected` — Noise handshake complete + post-auth bind.
- `LoggedIn` — `<success>` decoded; carries `lid` + `server_time_offset`.
- `Disconnected` — TCP/WS lost.
- `LoggedOut` — Account unlinked on the WhatsApp side.
- `QR` — QR code refresh.
- `PairSuccess` — Pairing handshake completed.
- `PairError` — Pairing failed.
- `Message` — Decrypted message arrived.
- `Receipt` — Delivery / read receipt.
- `Presence` — Presence change.
- `GroupInfo` — Group info / participant change.
- `CallEvent` — Inbound call signaling.
- `Contact` — Contact info changed.

The crypto-side events (`PairSuccess`, `LoggedIn`) are emitted today; the message-flow events wait on Phase 9.

---

## 4. Live-verified end-to-end flows

These are flows that have been executed against the **real** `web.whatsapp.com` and observed working — not just unit-tested.

### 4.1 QR pairing (live-verified 2026-05-12)

```
mix whatsmeow.smoke --dump-raw
```

1. `WAVersion.refresh/1` GETs `https://web.whatsapp.com/` and scrapes the live `client_revision` → `:persistent_term`.
2. Mint opens `wss://web.whatsapp.com/ws/chat`.
3. `Handshake.run/1` drives the XX three-message dance. Server accepts our `ClientPayload` (registration variant) — proven by the absence of `<stream:error 500>`.
4. First post-handshake frame: `<iq><pair-device>` with multiple `<ref>` strings.
5. `Pair.handle_pair_device/2` builds the canonical QR payloads; `QRChannel.render_terminal/1` prints a compact half-block QR.
6. User scans on the WhatsApp phone app.
7. Second post-handshake frame: `<iq><pair-success>` with `<device-identity>` containing `ADVSignedDeviceIdentityHMAC` bytes.
8. `Pair.handle_pair_success/2` decodes, verifies the HMAC with `adv_key`, verifies the account signature with XEdDSA, generates our device signature with XEdDSA-sign, builds the `<pair-device-sign>` ack IQ.
9. Ack IQ is sent. Optionally (`--persist`) the device row is upserted into Postgres.

### 4.2 Login-payload reconnect (live-verified 2026-05-12)

```
mix whatsmeow.smoke --relogin --dump-raw
```

Continues from §4.1 after the ack:

10. Server closes the WSS shortly after the ack (this is normal).
11. `drain_until_closed/1` waits up to 5 s for the goodbye.
12. A fresh WSS is opened.
13. `Handshake.run/1` runs again. This time `ClientPayload.build/1` routes to `login_payload/1` because the device has a numeric WA JID.
14. First post-handshake frame: `<success lid="…" t="…">`.
15. `Login.parse_first_node/1` extracts `lid` and `server_time_offset`. Mission accomplished.

### 4.3 The two `<stream:error code="500">` traps and their fixes

Both were diagnosed and fixed during the port:

| Root cause | Symptom | Fix |
|---|---|---|
| Stale `client_revision` (hardcoded pin drifted) | `<stream:error code="500">` immediately after handshake | `Whatsmeow.WAVersion` — `:persistent_term`-cached live scrape, proxy-aware |
| Random bytes used as `signed_pre_key_sig` instead of a real XEdDSA signature | `<stream:error code="500">` immediately after handshake | `Whatsmeow.Crypto.XEdDSA.sign(identity_priv, <<5, spk_pub::binary>>)` — wired into both the smoke task's device factory and `Store.Postgres.new_device/1` |

Both look identical on the wire, which made the second one easy to misdiagnose as the first. Memory in `~/.claude/projects/.../memory/whatsmeow_500_root_cause.md` captures the discrimination for next time.

---

## 5. Test inventory

`mix test` (excluding `:integration` and `:external` tags) reports **4 doctests, 5 properties, 352 tests, 0 failures** as of `2026-05-12`. Broken down:

| Test file | Focus |
|---|---|
| `whatsmeow_test.exs` | Public facade — start_session / stop_session / list_sessions |
| `whatsmeow_ex_test.exs` | Module presence smoke |
| `whatsmeow/binary_test.exs` | Encoder + decoder round-trip; nibble + hex packed strings; JID encoding |
| `whatsmeow/binary_property_test.exs` | StreamData property — random `Node` trees round-trip |
| `whatsmeow/client_payload_test.exs` | Registration + login wire encoding round-trip |
| `whatsmeow/crypto_test.exs` | RFC vectors for X25519, HKDF, ChaCha20-Poly1305, AES-GCM |
| `whatsmeow/crypto/xeddsa_test.exs` | Verify path + birational map + degenerate-input handling |
| `whatsmeow/crypto/xeddsa_sign_test.exs` | **100-iter property:** sign(priv, msg) verifies via `:crypto.verify(:eddsa)` + tamper detection |
| `whatsmeow/jid_test.exs` | Parse + atom-safety property test (no atom growth across 100 random JIDs) |
| **`whatsmeow/login_test.exs`** | **`<success>` happy path + JID-typed `lid` normalization + missing/empty/malformed-attr tolerance + `<stream:error>` + `<failure>` — 9 tests** |
| `whatsmeow/media/*_test.exs` | Upload/Download round-trip × 5 media types + tamper |
| `whatsmeow/notifications_test.exs` | PubSub broadcast + subscribe |
| `whatsmeow/pair_test.exs` | `handle_pair_success/2` — happy + 4 error paths (hmac mismatch, missing pair-success, missing device-identity, key rotation) |
| `whatsmeow/qr_channel_test.exs` | Canonical payload + terminal + SVG render |
| **`whatsmeow/session_test.exs`** | **Session dispatch tree (`<success>` → LoggedIn + keepalive schedule, `<failure>` → LoggedOut + disable auto-reconnect, `<stream:error>` → telemetry, IQ-id routing for keepalive + caller-pid), failure-reason-atom mapping, exponential backoff shape + 5min cap, lifecycle (info/1, start/stop) — 12 tests** |
| **`whatsmeow/iq_test.exs`** | **`generate_id/0` uniqueness, `build_keepalive/1` shape (`xmlns="w:p"`, `type="get"`, `to="s.whatsapp.net"`), `build_prekeys_get/2` per-user JID + reason child — 7 tests** |
| `whatsmeow/signal/*_test.exs` | Ratchet KDF + 1:1 round-trip + group sender-key + out-of-order property (caught counter-increment bug); `wire_test.exs`, `wire_decrypt_test.exs`, `wire_encrypt_test.exs` for libsignal 1:1 wire envelopes; `sender_key_wire_test.exs` for skmsg wire codec |
| **`whatsmeow/signal/group_decrypt_test.exs`** | **`GroupSession.from_distribution/1` round-trip + bad-signing-key + bad-chain-key rejections; encrypt → decrypt round-trip; multi-message in-order delivery; out-of-order with skipped-key cache; replay rejection; tampered-signature rejection; wrong-signer rejection; wire envelope shape (`<<0x33>> || proto || sig[64]`); distribution-message DJB-type prefix; Curve25519 keypair sanity — 12 tests** |
| `whatsmeow/prekeys_test.exs` | `PreKeys.generate/2`, `build_upload_iq/3`, `prekey_to_node/1`, `signed_pre_key_node/3` shape + counts |
| `whatsmeow/send_test.exs` | `Send.build_text_message_node/4` + `build_e2e_text_message/1` shapes |
| `whatsmeow/media/*_test.exs` | Upload + Download + Conn + Refresh round-trip / tamper / host failover |
| `whatsmeow/transport/cert_verifier_test.exs` | Malformed cert / bad sig length / missing parts |
| `whatsmeow/transport/handshake_test.exs` | In-memory loopback simulating the server side of the XX dance |
| `whatsmeow/transport/noise_socket_test.exs` | Encrypt/decrypt round-trip + counter drift |
| `whatsmeow/transport/web_socket/mint_test.exs` | 4-tuple / shorthand / URL with Basic auth |
| `whatsmeow/wa_version_test.exs` | 14 tests including 4 Bypass-driven HTTP scrapes + `:persistent_term` round-trip + no-cache-on-failure invariant |
| `whatsmeow/app_state/*_test.exs` | LTHash homomorphism + Encode→Decode + MAC verify + tamper reject |
| `whatsmeow/argo/*_test.exs` | Varint + label + self-describing nested encode/decode |
| `whatsmeow/armadillo_test.exs` | Envelope marshal/unmarshal + FB/IG routing |
| `whatsmeow/msg_secret_test.exs` | HKDF derivation + poll-vote/event-response AAD |
| `whatsmeow/receipt_test.exs` | Decoder for all 6 receipt types |

### 5.1 What's **not** in CI

- Any test that talks to `web.whatsapp.com` (run manually via `mix whatsmeow.smoke`).
- Postgres integration tests requiring a running DB (gated behind `:integration` tag).
- A `signal-cli` cross-validator (planned).
- A multi-day soak test (the eventual `v1.0.0-rc` gate).

---

## 6. Locked vs scaffolded vs missing

### Locked (cryptographically critical paths protected by tests)

- All `:crypto` primitives against RFC vectors
- Binary codec round-trip on random `Node` trees
- Noise XX handshake symmetry (Alice + Bob → same key after X25519 + HKDF mix)
- Signal Ratchet KDF determinism
- 1:1 Session encrypt → decrypt round-trip
- Out-of-order delivery via skipped-key cache (property test)
- Group SenderKey home-grown encrypt → decrypt round-trip
- **Group libsignal-wire `<enc type="skmsg">` encrypt → decrypt + tampered signature rejection + wrong-signer rejection + replay rejection + out-of-order via skip cache (12 tests)**
- Media upload → download × 5 media types + tamper detection
- LTHash homomorphism + commutativity + wrap-at-2^16
- AppState Encode → Decode + snapshot/patch MAC verify + tamper rejection
- MsgSecret HKDF + AAD
- Argo varint + self-describing encode/decode
- Armadillo envelope marshal/unmarshal + FB/IG version routing
- **XEdDSA sign + verify** round-trip (100-iter property, cross-validated by stdlib `:crypto.verify(:eddsa)`)
- **`<pair-success>` end-to-end** (HMAC, account sig, device sig, ack IQ shape) — 9 tests
- **`<success>` post-login decoder** (`Login.parse_first_node/1`) — 9 tests covering all three valid stanza shapes
- **WAVersion fetch + parse + persist** — Bypass-driven HTTP scrape + `:persistent_term` round-trip + no-cache-on-failure
- **Mint proxy spec parser** — 4-tuple / shorthand / URL with Basic-auth
- **libsignal-wire 1:1 envelope** — `Wire.compute_mac/4` with DJB-type prefix, `SignalMessage` / `PreKeySignalMessage` round-trip, MAC tamper rejection
- **`SenderKeyWire`** — wire shape `<<0x33>> ‖ proto ‖ sig[64]` for `SenderKeyMessage` and `<<0x33>> ‖ proto` for `SenderKeyDistributionMessage`

### Scaffolded (compileable + structurally complete, needs live wiring)

- `Whatsmeow.Send` — builders exist; wire path through `WAWebProtobufsE2E` is the remaining chunk
- `Whatsmeow.Receipt` / `Retry` / `MsgSecret` — used internally by Session once Phase 9 outbound lands
- `Group` / `Presence` / `Call` — IQ builders + decoders ready; live exchange pending
- `PairCode` — phone-number pair-code builder; live IQ exchange not wired

### Missing (deliberate next-step work)

- **Outbound group send (`<enc type="skmsg">` fanout)** — `GroupDecrypt.encrypt_envelope/2` is in. Need `Whatsmeow.Send.send_text_to_group/3` that fans out the SKDM to every member device via `<enc type="msg">` AND emits one `<enc type="skmsg">` for the body. Also needs `<usync>` member-device discovery.
- **Live group create / participant management / invite** — IQ builders exist (`Whatsmeow.Group`); live exchange untested.
- **History sync replay** — codec is in (`AppState.{Decode, Encode, Recovery}`); trigger for the 5 000+ patch first-sync isn't.
- **Newsletter live ops** — subscribe IQ builder exists; no end-to-end test.
- **Call IQ end-to-end** — decoder only.
- **Pair-code (phone-number) flow** — `Whatsmeow.PairCode` builder exists; live IQ exchange not wired.
- **WhatsApp Business catalog / order** — not started.
- **Retry-receipt on `:no_group_session`** — server-side retry-receipt protocol that triggers a peer-side SKDM redistribution.
- **`signal-cli` cross-validator in CI** — planned, not implemented.
- **`mix dialyzer` clean** — ≈100 modules; hours of `@spec` polish.
- **Publish `v0.1.0` to hex.pm.**

---

## 7. Production deps

```elixir
# Transport
{:mint, "~> 1.7"},
{:mint_web_socket, "~> 1.0"},
{:castore, "~> 1.0"},
{:finch, "~> 0.20"},

# Protocol + state machines
{:protobuf, "~> 0.13"},
{:gen_state_machine, "~> 3.0"},

# Persistence
{:ecto_sql, "~> 3.12"},
{:postgrex, "~> 0.20"},

# Eventing + observability
{:phoenix_pubsub, "~> 2.1"},
{:telemetry, "~> 1.3"},

# Misc
{:nimble_options, "~> 1.1"},
{:jason, "~> 1.4"},
{:qqr, "~> 0.2"}    # pure-Elixir QR rendering (no libqrencode)
```

All listed deps are pure Elixir / pure Erlang. **No NIFs, no Rustler, no native ports** at runtime.

---

## 8. Operational concerns (for fleets)

### 8.1 Memory per session

Estimated, not benchmarked:

| Component | Estimate |
|---|---|
| GenServer heap | 50–200 KB |
| Mint WS conn (TLS state + buffers) | 80–150 KB |
| Noise cipher state | < 1 KB |
| Signal session cache (private ETS) | 5–20 KB |
| IQ pending map | 1–10 KB |
| Process mailbox slack | 10–50 KB |
| **Per idle session** | **≈ 200–400 KB** |
| **Per active-chat session** | **≈ 500 KB – 1 MB** |

100 000 idle sessions × 300 KB ≈ 30 GB. Budget 40–60 GB BEAM heap with GC slack.

### 8.2 Proxy routing

The transport's `:proxy` option lets each session egress through a different residential / mobile proxy. Conventions:

- **One proxy per tenant** (or per geographic region), not per session. Stable IP → stable account is the safe pattern Meta's anti-abuse expects.
- Accepted forms: `{host, port}`, `{scheme, host, port}`, `{scheme, host, port, opts}`, `"http(s)://user:pass@host:port"`. URL userinfo becomes `Proxy-Authorization: Basic …` on the CONNECT.
- The smoke task redacts userinfo before logging.
- SOCKS5 isn't supported by Mint; almost all residential-proxy providers offer HTTPS endpoints too.

### 8.3 Version pinning per IP-pool

- **Refresh per IP-pool, not per-session.** Run a `GenServer` per residential-proxy bucket calling `Whatsmeow.WAVersion.refresh(proxy: pool_url)` every 30 min.
- **Refresh before boot.** Call `refresh/1` once before booting a fresh session if the cache is older than 30 min.

### 8.4 The single most damaging operational mistake

**Losing a paired device row.** Re-pairing destroys peer trust — every contact sees "security number changed". Treat encrypted device rows as high-value secrets, replicate them, snapshot Postgres.

### 8.5 What this library does **not** protect against

- Meta's rate limits and behavioural fingerprinting. Apply per-account token-bucket rate limits at the `Whatsmeow.Send` layer.
- A burnt residential pool. Budget for periodic pool rotation.
- Account bans for automation-looking patterns. Test with throwaway numbers.

---

## 9. Comparison vs Go upstream

| Aspect | Go `whatsmeow` | `whatsmeow_ex` |
|---|---|---|
| Process model | one `*Client` per device, goroutines internally | one `GenServer` per device, supervised |
| Signal | `go.mau.fi/libsignal` (Go port of libsignal) | pure-Elixir Double Ratchet + X3DH + SenderKey (re-implemented from spec) |
| Persistence | pluggable; default sqlite | pluggable behaviour; default Ecto/Postgres |
| Crypto | stdlib `crypto/*` | Erlang `:crypto` only + pure-Elixir Ed25519 |
| Transport | `gorilla/websocket` | `mint_web_socket` |
| Protobuf | `google.golang.org/protobuf` | `:protobuf` (hex) |
| Eventing | callback channels | `Phoenix.PubSub` topics |
| Process isolation | shared goroutines, panic = process death | crash-restart per device, free |
| Live status | production-ready | crypto + codecs + pair + login-payload-reconnect locked; outbound message wire WIP |

The Elixir version benefits from BEAM process isolation — a bug in session 47 cannot crash session 48. Where Go ships a working live client today, Elixir does not (yet); see §6 "Missing".

---

## 10. Roadmap (rough priorities)

**Next concrete milestones:**

1. **Outbound group send.** `Whatsmeow.Send.send_text_to_group/3` — `<usync>` discovery → per-member-device SKDM fanout → single `<enc type="skmsg">` body. Cipher layer is in (`GroupDecrypt.encrypt_envelope/2`); only the framing + fanout is missing.
2. **Retry-receipt path.** Server protocol that asks a peer to redistribute their SKDM when we hit `:no_group_session`. Builders exist; wiring into `Session.handle_info/2` is small.
3. **AppState 5000+ patch first-sync** against server-reported hash. The codec is locked; the trigger isn't.
4. **Group create / participant management** live exchange (builders exist).
5. **Pair-code (phone-number) flow** — non-QR pairing for headless deployments.
6. **`mix dialyzer` clean** — across ~100 modules.
7. **Phoenix bot example** at `examples/phoenix_bot/` with QR-in-LiveView, message stream, and observability hooks.
8. **Soak-test 10 sandbox accounts × 7 days.**
9. **Publish `v0.1.0` to hex.pm**; cut `v1.0.0-rc` after the soak.

---

## 11. Quick reference

**Files to read in this order if you're new to the codebase:**

1. `plan.md` — phased roadmap with check-marks
2. `GUIDE.md` — integration + operations guide
3. `lib/whatsmeow.ex` — public facade
4. `lib/whatsmeow/session.ex` — the per-device GenServer
5. `lib/whatsmeow/transport/handshake.ex` — XX choreography
6. `lib/whatsmeow/client_payload.ex` — registration vs login branch
7. `lib/whatsmeow/pair.ex` — `<pair-success>` end-to-end
8. `lib/whatsmeow/login.ex` — `<success>` end-to-end
9. `lib/mix/tasks/whatsmeow.smoke.ex` — the live integration test

**Mix tasks:**

```bash
mix whatsmeow.protoc            # regenerate proto modules from .proto sources
mix whatsmeow.gen.tokens        # regenerate binary-XML token tables
mix whatsmeow.smoke             # live pairing test (interactive)
mix whatsmeow.smoke --persist   # also write device row to Postgres
mix whatsmeow.smoke --relogin   # pair → close → reconnect with login_payload → assert <success>
mix whatsmeow.smoke --proxy URL # route through HTTP CONNECT proxy
mix whatsmeow.smoke --dump-raw  # echo decrypted bytes for debugging
mix test                        # unit suite (excludes :integration / :external)
```

**Two memory notes worth carrying between sessions** (in `~/.claude/projects/.../memory/`):

- `whatsmeow_500_root_cause.md` — the two distinct causes of `<stream:error 500>` and how to discriminate them.
- `whatsmeow_next_milestone.md` — what's done as of 2026-05-12 and what's next.
