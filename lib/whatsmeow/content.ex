defmodule Whatsmeow.Content do
  @moduledoc """
  Builders for the message payloads that aren't plain text or uploaded media.

  Every function here returns a `%WAWebProtobufsE2E.Message{}` ready for
  `Whatsmeow.Send.send_message/4`:

      Whatsmeow.Content.location(30.0444, 31.2357, name: "Cairo")
      |> then(&Whatsmeow.Send.send_message(session, peer, &1))

  Splitting building from sending is deliberate. A payload can be composed,
  wrapped (`view_once/1`, `reply/3`), inspected, and tested without a connection
  — and one generic sender then covers every content type instead of a
  `send_*` function per kind.

  ## Composition

  `reply/3`, `mention/2`, and `view_once/1` take a message and return a modified
  one, so they chain:

      Content.text("look at this")
      |> Content.reply(quoted_key, quoted_message)
      |> Content.mention(["15551234567@s.whatsapp.net"])
      |> Content.view_once()

  ## What isn't here

  Media (`image`, `video`, `audio`, `document`, `sticker`) needs an upload before
  a payload can be built, so it lives in `Whatsmeow.Send` alongside the upload
  step. Reactions, edits, revokes, and poll creation live in `Whatsmeow.Send` as
  `build_*` for the same historical reason and work identically.
  """

  alias Whatsmeow.Types.JID

  @type message :: WAWebProtobufsE2E.Message.t()
  @type jid :: JID.t() | String.t()

  # --- Text ------------------------------------------------------------------

  @doc """
  Plain text.

  Returns the compact `conversation` form. `reply/3` and `mention/2` promote it
  to `extendedTextMessage` when they need somewhere to put context — WhatsApp
  has no way to attach context to a bare `conversation`.
  """
  @spec text(String.t()) :: message()
  def text(body) when is_binary(body) do
    %WAWebProtobufsE2E.Message{conversation: body}
  end

  @doc """
  Text with a link preview card.

  `url` must appear in `body` — WhatsApp renders the preview attached to the
  matched text, and a `matchedText` that isn't in the body renders nothing.

  ## Options

    * `:title` — the preview headline (this is also what makes the server treat
      the message as media; without it the preview is not rendered)
    * `:description` — the preview subtitle
    * `:thumbnail` — raw JPEG bytes
  """
  @spec link_preview(String.t(), String.t(), keyword()) :: message()
  def link_preview(body, url, opts \\ []) when is_binary(body) and is_binary(url) do
    %WAWebProtobufsE2E.Message{
      extendedTextMessage: %WAWebProtobufsE2E.ExtendedTextMessage{
        text: body,
        matchedText: url,
        title: Keyword.get(opts, :title),
        description: Keyword.get(opts, :description),
        JPEGThumbnail: Keyword.get(opts, :thumbnail)
      }
    }
  end

  # --- Location --------------------------------------------------------------

  @doc """
  A pinned location.

  ## Options

    * `:name` — place name shown on the card
    * `:address` — street address under the name
    * `:url` — a link opened when the card is tapped
    * `:accuracy` — accuracy radius in metres
    * `:thumbnail` — raw JPEG map preview
  """
  @spec location(float() | integer(), float() | integer(), keyword()) :: message()
  def location(latitude, longitude, opts \\ [])
      when is_number(latitude) and is_number(longitude) do
    %WAWebProtobufsE2E.Message{
      locationMessage: %WAWebProtobufsE2E.LocationMessage{
        degreesLatitude: latitude / 1,
        degreesLongitude: longitude / 1,
        name: Keyword.get(opts, :name),
        address: Keyword.get(opts, :address),
        URL: Keyword.get(opts, :url),
        accuracyInMeters: Keyword.get(opts, :accuracy),
        JPEGThumbnail: Keyword.get(opts, :thumbnail)
      }
    }
  end

  @doc """
  A live location that keeps updating for `duration_seconds`.

  The recipient sees a moving pin. Sending this once starts the share; the
  updates themselves are separate messages the caller is responsible for sending,
  each with an incremented `:sequence_number`.
  """
  @spec live_location(float() | integer(), float() | integer(), non_neg_integer(), keyword()) ::
          message()
  def live_location(latitude, longitude, duration_seconds, opts \\ [])
      when is_number(latitude) and is_number(longitude) and is_integer(duration_seconds) do
    %WAWebProtobufsE2E.Message{
      liveLocationMessage: %WAWebProtobufsE2E.LiveLocationMessage{
        degreesLatitude: latitude / 1,
        degreesLongitude: longitude / 1,
        accuracyInMeters: Keyword.get(opts, :accuracy),
        speedInMps: Keyword.get(opts, :speed),
        caption: Keyword.get(opts, :caption),
        sequenceNumber: Keyword.get(opts, :sequence_number, 0),
        timeOffset: duration_seconds,
        JPEGThumbnail: Keyword.get(opts, :thumbnail)
      }
    }
  end

  # --- Contacts --------------------------------------------------------------

  @doc """
  Share one contact card.

  `vcard` must be a vCard 3.0 string. `vcard/2` builds a minimal valid one from a
  name and phone number if you don't have one already.
  """
  @spec contact(String.t(), String.t()) :: message()
  def contact(display_name, vcard) when is_binary(display_name) and is_binary(vcard) do
    %WAWebProtobufsE2E.Message{
      contactMessage: %WAWebProtobufsE2E.ContactMessage{
        displayName: display_name,
        vcard: vcard
      }
    }
  end

  @doc """
  Share several contacts as one card stack.

  `contacts` is a list of `{display_name, vcard}` pairs.
  """
  @spec contacts(String.t(), [{String.t(), String.t()}]) :: message()
  def contacts(display_name, contacts) when is_binary(display_name) and is_list(contacts) do
    %WAWebProtobufsE2E.Message{
      contactsArrayMessage: %WAWebProtobufsE2E.ContactsArrayMessage{
        displayName: display_name,
        contacts:
          Enum.map(contacts, fn {name, card} ->
            %WAWebProtobufsE2E.ContactMessage{displayName: name, vcard: card}
          end)
      }
    }
  end

  @doc """
  Build a minimal vCard 3.0 for `name` at `phone`.

  `phone` should be E.164 digits. The `waid` parameter is what makes WhatsApp
  render the card as a *tappable* contact rather than inert text — without it the
  recipient can read the number but not start a chat from it.
  """
  @spec vcard(String.t(), String.t()) :: String.t()
  def vcard(name, phone) when is_binary(name) and is_binary(phone) do
    digits = String.replace(phone, ~r/[^\d]/, "")

    """
    BEGIN:VCARD\r
    VERSION:3.0\r
    N:;#{name};;;\r
    FN:#{name}\r
    TEL;type=CELL;type=VOICE;waid=#{digits}:+#{digits}\r
    END:VCARD\r
    """
  end

  # --- Group invite ----------------------------------------------------------

  @doc """
  A group invite rendered as a joinable card in the chat.

  `code` and `expiration` come from `Whatsmeow.Group.get_invite_link/2`. Sending
  the raw `chat.whatsapp.com` URL as text works too, but the recipient gets a
  plain link instead of a card with the group name and a Join button.
  """
  @spec group_invite(jid(), String.t(), integer(), String.t(), keyword()) :: message()
  def group_invite(group_jid, code, expiration, group_name, opts \\ [])
      when is_binary(code) and is_integer(expiration) and is_binary(group_name) do
    %WAWebProtobufsE2E.Message{
      groupInviteMessage: %WAWebProtobufsE2E.GroupInviteMessage{
        groupJID: to_jid_string(group_jid),
        inviteCode: code,
        inviteExpiration: expiration,
        groupName: group_name,
        caption: Keyword.get(opts, :caption),
        JPEGThumbnail: Keyword.get(opts, :thumbnail)
      }
    }
  end

  # --- Pin / keep ------------------------------------------------------------

  @doc """
  Pin a message to the top of the chat for everyone.

  `seconds` is how long the pin lasts. WhatsApp accepts 86400 (24h), 604800 (7d),
  and 2592000 (30d); other values are rejected server-side.
  """
  @spec pin(jid(), jid() | nil, String.t(), non_neg_integer()) :: message()
  def pin(chat, sender, message_id, seconds \\ 604_800) when is_binary(message_id) do
    pin_message(chat, sender, message_id, :PIN_FOR_ALL, seconds)
  end

  @doc "Remove a pin set by `pin/4`."
  @spec unpin(jid(), jid() | nil, String.t()) :: message()
  def unpin(chat, sender, message_id) when is_binary(message_id) do
    pin_message(chat, sender, message_id, :UNPIN_FOR_ALL, 0)
  end

  defp pin_message(chat, sender, message_id, type, seconds) do
    %WAWebProtobufsE2E.Message{
      pinInChatMessage: %WAWebProtobufsE2E.PinInChatMessage{
        key: Whatsmeow.Send.build_message_key(chat, sender, message_id),
        type: type,
        senderTimestampMS: System.system_time(:millisecond)
      },
      messageContextInfo: %WAWebProtobufsE2E.MessageContextInfo{
        messageAddOnDurationInSecs: seconds
      }
    }
  end

  @doc """
  Keep a message that would otherwise disappear.

  Only meaningful in a chat with disappearing messages on — it exempts this one
  message from the timer.
  """
  @spec keep(jid(), jid() | nil, String.t()) :: message()
  def keep(chat, sender, message_id) when is_binary(message_id) do
    keep_message(chat, sender, message_id, :KEEP_FOR_ALL)
  end

  @doc "Undo a `keep/3`, letting the message disappear on schedule again."
  @spec unkeep(jid(), jid() | nil, String.t()) :: message()
  def unkeep(chat, sender, message_id) when is_binary(message_id) do
    keep_message(chat, sender, message_id, :UNDO_KEEP_FOR_ALL)
  end

  defp keep_message(chat, sender, message_id, keep_type) do
    %WAWebProtobufsE2E.Message{
      keepInChatMessage: %WAWebProtobufsE2E.KeepInChatMessage{
        key: Whatsmeow.Send.build_message_key(chat, sender, message_id),
        keepType: keep_type,
        timestampMS: System.system_time(:millisecond)
      }
    }
  end

  # --- Events ----------------------------------------------------------------

  @doc """
  A calendar event card.

  ## Options

    * `:description` — body text under the title
    * `:end_time` — Unix seconds; omit for an open-ended event
    * `:location` — a `location/3` message, whose `locationMessage` is embedded
    * `:join_link` — a call or meeting URL
    * `:extra_guests_allowed` — whether invitees may bring others
  """
  @spec event(String.t(), integer(), keyword()) :: message()
  def event(name, start_time, opts \\ []) when is_binary(name) and is_integer(start_time) do
    location =
      case Keyword.get(opts, :location) do
        %WAWebProtobufsE2E.Message{locationMessage: %{} = loc} -> loc
        %WAWebProtobufsE2E.LocationMessage{} = loc -> loc
        _ -> nil
      end

    %WAWebProtobufsE2E.Message{
      eventMessage: %WAWebProtobufsE2E.EventMessage{
        name: name,
        description: Keyword.get(opts, :description),
        startTime: start_time,
        endTime: Keyword.get(opts, :end_time),
        location: location,
        joinLink: Keyword.get(opts, :join_link),
        extraGuestsAllowed: Keyword.get(opts, :extra_guests_allowed),
        isCanceled: Keyword.get(opts, :canceled, false)
      },
      messageContextInfo: %WAWebProtobufsE2E.MessageContextInfo{
        messageSecret: :crypto.strong_rand_bytes(32)
      }
    }
  end

  # --- Albums ----------------------------------------------------------------

  @doc """
  Open an album — the header message that groups the images and videos that
  follow into a single gallery card.

  An album is not one message. It is a parent `albumMessage` announcing how many
  items to expect, followed by that many ordinary media messages, each tagged
  with `album_item/3` pointing back at the parent. The recipient's client only
  renders the gallery once it has the parent *and* the expected counts match — so
  the counts have to be right before the first item is sent.

      {:ok, album_id} = Whatsmeow.send_message(session, peer, Content.album(3, 0))

      for {bytes, i} <- Enum.with_index(images) do
        Whatsmeow.send_image(session, peer, bytes,
          media_conn: conn,
          decorate: &Content.album_item(&1, album_id, peer, i))
      end

  The `:decorate` hook is what makes this possible: a media payload only exists
  after its upload, so the album tag has to be applied there rather than composed
  beforehand.
  """
  @spec album(non_neg_integer(), non_neg_integer()) :: message()
  def album(image_count, video_count)
      when is_integer(image_count) and is_integer(video_count) do
    %WAWebProtobufsE2E.Message{
      albumMessage: %WAWebProtobufsE2E.AlbumMessage{
        expectedImageCount: image_count,
        expectedVideoCount: video_count
      }
    }
  end

  @doc """
  Tag `message` as item `index` of the album opened by `album_message_id`.

  `index` is zero-based and must be contiguous — a gap leaves the gallery
  permanently waiting for the missing item.
  """
  @spec album_item(message(), String.t(), jid(), non_neg_integer()) :: message()
  def album_item(%WAWebProtobufsE2E.Message{} = message, album_message_id, chat, index)
      when is_binary(album_message_id) and is_integer(index) do
    association = %WAWebProtobufsE2E.MessageAssociation{
      associationType: :MEDIA_ALBUM,
      parentMessageKey: Whatsmeow.Send.build_message_key(chat, nil, album_message_id),
      messageIndex: index
    }

    context =
      case message.messageContextInfo do
        %WAWebProtobufsE2E.MessageContextInfo{} = existing ->
          %{existing | messageAssociation: association}

        _ ->
          %WAWebProtobufsE2E.MessageContextInfo{messageAssociation: association}
      end

    %{message | messageContextInfo: context}
  end

  # --- Polls -----------------------------------------------------------------

  @doc """
  Cast a vote in an existing poll.

  Votes are **encrypted to the poll**, not sent in the clear: the selected
  options are hashed, then sealed under a key derived from the *original poll
  message's* secret. That secret came with the poll and lives in
  `Whatsmeow.MsgSecret.Store` — so you can only vote in a poll this device
  actually received (or one recovered through history sync).

  `poll` identifies the poll message: `%{chat:, sender:, id:}`. `option_names`
  must match the poll's option strings exactly — they are matched by hash, so a
  typo silently counts as no vote rather than an error.

  Returns `{:error, :no_message_secret}` when the poll's secret was never stored,
  which is the honest answer: without it no valid vote can be produced.

  Ports Go's `BuildPollVote` / `EncryptPollVote` (`msgsecret.go`).
  """
  @spec poll_vote(String.t(), %{chat: jid(), sender: jid(), id: String.t()}, [String.t()]) ::
          {:ok, message()} | {:error, term()}
  def poll_vote(our_jid, %{chat: chat, sender: sender, id: poll_id}, option_names)
      when is_binary(our_jid) and is_binary(poll_id) and is_list(option_names) do
    chat_s = to_jid_string(chat)
    sender_s = to_jid_string(sender) || chat_s

    case Whatsmeow.MsgSecret.Store.get(our_jid, chat_s, sender_s, poll_id) do
      {:ok, secret} ->
        plaintext =
          %WAWebProtobufsE2E.PollVoteMessage{
            selectedOptions: Whatsmeow.MsgSecret.hash_poll_options(option_names)
          }
          |> WAWebProtobufsE2E.PollVoteMessage.encode()
          |> IO.iodata_to_binary()

        {ciphertext, iv} =
          Whatsmeow.MsgSecret.encrypt(
            :poll_vote,
            our_jid,
            poll_id,
            sender_s,
            secret,
            plaintext
          )

        {:ok,
         %WAWebProtobufsE2E.Message{
           pollUpdateMessage: %WAWebProtobufsE2E.PollUpdateMessage{
             pollCreationMessageKey: Whatsmeow.Send.build_message_key(chat, sender, poll_id),
             vote: %WAWebProtobufsE2E.PollEncValue{encPayload: ciphertext, encIV: iv},
             senderTimestampMS: System.system_time(:millisecond)
           }
         }}

      :not_found ->
        {:error, :no_message_secret}
    end
  end

  # --- Wrappers / composition ------------------------------------------------

  @doc """
  Mark `message` as a reply to a previous one.

  `quoted` is the message being replied to (a `%WAWebProtobufsE2E.Message{}`), so
  the recipient's client can render the quoted preview without looking it up.
  Pass `nil` when you don't have the original — the reply still threads, but
  renders without a preview.
  """
  @spec reply(message(), map(), message() | nil) :: message()
  def reply(%WAWebProtobufsE2E.Message{} = message, %{} = quoted_key, quoted \\ nil) do
    context = %WAWebProtobufsE2E.ContextInfo{
      stanzaID: Map.get(quoted_key, :ID) || Map.get(quoted_key, :id),
      participant: to_jid_string(Map.get(quoted_key, :participant)),
      remoteJID: to_jid_string(Map.get(quoted_key, :remoteJID) || Map.get(quoted_key, :chat)),
      quotedMessage: quoted
    }

    put_context(message, context)
  end

  @doc """
  Attach @-mentions.

  The mentioned JIDs must also appear as `@<number>` in the body text — WhatsApp
  highlights by matching the two up, so a mention list without matching text
  notifies nobody.
  """
  @spec mention(message(), [jid()]) :: message()
  def mention(%WAWebProtobufsE2E.Message{} = message, jids) when is_list(jids) do
    context = %WAWebProtobufsE2E.ContextInfo{
      mentionedJID: Enum.map(jids, &to_jid_string/1)
    }

    put_context(message, context)
  end

  @doc """
  Wrap `message` so it can only be opened once.

  Applies to media; WhatsApp ignores view-once on plain text. Uses the V2
  wrapper, which is what current clients emit — V1 still decodes but renders
  without the view-once treatment on some clients.
  """
  @spec view_once(message()) :: message()
  def view_once(%WAWebProtobufsE2E.Message{} = message) do
    %WAWebProtobufsE2E.Message{
      viewOnceMessageV2: %WAWebProtobufsE2E.FutureProofMessage{message: message}
    }
  end

  @doc """
  Mark `message` as forwarded.

  `score` is WhatsApp's forward counter: at 1 the client shows "Forwarded", and
  above 4 it shows "Forwarded many times" and restricts further forwarding.
  """
  @spec forwarded(message(), non_neg_integer()) :: message()
  def forwarded(%WAWebProtobufsE2E.Message{} = message, score \\ 1) do
    put_context(message, %WAWebProtobufsE2E.ContextInfo{
      isForwarded: true,
      forwardingScore: score
    })
  end

  # --- Helpers ---------------------------------------------------------------

  # Context lives on the individual content message, and a bare `conversation`
  # has nowhere to put it — so setting context promotes plain text to
  # extendedTextMessage. Merging (rather than replacing) is what lets reply/3 and
  # mention/2 be chained in either order.
  defp put_context(%WAWebProtobufsE2E.Message{conversation: body} = msg, context)
       when is_binary(body) do
    put_context(
      %WAWebProtobufsE2E.Message{
        msg
        | conversation: nil,
          extendedTextMessage: %WAWebProtobufsE2E.ExtendedTextMessage{text: body}
      },
      context
    )
  end

  defp put_context(%WAWebProtobufsE2E.Message{} = msg, context) do
    case content_field(msg) do
      nil -> msg
      field -> Map.put(msg, field, merge_context(Map.get(msg, field), context))
    end
  end

  defp merge_context(content, context) do
    existing = Map.get(content, :contextInfo) || %WAWebProtobufsE2E.ContextInfo{}

    merged =
      context
      |> Map.from_struct()
      |> Enum.reduce(existing, fn
        {_k, nil}, acc -> acc
        {_k, []}, acc -> acc
        {_k, false}, acc -> acc
        {k, v}, acc -> Map.put(acc, k, v)
      end)

    Map.put(content, :contextInfo, merged)
  end

  @content_fields [
    :extendedTextMessage,
    :imageMessage,
    :videoMessage,
    :audioMessage,
    :documentMessage,
    :stickerMessage,
    :locationMessage,
    :liveLocationMessage,
    :contactMessage,
    :contactsArrayMessage,
    :groupInviteMessage,
    :eventMessage,
    :pollCreationMessage
  ]

  defp content_field(%WAWebProtobufsE2E.Message{} = msg) do
    Enum.find(@content_fields, &(not is_nil(Map.get(msg, &1))))
  end

  defp to_jid_string(nil), do: nil
  defp to_jid_string(%JID{} = j), do: JID.to_string(j)
  defp to_jid_string(s) when is_binary(s), do: s
  defp to_jid_string(_), do: nil
end
