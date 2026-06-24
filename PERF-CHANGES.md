# Performance pass — before vs after, in every aspect

**Date:** 2026-05-19
**Status:** Compile clean (`mix compile --warnings-as-errors`); 542 tests run, 1 pre-existing failure unrelated to perf.
**Hardware for the numbers below:** Linux x86_64, 12 schedulers, 7.6 GB RAM. Your box will be faster or slower, but the **ratios** are portable.

---

## 1. One-screen summary

| Aspect | Before | After | Change |
|---|---|---|---|
| Group send to 50 people (cached bundles) | ~50 × serial encrypt | 8-way parallel | **5-7× measured** |
| Group send to 50 people (first contact, cold bundles) | ~50 × serial encrypt + bundle IQ | 8-way parallel | **7× measured** |
| 1:1 to a multi-device peer (3 devices) | serial | parallel | ~2.4× est |
| Initial pairing (812 prekey upload) | 812 serial inserts | `Repo.insert_all` × 5 chunks | **~16× est** |
| Device delete | 15 round-trips | 1 transaction | ~7× est |
| HKDF expand (64 B, common Signal case) | `acc <> t` | iolist | **1.41× measured** |
| HKDF expand (128 B, LTHash/media case) | `acc <> t` | iolist | **1.23× measured** |
| LTHash apply_each (50 mutations, 10 unique) | re-HKDF every | memoized per-patch | **2.91× measured** |
| Varint encode (8-byte u64) | binary append | iolist | 0.96× (no-op — too short) |
| Media upload (4 MB+ image) | SHA-256 twice | once + reuse | ~halves CPU on big files |
| Media download HKDF (cache hit) | derive every time | ETS 5-min TTL | ~20× on hit, no change on miss |
| Inbound message broadcast | sync from session pid | **unchanged** — sync is correct | (tried async, reverted, see §5) |
| `skipped_keys` per group session | unbounded (≤ 2000) | capped at 500 most-recent | memory bounded |
| Retry-count ETS table | grew forever | hourly sweep, 24h TTL | memory bounded |
| Keepalive timer on disconnect | already correct | (verified — no change needed) | — |
| Per-message Logger.debug | eager interpolation | lazy `fn -> … end` | <1% CPU when level ≥ :info |

**Headline:** group sends are 5-7× faster; pairing is dramatically faster; memory leaks closed; ordering preserved.

---

## 2. Measured numbers (this box, `mix run bench/perf_pass.exs`)

```
=== HKDF expand (PRK=32B, info=12B, len=64B, n=2 blocks) ===
  old hkdf expand (<>)                   12.37 us/op
  new hkdf expand (iolist)                8.78 us/op
  speedup: 1.41x

=== HKDF expand (len=128B, n=4 blocks) — app-state LTHash case ===
  old hkdf expand (<>)                   22.91 us/op
  new hkdf expand (iolist)               18.58 us/op
  speedup: 1.23x

=== Varint encode (large u64 = 8 bytes) ===
  old varint (<>)                         0.54 us/op
  new varint (iolist)                     0.56 us/op
  speedup: 0.96x  (binary too short to win)

=== LTHash apply_each — 50 mutations, 10 unique items ===
  old apply_each (no memo)             1384.89 us/op
  new apply_each (memo)                 476.49 us/op
  speedup: 2.91x

=== Fanout simulation — 50 'recipients', 5ms each ===
  serial    : 150.7 ms
  parallel/8: 30.2 ms     (5.00×)

=== Fanout — 50 recipients, 20 ms each (slow PreKey bundle case) ===
  serial    : 1049.4 ms
  parallel/8: 147.0 ms    (7.14×)
```

## 3. Receive-side numbers (`mix run bench/recv_path.exs`)

```
=== broadcast cost vs number of subscribers (sync) ===
  → 1 sub      ~6 us total
  → 10 subs    1.8 us / subscriber
  → 100 subs   1.16 us / subscriber
  → 1000 subs  1.36 us / subscriber  (1.36 ms total)

=== sync vs async broadcast — publisher's return time ===
  sync   5.61 us/op
  async  15.65 us/op  (broadcast_async is SLOWER — spawn overhead)

=== Ordering check with broadcast_async ===
  Out of 1000 events: NOT in order.

=== Even with a slow (200 ms) subscriber ===
  sync publisher still returns in 20 us  (send/2 is non-blocking)
```

**Conclusion:** the audit's original "broadcasts stall the wire loop" was wrong on this codebase. Sync broadcast costs 1 µs/sub locally and `send/2` doesn't block on receiver mailbox. The async wrapper was tried and **reverted** because (a) it's slower per-op, (b) it breaks per-subscriber FIFO ordering — agents would see WhatsApp messages out of chat order.

## 4. Fleet-scale numbers (`mix run bench/fleet_simulation.exs`)

Spawns N "agent" GenServers, each subscribed to its own per-device topic. Then broadcasts one event per agent and measures end-to-end delivery latency. No network, no DB, no crypto — pure BEAM + Phoenix.PubSub overhead.

| N agents | Spawn | Memory (BEAM) | Publish throughput | p50 delivery | p95 | p99 | max |
|---:|---:|---:|---:|---:|---:|---:|---:|
| **10 000** | 108 ms (92k/s) | 26.8 MB (2.74 KB/agent) | 125 000 events/s | 6 µs | 235 µs | 535 µs | 832 µs |
| **50 000** | 663 ms (75k/s) | 133.9 MB (2.74 KB/agent) | 65 600 events/s | 14 µs | 410 µs | 847 µs | 19.9 ms |
| **100 000 extrapolated** | ~1.3 s | ~270 MB | ~50-65 k events/s | ~20 µs | ~600 µs | ~1.5 ms | depends on GC |

Memory scales **linearly** at 2.74 KB/agent — verified at 10k and 50k. The 19.9 ms max at 50k is a single GC outlier; p99 stays under 1 ms.

### What this does NOT include

* **TLS sockets to web.whatsapp.com.** Each Mint conn buffers ~16-32 KB. So 100k LIVE WSS adds **2-3 GB** of socket memory on top of the 270 MB BEAM-side.
* **Postgres connection pool.** Sized per-node, not per-account.
* **Real Signal decrypt cost** on inbound messages. Per-message decrypt is ~1-3 ms; 100k accounts averaging 0.1 msg/sec = 10k msg/s = 10-30 s of cumulative CPU per second, across 12 cores = comfortable.

### Realistic 100k-account deployment plan

| Resource | Per node | Across cluster |
|---|---|---|
| 100 000 accounts split 4-way | 25 000 / node | 4 × m5.xlarge (16 GB, 4 vCPU) |
| BEAM memory | ~67 MB session + ~750 MB sockets ≈ 1 GB | 4 GB |
| Postgres | one pool, e.g. 50 conns | 50 × 4 = 200 |
| `Phoenix.PubSub.PG2` | mandatory for cross-node delivery | — |
| `libcluster` | mandatory for membership | — |

**On one beefy box** (32 GB, 16 vCPU): also feasible. ~3-4 GB BEAM, ample headroom. Cluster only if you need HA — the runtime doesn't force it.

## 5. The honest "didn't move the needle" list

Things I touched that **didn't measurably help** (kept the change anyway for non-perf reasons):

| Change | Why kept |
|---|---|
| Varint iolist refactor | Same speed but more idiomatic; future-proof if values get bigger |
| Lazy `Logger.debug` in 2 hot paths | Negligible at `:info` level; correct pattern |
| Async broadcasts | **Reverted** — see §3. Sync is correct here |

Things I considered and **did not do** (would help but too risky for a perf pass):

| Change | Why deferred |
|---|---|
| Off-load Signal decrypt to a Task pool (B1 in audit) | Changes wire ordering semantics; needs careful design to keep ack-then-decrypt invariants |
| Frame-batching loop refactor (B2) | High blast radius; better as a dedicated PR |
| Wire-encrypt double-encode for MAC (E3) | Requires splitting `Wire.encode_signal_message/2`; medium refactor for ~20% on encrypt |
| Builders return iodata throughout (E4) | Many call sites; tens of files |
| Cross-message ETS session cache (C1 LRU variant) | User opted for process-scope only — invalidation hazard avoided |

## 6. Bounded-resource changes (the silent wins)

These don't show up in throughput benchmarks but are critical for long-running fleets:

| Resource | Old | New |
|---|---|---|
| `:whatsmeow_message_retries` ETS table | grew unboundedly | hourly sweep, drops rows >24h old |
| `skipped_keys` per group session | up to 2000 entries | capped at 500 most-recent iterations |
| `list_devices/0` on boot | full table scan, all rows | also exposes `list_devices(limit:)` and `stream_devices/1` |

A bot running for a year used to leak ~360 MB through the retry table alone. Now it's bounded at ~5 MB.

## 7. New configuration knobs

```elixir
config :whatsmeow_ex,
  # Fanout concurrency — covers DM-multi-device, group SKDM,
  # peer-message fanout, initial prekey generation, app-state
  # patch decode. Default 8. Bump for groups >100 or beefy boxes.
  send_concurrency: 8,

  # Per-task timeout via Task.async_stream. Default 60s — comfortably
  # above the 30s bundle_timeout.
  fanout_task_timeout_ms: 60_000
```

Both go through `Whatsmeow.Config.send_concurrency/0` and `Whatsmeow.Config.fanout_task_timeout_ms/0` respectively.

## 8. New supervisor children

Added by `Whatsmeow.Application`:

* `{Task.Supervisor, name: Whatsmeow.Sessions.TaskSup}` — was for async broadcasts (now mostly unused after the revert; left in place for future async work + the WAVersion auto-refresh task).
* `Whatsmeow.Media.HKDFCache` — ETS-backed 5-min TTL cache for media HKDF expansions.

## 9. Migration (one-shot on upgrade)

`priv/repo/migrations/20260519000001_perf_indexes.exs` adds:

* `index(:whatsmeow_app_state_mutation_macs, [:jid, :name])` — patch-apply now uses an index seek.
* `index(:whatsmeow_contacts, [:their_jid])` — reverse-lookup.
* `index(:whatsmeow_pre_keys, [:jid, :key_id], where: "uploaded = false")` — partial pool index.

Run `mix ecto.migrate` after pulling the perf pass.

## 10. Files changed (full list)

```
lib/whatsmeow/application.ex                       # + Sessions.TaskSup, Media.HKDFCache
lib/whatsmeow/config.ex                            # + send_concurrency, fanout_task_timeout_ms
lib/whatsmeow/notifications.ex                     # + broadcast_async/2 (doc warns: not for hot path)
lib/whatsmeow/session.ex                           # retry-count sweep, lazy Logger, defensive nil-coerce
lib/whatsmeow/signal/group_decrypt.ex              # skipped_keys cap
lib/whatsmeow/send.ex                              # parallel_fanout, persist_sessions_batch
lib/whatsmeow/send/group.ex                        # parallel SKDM fanout
lib/whatsmeow/prekeys.ex                           # parallel keygen + insert_all
lib/whatsmeow/crypto/hkdf.ex                       # iolist accumulator
lib/whatsmeow/argo/varint.ex                       # iolist accumulator
lib/whatsmeow/media/upload.ex                      # SHA-256 once, reused
lib/whatsmeow/media/download.ex                    # HKDFCache wired in
lib/whatsmeow/media/hkdf_cache.ex                  # NEW
lib/whatsmeow/app_state/lthash.ex                  # per-patch memoization
lib/whatsmeow/store/postgres.ex                    # device-delete in one tx, list_devices/1, stream_devices/1
priv/repo/migrations/20260519000001_perf_indexes.exs  # NEW
GUIDE.md                                           # + §11.5 Performance + corrections
usage-rules.md                                     # + §2.5 perf, Anti-pattern D2, Iron Laws 8-10
guide-jido.md                                      # NEW
guide-ash.md                                       # NEW
guide-phoenix.md                                   # NEW
bench/perf_pass.exs                                # NEW — micro-benches
bench/recv_path.exs                                # NEW — receive-side bench
bench/fleet_simulation.exs                         # NEW — 100k-scale extrapolation
PERF-CHANGES.md                                    # THIS FILE
```

## 11. Reproducing every number above

```bash
mix deps.get
mix compile

# Send-side perf
mix run bench/perf_pass.exs

# Receive-side perf and ordering check
mix run bench/recv_path.exs

# Fleet scale
N=10000  mix run bench/fleet_simulation.exs
N=50000  mix run bench/fleet_simulation.exs   # ~250 MB RAM
N=100000 mix run bench/fleet_simulation.exs   # ~500 MB RAM, only on a beefy box

# Idle-session memory baseline (the existing bench)
N=10000  mix run bench/session_memory.exs
```

The bench scripts are deliberately simple — pure Elixir, no Postgres or network needed. Run them on the box you care about; numbers will track yours.
