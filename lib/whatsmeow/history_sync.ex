defmodule Whatsmeow.HistorySync do
  @moduledoc """
  Download, inflate, and decode the history-sync blob the primary phone pushes
  after linking.

  Ports Go's `DownloadHistorySync` (`whatsmeow-main/message.go:740`) plus the
  storage side-effects it fans out to.

  ## Why it matters

  On first link — and incrementally afterwards — your phone uploads your existing
  chats as an encrypted, zlib-deflated blob and points at it with a
  `HistorySyncNotification` inside a `protocolMessage`. Until a client downloads
  and acknowledges that blob:

    * the chat list is empty, because the live receive path only ever sees
      messages sent *after* linking;
    * messages you send from your phone while this device is offline are
      unrecoverable — WhatsApp does not redeliver them on reconnect;
    * the phone keeps the linked device in a "Paused" state.

  ## Flow

      <protocolMessage><historySyncNotification>
        → download (media crypto, "WhatsApp History Keys")
        → zlib inflate
        → WAWebProtobufsHistorySync.HistorySync
        → %Whatsmeow.Types.Events.HistorySync{}

  A notification may instead carry `initialHistBootstrapInlinePayload`, in which
  case the payload is already in hand and only needs inflating — no download.

  ## Side effects

  Decoding also yields state worth keeping, which `store_side_effects/2` writes:
  per-message secrets (needed to decrypt reactions/polls/edits on historical
  messages), phone-number ↔ LID mappings, push names, and the NCT salt. These are
  best-effort; a failure to store one never fails the sync.
  """

  require Logger

  alias Whatsmeow.Media
  alias Whatsmeow.Types.JID

  @type sync :: WAWebProtobufsHistorySync.HistorySync.t()

  @doc """
  Fetch and decode the blob a `%HistorySyncNotification{}` points at.

  ## Options

    * `:media_conn` — a `%Whatsmeow.Media.Conn{}`. Required for a real download
      unless `server` is given, in which case one is fetched.
    * `:server` — a `Whatsmeow.Session` pid or device id, used to pull a fresh
      media conn when `:media_conn` isn't supplied.
    * `:max_bytes` — download ceiling. History blobs are large; defaults to
      256 MiB rather than the media default of 100 MiB.
  """
  @spec download(WAWebProtobufsE2E.HistorySyncNotification.t(), keyword()) ::
          {:ok, sync()} | {:error, term()}
  def download(%WAWebProtobufsE2E.HistorySyncNotification{} = notif, opts \\ []) do
    with {:ok, compressed} <- fetch_blob(notif, opts),
         {:ok, raw} <- inflate(compressed) do
      decode(raw)
    end
  end

  @doc """
  Inflate + decode an already-downloaded blob. Split out so the transport and the
  parsing can be tested independently.
  """
  @spec decode_blob(binary()) :: {:ok, sync()} | {:error, term()}
  def decode_blob(compressed) when is_binary(compressed) do
    with {:ok, raw} <- inflate(compressed) do
      decode(raw)
    end
  end

  @doc """
  Build the media descriptor `Whatsmeow.Media.Download` consumes from a history
  sync notification.
  """
  @spec descriptor(WAWebProtobufsE2E.HistorySyncNotification.t()) :: map()
  def descriptor(%WAWebProtobufsE2E.HistorySyncNotification{} = n) do
    %{
      kind: :history,
      direct_path: n.directPath,
      media_key: n.mediaKey,
      file_sha256: n.fileSHA256,
      file_enc_sha256: n.fileEncSHA256,
      file_length: n.fileLength
    }
  end

  # --- Storage side effects --------------------------------------------------

  @doc """
  Persist the durable state carried alongside the conversations.

  Best-effort by design: this runs after the event has been broadcast, and a
  failed write must not cost the consumer their history.

  Writes, in order of how much they matter:

    * **message secrets** — without these, every reaction, poll vote, and edit on
      a historical message is undecryptable;
    * **trusted-contact tokens** — pre-seeds `Whatsmeow.PrivacyToken` so the first
      send to an existing contact isn't rejected with a 463;
    * **LID ↔ PN mappings** — the bulk seed for `Whatsmeow.LIDMap`.
  """
  @spec store_side_effects(String.t(), sync()) :: :ok
  def store_side_effects(our_jid, %WAWebProtobufsHistorySync.HistorySync{} = sync)
      when is_binary(our_jid) do
    conversations = sync.conversations || []

    _ = store_lid_mappings(sync.phoneNumberToLidMappings || [])
    _ = store_message_secrets(our_jid, conversations)
    _ = store_tc_tokens(our_jid, conversations)
    :ok
  end

  # The phone knows which LIDs belong to which phone numbers; the live path only
  # learns a pairing when a `<notification type="devices">` happens to mention it.
  # Seeding from history is what stops historical LID-only chats arriving as
  # anonymous strangers.
  defp store_lid_mappings(mappings) do
    pairs =
      for %{pnJID: pn, lidJID: lid} <- mappings,
          is_binary(pn) and is_binary(lid),
          do: {lid, pn}

    count = Whatsmeow.LIDMap.put_all(pairs)
    if count > 0, do: Logger.debug("[whatsmeow] history sync: stored #{count} LID mappings")
    :ok
  rescue
    _ -> :ok
  end

  # Reactions, poll votes, and edits on a historical message can only be
  # decrypted with that message's secret, and this blob is the only place those
  # secrets ever appear for messages that predate this device.
  defp store_message_secrets(our_jid, conversations) do
    entries =
      for conv <- conversations,
          chat = conv."ID",
          is_binary(chat) and chat != "",
          %{message: %WAWebProtobufsWeb.WebMessageInfo{} = wmi} <- conv.messages || [],
          secret = wmi.messageSecret,
          is_binary(secret) and byte_size(secret) > 0,
          id = message_id(wmi),
          is_binary(id) and id != "" do
        {chat, secret_sender(wmi, chat, our_jid), id, secret}
      end

    count = Whatsmeow.MsgSecret.Store.put_all(our_jid, entries)
    if count > 0, do: Logger.debug("[whatsmeow] history sync: stored #{count} message secrets")
    :ok
  rescue
    _ -> :ok
  end

  defp message_id(%WAWebProtobufsWeb.WebMessageInfo{key: %WACommon.MessageKey{ID: id}}), do: id
  defp message_id(_), do: nil

  # Mirrors Go's `storeHistoricalMessageSecrets` sender resolution: our own
  # messages are keyed to us, 1:1 messages to the chat itself, and group messages
  # to whichever participant field is populated.
  defp secret_sender(%WAWebProtobufsWeb.WebMessageInfo{key: key} = wmi, chat, our_jid) do
    cond do
      match?(%WACommon.MessageKey{fromMe: true}, key) -> our_jid
      one_to_one?(chat) -> chat
      is_binary(key.participant) and key.participant != "" -> key.participant
      is_binary(wmi.participant) and wmi.participant != "" -> wmi.participant
      true -> chat
    end
  end

  defp one_to_one?(chat) when is_binary(chat) do
    case JID.parse(chat) do
      {:ok, %JID{server: server}} -> server == JID.default_user_server()
      _ -> false
    end
  end

  defp one_to_one?(_), do: false

  # Each 1:1 conversation carries the trusted-contact token the server issued for
  # that contact. Seeding them here means the first send to an existing contact
  # after a re-link already has a token to attach, instead of eating a silent 463
  # while it waits for one to be issued.
  defp store_tc_tokens(our_jid, conversations) do
    count =
      Enum.count(conversations, fn conv ->
        with chat when is_binary(chat) <- conv."ID",
             token when is_binary(token) and byte_size(token) > 0 <- conv.tcToken,
             true <- one_to_one?(chat) do
          :ok ==
            Whatsmeow.PrivacyToken.put(
              our_jid,
              chat,
              token,
              conv.tcTokenTimestamp || System.system_time(:second),
              conv.tcTokenSenderTimestamp
            )
        else
          _ -> false
        end
      end)

    if count > 0, do: Logger.debug("[whatsmeow] history sync: stored #{count} privacy tokens")
    :ok
  rescue
    _ -> :ok
  end

  # --- Internals -------------------------------------------------------------

  # An inline bootstrap payload is handed to us directly — it is not on the CDN
  # and carries no media key. Everything else is a normal encrypted media fetch.
  defp fetch_blob(
         %WAWebProtobufsE2E.HistorySyncNotification{initialHistBootstrapInlinePayload: inline},
         _opts
       )
       when is_binary(inline) and byte_size(inline) > 0 do
    {:ok, inline}
  end

  defp fetch_blob(%WAWebProtobufsE2E.HistorySyncNotification{} = notif, opts) do
    with {:ok, conn} <- media_conn(opts) do
      Media.Download.fetch_and_decrypt(descriptor(notif),
        media_conn: conn,
        max_bytes: Keyword.get(opts, :max_bytes, 256 * 1024 * 1024)
      )
    end
  end

  defp media_conn(opts) do
    case Keyword.get(opts, :media_conn) do
      %Media.Conn{} = conn ->
        {:ok, conn}

      _ ->
        case Keyword.get(opts, :server) do
          nil -> {:error, :media_conn_required}
          server -> Media.Refresh.refresh(server)
        end
    end
  end

  # zlib (RFC 1950) framing, matching Go's `zlib.NewReader`. `:zlib.uncompress/1`
  # raises on malformed input rather than returning an error tuple.
  defp inflate(compressed) do
    {:ok, :zlib.uncompress(compressed)}
  rescue
    e -> {:error, {:inflate, Exception.message(e)}}
  end

  defp decode(raw) do
    {:ok, WAWebProtobufsHistorySync.HistorySync.decode(raw)}
  rescue
    e -> {:error, {:proto_decode, Exception.message(e)}}
  end
end
