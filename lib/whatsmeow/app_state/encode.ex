defmodule Whatsmeow.AppState.Encode do
  @moduledoc """
  Encode app-state mutations into the WhatsApp `SyncdMutation` wire format.

  Ports the encrypting half of `whatsmeow-main/appstate/encode.go`.

  The protobuf marshalling of the outer `SyncdPatch` is deferred to the
  generated modules (Phase 3). This module produces the byte fragments
  that go into those protobufs — encrypted mutation blobs, MACs, and the
  snapshot/patch MAC — so the wire wiring is a thin shim.
  """

  alias Whatsmeow.AppState.{Hash, Keys}
  alias Whatsmeow.Crypto.AES

  @type mutation_input :: %{
          # JSON-marshalled index, e.g. `~s(["pin_v1","555@s.whatsapp.net"])`
          required(:index_json) => binary(),
          # The protobuf-marshalled SyncActionData (or any opaque payload).
          required(:content) => binary(),
          # :set or :remove
          required(:operation) => :set | :remove
        }

  @type encoded_mutation :: %{
          operation: :set | :remove,
          index_mac: binary(),
          value_blob: binary(),
          value_mac: binary(),
          key_id: binary()
        }

  @doc """
  Encrypt a single mutation under the given expanded keys.

  Generates a random 16-byte IV and prepends it to the AES-256-CBC
  ciphertext. The 32-byte content MAC is computed over the prefixed
  ciphertext and appended.

  Returns the index MAC, the full value blob (`IV || ciphertext || MAC`),
  the value MAC alone, and the operation.
  """
  @spec encode_mutation(mutation_input(), Keys.expanded(), binary()) :: encoded_mutation()
  def encode_mutation(
        %{index_json: index_json, content: content, operation: op},
        %{value_encryption: enc_key, value_mac: vmac_key, index: idx_key},
        key_id
      )
      when is_binary(index_json) and is_binary(content) and op in [:set, :remove] and
             is_binary(key_id) do
    iv = :crypto.strong_rand_bytes(16)
    ciphertext = AES.CBC.encrypt(enc_key, iv, content)
    iv_and_ct = iv <> ciphertext
    value_mac = Hash.content_mac(op, iv_and_ct, key_id, vmac_key)
    index_mac = Hash.index_mac(index_json, idx_key)

    %{
      operation: op,
      index_mac: index_mac,
      value_blob: iv_and_ct <> value_mac,
      value_mac: value_mac,
      key_id: key_id
    }
  end

  @doc """
  Encode a list of mutation inputs and return the encoded mutations plus
  the new hash state, snapshot MAC, and patch MAC.

  `prev_set_value_mac.(index_mac, i)` looks up the value MAC for a
  previous SET on that index (across both the in-flight patch and the
  caller's local store).
  """
  @spec encode_patch(
          [mutation_input()],
          Keys.expanded(),
          binary(),
          Hash.t(),
          binary(),
          (binary(), non_neg_integer() -> binary() | nil)
        ) :: %{
          mutations: [encoded_mutation()],
          state: Hash.t(),
          snapshot_mac: binary(),
          patch_mac: binary()
        }
  def encode_patch(mutations, keys, key_id, %Hash{} = state, patch_name, prev_set_value_mac)
      when is_list(mutations) and is_binary(key_id) and is_binary(patch_name) and
             is_function(prev_set_value_mac, 2) do
    encoded = Enum.map(mutations, &encode_mutation(&1, keys, key_id))

    hash_inputs =
      Enum.map(encoded, fn m ->
        %{operation: m.operation, value_mac: m.value_mac, index_mac: m.index_mac}
      end)

    {:ok, post_hash, _warn} = Hash.update(state, hash_inputs, prev_set_value_mac)
    new_state = %Hash{post_hash | version: state.version + 1}

    snapshot_mac = Hash.snapshot_mac(new_state, patch_name, keys.snapshot_mac)

    value_macs = Enum.map(encoded, & &1.value_mac)

    patch_mac =
      Hash.patch_mac(snapshot_mac, value_macs, new_state.version, patch_name, keys.patch_mac)

    %{
      mutations: encoded,
      state: new_state,
      snapshot_mac: snapshot_mac,
      patch_mac: patch_mac
    }
  end
end
