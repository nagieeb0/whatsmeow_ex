# `whatsmeow_ex` + Jido — building WhatsApp agents

This guide is for hosts that want to drive WhatsApp accounts with **Jido agents** (stateful, message-driven, tool-using BEAM processes). It assumes you've already read [`GUIDE.md`](GUIDE.md) and [`usage-rules.md`](usage-rules.md). Everything here builds on the public API surface defined there.

> **Pattern fit, in one line:** Each WhatsApp account is one `Whatsmeow.Session` (a GenServer). Each agent is one Jido agent (also a GenServer). The agent **subscribes** to the session's per-device PubSub topic and **reacts** by calling back into `Whatsmeow.Send.*`. Both processes are supervised; both crash-isolated; both share the same scheduler.

---

## 1. Mental model

```
  ┌───────────────────────────────────────────┐
  │           Jido Agent (your code)          │
  │  state: %{session_id, memory, tools}      │
  │  handle_info({:whatsmeow, event}, ...)    │
  │  ─── reasoning / LLM / tool calls ───     │
  │  Whatsmeow.Send.send_text(...)            │
  └───────────────▲───────────────────────────┘
                  │ {:whatsmeow, %Events.Message{}}
                  │ {:whatsmeow, %Events.Receipt{}}
                  │ (in wire order — sync broadcast)
                  │
  ┌───────────────┴───────────────────────────┐
  │       Whatsmeow.Session (this lib)        │
  │   WSS + Noise + Signal + binary XML       │
  └───────────────────────────────────────────┘
```

* The **session** owns the wire. It decrypts, acks, and broadcasts.
* The **agent** owns the policy. It interprets, remembers, decides, replies.
* They communicate only through the PubSub topic. No shared state, no synchronous coupling.

This separation is deliberate: the session must never wait for the agent (otherwise the WebSocket can stall and the server tears it down). The agent must never block the session (otherwise WhatsApp's read receipts and resend logic break).

---

## 2. Minimal agent

```elixir
defmodule MyApp.WhatsAppAgent do
  use Jido.Agent,
    name: "whatsapp_agent",
    description: "A WhatsApp account driven by Jido",
    schema: [
      session: [type: {:custom, MyApp, :validate_session_ref, []}, required: true],
      memory: [type: :map, default: %{}]
    ]

  alias Whatsmeow.Types.Events

  @impl Jido.Agent
  def mount(agent, _opts) do
    :ok = Whatsmeow.subscribe(agent.state.session)
    {:ok, agent}
  end

  # Jido agents are GenServer-backed; this is just the underlying `handle_info`.
  def handle_info({:whatsmeow, %Events.Message{} = msg}, agent) do
    chat = Whatsmeow.Types.JID.to_string(msg.info.from)
    body = msg.message.body || ""

    history = Map.get(agent.state.memory, chat, [])
    new_memory = Map.put(agent.state.memory, chat, [{:user, body} | history])

    # OFFLOAD heavy work — see §4
    Task.Supervisor.start_child(MyApp.AgentTaskSup, fn ->
      reply = MyApp.Reasoning.respond(body, history)
      _ = MyApp.Throttle.send_text(agent.state.session, chat, reply)
    end)

    {:noreply, %{agent | state: %{agent.state | memory: new_memory}}}
  end

  # Drop other event types (Receipt, MediaMessage, etc.) — handle the ones you care about.
  def handle_info({:whatsmeow, _}, agent), do: {:noreply, agent}
end
```

A few choices baked in here, each justified below:

* **`mount/2` subscribes**, not the supervisor or external code. The agent owns its subscription so it lives and dies with the agent process.
* **`String` key for `memory`**, not the `%JID{}` struct. Easier to serialise if you later persist conversation history.
* **`Task.Supervisor.start_child`** for LLM work. Critical — see §4.

---

## 3. State and memory

Two kinds of state live in a Jido WhatsApp agent. Keep them separate.

| Kind | Lives in | Persistence | Example |
|---|---|---|---|
| **Conversation memory** | `agent.state.memory` | Snapshot to your own table if needed | "Last 20 messages from this chat" |
| **Signal session state** | `whatsmeow_sessions` table | Library handles persistence + invalidation | Encryption ratchet, identity keys |

**Don't blur these.** Storing conversation memory in `whatsmeow_*` tables couples agent logic to wire state — a re-pair (which deletes Signal state) shouldn't erase the agent's memory. Storing Signal state in your agent struct loses it on agent crash.

### Persisting conversation memory

Jido agents can be restarted by a supervisor. To survive that, snapshot:

```elixir
defmodule MyApp.AgentMemory do
  use Ecto.Schema

  schema "agent_memory" do
    field :session_id, :string
    field :chat, :string
    field :history, {:array, :map}      # [%{role: "user|assistant", text: ...}, ...]
    field :summary, :string             # optional, periodic LLM-condensed
    timestamps()
  end
end
```

Snapshot every N messages OR on `terminate/2`. On `mount/2`, load and merge into `agent.state.memory`. Don't snapshot every event — that would defeat the performance pass.

### Per-chat memory cap

LLM context windows are finite. Cap each chat's history at e.g. 50 turns and summarise older ones:

```elixir
defp trim(history) when length(history) > 50 do
  {keep, dump} = Enum.split(history, 30)
  summary = MyApp.Reasoning.summarise(dump)
  [{:system, summary} | keep]
end

defp trim(history), do: history
```

---

## 4. The blocking-work rule (the most important rule here)

Jido agents are GenServers. **Their `handle_info/2` is the serial bottleneck for everything that arrives at that PID** — including the next `{:whatsmeow, %Events.Message{}}`.

If you call an LLM synchronously in `handle_info/2`, you stall the agent for whatever the LLM takes (often 1-10 s). During that time, the agent's mailbox queues every subsequent message. Worse: by the time you respond, the user has sent five more messages and your reply is stale.

**The pattern that works:**

```elixir
def handle_info({:whatsmeow, %Events.Message{} = msg}, agent) do
  # 1. Update memory FAST (synchronous, microseconds)
  new_memory = update_memory(agent.state.memory, msg)

  # 2. Spawn the slow work
  Task.Supervisor.start_child(MyApp.AgentTaskSup, fn ->
    reply = MyApp.Reasoning.respond(msg, new_memory)
    MyApp.Throttle.send_text(agent.state.session, peer_of(msg), reply)
  end)

  # 3. Return immediately — agent ready for the next message
  {:noreply, %{agent | state: %{agent.state | memory: new_memory}}}
end
```

Trade-offs you accept:

* **Out-of-order replies.** If the user sends "A" then "B" while you're thinking, you may reply to A after B arrived. Mitigation: serialise per-chat in your Throttle (§5).
* **No backpressure.** If LLM calls pile up, you'll burn money. Mitigation: bounded `Task.Supervisor` (`max_children:`) or a circuit breaker.

In your app's supervision tree:

```elixir
{Task.Supervisor, name: MyApp.AgentTaskSup, max_children: 1_000}
```

---

## 5. Rate-limiting outbound sends

The library does **zero** outbound throttling. WhatsApp's anti-spam considers any account sending faster than ~1 msg/1.5 s with bursts >3 a bot candidate. Re-pair-able accounts can recover; flagged business accounts often can't.

A per-session throttle:

```elixir
defmodule MyApp.Throttle do
  use GenServer

  @rate_msgs 1
  @rate_window_ms 1500

  def start_link(opts), do: GenServer.start_link(__MODULE__, opts, name: via(opts[:session]))

  def send_text(session, peer, body) do
    GenServer.call(via(session), {:send, peer, body}, 30_000)
  end

  def init(opts), do: {:ok, %{session: opts[:session], queue: :queue.new(), last: 0}}

  def handle_call({:send, peer, body}, _from, state) do
    wait = max(0, @rate_window_ms - (System.monotonic_time(:millisecond) - state.last))
    if wait > 0, do: Process.sleep(wait)
    result = Whatsmeow.Send.send_text(state.session, peer, body)
    {:reply, result, %{state | last: System.monotonic_time(:millisecond)}}
  end

  defp via(session), do: {:via, Registry, {MyApp.ThrottleRegistry, {:throttle, session}}}
end
```

For higher throughput (groups, broadcasts), use a token bucket instead of a sleep. The library's per-fanout parallelism (`Whatsmeow.Config.send_concurrency/0`) handles the multi-device side; **you** handle the multi-chat side.

---

## 6. Tools — actions the agent can call

If you're using `Jido.AI` (LLM + tool calling), expose WhatsApp operations as Jido Actions:

```elixir
defmodule MyApp.Actions.SendText do
  use Jido.Action,
    name: "send_text",
    description: "Send a text message to a WhatsApp peer.",
    schema: [
      session: [type: :any, required: true],
      peer: [type: :string, required: true, doc: "Peer JID e.g. 12025550101@s.whatsapp.net"],
      body: [type: :string, required: true]
    ]

  def run(%{session: s, peer: p, body: b}, _ctx) do
    case MyApp.Throttle.send_text(s, p, b) do
      {:ok, id} -> {:ok, %{message_id: id}}
      err -> err
    end
  end
end
```

Other useful Actions:

* `SendImage` — wraps `Whatsmeow.Send.send_image/4` + `Whatsmeow.Media.Refresh.refresh/1`.
* `ReadHistory` — pulls last N messages from your `agent_memory` table.
* `MarkUnread` — `Whatsmeow.Send.send_node/2` with an unread receipt (rare, but useful).
* `LeaveGroup` — `Whatsmeow.Group.build_*` IQ helpers.

Register them in the agent definition:

```elixir
use Jido.Agent,
  actions: [MyApp.Actions.SendText, MyApp.Actions.SendImage, MyApp.Actions.ReadHistory]
```

---

## 7. Multi-account fleets

The library was designed for many concurrent accounts. A common architecture:

```elixir
# In your supervision tree:
children = [
  Whatsmeow,                                     # already starts its supervisor
  {Registry, name: MyApp.ThrottleRegistry, keys: :unique},
  {Task.Supervisor, name: MyApp.AgentTaskSup},
  {DynamicSupervisor, name: MyApp.AgentSupervisor, strategy: :one_for_one},
  MyApp.AgentManager                              # spawns one agent per paired device
]
```

`MyApp.AgentManager` reads `whatsmeow_device` rows at boot and starts:

* one `Whatsmeow.Session` per device (lib supervisor)
* one Throttle per device (your registry)
* one Jido agent per device (your DynamicSupervisor)

The lib already partitions `Whatsmeow.Sessions.Registry` by `System.schedulers_online()` — so session lookups don't bottleneck. Mirror this for your agent registry.

**Memory rule of thumb** (measured on this codebase, BEAM-side only, no TLS sockets):

| Component | Per-session footprint |
|---|---|
| `Whatsmeow.Session` GenServer | ~2.7 KB |
| Phoenix.PubSub subscriber slot | ~0.3 KB |
| Jido agent GenServer | ~5-10 KB (depending on `memory` size) |
| **Total per active agent (BEAM)** | **~10-15 KB** |
| Add for live TLS socket + Mint buffers | +16-32 KB |

So 10k agents on one node ≈ **300-500 MB**. 100k agents on one node ≈ **3-5 GB** — feasible on a 16 GB box, comfortable across 2-4 nodes with `Phoenix.PubSub` PG2 adapter and libcluster.

---

## 8. Crash recovery

OTP makes this easier than any other runtime, but you have to wire it deliberately.

**What survives a session crash:**
* The device row (`whatsmeow_device`).
* Signal session state (`whatsmeow_sessions`).
* Pre-keys (`whatsmeow_pre_keys`).
* Your agent_memory snapshot.

**What is lost:**
* In-flight messages not yet broadcast.
* The Jido agent's in-memory state since last snapshot.
* Pending IQ replies (callers get `:timeout`).

A `Whatsmeow.Sessions.Supervisor` restart re-runs `Session.init/1`, which loads the device row, then `connect/1` to re-establish the wire. Your agent's `mount/2` re-subscribes. Within seconds you're back, missing only what was in-flight.

**The one trap:** if your agent crashes and Jido auto-restarts it, `mount/2` re-subscribes — but the lib doesn't replay missed events. To recover them, your `mount/2` should query the recent-message buffer (the library's `Whatsmeow.Retry.RecentCache` only stores outbound; you may want your own inbound cache for "last N undelivered" replay).

---

## 9. Testing your agent

Don't bring the WSS up in unit tests. Drive the agent directly via PubSub:

```elixir
defmodule MyApp.WhatsAppAgentTest do
  use ExUnit.Case, async: true
  alias Whatsmeow.Types.Events

  setup do
    {:ok, agent} = MyApp.WhatsAppAgent.start_link(session: "test-#{System.unique_integer()}")
    {:ok, agent: agent}
  end

  test "remembers a conversation", %{agent: agent} do
    msg = %Events.Message{
      info: %Whatsmeow.MessageInfo{from: %Whatsmeow.Types.JID{user: "1234", server: "s.whatsapp.net"}},
      message: %{body: "hi"}
    }

    Whatsmeow.Notifications.broadcast(agent.state.session, msg)

    Process.sleep(50)
    assert %{state: %{memory: %{"1234@s.whatsapp.net" => [{:user, "hi"}]}}} = :sys.get_state(agent)
  end
end
```

For integration tests that exercise the real wire, see `mix whatsmeow.smoke`.

---

## 10. Production checklist

- [ ] Each agent in a DynamicSupervisor — never `start_link` an agent unsupervised.
- [ ] Per-session Throttle GenServer in front of `Whatsmeow.Send.*`.
- [ ] `Task.Supervisor` for LLM/tool calls (`max_children` set).
- [ ] `agent_memory` table + periodic snapshot.
- [ ] Subscribe on `mount/2`, never globally.
- [ ] `:telemetry` handlers for `[:whatsmeow, :session, :*]` events feeding your observability.
- [ ] `cold_start_jitter_ms` set if your boot brings up >100 sessions at once.
- [ ] Per-pool `WAVersion.Refresher` if you run multi-IP egress.
- [ ] Rate-limit caps reviewed against WhatsApp's anti-spam thresholds.
- [ ] LLM cost monitoring (a stuck agent in a noisy chat can burn $100/hour).

---

## 11. What this library does NOT do for you

* Pick which messages are worth responding to (you decide).
* Detect spam / abuse from peers (you decide).
* Persist your agent state (you decide where).
* Pay for LLM tokens (you decide which model).
* Comply with WhatsApp Business Policy (you, your legal team).

The library is the transport + protocol. Jido is the brain. The wiring between them is what this guide is for.
