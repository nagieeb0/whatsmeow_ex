defmodule Whatsmeow.AppState.Errors do
  @moduledoc """
  Error atoms returned by the app-state encode/decode pipeline.

  Ports `whatsmeow-main/appstate/errors.go`.

  * `:missing_previous_set_value` — a REMOVE mutation referenced an index
    with no prior SET.
  * `:mismatching_lthash` — the snapshot MAC does not match the locally
    recomputed LTHash.
  * `:mismatching_patch_mac` — the patch MAC does not match.
  * `:mismatching_content_mac` — the mutation value MAC does not match.
  * `:mismatching_index_mac` — the mutation index MAC does not match.
  * `:key_not_found` — the requested app-state-sync key id is unknown.
  """

  @type t ::
          :missing_previous_set_value
          | :mismatching_lthash
          | :mismatching_patch_mac
          | :mismatching_content_mac
          | :mismatching_index_mac
          | :key_not_found
end
