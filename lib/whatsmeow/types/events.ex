defmodule Whatsmeow.Types.Events do
  @moduledoc """
  Event structs published to `Whatsmeow.PubSub` for each session.

  Subscribers receive `{:whatsmeow, event_struct}` messages. Each event is a
  defined struct so consumers can pattern-match by kind:

      receive do
        {:whatsmeow, %Whatsmeow.Types.Events.Message{} = msg} -> ...
        {:whatsmeow, %Whatsmeow.Types.Events.QR{code: code}} -> ...
        {:whatsmeow, %Whatsmeow.Types.Events.Connected{}}    -> ...
      end

  Phases 8-13 fill out the catalogue. This module declares the structs we
  need across the library; emission happens in `Whatsmeow.Session` and the
  helpers it calls.
  """

  alias Whatsmeow.Types.{Call, Group, JID, Message, Presence, User}

  defmodule Connected do
    @moduledoc "Successful Noise handshake + post-auth bind."
    defstruct [:device_id]
    @type t :: %__MODULE__{device_id: String.t()}
  end

  defmodule OfflineSyncPreview do
    @moduledoc """
    The server's own statement of what it queued while we were away.

    Sent in an `<ib><offline_preview …/></ib>` shortly after login, and it is
    the only place WhatsApp says how much it is about to deliver. A host that
    receives seven messages' worth of preview and then writes no rows knows
    the loss is on its side of the socket; one that is told zero knows the
    server had nothing for it.

    Without this the two are indistinguishable, and they have opposite fixes.
    """
    defstruct [:device_id, :total, :app_data_changes, :messages, :notifications, :receipts]

    @type t :: %__MODULE__{
            device_id: String.t(),
            total: non_neg_integer(),
            app_data_changes: non_neg_integer(),
            messages: non_neg_integer(),
            notifications: non_neg_integer(),
            receipts: non_neg_integer()
          }
  end

  defmodule OfflineSyncCompleted do
    @moduledoc "`<ib><offline count=N/></ib>` — the queue has been drained."
    defstruct [:device_id, :count]
    @type t :: %__MODULE__{device_id: String.t(), count: non_neg_integer()}
  end

  defmodule LoggedIn do
    @moduledoc """
    Authenticated post-handshake login — server replied `<success>` to our
    `login_payload`. Carries the LID the server returned (or `nil` if it
    matched what we already stored) and the signed server-time offset in
    seconds.
    """
    defstruct [:device_id, :lid, :server_time_offset]

    @type t :: %__MODULE__{
            device_id: String.t(),
            lid: String.t() | nil,
            server_time_offset: integer() | nil
          }
  end

  defmodule Disconnected do
    @moduledoc "TCP/WebSocket lost (will auto-reconnect)."
    defstruct [:device_id, :reason]
    @type t :: %__MODULE__{device_id: String.t(), reason: term()}
  end

  defmodule LoggedOut do
    @moduledoc "Account was unlinked on the WhatsApp side; session is done."
    defstruct [:device_id, :on_connect, :reason]
    @type t :: %__MODULE__{device_id: String.t(), on_connect: boolean(), reason: atom()}
  end

  defmodule QR do
    @moduledoc "QR code refresh for pairing. `code` is the raw QR payload."
    defstruct [:device_id, :code, :expires_at]
    @type t :: %__MODULE__{device_id: String.t(), code: String.t(), expires_at: DateTime.t()}
  end

  defmodule PairSuccess do
    @moduledoc "Pairing handshake completed; device JID assigned."
    defstruct [:device_id, :jid, :business_name, :platform]

    @type t :: %__MODULE__{
            device_id: String.t(),
            jid: JID.t(),
            business_name: String.t() | nil,
            platform: String.t() | nil
          }
  end

  defmodule PairError do
    @moduledoc "Pairing failed."
    defstruct [:device_id, :reason]
    @type t :: %__MODULE__{device_id: String.t(), reason: atom()}
  end

  defmodule Message do
    @moduledoc "A decrypted message arrived."
    defstruct [:device_id, :message, :info]

    @type t :: %__MODULE__{
            device_id: String.t(),
            message: Whatsmeow.Types.Message.t(),
            info: map()
          }
  end

  defmodule UndecryptableMessage do
    @moduledoc """
    A `<message>` stanza arrived but we couldn't decrypt the inner `<enc>`
    body. Reasons today are `:no_signal_wire_proto` — the Signal wire
    proto / X3DH-from-bundle path isn't wired yet, so we surface the
    encrypted bytes for upstream handling and so live testing can
    confirm the inbound dispatch path itself works end-to-end.

    Mirrors Go's `events.UndecryptableMessage` (`whatsmeow-main/events`).
    """
    defstruct [:device_id, :info, :reason, :enc_type, :enc_version, :enc_payload]

    @type t :: %__MODULE__{
            device_id: String.t(),
            info: Whatsmeow.MessageInfo.t(),
            reason: atom(),
            enc_type: String.t() | nil,
            enc_version: String.t() | nil,
            enc_payload: binary() | nil
          }
  end

  defmodule MediaMessage do
    @moduledoc """
    A decrypted message arrived carrying a downloadable attachment.

    One `%MediaMessage{}` is broadcast per attachment, in addition to
    the top-level `%Message{}`. Consumers can subscribe to media
    exclusively without inspecting every text body.

    `descriptor` is the same shape `Whatsmeow.Media.Download.fetch_and_decrypt/2`
    consumes — pass it through to fetch + decrypt the file.
    """
    defstruct [:device_id, :info, :message, :descriptor, :kind]

    @type t :: %__MODULE__{
            device_id: String.t(),
            info: Whatsmeow.MessageInfo.t(),
            message: Whatsmeow.Types.Message.t(),
            descriptor: Whatsmeow.Signal.MessageBuilder.media_descriptor(),
            kind: Whatsmeow.Signal.MessageBuilder.media_kind()
          }
  end

  defmodule Receipt do
    @moduledoc "Delivery / read receipt for an outbound message."
    defstruct [:device_id, :type, :message_ids, :from, :participant, :timestamp]

    @type kind :: :delivery | :read | :played | :server_error | :inactive | :sender
    @type t :: %__MODULE__{
            device_id: String.t(),
            type: kind,
            message_ids: [String.t()],
            from: JID.t(),
            # Group receipts address the group in `from` and the individual
            # sender in `participant`. A retry receipt has to be answered to
            # the device that asked, so the sender is the one that matters.
            # `nil` in a 1:1 chat, where `from` is already the device.
            participant: JID.t() | nil,
            timestamp: DateTime.t()
          }
  end

  defmodule Presence do
    @moduledoc "Presence change for a chat participant."
    defstruct [:device_id, :presence]
    @type t :: %__MODULE__{device_id: String.t(), presence: Whatsmeow.Types.Presence.t()}
  end

  defmodule GroupInfo do
    @moduledoc "Group info / participant change."
    defstruct [:device_id, :group, :change]
    @type t :: %__MODULE__{device_id: String.t(), group: Group.t(), change: atom()}
  end

  defmodule CallEvent do
    @moduledoc "Inbound call signaling (offer / accept / terminate)."
    defstruct [:device_id, :call, :kind]
    @type t :: %__MODULE__{device_id: String.t(), call: Call.t(), kind: atom()}
  end

  defmodule Contact do
    @moduledoc "Contact info changed (push name update, business profile, …)."
    defstruct [:device_id, :user]
    @type t :: %__MODULE__{device_id: String.t(), user: User.t()}
  end

  defmodule HistorySync do
    @moduledoc """
    A chunk of your existing chat history, downloaded and decoded.

    Arrives after linking (and incrementally afterwards) as your phone uploads
    the chats this device was never online for. `sync` is the decoded
    `%WAWebProtobufsHistorySync.HistorySync{}`: `conversations` holds the chats
    and their messages, `statusV3Messages` the status/story posts.

    History arrives in **chunks** — `progress` counts toward 100 and
    `chunk_order` orders them. Expect several of these events per link, not one.

    This is the only way to recover a message the live path never delivered —
    most notably one you sent from your phone while this device was offline,
    which WhatsApp does not redeliver on reconnect.
    """
    defstruct [:device_id, :sync, :sync_type, :progress, :chunk_order]

    @type t :: %__MODULE__{
            device_id: String.t(),
            sync: struct(),
            sync_type: atom() | nil,
            progress: non_neg_integer() | nil,
            chunk_order: non_neg_integer() | nil
          }
  end

  defmodule HistorySyncFailed do
    @moduledoc """
    A history-sync blob was announced but could not be retrieved.

    Emitted instead of `HistorySync` when the download, inflate, or decode step
    fails, so a silent gap in the chat list is visible rather than mysterious.
    """
    defstruct [:device_id, :reason, :notification]

    @type t :: %__MODULE__{device_id: String.t(), reason: term(), notification: struct() | nil}
  end

  defmodule SendRejected do
    @moduledoc """
    The server accepted an outbound stanza on the socket but the application
    layer rejected it — the message was **not** delivered.

    Arrives as `<ack class="message" error="…">`. Without this event a rejected
    send is indistinguishable from a successful one: `Whatsmeow.Send.send_text/4`
    already returned `{:ok, msg_id}` by the time the ack lands.

    Codes worth knowing:

      * `"463"` — account restriction; we sent without a trusted-contact token
        the recipient trusts. See `Whatsmeow.PrivacyToken`.
      * `"479"` — the stanza failed the server's schema validation.
      * `"401"` / `"403"` — not authorised to message this recipient.
    """
    defstruct [:device_id, :message_id, :code, :from, :class]

    @type t :: %__MODULE__{
            device_id: String.t(),
            message_id: String.t() | nil,
            code: String.t(),
            from: JID.t() | nil,
            class: String.t() | nil
          }
  end
end
