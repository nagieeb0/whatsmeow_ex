defmodule Whatsmeow.Types.Call do
  @moduledoc "WhatsApp call metadata."

  alias Whatsmeow.Types.JID

  defstruct [:id, :from, :timestamp, :video, :group_call]

  @type t :: %__MODULE__{
          id: String.t(),
          from: JID.t(),
          timestamp: DateTime.t() | nil,
          video: boolean(),
          group_call: boolean()
        }
end
