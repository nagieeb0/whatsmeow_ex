# Usage

Task-oriented notes for the parts of `whatsmeow_ex` that need more than a docstring.
For installation and the overall design see [README.md](README.md).

- [Archive and mark-as-read (app-state patches)](#archive-and-mark-as-read-app-state-patches)

---

## Archive and mark-as-read (app-state patches)

```elixir
{:ok, version} = Whatsmeow.archive_chat(session, "201141465543@s.whatsapp.net")
{:ok, version} = Whatsmeow.unarchive_chat(session, "201141465543@s.whatsapp.net")
{:ok, version} = Whatsmeow.mark_chat_read(session, "201141465543@s.whatsapp.net")
{:ok, version} = Whatsmeow.mark_chat_unread(session, "201141465543@s.whatsapp.net")
```

These change the chat's state **on the account**, as if you had done it on the phone:
the chat moves to Archived in every linked device, the unread badge clears, and so
on. They return `{:ok, version}` — the new version of the `regular_low` collection —
or `{:error, reason}`, and never raise.

> ### ⚠️ Trial this on a spare number before a personal one
>
> App-state is end-to-end encrypted, and the keys are shared only between your own
> devices, so **WhatsApp's server cannot check a patch's MACs** — all it can check is
> the version the patch extends. A patch with a wrong MAC is therefore accepted,
> forwarded to your phone, and rejected *there*. What the phone then does is not
> something this project has observed: at minimum it breaks app-state sync for that
> collection, and Go whatsmeow documents a "fatal app state exception" recovery path
> that logs out all linked devices.
>
> What has been done to make that not happen:
>
> - the encoding is **byte-for-byte identical** to Go whatsmeow's for the same
>   inputs (tested against output of Go's own `appstate` package);
> - patches this library encodes are **decoded and MAC-verified by Go's real
>   decoder** (`mix test --include go_interop`);
> - every patch is **decoded back and MAC-verified locally before it is sent**; one
>   that does not verify is never sent (`{:error, {:self_check_failed, _}}`).
>
> What has **not** been done: none of this has been run against a live WhatsApp
> account. Everything above is against Go's code, not against WhatsApp.
>
> **Run it on a throwaway number first**, with the checklist
> [below](#trial-checklist), and only then on a number you care about. Keep any
> feature switch that calls it (e.g. imdent's) **off** until that trial is clean.

### What it sends

All in the `regular_low` collection, exactly as Go whatsmeow's `BuildArchive`,
`BuildMarkChatAsRead` and `BuildPin`:

| Call | Mutations in the patch |
| --- | --- |
| `archive_chat/3` | `["archive", jid]` v3 — `archived: true`, plus **`["pin_v1", jid]` v5 — `pinned: false`** (archiving unpins, as Go does) |
| `unarchive_chat/3` | `["archive", jid]` v3 — `archived: false` |
| `mark_chat_read/3` | `["markChatAsRead", jid]` v3 — `read: true` |
| `mark_chat_unread/3` | `["markChatAsRead", jid]` v3 — `read: false` |

The `jid` must be a chat on `s.whatsapp.net`, `lid` or `g.us`, without a device
suffix. Anything else is refused up front (`:invalid_jid`,
`{:unsupported_chat_jid, server}`, `{:device_jid_not_allowed, jid}`) — the phone
finds the chat by that exact string, so a wrong one would address a chat that does
not exist.

### The last message

An optional third argument says what the chat's latest message was, which the phone
uses for "archived up to here":

```elixir
Whatsmeow.archive_chat(session, jid)                       # "now", no message list
Whatsmeow.archive_chat(session, jid, 1_700_000_000)        # Unix seconds (or a DateTime)
Whatsmeow.archive_chat(session, jid, {1_700_000_000, key}) # timestamp + message key
Whatsmeow.archive_chat(session, jid,
  last_message_timestamp: 1_700_000_000,
  last_message_key: %{id: "3EB0…", remote_jid: jid, from_me: false})
```

A message key is `%{id: …, remote_jid: …, from_me: …, participant: …}` (or a
`WACommon.MessageKey`); `messages:` takes a list. Timestamps are seconds; an integer
that can only be milliseconds is converted rather than sent as a date thousands of
years out.

### Preconditions: the phone must have shared its keys

App-state is encrypted under keys that live on your primary phone. A linked device
cannot create them; the phone *shares* them, normally just after linking, in an
`AppStateSyncKeyShare` message. This library stores that share (only from your own
account) and then syncs `regular_low`.

**A device that was linked before this feature existed has no keys** — that message
arrived and was dropped. Its first call asks the phone for them and returns:

```elixir
{:error, {:key_not_found, <<key_id::binary>>}}
```

The request goes out as a peer message (at most once per key per 24 hours). When the
phone answers, the keys are stored and the collection is synced automatically; **retry
the call a little later**. The phone has to be online, and it may not answer.

### Errors

| `{:error, reason}` | Meaning | What to do |
| --- | --- | --- |
| `:invalid_jid`, `{:unsupported_chat_jid, _}`, `{:device_jid_not_allowed, _}` | the chat JID | fix the input |
| `:invalid_last_message`, `:invalid_timestamp` | the third argument | fix the input |
| `:no_session`, `:offline_session` | no live session (an offline/sandbox session only records sends) | start a real session |
| `{:key_not_found, id}` | a key we don't have; it has been requested from the phone | retry later |
| `:no_app_state_keys` | the store has no key at all (and nothing to learn one from) | wait for / trigger a key share |
| `{:rejected, %{code: code, text: text}}` | the server refused the patch | log it; don't hammer |
| `{:conflict_resync_failed, reason, _}` | the server was ahead; applying its patches failed verification | see *Recovery* |
| `{:resync_failed, reason}` | **the patch was accepted**; re-reading the collection afterwards failed | do **not** blindly resend; call `Whatsmeow.AppState.sync/3` |
| `{:self_check_failed, reason}` | our own patch did not verify, so **nothing was sent** | a bug — please report it |
| `{:mismatching_lthash, v}`, `{:mismatching_patch_mac, v}`, `{:mismatching_content_mac, n}`, `{:mismatching_index_mac, n}` | a patch from the server failed verification | see *Recovery* |
| `{:iq_error, %{code: _, text: _}}`, `:timeout` | the request itself failed | retry |
| `:lock_timeout` | another app-state operation on this device is stuck | retry |
| `{:store, reason}` | persistence failed (e.g. `{:store, :no_store}` without a Repo) | see *Persistence* |
| `{:exception, msg}`, `{:exit, reason}` | something below raised or exited; it was caught | report it |

### How a send works

1. Read the stored version and LTHash for the collection. A collection **never
   synced is fetched first** — sending against version 0 when the server is further
   along can only conflict.
2. Encode under the newest stored key.
3. **Self-check**: decode the encoded patch back through the verifying path and
   compare. Not verifiable → not sent.
4. Send. A **`409`** means the server is ahead of us: the patches it returns are
   verified and applied, and the send is **retried once**. A second `409`, or any
   other refusal, is returned as is.
5. On success, re-read the collection from the version we extended; the server hands
   our own patch back, which re-verifies it and advances local state.

Operations on one device are serialised by a lock, so a fetch can never race a send
from the same stored hash.

### Recovery

If local state has diverged from the server's (a verification error that repeats),
discard it and re-read everything:

```elixir
{:ok, version} = Whatsmeow.AppState.sync(session, "regular_low", full_sync: true)
```

`full_sync` clears the stored version **and every stored mutation MAC** for that
collection before taking the snapshot. (Go only drops the version row; a MAC left
behind for an index that is not in the new snapshot would be subtracted from a hash
that never contained it, after which no patch would verify.)

### Persistence and configuration

App-state needs the database: keys, each collection's version + 128-byte LTHash, and
per-index value MACs live in `whatsmeow_app_state_sync_keys`,
`whatsmeow_app_state_version` and `whatsmeow_app_state_mutation_macs` — tables the
existing migration already creates. The DETS adapters cover the Signal layer only;
without a Repo these calls return an error tuple.

```elixir
config :whatsmeow_ex,
  # which collections to sync when the phone shares keys (default shown)
  app_state_collections: ["regular_low"],
  # the persistence module (default shown)
  app_state_store: Whatsmeow.AppState.Store.Postgres
```

`regular_low` (chat pin/archive/read state) is all that archive and mark-as-read
need. The other four collections hold your contact list and settings and are off by
default; add them to `:app_state_collections` only if you want them synced.

### What this does *not* do

- **No events** for changes made elsewhere. A chat archived on the phone is verified
  and applied to the stored state — it has to be, or the next send would conflict —
  but no event is broadcast and no chat-settings table is updated.
- **Only `regular_low`** is wired up, and only these four actions plus `build_pin/2`
  in `Whatsmeow.AppState.Patch`.
- **Mute, star, labels, delete-chat, push name** etc. are not built, although Go has
  builders for them.
- **No key creation.** If the phone never shares a key, nothing can be sent.

### Trial checklist

On a **spare number** (a throwaway SIM you do not mind losing), linked to this
library as a companion device:

1. Link it and let it settle. Check the logs for `app-state` lines; there should be
   a stored key and a completed `regular_low` sync, no `mismatching`.
2. On the phone, make two or three test chats.
3. `archive_chat/3` one → it should move to **Archived** on the phone within seconds.
4. `unarchive_chat/3` it → back in the main list.
5. `mark_chat_unread/3`, then `mark_chat_read/3` → the badge appears, then clears.
6. Do each of the above while *also* archiving/pinning a different chat on the phone
   at the same moment, to exercise the `409` path.
7. Throughout: the phone must stay linked, show no "syncing"/reset notice, and the
   logs must show no `mismatching` and no `self_check_failed`.

Only when that is clean, try the personal number — and still start with one chat you
do not mind about.

### Testing the implementation itself

No test needs the network.

```bash
mix test                              # everything below, except the opt-in Go check
mix test --include go_interop         # also run Go's real decoder over our patches
```

- `test/fixtures/app_state/go_vectors.json` is **output of Go whatsmeow's own
  `appstate` package** — MAC primitives, and ten patches Go encoded/built and
  decoded. Regenerate with `scripts/app_state_vectors/run.sh gen` (needs `go` and
  module-download network; reads the vendored `whatsmeow-main/`).
- `go_interop` builds a small Go program over a verbatim copy of that package and has
  it decode-and-verify patches this library produced, with random IVs, in chains.
- Sync tests run against a fake server whose "phone" independently verifies every
  patch it is forwarded (the real server cannot, and neither does the fake server).
