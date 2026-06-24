defmodule Whatsmeow.Types.Presence do
  @moduledoc "User presence state."

  alias Whatsmeow.Types.JID

  defstruct [:from, :state, :last_seen]

  @type state :: :available | :unavailable | :composing | :recording | :paused
  @type t :: %__MODULE__{
          from: JID.t(),
          state: state,
          last_seen: DateTime.t() | nil
        }
end
