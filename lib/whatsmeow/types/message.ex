defmodule Whatsmeow.Types.Message do
  @moduledoc """
  A high-level message representation handed to user code after the receive
  pipeline (Phase 9) has decrypted and decoded a frame.

  The encrypted-wire form lives in the generated `Whatsmeow.Proto.WaE2E.*`
  modules; this struct is the user-facing summary.
  """

  alias Whatsmeow.Types.JID

  @enforce_keys [:id, :from]
  defstruct [
    :id,
    :from,
    :chat,
    :sender,
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
