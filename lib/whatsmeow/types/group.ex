defmodule Whatsmeow.Types.Group do
  @moduledoc "Group chat metadata and participant list."

  alias Whatsmeow.Types.JID

  defstruct [
    :jid,
    :owner,
    :name,
    :name_set_at,
    :name_set_by,
    :topic,
    :topic_set_at,
    :topic_set_by,
    :created_at,
    :is_announce,
    :is_locked,
    :is_ephemeral,
    :ephemeral_duration,
    participants: [],
    is_parent: false,
    parent_group: nil,
    is_default_sub_group: false
  ]

  @type t :: %__MODULE__{
          jid: JID.t(),
          owner: JID.t() | nil,
          name: String.t() | nil,
          topic: String.t() | nil,
          participants: [Whatsmeow.Types.Group.Participant.t()],
          created_at: DateTime.t() | nil,
          is_announce: boolean() | nil,
          is_locked: boolean() | nil,
          is_ephemeral: boolean() | nil,
          ephemeral_duration: non_neg_integer() | nil
        }

  defmodule Participant do
    @moduledoc "A group participant — JID plus admin status."
    defstruct [:jid, :lid, :is_admin, :is_super_admin, :error]

    @type t :: %__MODULE__{
            jid: Whatsmeow.Types.JID.t(),
            lid: Whatsmeow.Types.JID.t() | nil,
            is_admin: boolean(),
            is_super_admin: boolean(),
            error: integer() | nil
          }
  end
end
