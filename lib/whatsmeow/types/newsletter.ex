defmodule Whatsmeow.Types.Newsletter do
  @moduledoc "WhatsApp Channel (newsletter) metadata."

  alias Whatsmeow.Types.JID

  defstruct [
    :jid,
    :name,
    :description,
    :picture_id,
    :verified,
    :subscribers,
    :created_at,
    :role
  ]

  @type role :: :subscriber | :guest | :admin | :owner | nil
  @type t :: %__MODULE__{
          jid: JID.t(),
          name: String.t() | nil,
          description: String.t() | nil,
          picture_id: String.t() | nil,
          verified: boolean() | nil,
          subscribers: non_neg_integer() | nil,
          created_at: DateTime.t() | nil,
          role: role
        }
end
