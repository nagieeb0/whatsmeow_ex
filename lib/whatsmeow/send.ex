defmodule Whatsmeow.Send do
  @moduledoc """
  Outbound message pipeline.

  Plaintext → `Whatsmeow.Proto.WaE2E` → Signal encrypt
  → `Whatsmeow.Binary` encode → frame send.

  `send_text/3` is the high-level entry point — orchestrates bundle
  lookup-or-fetch, encrypt, send, and Signal-session persistence
  against a running `Whatsmeow.Session`.

  The lower-level helpers (`build_text_message_node/4`,
  `build_e2e_text_message/1`, `generate_message_id/0`) are intentionally
  stateless so they're reusable in batch/retry paths and tests.

  Ports `whatsmeow-main/send.go` + `sendfb.go`.
  """

  require Logger

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.IQ
  alias Whatsmeow.PreKeyBundle
  alias Whatsmeow.Session
  alias Whatsmeow.Signal.{Decrypt, WireEncrypt}
  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.Types.JID
  alias Whatsmeow.User

  @typedoc "Things that can go wrong on `send_text/3`."
  @type send_error ::
          :no_device
          | :not_connected
          | :no_bundle
          | :invalid_peer_jid
          | :cannot_send_to_self
          | {:bundle_error, term()}
          | {:encrypt, term()}
          | {:transport, term()}

  @doc """
  Generate a unique message ID in WhatsApp Web's modern format.

  Mirrors Go's `Client.GenerateMessageID` (`whatsmeow-main/send.go:46`):

      "3EB0" || HEX(SHA256(unix_seconds_be8 || own_user || "@c.us" || random16)[0..9])

  Total length: `"3EB0"` (4) + 18-char hex (= 9 bytes of SHA256 prefix) = **22 chars**.

  The old format (`"3EB0" + hex(ms_since_epoch) + 16 random hex`, ~31 chars,
  variable length) was the deprecated `GenerateMessageID/0` in upstream Go —
  the docstring there reads "WhatsApp web has switched to using a hash of
  the current timestamp, user id and random bytes." Recipients running modern
  WhatsApp clients silently drop deliveries whose id length doesn't match
  the new format — the message gets `<ack>`-ed at the stanza layer but never
  decrypted into a visible chat bubble. This caused the "Waiting for this
  message" placeholder on every test send.
  """
  @spec generate_message_id() :: String.t()
  @spec generate_message_id(own_jid :: String.t() | nil) :: String.t()
  def generate_message_id(own_jid \\ nil) do
    unix_seconds = System.system_time(:second)
    seconds_be8 = <<unix_seconds::big-unsigned-64>>

    own_user_bytes =
      case own_jid && JID.parse(own_jid) do
        {:ok, %JID{user: user}} when is_binary(user) and user != "" ->
          user <> "@c.us"

        _ ->
          ""
      end

    random16 = :crypto.strong_rand_bytes(16)
    data = seconds_be8 <> own_user_bytes <> random16
    <<prefix9::binary-size(9), _::binary>> = :crypto.hash(:sha256, data)

    "3EB0" <> Base.encode16(prefix9, case: :upper)
  end

  @doc """
  Send `text` to `peer_jid` through the running session `server`.

  Orchestrates the full outbound pipeline:

    1. Pull the live device record from the Session GenServer.
    2. Try to load a persisted `%Whatsmeow.Signal.Session{}` for the
       peer. If found → steady-state `<enc type="msg">`. If not →
       fetch the peer's PreKey bundle (`<iq xmlns="encrypt" type="get">`)
       and bootstrap a fresh session via X3DH → `<enc type="pkmsg">`.
    3. Encode the message bytes (`build_e2e_text_message/1`), feed them
       through `Whatsmeow.Signal.WireEncrypt`, and wrap the resulting
       envelope as `<message><enc>` via `build_text_message_node/4`.
    4. Send the node, persist the advanced Signal session.

  Returns `{:ok, message_id}` so callers can correlate the matching
  inbound `<receipt>` / ack later.

  `peer_jid` may be either a `%JID{}` or its string form (e.g.
  `"4477…@s.whatsapp.net"`).
  """
  @spec send_text(pid() | String.t(), JID.t() | String.t(), String.t(), keyword()) ::
          {:ok, message_id :: String.t()} | {:error, send_error()}
  def send_text(server, peer, text, opts \\ []) when is_binary(text) do
    with {:ok, peer_jid} <- to_jid(peer),
         {:ok, %Device{} = device} <- Session.get_device(server),
         {:ok, our_ad_jid} <- parse_device_jid(device.jid),
         :ok <- guard_not_self(our_ad_jid, peer_jid) do
      inner_proto = %WAWebProtobufsE2E.Message{conversation: text}
      do_send_dm(server, device, our_ad_jid, peer_jid, inner_proto, "text", opts)
    end
  end

  # Full multi-device E2E fanout. WhatsApp's multi-device protocol won't
  # deliver a single `<message><enc>` — it requires `<message><participants>`
  # with one `<to jid="<device_jid>"><enc>...</enc></to>` child per device
  # of the recipient AND each of OUR other devices (encrypted to a
  # `DeviceSentMessage` wrapper so they show "sent from your other
  # device" in the WhatsApp Web / Desktop UI). Without that wrapper the
  # server accepts the stanza with an `<ack class="message" phash=…>`
  # but silently drops delivery — the recipient phone never buzzes.
  # Mirrors Go's `sendDM` + `prepareMessageNode` + `encryptMessageForDevices`
  # (`whatsmeow-main/send.go:841,1156,1261`).
  #
  # `msg_type` is the outer `<message type="…">` attribute — `"text"` for
  # plain text, `"media"` for image/video/audio/document. Same fanout shape
  # in either case (Go's `sendDM` doesn't branch on payload kind).
  defp do_send_dm(
         server,
         %Device{} = device,
         %JID{} = our_ad_jid,
         %JID{} = peer_jid,
         %WAWebProtobufsE2E.Message{} = inner_proto,
         msg_type,
         opts
       )
       when msg_type in ["text", "media"] do
    plaintext =
      inner_proto |> WAWebProtobufsE2E.Message.encode() |> IO.iodata_to_binary()

    dsm_plaintext =
      %WAWebProtobufsE2E.Message{
        deviceSentMessage: %WAWebProtobufsE2E.DeviceSentMessage{
          destinationJID: JID.to_string(peer_jid),
          message: inner_proto
        }
      }
      |> WAWebProtobufsE2E.Message.encode()
      |> IO.iodata_to_binary()

    timeout = Keyword.get(opts, :device_timeout, 30_000)

    with {:ok, all_devices} <-
           User.get_user_devices(server, [peer_jid, JID.to_non_ad(our_ad_jid)], timeout: timeout),
         devices = strip_self_and_hosted(all_devices, our_ad_jid),
         :ok <- guard_have_devices(devices) do
      our_bare_user = our_ad_jid.user

      {participant_nodes, sessions_to_persist, any_pkmsg} =
        parallel_fanout(devices, fn ad_jid ->
          pt = if ad_jid.user == our_bare_user, do: dsm_plaintext, else: plaintext
          {ad_jid, encrypt_plaintext_for_peer(server, device, ad_jid, pt, opts)}
        end)

      case Enum.reverse(participant_nodes) do
        [] ->
          {:error, :no_devices_encrypted}

        participant_nodes ->
          sessions_to_persist = Enum.reverse(sessions_to_persist)

          msg_id =
            Keyword.get_lazy(opts, :message_id, fn -> generate_message_id(device.jid) end)

          msg_node =
            build_dm_message_node(peer_jid, msg_id, participant_nodes, device, any_pkmsg, msg_type)

          case Session.send_node(server, msg_node) do
            :ok ->
              # Persist each advanced Signal session AFTER the wire send
              # succeeds — same reason as before (if the WSS write fails
              # we don't want to burn the chain keys). Now batched in a
              # single transaction so we don't issue N serial round-trips.
              _ = persist_sessions_batch(device.jid, sessions_to_persist)

              _ =
                Whatsmeow.Retry.RecentCache.put(
                  JID.to_string(peer_jid),
                  msg_id,
                  plaintext,
                  msg_type
                )

              {:ok, msg_id}

            {:error, reason} ->
              {:error, {:transport, reason}}
          end
      end
    end
  end

  defp build_participant_node(%JID{} = ad_jid, envelope, enc_type)
       when enc_type in ["msg", "pkmsg"] do
    Node.new("to", %{"jid" => ad_jid}, [
      Node.new("enc", %{"v" => "2", "type" => enc_type}, envelope)
    ])
  end

  defp build_dm_message_node(
         %JID{} = peer_jid,
         msg_id,
         participant_nodes,
         %Device{} = device,
         include_identity?,
         msg_type
       )
       when msg_type in ["text", "media"] do
    # Mirror Go's `prepareMessageNode` (`whatsmeow-main/send.go:1185`)
    # exactly — id / type / to only. `phash` is server-side: it's the
    # value the server *returns* on the `<ack>`. Including `phash` as an
    # outbound attr makes the stanza invalid against WhatsApp's SMAX
    # schema and the server replies `<ack class="message" error="479">`
    # (smax-invalid) without delivering. Took an hour to spot.
    attrs = %{
      "id" => msg_id,
      "type" => msg_type,
      "to" => JID.to_non_ad(peer_jid)
    }

    participants_node = Node.new("participants", %{}, participant_nodes)
    children = [participants_node]

    # `<device-identity>` is required whenever any per-device envelope
    # used `pkmsg` (first contact / X3DH). Tells the receiving end how
    # to verify our identity key chain. Mirrors Go's
    # `makeDeviceIdentityNode` (`send.go:1250`).
    children =
      if include_identity?,
        do: children ++ [device_identity_node(device)],
        else: children

    Node.new("message", attrs, children)
  end

  defp device_identity_node(%Device{} = device) do
    bytes =
      %WAAdv.ADVSignedDeviceIdentity{
        details: device.adv_details,
        accountSignature: device.adv_account_sig,
        accountSignatureKey: device.adv_account_sig_key,
        deviceSignature: device.adv_device_sig
      }
      |> WAAdv.ADVSignedDeviceIdentity.encode()
      |> IO.iodata_to_binary()

    Node.new("device-identity", %{}, bytes)
  end

  defp strip_self_and_hosted(devices, %JID{user: own_user, device: own_device}) do
    Enum.reject(devices, fn ad ->
      hosted_server?(ad.server) or (ad.user == own_user and ad.device == own_device)
    end)
  end

  defp hosted_server?(server),
    do: server == JID.hosted_server() or server == JID.hosted_lid_server()

  defp guard_have_devices([]), do: {:error, :no_devices_resolved}
  defp guard_have_devices(_), do: :ok

  defp parse_device_jid(jid_str) when is_binary(jid_str) do
    case JID.parse(jid_str) do
      {:ok, %JID{} = j} -> {:ok, j}
      _ -> {:error, :no_device}
    end
  end

  defp parse_device_jid(_), do: {:error, :no_device}

  # Reject sends where the peer resolves to our own user. WhatsApp Web
  # doesn't deliver self-1:1 messages through the normal peer protocol —
  # encrypt+send may "succeed" but the message never lands, and the
  # persisted Signal session ends up corrupted because we encrypted to
  # the bare user JID instead of a remote device.
  defp guard_not_self(%JID{user: our_user}, %JID{user: their_user})
       when our_user == their_user,
       do: {:error, :cannot_send_to_self}

  defp guard_not_self(_, _), do: :ok

  # --- prekey bundle fetch -----------------------------------------------

  @doc """
  Fetch a `%PreKeyBundle{}` for `peer` via a synchronous `<iq>` round-trip.

  Public so callers (e.g. higher-level send orchestrators or tests)
  can preload bundles outside of `send_text/3`.
  """
  @spec fetch_prekey_bundle(pid() | String.t(), JID.t(), non_neg_integer()) ::
          {:ok, PreKeyBundle.t()} | {:error, send_error()}
  def fetch_prekey_bundle(server, %JID{} = peer, timeout \\ 30_000) do
    iq = IQ.build_prekeys_get([JID.to_string(peer)])

    with {:ok, response} <- request_bundle(server, iq, timeout),
         {:ok, bundles} <- PreKeyBundle.from_iq_response(response),
         {:ok, %PreKeyBundle{} = bundle} <- pick_bundle(bundles, peer) do
      {:ok, bundle}
    end
  end

  defp request_bundle(server, iq, timeout) do
    case Session.send_iq(server, iq, timeout) do
      {:ok, response} -> {:ok, response}
      {:error, reason} -> {:error, {:bundle_error, reason}}
    end
  end

  defp pick_bundle([], _peer), do: {:error, :no_bundle}

  defp pick_bundle(bundles, peer) do
    case Enum.find(bundles, fn {jid, _} -> jids_match?(jid, peer) end) || List.first(bundles) do
      {_jid, %PreKeyBundle{} = bundle} -> {:ok, bundle}
      {_jid, {:error, reason}} -> {:error, {:bundle_error, reason}}
      _ -> {:error, :no_bundle}
    end
  end

  defp jids_match?(%JID{user: u}, %JID{user: u}), do: true
  defp jids_match?(_, _), do: false

  # --- session + identity lookup -----------------------------------------

  defp load_session_and_identity(our_jid, their_id, override) do
    case load_session(our_jid, their_id) do
      {:ok, sess} ->
        case override || load_identity_pub(our_jid, their_id) do
          pub when is_binary(pub) and byte_size(pub) == 32 -> {:ok, sess, pub}
          _ -> :no_session
        end

      :not_found ->
        :no_session

      {:error, _} ->
        :no_session
    end
  end

  defp load_session(our_jid, their_id) do
    if repo_up?(),
      do: Whatsmeow.Signal.Store.Postgres.get(our_jid, their_id),
      else: :not_found
  end

  defp load_identity_pub(our_jid, their_id) do
    if repo_up?() do
      case Whatsmeow.Repo.get_by(Whatsmeow.Store.Schemas.IdentityKey,
             our_jid: our_jid,
             their_id: their_id
           ) do
        %Whatsmeow.Store.Schemas.IdentityKey{identity: id_pub}
        when is_binary(id_pub) and byte_size(id_pub) == 32 ->
          id_pub

        _ ->
          nil
      end
    else
      nil
    end
  rescue
    _ -> nil
  end

  defp repo_up? do
    Code.ensure_loaded?(Whatsmeow.Repo) and is_pid(Process.whereis(Whatsmeow.Repo))
  end

  defp to_jid(%JID{} = j), do: {:ok, j}

  defp to_jid(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, %JID{} = j} -> {:ok, j}
      _ -> {:error, :invalid_peer_jid}
    end
  end

  defp to_jid(_), do: {:error, :invalid_peer_jid}

  # --- low-level builders (unchanged signatures, kept stateless) ---------

  @doc """
  Wrap an already-encrypted Signal envelope as a `<message><enc>` Node
  ready to send. `enc_type` is `"msg"` for steady-state (post-first-message)
  or `"pkmsg"` for first-contact (X3DH bootstrap).

  Mirrors Go's `<message id type to><enc v="2" type="msg|pkmsg">…</enc></message>`
  shape from `whatsmeow-main/send.go#sendDM`.
  """
  @spec build_text_message_node(
          to :: JID.t(),
          message_id :: String.t(),
          envelope :: binary(),
          enc_type :: String.t()
        ) :: Node.t()
  def build_text_message_node(%JID{} = to, message_id, envelope, enc_type)
      when is_binary(message_id) and is_binary(envelope) and enc_type in ["msg", "pkmsg"] do
    Node.new(
      "message",
      %{
        "id" => message_id,
        "type" => "text",
        "to" => to
      },
      [
        Node.new(
          "enc",
          %{"v" => "2", "type" => enc_type},
          envelope
        )
      ]
    )
  end

  @doc """
  Build a `WAWebProtobufsE2E.Message` carrying a plain text body.

  WhatsApp encodes a simple text message as the `conversation` field of
  the top-level `WAWebProtobufsE2E.Message`. This helper hides the
  protobuf shape from the caller.
  """
  @spec build_e2e_text_message(String.t()) :: binary()
  def build_e2e_text_message(text) when is_binary(text) do
    WAWebProtobufsE2E.Message
    |> struct(%{conversation: text})
    |> WAWebProtobufsE2E.Message.encode()
    |> IO.iodata_to_binary()
  end

  # --- Message-action builders (Edit / Revoke / Reaction / Poll) ----------
  #
  # All return a `%WAWebProtobufsE2E.Message{}` (unmarshalled). The caller
  # is expected to feed it through the regular send pipeline (which
  # marshals + encrypts). Mirrors Go's `BuildEdit` / `BuildRevoke` /
  # `BuildReaction` / `BuildPollCreation` in `send.go` + `msgsecret.go`.

  @doc """
  Build a `MessageKey` proto identifying a previously-sent message.

  `chat`   — the chat JID (1:1 peer or group).
  `sender` — the original sender's JID. Pass `nil` (or an empty `%JID{}`)
             when the message was sent by us; pass a peer JID when revoking
             someone else's message as a group admin.

  Mirrors Go's `Client.BuildMessageKey` (`send.go:488`).
  """
  @spec build_message_key(JID.t() | String.t(), JID.t() | nil, String.t()) ::
          WACommon.MessageKey.t()
  def build_message_key(chat, sender, msg_id) when is_binary(msg_id) do
    {:ok, chat_jid} = to_jid(chat)
    chat_str = JID.to_string(chat_jid)

    base = %WACommon.MessageKey{
      fromMe: from_me?(sender),
      ID: msg_id,
      remoteJID: chat_str
    }

    case sender do
      %JID{user: u, server: _} = peer when u != "" ->
        if from_me?(sender) do
          base
        else
          participant =
            if chat_jid.server in [
                 JID.default_user_server(),
                 JID.hidden_user_server(),
                 JID.messenger_server()
               ] do
              nil
            else
              JID.to_string(JID.to_non_ad(peer))
            end

          %WACommon.MessageKey{base | participant: participant}
        end

      _ ->
        base
    end
  end

  defp from_me?(nil), do: true
  defp from_me?(%JID{user: ""}), do: true
  defp from_me?(%JID{server: ""}), do: true
  defp from_me?(%JID{}), do: false

  @doc """
  Build a `PEER_DATA_OPERATION_REQUEST_MESSAGE` asking the user's
  primary phone to re-forward a message our companion device failed
  to decrypt or never received.

  Used when a `<message>` arrives whose `<enc>` body we can't decrypt
  (`:mac_mismatch`, `:no_session`), the peer is encrypting against a
  stale session, AND the count=1 retry receipt didn't unblock them.
  Mirrors Go's `Client.BuildUnavailableMessageRequest`
  (`whatsmeow-main/send.go:544`). The built message must be sent via
  `send_peer_message/2` (NOT `send_text/3`) — peer messages have
  different routing on the wire (`<message category="peer">`).

  `chat_jid` and `sender_jid` come from the failed inbound's
  `MessageInfo`. For a 1:1 chat both are the peer's JID; for a group
  message `chat_jid` is the group JID and `sender_jid` is the actual
  member.

  Returns a `%WAWebProtobufsE2E.Message{}` ready to feed through
  `send_peer_message/2`.
  """
  @spec build_unavailable_message_request(JID.t() | String.t(), JID.t() | nil, String.t()) ::
          WAWebProtobufsE2E.Message.t()
  def build_unavailable_message_request(chat, sender, msg_id) when is_binary(msg_id) do
    %WAWebProtobufsE2E.Message{
      protocolMessage: %WAWebProtobufsE2E.ProtocolMessage{
        type: :PEER_DATA_OPERATION_REQUEST_MESSAGE,
        peerDataOperationRequestMessage: %WAWebProtobufsE2E.PeerDataOperationRequestMessage{
          peerDataOperationRequestType: :PLACEHOLDER_MESSAGE_RESEND,
          placeholderMessageResendRequest: [
            %WAWebProtobufsE2E.PeerDataOperationRequestMessage.PlaceholderMessageResendRequest{
              messageKey: build_message_key(chat, sender, msg_id)
            }
          ]
        }
      }
    }
  end

  @doc """
  Send a "peer message" — a message addressed to our own primary
  device (not a third party). Used for app-internal coordination
  signals like `PLACEHOLDER_MESSAGE_RESEND` (ask the primary phone
  to re-forward a message), `HISTORY_SYNC_ON_DEMAND` (request more
  history backfill), and similar Peer-Data-Operation requests.

  The outer `<message>` node carries `category="peer"` which tells
  WhatsApp's server to route the stanza to our own JID (NOT to a
  remote peer). The body is still Signal-encrypted, but only
  encrypted for our OWN linked devices and primary — never for a
  third-party recipient. Mirrors Go's `Client.SendPeerMessage`
  (`whatsmeow-main/send.go:468`).

  Returns `{:ok, message_id}` so callers can correlate the
  `PeerDataOperationRequestResponseMessage` reply later.
  """
  @spec send_peer_message(pid() | String.t(), WAWebProtobufsE2E.Message.t(), keyword()) ::
          {:ok, String.t()} | {:error, term()}
  def send_peer_message(server, %WAWebProtobufsE2E.Message{} = msg, opts \\ []) do
    with {:ok, %Device{} = device} <- Session.get_device(server),
         {:ok, our_ad_jid} <- parse_device_jid(device.jid) do
      own_non_ad = JID.to_non_ad(our_ad_jid)

      plaintext =
        msg
        |> WAWebProtobufsE2E.Message.encode()
        |> IO.iodata_to_binary()

      timeout = Keyword.get(opts, :device_timeout, 30_000)

      with {:ok, all_devices} <-
             User.get_user_devices(server, [own_non_ad], timeout: timeout),
           devices = strip_self_and_hosted(all_devices, our_ad_jid),
           :ok <- guard_have_devices(devices) do
        {participant_nodes, sessions_to_persist, any_pkmsg} =
          parallel_fanout(devices, fn ad_jid ->
            {ad_jid, encrypt_plaintext_for_peer(server, device, ad_jid, plaintext, opts)}
          end)

        case Enum.reverse(participant_nodes) do
          [] ->
            {:error, :no_devices_encrypted}

          participant_nodes ->
            msg_id =
              Keyword.get_lazy(opts, :message_id, fn -> generate_message_id(device.jid) end)

            # `category="peer"` is what flips the server routing path.
            # Same shape as a regular DM otherwise.
            attrs =
              %{
                "id" => msg_id,
                "type" => "text",
                "to" => own_non_ad,
                "category" => "peer"
              }

            children = [Node.new("participants", %{}, participant_nodes)]

            children =
              if any_pkmsg, do: children ++ [device_identity_node(device)], else: children

            node = Node.new("message", attrs, children)

            case Session.send_node(server, node) do
              :ok ->
                _ = persist_sessions_batch(device.jid, sessions_to_persist)
                {:ok, msg_id}

              {:error, reason} ->
                {:error, {:transport, reason}}
            end
        end
      end
    end
  end

  @doc """
  Build a message that, when sent, deletes (revokes) the previously-sent
  message identified by `msg_id`.

  To revoke our own message: pass `nil` (or empty `%JID{}`) as `sender`.
  To revoke another participant's message as a group admin: pass their JID.

  Mirrors Go's `Client.BuildRevoke` (`send.go:513`).
  """
  @spec build_revoke(JID.t() | String.t(), JID.t() | nil, String.t()) ::
          WAWebProtobufsE2E.Message.t()
  def build_revoke(chat, sender, msg_id) when is_binary(msg_id) do
    %WAWebProtobufsE2E.Message{
      protocolMessage: %WAWebProtobufsE2E.ProtocolMessage{
        type: :REVOKE,
        key: build_message_key(chat, sender, msg_id)
      }
    }
  end

  @doc """
  Build a reaction message (emoji reply) targeting a previous message.

  Pass `reaction: ""` to remove a prior reaction.

  Mirrors Go's `Client.BuildReaction` (`send.go:528`).
  """
  @spec build_reaction(JID.t() | String.t(), JID.t() | nil, String.t(), String.t()) ::
          WAWebProtobufsE2E.Message.t()
  def build_reaction(chat, sender, msg_id, reaction)
      when is_binary(msg_id) and is_binary(reaction) do
    %WAWebProtobufsE2E.Message{
      reactionMessage: %WAWebProtobufsE2E.ReactionMessage{
        key: build_message_key(chat, sender, msg_id),
        text: reaction,
        senderTimestampMS: System.system_time(:millisecond)
      }
    }
  end

  @doc """
  Build an edit message that replaces the body of the previously-sent
  message `msg_id` with `new_content`.

  `new_content` should be a `%WAWebProtobufsE2E.Message{}` (e.g.
  `%WAWebProtobufsE2E.Message{conversation: "edited body"}`).

  WhatsApp enforces a 20-minute edit window — outside that, the server
  silently drops the edit. Mirrors Go's `Client.BuildEdit` and
  `whatsmeow.EditWindow` (`send.go:585+`).
  """
  @spec build_edit(JID.t() | String.t(), String.t(), WAWebProtobufsE2E.Message.t()) ::
          WAWebProtobufsE2E.Message.t()
  def build_edit(chat, msg_id, %WAWebProtobufsE2E.Message{} = new_content)
      when is_binary(msg_id) do
    %WAWebProtobufsE2E.Message{
      editedMessage: %WAWebProtobufsE2E.FutureProofMessage{
        message: %WAWebProtobufsE2E.Message{
          protocolMessage: %WAWebProtobufsE2E.ProtocolMessage{
            type: :MESSAGE_EDIT,
            key: build_message_key(chat, nil, msg_id),
            editedMessage: new_content,
            timestampMS: System.system_time(:millisecond)
          }
        }
      }
    }
  end

  @doc """
  Build a poll creation message.

  `selectable_count` clamps how many options a voter can pick at once.
  Pass `1` for single-select, `0` to disable the limit.

  Mirrors Go's `Client.BuildPollCreation` (`msgsecret.go:326`). The poll
  vote builder lives in `Whatsmeow.MsgSecret` because votes are encrypted
  via the message-secret HKDF derivation.
  """
  @spec build_poll_creation(String.t(), [String.t()], non_neg_integer()) ::
          WAWebProtobufsE2E.Message.t()
  def build_poll_creation(name, option_names, selectable_count)
      when is_binary(name) and is_list(option_names) and is_integer(selectable_count) and
             selectable_count >= 0 do
    msg_secret = :crypto.strong_rand_bytes(32)

    selectable =
      if selectable_count > length(option_names), do: 0, else: selectable_count

    options =
      Enum.map(option_names, fn opt when is_binary(opt) ->
        %WAWebProtobufsE2E.PollCreationMessage.Option{optionName: opt}
      end)

    %WAWebProtobufsE2E.Message{
      pollCreationMessage: %WAWebProtobufsE2E.PollCreationMessage{
        name: name,
        options: options,
        selectableOptionsCount: selectable
      },
      messageContextInfo: %WAWebProtobufsE2E.MessageContextInfo{
        messageSecret: msg_secret
      }
    }
  end

  # --- outbound media -----------------------------------------------------

  @doc """
  Send an image to `peer`. Encrypts the bytes for media upload, uploads
  to the WhatsApp CDN, then sends a Signal-encrypted `<message>`
  carrying the resulting `imageMessage` descriptor.

  Required: a `:media_conn` opt (fetch via `Whatsmeow.Media.Refresh.refresh/2`).

  Optional:
    * `:caption` — image caption.
    * `:mime_type` — defaults to `"image/jpeg"`.

  Returns `{:ok, message_id}` like `send_text/3`.
  """
  @spec send_image(pid() | String.t(), JID.t() | String.t(), binary(), keyword()) ::
          {:ok, message_id :: String.t()} | {:error, term()}
  def send_image(server, peer, bytes, opts \\ []) when is_binary(bytes) do
    send_media(server, peer, bytes, :image, opts)
  end

  @doc "Send a video to `peer`. Same options as `send_image/4`."
  @spec send_video(pid() | String.t(), JID.t() | String.t(), binary(), keyword()) ::
          {:ok, message_id :: String.t()} | {:error, term()}
  def send_video(server, peer, bytes, opts \\ []) when is_binary(bytes) do
    send_media(server, peer, bytes, :video, opts)
  end

  @doc "Send an audio file (music/podcast) to `peer`."
  @spec send_audio(pid() | String.t(), JID.t() | String.t(), binary(), keyword()) ::
          {:ok, message_id :: String.t()} | {:error, term()}
  def send_audio(server, peer, bytes, opts \\ []) when is_binary(bytes) do
    send_media(server, peer, bytes, :audio, opts)
  end

  @doc "Send a voice note (PTT-flagged audio) to `peer`."
  @spec send_voice(pid() | String.t(), JID.t() | String.t(), binary(), keyword()) ::
          {:ok, message_id :: String.t()} | {:error, term()}
  def send_voice(server, peer, bytes, opts \\ []) when is_binary(bytes) do
    send_media(server, peer, bytes, :voice, opts)
  end

  @doc "Send a document to `peer`. Pass `:file_name` and `:mime_type` opts."
  @spec send_document(pid() | String.t(), JID.t() | String.t(), binary(), keyword()) ::
          {:ok, message_id :: String.t()} | {:error, term()}
  def send_document(server, peer, bytes, opts \\ []) when is_binary(bytes) do
    send_media(server, peer, bytes, :document, opts)
  end

  defp send_media(server, peer, bytes, kind, opts) do
    with {:ok, peer_jid} <- to_jid(peer),
         {:ok, %Device{} = device} <- Session.get_device(server),
         {:ok, our_ad_jid} <- parse_device_jid(device.jid),
         :ok <- guard_not_self(our_ad_jid, peer_jid),
         {:ok, upload} <- upload_media_bytes(bytes, kind, opts) do
      inner_proto = build_media_message_proto(kind, upload, opts)
      # Outer `<message type=>` mirrors Go's `sendDM` — it uses "text" even
      # for media-carrying DMs (the payload kind is implicit in the protobuf,
      # not in the stanza-level type attr). Earlier `"media"` was a silent
      # delivery killer: server accepts with `<ack class="message">` but
      # recipient phone never renders the imageMessage.
      do_send_dm(server, device, our_ad_jid, peer_jid, inner_proto, "text", opts)
    end
  end

  defp upload_media_bytes(bytes, kind, opts) do
    media_conn = Keyword.get(opts, :media_conn)

    if is_nil(media_conn) do
      {:error, :media_conn_required}
    else
      # Audio/voice share encryption keys; the CDN distinguishes them
      # by mms-type but the HKDF info is the same string.
      crypto_kind = if kind == :voice, do: :audio, else: kind

      case Whatsmeow.Media.Upload.upload(bytes, crypto_kind, media_conn: media_conn) do
        {:ok, upload} -> {:ok, upload}
        {:error, _} = err -> err
      end
    end
  end

  # Build the unencoded `%WAWebProtobufsE2E.Message{}` carrying a media
  # descriptor. Returns the struct (NOT the encoded bytes) so the caller
  # can rewrap it inside a `DeviceSentMessage` for own-device fanout
  # before encoding per-device plaintexts.
  #
  # For image/video, `:jpeg_thumbnail` (+ `:width`/`:height`) carry the inline
  # preview WhatsApp shows before download. WITHOUT a thumbnail the recipient
  # sees a grey placeholder until they manually tap-to-download — the full
  # media (URL/mediaKey/sha) is correct, only the preview is missing. The
  # caller is responsible for generating the thumbnail (e.g. via ImageMagick).
  @doc false
  def build_media_message_proto(:image, upload, opts) do
    %WAWebProtobufsE2E.Message{
      imageMessage: %WAWebProtobufsE2E.ImageMessage{
        URL: upload.url,
        directPath: upload.direct_path,
        mediaKey: upload.media_key,
        fileSHA256: upload.file_sha256,
        fileEncSHA256: upload.file_enc_sha256,
        fileLength: upload.file_length,
        mimetype: Keyword.get(opts, :mime_type, "image/jpeg"),
        caption: Keyword.get(opts, :caption),
        mediaKeyTimestamp: System.os_time(:second),
        JPEGThumbnail: Keyword.get(opts, :jpeg_thumbnail),
        height: Keyword.get(opts, :height),
        width: Keyword.get(opts, :width)
      }
    }
  end

  def build_media_message_proto(:video, upload, opts) do
    %WAWebProtobufsE2E.Message{
      videoMessage: %WAWebProtobufsE2E.VideoMessage{
        URL: upload.url,
        directPath: upload.direct_path,
        mediaKey: upload.media_key,
        fileSHA256: upload.file_sha256,
        fileEncSHA256: upload.file_enc_sha256,
        fileLength: upload.file_length,
        mimetype: Keyword.get(opts, :mime_type, "video/mp4"),
        caption: Keyword.get(opts, :caption),
        seconds: Keyword.get(opts, :duration_seconds),
        mediaKeyTimestamp: System.os_time(:second),
        JPEGThumbnail: Keyword.get(opts, :jpeg_thumbnail),
        height: Keyword.get(opts, :height),
        width: Keyword.get(opts, :width)
      }
    }
  end

  def build_media_message_proto(kind, upload, opts) when kind in [:audio, :voice] do
    %WAWebProtobufsE2E.Message{
      audioMessage: %WAWebProtobufsE2E.AudioMessage{
        URL: upload.url,
        directPath: upload.direct_path,
        mediaKey: upload.media_key,
        fileSHA256: upload.file_sha256,
        fileEncSHA256: upload.file_enc_sha256,
        fileLength: upload.file_length,
        mimetype: Keyword.get(opts, :mime_type, "audio/ogg; codecs=opus"),
        seconds: Keyword.get(opts, :duration_seconds),
        PTT: kind == :voice,
        mediaKeyTimestamp: System.os_time(:second)
      }
    }
  end

  def build_media_message_proto(:document, upload, opts) do
    %WAWebProtobufsE2E.Message{
      documentMessage: %WAWebProtobufsE2E.DocumentMessage{
        URL: upload.url,
        directPath: upload.direct_path,
        mediaKey: upload.media_key,
        fileSHA256: upload.file_sha256,
        fileEncSHA256: upload.file_enc_sha256,
        fileLength: upload.file_length,
        mimetype: Keyword.get(opts, :mime_type, "application/octet-stream"),
        fileName: Keyword.get(opts, :file_name),
        caption: Keyword.get(opts, :caption),
        mediaKeyTimestamp: System.os_time(:second)
      }
    }
  end

  @doc """
  Encrypt arbitrary plaintext (already-marshalled `WaE2E.Message` bytes)
  for a single peer device. Returns `{:ok, envelope, enc_type, new_session}`
  where `enc_type` is `"msg"` (steady state) or `"pkmsg"` (first contact,
  X3DH bootstrap).

  Public so callers building a fanout (e.g. group SKDM distribution) can
  reuse the steady-state / first-contact selection logic without rewriting
  bundle fetching + identity stashing.
  """
  @spec encrypt_plaintext_for_peer(
          pid() | String.t(),
          Device.t(),
          JID.t(),
          binary(),
          keyword()
        ) ::
          {:ok, envelope :: binary(), enc_type :: String.t(), new_session :: term()}
          | {:error, send_error()}
  def encrypt_plaintext_for_peer(server, %Device{} = device, %JID{} = peer, plaintext, opts) do
    their_id = JID.to_string(peer)
    their_id_pub_override = Keyword.get(opts, :their_identity_pub)

    case load_session_and_identity(device.jid, their_id, their_id_pub_override) do
      {:ok, sess, their_id_pub} ->
        our_id_pub = Whatsmeow.Crypto.Curve25519.public_for(device.identity_key)

        case WireEncrypt.encrypt_signal_envelope(plaintext, sess, our_id_pub, their_id_pub) do
          {:ok, inner_envelope, new_sess} ->
            # Until the peer has acked ANY of our messages we MUST keep
            # shipping `PreKeySignalMessage`s — the peer has no Signal
            # session for us yet, so a bare `<enc type="msg">` would be
            # silently dropped and the chat UI would stick on "Waiting
            # for this message" forever. libsignal-java mirrors this via
            # `SessionState.hasPendingPreKey()` — we mirror via
            # `Session.pending_pre_key` on `%Whatsmeow.Signal.Session{}`.
            #
            # `Map.get/2` (not dot-access) so legacy persisted Session
            # structs that predate this field don't crash the encrypt
            # path with `KeyError`. Missing == treated as `nil` ==
            # steady-state `msg` — which is the right default for a
            # session that has already exchanged messages.
            case Map.get(sess, :pending_pre_key) do
              %{} = pending ->
                envelope = WireEncrypt.wrap_as_pkmsg(inner_envelope, pending)
                {:ok, envelope, "pkmsg", new_sess}

              _ ->
                {:ok, inner_envelope, "msg", new_sess}
            end

          {:error, reason} ->
            {:error, {:encrypt, reason}}
        end

      :no_session ->
        timeout = Keyword.get(opts, :bundle_timeout, 30_000)

        with {:ok, bundle} <- fetch_prekey_bundle(server, peer, timeout) do
          case WireEncrypt.encrypt_prekey_envelope(
                 plaintext,
                 device.identity_key,
                 device.registration_id,
                 bundle
               ) do
            {:ok, envelope, sess} ->
              _ =
                Whatsmeow.Signal.Decrypt.stash_identity_pub(
                  device.jid,
                  their_id,
                  bundle.identity_pub
                )

              {:ok, envelope, "pkmsg", sess}

            {:error, reason} ->
              {:error, {:encrypt, reason}}
          end
        end
    end
  end

  # --- Parallel fanout helpers --------------------------------------------
  #
  # Encrypt-per-device is independent work, but historically ran serially
  # via Enum.reduce — a group of 50 participants meant 50 sequential
  # X3DH / SKDM encryptions plus 50 PreKey-bundle IQ round-trips when no
  # session existed. `parallel_fanout/2` runs the per-device encrypt
  # closure under `Task.async_stream/3` with `Whatsmeow.Config.send_concurrency/0`
  # workers (default 8 — see Config docs) and re-merges into the same
  # `{participant_nodes, sessions_to_persist, any_pkmsg?}` accumulator
  # the old reduce produced. Order of `participant_nodes` is irrelevant
  # on the wire (the server doesn't depend on participant order inside
  # `<participants>`), so we use `ordered: false`.

  @doc false
  @spec parallel_fanout(
          [JID.t()],
          (JID.t() ->
             {JID.t(), {:ok, binary(), String.t(), term()} | {:error, term()}})
        ) :: {[Node.t()], [{JID.t(), term()}], boolean()}
  def parallel_fanout(devices, encrypt_fun) when is_list(devices) and is_function(encrypt_fun, 1) do
    devices
    |> Task.async_stream(encrypt_fun,
      max_concurrency: Whatsmeow.Config.send_concurrency(),
      ordered: false,
      timeout: Whatsmeow.Config.fanout_task_timeout_ms(),
      on_timeout: :kill_task
    )
    |> Enum.reduce({[], [], false}, &collect_fanout_result/2)
  end

  defp collect_fanout_result(
         {:ok, {%JID{} = ad_jid, {:ok, envelope, enc_type, new_sess}}},
         {nodes, sessions, pkmsg?}
       )
       when enc_type in ["msg", "pkmsg"] do
    participant = build_participant_node(ad_jid, envelope, enc_type)
    {[participant | nodes], [{ad_jid, new_sess} | sessions], pkmsg? or enc_type == "pkmsg"}
  end

  defp collect_fanout_result({:ok, {%JID{} = ad_jid, {:error, reason}}}, acc) do
    Logger.warning("[whatsmeow] dm fanout: skipped #{JID.to_string(ad_jid)}: #{inspect(reason)}")

    acc
  end

  defp collect_fanout_result({:exit, reason}, acc) do
    Logger.warning("[whatsmeow] dm fanout: task crashed: #{inspect(reason)}")
    acc
  end

  # Persist each advanced Signal session in a single transaction so the
  # post-send DB cost is one round-trip rather than N. Falls back to
  # serial put when no Repo is available.
  @doc false
  @spec persist_sessions_batch(String.t(), [{JID.t(), term()}]) :: :ok
  def persist_sessions_batch(our_jid, sessions) when is_binary(our_jid) and is_list(sessions) do
    if repo_up?() do
      _ =
        Whatsmeow.Repo.transaction(fn ->
          for {%JID{} = ad_jid, new_sess} <- sessions do
            _ = Decrypt.persist_session(our_jid, JID.to_string(ad_jid), new_sess)
          end
        end)

      :ok
    else
      for {%JID{} = ad_jid, new_sess} <- sessions do
        _ = Decrypt.persist_session(our_jid, JID.to_string(ad_jid), new_sess)
      end

      :ok
    end
  end
end
