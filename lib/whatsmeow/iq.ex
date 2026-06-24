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
