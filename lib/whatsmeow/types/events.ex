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
    defstruct [:device_id, :type, :message_ids, :from, :timestamp]

    @type kind :: :delivery | :read | :played | :server_error | :inactive | :sender
    @type t :: %__MODULE__{
            device_id: String.t(),
            type: kind,
            message_ids: [String.t()],
            from: JID.t(),
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
end
