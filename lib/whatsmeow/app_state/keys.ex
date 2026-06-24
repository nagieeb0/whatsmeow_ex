defmodule Whatsmeow.AppState.Keys do
  @moduledoc """
  WhatsApp app-state key derivation and patch-name constants.

  Ports `whatsmeow-main/appstate/keys.go`. The `keyData` for each app-state
  collection is expanded via HKDF-SHA256 (info `"WhatsApp Mutation Keys"`,
  length 160) into five 32-byte sub-keys:

  * `index` — HMAC-SHA256 key used to MAC the JSON-encoded mutation index
  * `value_encryption` — AES-256-CBC key for the mutation envelope
  * `value_mac` — HMAC-SHA512 key for the mutation value (truncated to 32B)
  * `snapshot_mac` — HMAC-SHA256 key for the snapshot LTHash
  * `patch_mac` — HMAC-SHA256 key over the patch's mutation digests
  """

  alias Whatsmeow.Crypto.HKDF

  @hkdf_info "WhatsApp Mutation Keys"
  @hkdf_size 160

  @patch_critical_block "critical_block"
  @patch_critical_unblock_low "critical_unblock_low"
  @patch_regular_low "regular_low"
  @patch_regular_high "regular_high"
  @patch_regular "regular"

  @all_patch_names [
    @patch_critical_block,
    @patch_critical_unblock_low,
    @patch_regular_high,
    @patch_regular,
    @patch_regular_low
  ]

  @type patch_name :: String.t()

  @type expanded :: %{
          index: binary(),
          value_encryption: binary(),
          value_mac: binary(),
          snapshot_mac: binary(),
          patch_mac: binary()
        }

  @doc "List of all known patch names."
  @spec all_patch_names() :: [patch_name()]
  def all_patch_names, do: @all_patch_names

  @doc "WhatsApp patch names as string constants."
  def patch_critical_block, do: @patch_critical_block
  def patch_critical_unblock_low, do: @patch_critical_unblock_low
  def patch_regular_low, do: @patch_regular_low
  def patch_regular_high, do: @patch_regular_high
  def patch_regular, do: @patch_regular

  @doc """
  Expand a 32-byte (or longer) app-state-sync `key_data` into the 5 sub-keys
  used by the encode/decode pipeline.
  """
  @spec expand(binary()) :: expanded()
  def expand(key_data) when is_binary(key_data) do
    expanded = HKDF.derive(key_data, nil, @hkdf_info, @hkdf_size)

    <<index::binary-size(32), value_enc::binary-size(32), value_mac::binary-size(32),
      snapshot_mac::binary-size(32), patch_mac::binary-size(32)>> = expanded

    %{
      index: index,
      value_encryption: value_enc,
      value_mac: value_mac,
      snapshot_mac: snapshot_mac,
      patch_mac: patch_mac
    }
  end
end
