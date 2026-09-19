defmodule Whatsmeow.IQ do
  @moduledoc """
  IQ stanza helpers — ID generation and one-shot builders.

  WhatsApp's IQ shape is a thin XMPP descendant: every `<iq>` has an `id`
  attribute, a `type` (`get`/`set`/`result`/`error`), and a `to`/`xmlns`
  pair that namespaces the request. Responses echo the same `id`, which
  is how the Session GenServer correlates an outbound IQ to its caller
  via the per-process pending map (`request_id → {caller_pid, ref}`).

  Builders live here when they're trivial enough not to deserve their
  own module (`build_keepalive/1`, `build_prekeys_get/1`, …). Per-feature
  builders with rich payloads (`Whatsmeow.Pair`, `Whatsmeow.Group`,
  `Whatsmeow.Newsletter`) keep their own builders close to the decoder.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Types.JID

  # The `to` attribute on outbound IQs MUST be a typed `%JID{}` (the
  # binary encoder serialises it with the `@jid_pair` opcode). Sending
  # the plain string `"s.whatsapp.net"` makes the encoder tokenise it
  # as a bare string — the server accepts this on some stanzas but
  # silently rejects others (notably `<pair-device-sign>`), and the
  # mismatch leaves keepalive pings effectively un-routed during the
  # pairing window. Use a typed JID everywhere for consistency with
  # upstream Go (`types.ServerJID`).
  defp server_jid, do: %JID{user: "", server: JID.default_user_server()}

  @doc """
  Generate a fresh IQ id. The wire just wants something unique per
  in-flight request; we use 8 random bytes hex-encoded which mirrors
  upstream Go's `requestID/generateRequestID`.
  """
  @spec generate_id() :: String.t()
  def generate_id, do: Base.encode16(:crypto.strong_rand_bytes(8), case: :lower)

  @doc """
  Build the keepalive ping IQ: `<iq xmlns="w:p" type="get" to="s.whatsapp.net" id="…"/>`.
  WhatsApp's server closes idle WebSocket conns after ~30 s — sending
  this every 20–30 s keeps the link warm and ensures any lower-layer
  network failure surfaces in time to reconnect rather than getting
  noticed only on the next outbound message.

  Mirrors Go's `sendKeepAlive` (`whatsmeow-main/keepalive.go:65`).
  """
  @spec build_keepalive(String.t() | nil) :: Node.t()
  def build_keepalive(id \\ nil) do
    Node.new(
      "iq",
      %{
        "id" => id || generate_id(),
        "to" => server_jid(),
        "type" => "get",
        "xmlns" => "w:p"
      },
      nil
    )
  end

  @doc """
  Build the post-login "set passive flag" IQ. WhatsApp's server expects
  every newly-logged-in client to declare whether it's the active session
  (`<active/>`) or a passive secondary (`<passive/>`) — without this the
  server may close the connection assuming we're abandoned.

  Mirrors Go's `SetPassive` (`whatsmeow-main/connectionevents.go:209`).

  Resulting shape:

      <iq id="…" xmlns="passive" type="set" to="s.whatsapp.net">
        <active/> (or <passive/>)
      </iq>
  """
  @spec build_set_passive(boolean(), String.t() | nil) :: Node.t()
  def build_set_passive(passive?, id \\ nil) when is_boolean(passive?) do
    child_tag = if passive?, do: "passive", else: "active"

    Node.new(
      "iq",
      %{
        "id" => id || generate_id(),
        "to" => server_jid(),
        "type" => "set",
        "xmlns" => "passive"
      },
      [Node.new(child_tag, %{}, nil)]
    )
  end

  @doc """
  The four stanzas a connect sends and this port never did.

  ## Why they exist

  `amarula`, an independent Elixir WhatsApp client that mirrors Baileys, sends
  these on every login and says why in a comment its author clearly earned
  (`connection.ex:3417`):

  > *Baileys `executeInitQueries` (chats.ts), fired on `open`: fetchProps +
  > blocklist + privacy. **These appear to be a server-side precondition for
  > E2E key-exchange: without them the server SILENTLY ignores our prekey-bundle
  > fetches (answers every other IQ).***

  That is, to the word, the state this library has been stuck in: an
  authenticated socket whose keepalive IQs are answered, whose receipts arrive,
  whose `<active/>` is accepted — and which the server will not feed.

  Go sends `unified_session` too (`client.go:1091`). Neither Go nor this port
  sent the other three.

  All four are fire-and-forget, matching Baileys, which does not block sends on
  the replies.
  """
  @spec build_unified_session() :: Node.t()
  def build_unified_session do
    # `(now + 3 days) % 7 days` — Baileys' `getUnifiedSessionId()`, mirrored by
    # both Go (`getUnifiedSessionID`) and amarula. The value is a rotating
    # bucket, not an identifier of anything.
    three_days = 3 * 24 * 60 * 60 * 1000
    seven_days = 7 * 24 * 60 * 60 * 1000
    id = rem(System.system_time(:millisecond) + three_days, seven_days)

    Node.new("ib", %{}, [
      Node.new("unified_session", %{"id" => Integer.to_string(id)}, nil)
    ])
  end

  @doc """
  Ask the server to start sending the offline queue it just announced.

  ## The stanza the whole post-deploy outage was missing

  `<ib><offline_preview count="48" message="5"/></ib>` is an **offer**, not a
  delivery. Baileys answers it with `<ib><offline_batch count="100"/></ib>`, and
  `amarula` — an independent Elixir client that works — carries the comment:

  > *"reply `<ib><offline_batch count="100"/></ib>` **or the server never
  > delivers the queued offline messages**."*

  This library read the preview, broadcast an event about it, armed a timer to
  notice nothing arrived, and never asked. So on every connect after a gap the
  server offered a queue, waited to be asked, and was not — which reads on every
  instrument as a socket that is perfectly healthy and simply not being fed:
  keepalives answered, `<active/>` accepted, receipts flowing, twenty-one IQs
  answered, `received: 0` for ever.

  Re-sending `passive`/`active` could never have fixed it, because the server
  was not waiting on a state change. It was waiting for a question.

  `count` is how many items to send in this batch, and 100 is Baileys' value.
  """
  @spec build_offline_batch(pos_integer()) :: Node.t()
  def build_offline_batch(count \\ 100) do
    Node.new("ib", %{}, [
      Node.new("offline_batch", %{"count" => Integer.to_string(count)}, nil)
    ])
  end

  @doc """
  Clear the server's dirty flag: `<iq type="set" xmlns="urn:xmpp:whatsapp:dirty">`.

  ## The same shape as `build_offline_batch/1`, one layer up

  `<ib><dirty type="account_sync" timestamp="…"/></ib>` arrives on every connect
  to this device and was decoded, logged and dropped — on the reasoning that Go
  ignores it too (`connectionevents.go:91` has `MarkNotDirty` commented out).

  That reasoning is exactly what kept `offline_batch` missing for eight
  hypotheses: Go is a different client, and "Go gets away without it" is not
  "the server does not want it". `amarula` — which works — sends it, and says:

  > *"Baileys `CB:ib,,dirty` (chats.ts): clear the server's dirty sync flag …
  > **Until this is acked the server keeps the companion's sync paused.**"*

  `timestamp` echoes the server's when it gave one; Baileys omits it otherwise.
  """
  @spec build_clean_dirty(String.t(), integer() | nil, String.t() | nil) :: Node.t()
  def build_clean_dirty(type, timestamp \\ nil, id \\ nil) when is_binary(type) do
    attrs =
      case timestamp do
        nil -> %{"type" => type}
        ts -> %{"type" => type, "timestamp" => to_string(ts)}
      end

    Node.new(
      "iq",
      %{
        "id" => id || generate_id(),
        "to" => server_jid(),
        "type" => "set",
        "xmlns" => "urn:xmpp:whatsapp:dirty"
      },
      [Node.new("clean", attrs, nil)]
    )
  end

  @doc """
  `<iq type="get" xmlns="encrypt"><digest/></iq>` — ask the server to validate
  our key bundle.

  amarula's comment: *"digestKeyBundle: server validates our key bundle; if no
  `<digest>` in reply we re-upload prekeys."* So the reply is not decoration —
  its absence is the server saying our published keys are not what it holds.
  """
  @spec build_digest(String.t() | nil) :: Node.t()
  def build_digest(id \\ nil) do
    Node.new(
      "iq",
      %{"id" => id || generate_id(), "to" => server_jid(), "type" => "get", "xmlns" => "encrypt"},
      [Node.new("digest", %{}, nil)]
    )
  end

  @doc """
  Baileys' `executeInitQueries`, in order: abt/props, blocklist, privacy.

  Returned as a list because they go out together and none of them is
  interesting on its own.
  """
  @spec build_init_queries() :: [Node.t()]
  def build_init_queries do
    [
      Node.new(
        "iq",
        %{"id" => generate_id(), "to" => server_jid(), "type" => "get", "xmlns" => "abt"},
        [Node.new("props", %{"protocol" => "1"}, nil)]
      ),
      Node.new(
        "iq",
        %{"id" => generate_id(), "to" => server_jid(), "type" => "get", "xmlns" => "blocklist"},
        nil
      ),
      Node.new(
        "iq",
        %{"id" => generate_id(), "to" => server_jid(), "type" => "get", "xmlns" => "privacy"},
        [Node.new("privacy", %{}, nil)]
      )
    ]
  end

  @doc """
  Build a `<presence>` stanza. WhatsApp wants this sent at least once
  after login so peers see your `push_name` (otherwise they see "-").

  Mirrors Go's `SendPresence` (`whatsmeow-main/presence.go:64`).

  Resulting shape: `<presence type="available" name="<push_name>"/>` (or
  `type="unavailable"` for going offline).
  """
  @spec build_presence(:available | :unavailable, String.t() | nil) :: Node.t()
  def build_presence(state, push_name \\ nil)
      when state in [:available, :unavailable] do
    attrs = %{"type" => Atom.to_string(state)}

    attrs =
      if is_binary(push_name) and push_name != "",
        do: Map.put(attrs, "name", push_name),
        else: attrs

    Node.new("presence", attrs, nil)
  end

  @doc """
  Build a `<iq type="get"><keys/></iq>` request to fetch a peer's PreKey
  bundle. The server replies with a `<iq type="result">` containing the
  peer's identity key, signed pre-key, signed pre-key signature, and one
  one-time pre-key per requested JID.

  Used by Phase 9's outbound send path: to start a Signal session with
  a peer we've never messaged before, we must first fetch their bundle
  to seed X3DH.

  Ports `whatsmeow-main/prekeys.go#fetchPreKeys`.
  """
  @spec build_prekeys_get([JID.t() | String.t()], keyword()) :: Node.t()
  def build_prekeys_get(peer_jids, opts \\ []) when is_list(peer_jids) do
    # Two attrs are non-negotiable for WhatsApp's `xmlns="encrypt"`
    # handler — get either wrong and the server silently drops the IQ
    # without an `<iq type="error">`, leaving the client to time out
    # with `{:bundle_error, :timeout}`.
    #
    #   1. `reason="identity"` (default) — Go's `fetchPreKeys`
    #      (`whatsmeow-main/prekeys.go:130`) always sends this.
    #   2. `jid=<JID>` must be encoded with the binary `@jid_pair`
    #      opcode, NOT as a bare string. The binary encoder picks the
    #      opcode based on the *Elixir type* of the attr value:
    #      `%JID{}` → `@jid_pair`, `binary` → plain string. So we
    #      normalise any string-form jid back into a `%JID{}` here.
    #      Took the same 2h second-time-around to spot — the IQ goes
    #      out, the server reads it as a malformed stanza, and the
    #      pending entry sits in our map until 30s timeout.
    reason = Keyword.get(opts, :reason, "identity")
    id = Keyword.get(opts, :id) || generate_id()

    user_children =
      Enum.map(peer_jids, fn jid ->
        attrs = %{"jid" => normalize_jid!(jid)}
        attrs = if reason == "", do: attrs, else: Map.put(attrs, "reason", reason)
        Node.new("user", attrs, nil)
      end)

    Node.new(
      "iq",
      %{
        "id" => id,
        "to" => server_jid(),
        "type" => "get",
        "xmlns" => "encrypt"
      },
      [Node.new("key", %{}, user_children)]
    )
  end

  defp normalize_jid!(%JID{} = j), do: j

  defp normalize_jid!(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, %JID{} = j} -> j
      _ -> raise ArgumentError, "build_prekeys_get: invalid jid #{inspect(s)}"
    end
  end
end
