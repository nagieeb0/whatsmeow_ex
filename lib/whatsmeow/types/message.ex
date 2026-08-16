defmodule Whatsmeow.Types.Message do
  @moduledoc """
  A high-level message representation handed to user code after the receive
  pipeline (Phase 9) has decrypted and decoded a frame.

  The encrypted-wire form lives in the generated `Whatsmeow.Proto.WaE2E.*`
  modules; this struct is the user-facing summary.

  ## `sender` and `sender_alt`

  A contact with privacy enabled reaches you as a LID — `123456789@lid` — with
  no phone number in it. `sender` is always the address the message was
  actually sent with, because that is what a reply and a Signal session have to
  be keyed by. `sender_alt` is the same person's *other* address, which for a
  LID sender is their phone number.

  Read `sender` to answer; read `sender_alt` to know who they are.
  """

  alias Whatsmeow.Types.JID

  @enforce_keys [:id, :from]
  defstruct [
    :id,
    :from,
    :chat,
    :sender,
    :sender_alt,
    :timestamp,
    :push_name,
    :body,
    :raw,
    is_from_me: false,
    is_group: false,
    is_ephemeral: false,
    is_view_once: false,
    attachments: []
  ]

  @type t :: %__MODULE__{
          id: String.t(),
          from: JID.t(),
          chat: JID.t() | nil,
          sender: JID.t() | nil,
          sender_alt: JID.t() | nil,
          timestamp: DateTime.t() | nil,
          push_name: String.t() | nil,
          body: String.t() | nil,
          raw: term(),
          is_from_me: boolean(),
          is_group: boolean(),
          is_ephemeral: boolean(),
          is_view_once: boolean(),
          attachments: [map()]
        }
end
