defmodule Whatsmeow.Types.User do
  @moduledoc "Public information about a WhatsApp user contact."

  alias Whatsmeow.Types.JID

  defstruct [
    :jid,
    :verified_name,
    :status,
    :push_name,
    :business_name,
    :devices,
    :picture_id
  ]

  @type t :: %__MODULE__{
          jid: JID.t(),
          verified_name: String.t() | nil,
          status: String.t() | nil,
          push_name: String.t() | nil,
          business_name: String.t() | nil,
          devices: [JID.t()],
          picture_id: String.t() | nil
        }
end
