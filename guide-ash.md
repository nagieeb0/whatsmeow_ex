# `whatsmeow_ex` + Ash — declarative WhatsApp domain

This guide is for hosts using the **Ash framework** as their application core. It covers wrapping the library's imperative API behind Ash Resources / Actions / Policies, persisting message history through `AshPostgres`, and exposing the result through `AshGraphql` or `AshJsonApi` to your frontend.

Companion: [`guide-jido.md`](guide-jido.md) for the per-account brain; this guide is for the **state and queries** around it. They compose — most production apps need both.

---

## 1. What Ash gives you here

* **Declarative model** — `Account`, `Conversation`, `Message`, `Contact` as Resources, not Ecto schemas with policy logic scattered across contexts.
* **Authorisation in one place** — `policies` blocks on Resources cover read/write access without sprinkling guards through controllers.
* **AshOban** for background workers that drive the imperative side (`Whatsmeow.Send.send_text/3`).
* **AshAi** for tool-using LLM workflows. Each Resource Action becomes a callable tool.
* **AshGraphql** / **AshJsonApi** — your message store, queryable via your existing API.

What Ash does **NOT** give you: the wire. `Whatsmeow.Session` remains a plain GenServer; you don't model it as a Resource. Mix the two — Resources for state, GenServers for the wire — and you have a clean domain.

---

## 2. Domain layout

```
MyApp.WhatsApp.Domain
  ├── Account            # one row per paired WhatsApp account
  ├── Conversation       # one row per (account, peer_jid)
  ├── Message            # one row per inbound/outbound message
  └── Contact            # cached peer metadata
```

And separately, in your supervision tree (not a Resource):

```
Whatsmeow.Sessions.Supervisor
  ├── Session(account_id_1)
  ├── Session(account_id_2)
  └── ...
```

Sessions are spawned by an AshOban worker when an `Account` is created or its `status` flips to `:active`.

---

## 3. The `Account` Resource

```elixir
defmodule MyApp.WhatsApp.Account do
  use Ash.Resource,
    domain: MyApp.WhatsApp.Domain,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "wa_accounts"
    repo MyApp.Repo
  end

  attributes do
    uuid_primary_key :id
    attribute :client_id, :string, allow_nil?: false
    attribute :jid, :string             # populated post-pair
    attribute :display_name, :string
    attribute :status, :atom,
      constraints: [one_of: [:idle, :pairing, :active, :paused, :revoked]],
      default: :idle
    attribute :persona_kind, :atom, default: :mac_os
    attribute :proxy_url, :string
    timestamps()
  end

  relationships do
    has_many :conversations, MyApp.WhatsApp.Conversation
    has_many :messages, MyApp.WhatsApp.Message
  end

  actions do
    defaults [:read, :destroy]

    create :register do
      argument :display_name, :string
      change set_attribute(:client_id, &Ecto.UUID.generate/0)
      change set_attribute(:status, :idle)
    end

    update :mark_paired do
      argument :jid, :string, allow_nil?: false
      change set_attribute(:jid, arg(:jid))
      change set_attribute(:status, :active)
    end

    update :pause, change: set_attribute(:status, :paused)

    # Imperative side-effects go through `manual` or `after_action`
    action :start_session, :struct, constraints: [instance_of: __MODULE__] do
      argument :id, :uuid, allow_nil?: false

      run fn input, _ ->
        with {:ok, account} <- MyApp.WhatsApp.Domain.get(__MODULE__, input.arguments.id),
             {:ok, device} <- find_or_create_device(account),
             {:ok, _pid} <- Whatsmeow.start_session(device) do
          :ok = Whatsmeow.Session.connect(device.jid || device.client_id)
          {:ok, account}
        end
      end
    end
  end

  policies do
    policy action_type(:read) do
      authorize_if relates_to_actor_via([:owner])
    end

    policy action(:register) do
      authorize_if always()
    end
  end

  defp find_or_create_device(account) do
    Whatsmeow.Store.find_or_new_device(
      client_id: account.client_id,
      persona: persona_for(account.persona_kind)
    )
  end

  defp persona_for(:mac_os), do: Whatsmeow.ClientPayload.Persona.mac_os()
  defp persona_for(:linux), do: Whatsmeow.ClientPayload.Persona.linux()
  defp persona_for(:windows), do: Whatsmeow.ClientPayload.Persona.windows()
end
```

A few patterns worth calling out:

* **`client_id` is the stable key.** Library docs (and your usage-rules) are explicit: never key on `jid`, which the server can rewrite at pair time.
* **`start_session` is a generic Action**, not a `create`/`update` — it has a side-effect (spawning a GenServer) and doesn't fit the CRUD axes.
* **Persona stored as an atom** + a switch — keep it stable per Account. Don't rotate.

---

## 4. The `Message` Resource — the heart of the domain

```elixir
defmodule MyApp.WhatsApp.Message do
  use Ash.Resource,
    domain: MyApp.WhatsApp.Domain,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "wa_messages"
    repo MyApp.Repo

    # Index for the most common query: a conversation's history page.
    custom_indexes do
      index [:account_id, :peer_jid, :inserted_at]
      index [:account_id, :wa_message_id], unique: true
    end
  end

  attributes do
    uuid_primary_key :id
    attribute :wa_message_id, :string, allow_nil?: false  # WhatsApp's id (3EB0...)
    attribute :peer_jid, :string, allow_nil?: false
    attribute :direction, :atom, constraints: [one_of: [:inbound, :outbound]]
    attribute :type, :atom, constraints: [one_of: [:text, :image, :audio, :video, :document, :reaction, :revoke, :edit]]
    attribute :body, :string                         # text body, OR caption for media
    attribute :media_descriptor, :map                # the descriptor from MessageBuilder
    attribute :payload, :map                         # full decoded WaE2E.Message as JSON
    attribute :wa_timestamp, :utc_datetime_usec
    attribute :delivery, :atom,
      constraints: [one_of: [:queued, :sent, :delivered, :read, :failed]],
      default: :queued
    attribute :delivery_error, :string
    timestamps()
  end

  relationships do
    belongs_to :account, MyApp.WhatsApp.Account, allow_nil?: false
    belongs_to :conversation, MyApp.WhatsApp.Conversation
  end

  actions do
    defaults [:read]

    create :record_inbound do
      argument :event, :map, allow_nil?: false  # %Events.Message{} as map
      change MyApp.WhatsApp.Changes.UnpackInboundEvent
    end

    create :send_outbound do
      argument :peer_jid, :string, allow_nil?: false
      argument :body, :string, allow_nil?: false

      change set_attribute(:direction, :outbound)
      change set_attribute(:type, :text)

      change MyApp.WhatsApp.Changes.SendViaWhatsmeow
    end

    update :mark_delivered, change: set_attribute(:delivery, :delivered)
    update :mark_read, change: set_attribute(:delivery, :read)
  end
end
```

The `SendViaWhatsmeow` change is the bridge between the declarative Resource and the imperative library:

```elixir
defmodule MyApp.WhatsApp.Changes.SendViaWhatsmeow do
  use Ash.Resource.Change

  def change(changeset, _opts, _ctx) do
    Ash.Changeset.after_action(changeset, fn _cs, message ->
      account = MyApp.Repo.get!(MyApp.WhatsApp.Account, message.account_id)
      session = account.client_id  # via the Registry

      case MyApp.Throttle.send_text(session, message.peer_jid, message.body) do
        {:ok, wa_id} ->
          {:ok, %{message | wa_message_id: wa_id, delivery: :sent}}

        {:error, reason} ->
          {:ok, %{message | delivery: :failed, delivery_error: inspect(reason)}}
      end
    end)
  end
end
```

Trade-offs you accept by doing the send inside `after_action`:

* **The Action returns after the send completes** — fine for interactive UI calls but bad for batch.
* For batch, switch to `AshOban` (next section).

---

## 5. AshOban — the right place for outbound batches and delivery polling

If you ever want to "send a campaign to 5000 conversations", do it as an Oban job, not from a controller:

```elixir
defmodule MyApp.WhatsApp.Workers.SendCampaign do
  use AshOban.Worker,
    api: MyApp.WhatsApp.Domain,
    resource: MyApp.WhatsApp.Message,
    queue: :wa_send,
    max_attempts: 3

  def perform(%Oban.Job{args: %{"account_id" => acc_id, "peer_jid" => peer, "body" => body}}) do
    case Ash.create(MyApp.WhatsApp.Message, %{
           account_id: acc_id,
           peer_jid: peer,
           body: body
         }, action: :send_outbound) do
      {:ok, _msg} -> :ok
      err -> err
    end
  end
end
```

Schedule with delay-between-jobs that respects your Throttle (e.g. 1500 ms cooldown per `account_id`). Use Oban's `unique` option to prevent duplicate sends.

---

## 6. Wiring inbound messages into Resources

You have two patterns. **Pick one — don't mix them.**

### Pattern A: dedicated GenServer subscribes to `Whatsmeow.PubSub`

A long-lived bridge process per `Account` subscribes to the device topic and writes through Ash:

```elixir
defmodule MyApp.WhatsApp.InboundBridge do
  use GenServer

  def start_link(opts), do: GenServer.start_link(__MODULE__, opts, name: via(opts[:account_id]))

  def init(opts) do
    :ok = Whatsmeow.subscribe(opts[:account_id])
    {:ok, opts}
  end

  def handle_info({:whatsmeow, %Whatsmeow.Types.Events.Message{} = evt}, state) do
    _ = Ash.create!(MyApp.WhatsApp.Message, %{event: serialize(evt)}, action: :record_inbound)
    {:noreply, state}
  end

  def handle_info({:whatsmeow, _}, state), do: {:noreply, state}

  defp via(id), do: {:via, Registry, {MyApp.WhatsApp.BridgeRegistry, id}}
  defp serialize(evt), do: Map.from_struct(evt) |> Map.update!(:info, &Map.from_struct/1)
end
```

This is the simplest pattern. One bridge per account. Restarted by your DynamicSupervisor on crash.

### Pattern B: a single global GenServer subscribes to `:all`

Only do this for dashboards / observability. **Not** for production message persistence — at fleet scale, one process becomes the bottleneck. The library specifically warns about this. See [`GUIDE.md`](GUIDE.md) §11.5 and `Whatsmeow.Notifications`'s docs.

---

## 7. AshAi — exposing WhatsApp as agent tools

`AshAi` lets an LLM call your Ash Actions as tools. Mark them with `description:` and `argument`s and they're auto-exposed:

```elixir
actions do
  create :send_outbound do
    description "Send a WhatsApp text message to a peer."

    argument :peer_jid, :string,
      allow_nil?: false,
      description: "Recipient JID, e.g. 12025550101@s.whatsapp.net"

    argument :body, :string,
      allow_nil?: false,
      description: "Message text. Max 4096 chars."

    # ...
  end

  read :recent_messages do
    description "Last N messages in a conversation."
    argument :peer_jid, :string, allow_nil?: false
    argument :limit, :integer, default: 20

    filter expr(peer_jid == ^arg(:peer_jid))
    prepare build(sort: [inserted_at: :desc], limit: arg(:limit))
  end
end
```

Then in your agent definition (Ash side):

```elixir
ai_tools do
  tool :send, MyApp.WhatsApp.Message, action: :send_outbound
  tool :read, MyApp.WhatsApp.Message, action: :recent_messages
end
```

The LLM sees a `send` and a `read` tool, with rich schema. No glue code.

> **Comparison with the Jido approach:** Jido agents are more imperative — you write `handle_info` clauses, you call `MyApp.Throttle.send_text` directly. AshAi is more declarative — you describe what's possible and the LLM chooses. Use Jido when you want fine-grained reactive logic; use AshAi when you want a tool-calling LLM with structured access to your data.

---

## 8. Authorization

The library doesn't know anything about your users. The Account row is the perimeter.

```elixir
policies do
  # An account can only be read by its owner.
  policy action_type(:read) do
    authorize_if relates_to_actor_via([:owner])
  end

  # Sending requires ownership of the account.
  policy action(:send_outbound) do
    authorize_if expr(account.owner_id == ^actor(:id))
  end

  # Bot/system actor can ingest inbound messages (no human user).
  policy action(:record_inbound) do
    authorize_if actor_attribute_equals(:type, :system)
  end
end
```

The `record_inbound` policy is the one most teams get wrong — the inbound bridge runs as a **system actor**, not as the account owner. Don't reuse a user JWT for it.

---

## 9. Querying for the UI (AshGraphql)

If you're exposing the WhatsApp domain over GraphQL:

```elixir
defmodule MyApp.WhatsApp.Message do
  use Ash.Resource,
    extensions: [AshGraphql.Resource]

  graphql do
    type :wa_message

    queries do
      list :messages, :read
      list :recent_messages, :recent_messages
    end

    mutations do
      create :send_message, :send_outbound
      update :mark_message_read, :mark_read
    end

    subscriptions do
      pubsub MyAppWeb.Endpoint
      subscribe :inbound_message do
        actions [:record_inbound]
      end
    end
  end
end
```

A frontend then subscribes to `inbound_message` and your LiveView / React UI updates in real time without polling.

---

## 10. Migration coexistence

The library ships its own `whatsmeow_*` migrations. Your Ash Resources will ship their own (`wa_accounts`, `wa_messages`, ...). **They don't share tables.** The library's tables are wire-state (signal sessions, identity keys, prekeys); your Resources are application-state.

If you want one Repo for everything:

```elixir
config :whatsmeow_ex, start_repo?: false
config :whatsmeow_ex, :repo, MyApp.Repo
```

…and copy the library's migrations into `priv/repo/migrations/`. `mix ecto.migrate` then handles both.

---

## 11. AshPaperTrail / AshArchival for audit logging

For accounts you're operating on behalf of others (managed-account products), regulatory compliance often requires:

* Every outbound message attributable to an actor
* Every account state change logged
* Soft-delete on `:revoke` (the row stays for audit, status flips)

Both are one-line extensions:

```elixir
defmodule MyApp.WhatsApp.Message do
  use Ash.Resource,
    extensions: [AshPaperTrail.Resource]

  paper_trail do
    change_tracking_mode :snapshot
    store_action_inputs? true
  end
end
```

---

## 12. Production checklist (Ash-specific)

- [ ] One `Account` Resource per WhatsApp account (never reuse client_id).
- [ ] Inbound bridge GenServer per Account in a DynamicSupervisor.
- [ ] `AshOban` workers handle batched sends and delivery polling — not controllers.
- [ ] Policies cover read/write at the Resource level; no policy logic in changes.
- [ ] `record_inbound` runs as a system actor, separate from user actors.
- [ ] `AshPaperTrail` enabled on `Message` and `Account` if you have compliance obligations.
- [ ] AshGraphql `subscriptions` wired through `Phoenix.PubSub` if you have a frontend.
- [ ] Custom indexes on `[account_id, peer_jid, inserted_at]` (history page) and `[account_id, wa_message_id]` (dedup).
- [ ] Foreign-key cascade on Account delete → Messages, but NOT to `whatsmeow_*` tables (the library handles its own cleanup via `Whatsmeow.Store.Postgres.delete_device/1`).

---

## 13. What this combination is and isn't good for

**Good:**
* Multi-account products where each account has its own conversation history queryable by the UI.
* Compliance-bound deployments (paper trail, policies, audit).
* Real-time UIs (subscriptions over GraphQL/JSON-API).
* LLM-driven assistants with structured tool access.

**Not great:**
* Throughput-critical bulk send (Ash adds overhead per write; for >1000 msgs/sec consider raw Ecto + direct `Whatsmeow.Send`).
* Single-account hobby projects (Ash is overkill — use the library directly).

If you want both the imperative reactive logic AND the declarative domain, **use both** — Jido agents for reactions, Ash Resources for state. They share a Repo and a PubSub; they don't fight.
