defmodule Whatsmeow.AppState.Encode do
  @moduledoc """
  Encode app-state mutations into the WhatsApp `SyncdMutation` wire format.

  Ports the encrypting half of `whatsmeow-main/appstate/encode.go`.

  `encode_mutation/4` and `encode_patch/6` produce the byte fragments (the
  encrypted mutation blobs, MACs, the snapshot/patch MAC);
  `encode_syncd_patch/6` is Go's `Processor.EncodePatch` end to end, from a
  `Whatsmeow.AppState.Patch` to the marshalled `SyncdPatch` sent in
  `<patch>`.
  """

  alias Whatsmeow.AppState.{Hash, Keys, Patch}
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

  Generates a random 16-byte IV (or takes `opts[:iv]`, for tests) and
  prepends it to the AES-256-CBC ciphertext. The 32-byte content MAC is
  computed over the prefixed ciphertext and appended.

  Returns the index MAC, the full value blob (`IV || ciphertext || MAC`),
  the value MAC alone, and the operation.
  """
  @spec encode_mutation(mutation_input(), Keys.expanded(), binary(), keyword()) ::
          encoded_mutation()
  def encode_mutation(
        %{index_json: index_json, content: content, operation: op},
        %{value_encryption: enc_key, value_mac: vmac_key, index: idx_key},
        key_id,
        opts \\ []
      )
      when is_binary(index_json) and is_binary(content) and op in [:set, :remove] and
             is_binary(key_id) do
    iv = Keyword.get_lazy(opts, :iv, fn -> :crypto.strong_rand_bytes(16) end)
    16 = byte_size(iv)
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

  @doc """
  Encode a `Whatsmeow.AppState.Patch` into the marshalled `SyncdPatch` that
  goes inside `<patch>` — Go's `Processor.EncodePatch`
  (`whatsmeow-main/appstate/encode.go`), step for step:

    1. every value is stamped with the patch timestamp (ms; now if unset);
    2. each mutation is a SET of `SyncActionData{index: <json>, value,
       padding: <<>>, version}`, encrypted under the key's value-encryption
       key, value-MACed, index-MACed;
    3. the LTHash is advanced with `prev_set_value_mac.(index_mac, i)` as the
       value to subtract — Go asks only the store here, never the in-flight
       patch;
    4. the version goes up by one, then the snapshot MAC and the patch MAC
       are computed for that version.

  `state` is the stored, verified state of the collection. Returns the bytes
  and the state they lead to — which is *not* persisted here: the caller
  re-syncs after the server accepts, exactly as Go does.

  Options: `:ivs` — one 16-byte IV per mutation, for tests (default random).
  """
  @spec encode_syncd_patch(
          Patch.t(),
          Keys.expanded(),
          binary(),
          Hash.t(),
          (binary(), non_neg_integer() -> binary() | nil),
          keyword()
        ) :: {:ok, %{patch: binary(), state: Hash.t(), warnings: list()}}
  def encode_syncd_patch(
        %Patch{type: name, mutations: [_ | _] = infos} = patch,
        keys,
        key_id,
        %Hash{} = state,
        prev_set_value_mac,
        opts \\ []
      )
      when is_binary(name) and is_binary(key_id) and is_function(prev_set_value_mac, 2) do
    ts = patch.timestamp || System.os_time(:millisecond)

    ivs =
      Keyword.get_lazy(opts, :ivs, fn ->
        Enum.map(infos, fn _ -> :crypto.strong_rand_bytes(16) end)
      end)

    encoded =
      infos
      |> Enum.zip(ivs)
      |> Enum.map(fn {%{index: index, version: version, value: value}, iv} ->
        index_json = Patch.index_json(index)

        content =
          %WAWebProtobufSyncAction.SyncActionData{
            index: index_json,
            value: %{value | timestamp: ts},
            padding: <<>>,
            version: version
          }
          |> WAWebProtobufSyncAction.SyncActionData.encode()
          |> IO.iodata_to_binary()

        encode_mutation(%{index_json: index_json, content: content, operation: :set}, keys, key_id,
          iv: iv
        )
      end)

    {:ok, post_hash, warnings} = Hash.update(state, encoded, prev_set_value_mac)
    new_state = %Hash{post_hash | version: state.version + 1}
    snapshot_mac = Hash.snapshot_mac(new_state, name, keys.snapshot_mac)

    patch_mac =
      Hash.patch_mac(
        snapshot_mac,
        Enum.map(encoded, & &1.value_mac),
        new_state.version,
        name,
        keys.patch_mac
      )

    key = %WAServerSync.KeyId{ID: key_id}

    bytes =
      %WAServerSync.SyncdPatch{
        snapshotMAC: snapshot_mac,
        keyID: key,
        mutations:
          Enum.map(encoded, fn m ->
            %WAServerSync.SyncdMutation{
              operation: :SET,
              record: %WAServerSync.SyncdRecord{
                index: %WAServerSync.SyncdIndex{blob: m.index_mac},
                value: %WAServerSync.SyncdValue{blob: m.value_blob},
                keyID: key
              }
            }
          end),
        patchMAC: patch_mac
      }
      |> WAServerSync.SyncdPatch.encode()
      |> IO.iodata_to_binary()

    {:ok, %{patch: bytes, state: new_state, warnings: warnings}}
  end
end
