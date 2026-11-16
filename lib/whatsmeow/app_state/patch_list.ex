defmodule Whatsmeow.AppState.PatchList do
  @moduledoc """
  A decoded `<sync><collection>` response. Go: `appstate.PatchList`.

  `snapshot` is a decoded `WAServerSync.SyncdSnapshot` (any external blob already
  downloaded), or `nil`. Patches likewise have their external mutations
  inlined, so the `Processor` only ever sees complete data.
  """

  defstruct name: "", has_more_patches?: false, patches: [], snapshot: nil

  @type t :: %__MODULE__{
          name: String.t(),
          has_more_patches?: boolean(),
          patches: [WAServerSync.SyncdPatch.t()],
          snapshot: WAServerSync.SyncdSnapshot.t() | nil
        }
end
