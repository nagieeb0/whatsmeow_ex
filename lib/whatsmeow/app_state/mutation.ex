defmodule Whatsmeow.AppState.Mutation do
  @moduledoc """
  One decoded app-state mutation. Go: `appstate.Mutation`.

  `index` is the thing mutated followed by its parameters
  (`["archive", "1555…@s.whatsapp.net"]`); `action` is the decrypted
  `SyncActionValue`; `version` is the per-action schema version carried inside the
  envelope (not the collection version — that is `patch_version`).
  """

  @enforce_keys [:key_id, :operation, :index, :index_mac, :value_mac]
  defstruct [
    :key_id,
    :operation,
    :action,
    :version,
    :index,
    :index_mac,
    :value_mac,
    :patch_version
  ]

  @type t :: %__MODULE__{
          key_id: binary(),
          operation: :set | :remove,
          action: WAWebProtobufSyncAction.SyncActionValue.t() | nil,
          version: integer() | nil,
          index: [String.t()],
          index_mac: binary(),
          value_mac: binary(),
          patch_version: non_neg_integer() | nil
        }
end
