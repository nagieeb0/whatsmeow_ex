defmodule Whatsmeow.Send.Group do
  @moduledoc """
  Outbound group message pipeline (`<enc type="skmsg">` + SKDM fanout).

  This is the symmetric counterpart of `Whatsmeow.Signal.GroupDecrypt` —
  the cipher state machine already exists; this module handles the
  framing + fanout to every participant device.

  ## Pipeline

      caller plaintext
            │
            │ build WaE2E.Message{conversation: text}, marshal
            ▼
   ┌───────────────────────────────────────────────────────────────┐
   │ Load or create a %GroupSession{} for (our_jid, group_jid).    │
   │ On miss → `GroupSession.new/1` mints a fresh signing keypair  │
   │ + random chain key + iteration 0.                              │
   └───────────────────────────────────────────────────────────────┘
            │
            ├──────────────► encrypt body with GroupDecrypt.encrypt_envelope
            │                → `<enc v="2" type="skmsg">…</enc>`
            │
            └──────────────► build SKDM bytes (WaE2E.Message wrapper
                              carrying `axolotlSenderKeyDistributionMessage`)
                              and 1:1-encrypt them PER participant device:
                              → `<to jid=AD><enc v="2" type="msg|pkmsg">…</enc></to>`
                                fanned out under a `<participants>` node.

  Sender's own device JID is filtered out — Go's `sendGroup` does the same
  through the `DeviceSentMessage` exclusion. Hosted-server JIDs are filtered
  out (groups don't fan out to hosted).

  ## What this version does NOT do (yet)

  * `<usync>` for participant discovery — caller passes `:participants` as
    `[String.t() | JID.t()]` (regular user JIDs). Once `Whatsmeow.Group`
    grows live `GetGroupInfo`, we can derive this from the group node.
  * LID-mapping resolution (`Store.LIDs.GetManyLIDsForPNs`). We send to the
    raw PN/AD JID for now.
  * Retry-receipt-driven re-distribution when a peer reports
    `:no_session` — that's the retry-receipt task.
  * `<device-identity>` attachment alongside pkmsg envelopes — TODO when
    `Store.Schemas.Device.serialize_identity/1` lands.
  * Reporting token (`<reporting>`). Optional for production sends; can be
    bolted on later via `MsgSecret` once we wire it.

  Mirrors `whatsmeow-main/send.go#sendGroup` (lines 747–819).
  """

  require Logger

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Send
  alias Whatsmeow.Session
  alias Whatsmeow.Signal.Lock
  alias Whatsmeow.Signal.GroupDecrypt
  alias Whatsmeow.Signal.GroupSession
  alias Whatsmeow.Signal.SenderKeyWire
  alias Whatsmeow.Signal.SenderKeyWire.SenderKeyDistributionMessage, as: WireSKDM
  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.Types.JID
  alias Whatsmeow.User

  @typedoc "Things that can go wrong on group send."
  @type send_error ::
          :no_device
          | :not_connected
          | :invalid_group_jid
          | :no_participants
          | :no_devices_resolved
          | {:transport, term()}
          | {:fanout, term()}

  @doc """
  Send `text` to a group.

  `group` is the group JID (`%JID{}` or string form, server must be `g.us`).

  Required opt:

  * `:participants` — list of `JID.t() | String.t()` user JIDs (the regular,
    non-AD form). Will be resolved to AD-JIDs via `Whatsmeow.User.get_user_devices/3`.

  Optional opts:

  * `:registration_id` — outbound SenderKey id. Defaults to the device's.
  * `:message_id` — override generated message id.
  * `:bundle_timeout` — per-device PreKey bundle fetch timeout (default 30 s).
  * `:device_timeout` — `<usync>` device-resolution timeout (default 30 s).

  Returns `{:ok, message_id}` on success.
  """
  @spec send_text(pid() | String.t(), JID.t() | String.t(), String.t(), keyword()) ::
          {:ok, String.t()} | {:error, send_error()}
  def send_text(server, group, text, opts \\ []) when is_binary(text) do
    with {:ok, group_jid} <- to_group_jid(group),
         {:ok, participants} <- fetch_participants(opts),
         {:ok, %Device{} = device} <- Session.get_device(server),
         {:ok, devices} <- resolve_devices(server, participants, device, opts) do
      run_send(server, device, group_jid, devices, text, opts)
    end
  end

  # --- Orchestration ---------------------------------------------------------

  defp run_send(server, %Device{} = device, %JID{} = group_jid, devices, text, opts) do
    group_id_str = JID.to_string(group_jid)
    # `Device.jid` is already a string — it is the schema's primary key. Running
    # it back through `JID.to_string/1`, which only has a `%JID{}` clause, raised
    # FunctionClauseError on every group send. Nothing caught it because the
    # tests for this module stop at input validation and never reach here.
    sender_id = device.jid
    sender_key_id = Keyword.get(opts, :registration_id, device.registration_id || 0)

    body_plaintext = Send.build_e2e_text_message(text)

    # Load, encrypt, and store the sender key as one atomic step. The fanout
    # below waits on prekey-bundle IQs, so leaving the store until after it (as
    # this used to) left a multi-second window in which a second concurrent group
    # send would load the same chain key and encrypt at the same iteration —
    # repeating a message key, not merely losing an update. Persisting up front
    # means a failed wire write costs one skipped iteration, which every group
    # member's ratchet already knows how to absorb.
    {body_envelope, gs2} =
      Lock.with_sender_key(device.jid, group_id_str, sender_id, fn ->
        {:ok, gs} = load_or_new_group_session(device.jid, group_id_str, sender_id, sender_key_id)
        {envelope, advanced} = GroupDecrypt.encrypt_envelope(gs, body_plaintext)
        _ = persist_group_session(device.jid, group_id_str, sender_id, advanced)
        {envelope, advanced}
      end)

    skdm_plaintext = build_skdm_plaintext(group_id_str, gs2)

    with {:ok, participant_nodes, include_identity?} <-
           fanout_skdm(server, device, devices, skdm_plaintext, opts) do
      msg_id = Keyword.get_lazy(opts, :message_id, &Send.generate_message_id/0)
      phash = participant_list_hash_v2(devices)

      node =
        build_group_message_node(
          group_jid,
          msg_id,
          phash,
          participant_nodes,
          body_envelope,
          include_identity?
        )

      case Session.send_node(server, node) do
        :ok ->
          # Both the sender key and the per-device 1:1 sessions are already
          # stored, each inside the lock it was encrypted under.
          _ = Whatsmeow.Retry.RecentCache.put(group_id_str, msg_id, body_plaintext, "text")
          {:ok, msg_id}

        {:error, reason} ->
          {:error, {:transport, reason}}
      end
    end
  end

  # --- SKDM plaintext (the WaE2E.Message wrapping the wire SKDM bytes) -------

  defp build_skdm_plaintext(group_id_str, %GroupSession{} = gs) do
    wire_skdm = SenderKeyWire.encode_sender_key_distribution_message(skdm_proto(gs))

    %WAWebProtobufsE2E.Message{
      senderKeyDistributionMessage: %WAWebProtobufsE2E.SenderKeyDistributionMessage{
        groupID: group_id_str,
        axolotlSenderKeyDistributionMessage: wire_skdm
      }
    }
    |> WAWebProtobufsE2E.Message.encode()
    |> IO.iodata_to_binary()
  end

  defp skdm_proto(%GroupSession{} = gs) do
    libsignal = GroupSession.to_distribution(gs)

    %WireSKDM{
      id: libsignal.id,
      iteration: libsignal.iteration,
      chainKey: libsignal.chainKey,
      signingKey: libsignal.signingKey
    }
  end

  # --- Fanout ----------------------------------------------------------------

  defp fanout_skdm(server, %Device{} = device, devices, skdm_plaintext, opts) do
    # Same fanout shape as DM (`Whatsmeow.Send.parallel_fanout/2`) but
    # we also need the *error* list so we can surface `{:fanout, errs}`
    # when zero devices encrypted — group sends to a moribund group
    # need the diagnostic. Hence the local `Task.async_stream` instead
    # of reusing `parallel_fanout/2`.
    {nodes, errs, any_pkmsg?} =
      devices
      |> Task.async_stream(
        fn ad_jid ->
          {ad_jid, Send.encrypt_plaintext_for_peer(server, device, ad_jid, skdm_plaintext, opts)}
        end,
        max_concurrency: Whatsmeow.Config.send_concurrency(),
        ordered: false,
        timeout: Whatsmeow.Config.fanout_task_timeout_ms(),
        on_timeout: :kill_task
      )
      |> Enum.reduce({[], [], false}, fn
        {:ok, {%JID{} = ad_jid, {:ok, envelope, enc_type, _new_sess}}},
        {nodes_acc, errs_acc, pkmsg?} ->
          participant = build_participant_node(ad_jid, envelope, enc_type)
          {[participant | nodes_acc], errs_acc, pkmsg? or enc_type == "pkmsg"}

        {:ok, {%JID{} = ad_jid, {:error, reason}}}, {nodes_acc, errs_acc, pkmsg?} ->
          Logger.warning(
            "[whatsmeow] group fanout: skipped #{JID.to_string(ad_jid)}: #{inspect(reason)}"
          )

          {nodes_acc, [{ad_jid, reason} | errs_acc], pkmsg?}

        {:exit, reason}, {nodes_acc, errs_acc, pkmsg?} ->
          Logger.warning("[whatsmeow] group fanout: task crashed: #{inspect(reason)}")
          {nodes_acc, [{:task_crashed, reason} | errs_acc], pkmsg?}
      end)

    case {nodes, errs} do
      {[], [_ | _]} ->
        {:error, {:fanout, Enum.reverse(errs)}}

      {[], []} ->
        {:error, :no_devices_resolved}

      _ ->
        {:ok, Enum.reverse(nodes), any_pkmsg?}
    end
  end

  defp build_participant_node(%JID{} = ad_jid, envelope, enc_type)
       when enc_type in ["msg", "pkmsg"] do
    Node.new(
      "to",
      %{"jid" => ad_jid},
      [Node.new("enc", %{"v" => "2", "type" => enc_type}, envelope)]
    )
  end

  # --- Outer <message> node --------------------------------------------------

  defp build_group_message_node(
         %JID{} = group_jid,
         msg_id,
         phash,
         participant_nodes,
         body_envelope,
         _include_identity?
       ) do
    attrs = %{
      "id" => msg_id,
      "type" => "text",
      "to" => group_jid,
      "phash" => phash
    }

    skmsg_node = Node.new("enc", %{"v" => "2", "type" => "skmsg"}, body_envelope)
    participants_node = Node.new("participants", %{}, participant_nodes)

    Node.new("message", attrs, [participants_node, skmsg_node])
  end

  # --- Participants ----------------------------------------------------------

  defp fetch_participants(opts) do
    case Keyword.get(opts, :participants) do
      [] -> {:error, :no_participants}
      nil -> {:error, :no_participants}
      list when is_list(list) -> {:ok, list}
    end
  end

  defp resolve_devices(server, participants, %Device{} = device, opts) do
    timeout = Keyword.get(opts, :device_timeout, 30_000)

    case User.get_user_devices(server, participants, timeout: timeout) do
      {:ok, devices} ->
        filtered = strip_own_and_hosted(devices, device.jid)

        case filtered do
          [] -> {:error, :no_devices_resolved}
          _ -> {:ok, filtered}
        end

      {:error, _} = err ->
        err
    end
  end

  defp strip_own_and_hosted(devices, %JID{} = own_jid) do
    own_user = own_jid.user
    own_device = own_jid.device

    Enum.reject(devices, fn ad ->
      hosted_server?(ad.server) or (ad.user == own_user and ad.device == own_device)
    end)
  end

  defp hosted_server?(server),
    do: server == JID.hosted_server() or server == JID.hosted_lid_server()

  # --- Hashing ---------------------------------------------------------------

  @doc """
  WhatsApp's `phash` over a participant device list.

  `participant_list_hash_v2([ad_jid, ...]) -> "2:" <> base64-no-pad(SHA256(joined_ad_jids))[:8]`

  Devices are sorted lexicographically by their canonical wire string,
  joined with no separator, SHA-256'd, first 6 bytes Base64-URL-no-pad-encoded.

  Mirrors Go's `participantListHashV2` (`send.go:676`).
  """
  @spec participant_list_hash_v2([JID.t()]) :: String.t()
  def participant_list_hash_v2(devices) when is_list(devices) do
    sorted =
      devices
      |> Enum.map(&JID.to_string/1)
      |> Enum.sort()
      |> Enum.join("")

    digest = :crypto.hash(:sha256, sorted)
    "2:" <> Base.encode64(binary_part(digest, 0, 6), padding: false)
  end

  # --- Persistence -----------------------------------------------------------

  defp load_or_new_group_session(our_jid, group_id_str, sender_id, sender_key_id) do
    case Whatsmeow.Signal.Store.Adapter.load_sender_key(our_jid, group_id_str, sender_id) do
      {:ok, %GroupSession{signing_priv: priv} = gs}
      when is_binary(priv) and byte_size(priv) == 32 ->
        {:ok, gs}

      # No stored key, or one from before signing keys were persisted — start a
      # fresh chain rather than sending with a key we can't sign for.
      _ ->
        {:ok, GroupSession.new(sender_key_id)}
    end
  end

  defp persist_group_session(our_jid, group_id_str, sender_id, %GroupSession{} = gs),
    do: Whatsmeow.Signal.Store.Adapter.save_sender_key(our_jid, group_id_str, sender_id, gs)

  # --- Helpers ---------------------------------------------------------------

  defp to_group_jid(%JID{server: "g.us"} = jid), do: {:ok, jid}
  defp to_group_jid(%JID{}), do: {:error, :invalid_group_jid}

  defp to_group_jid(bin) when is_binary(bin) do
    case JID.parse(bin) do
      {:ok, %JID{server: "g.us"} = jid} -> {:ok, jid}
      {:ok, %JID{}} -> {:error, :invalid_group_jid}
      _ -> {:error, :invalid_group_jid}
    end
  end

  defp to_group_jid(_), do: {:error, :invalid_group_jid}
end
