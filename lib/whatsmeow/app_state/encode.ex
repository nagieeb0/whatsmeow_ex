defmodule Whatsmeow.AppState.Encode do
  @moduledoc """
  Encode an app-state patch for sending.

  Ports `Processor.EncodePatch` from `whatsmeow-main/appstate/encode.go`, step
  for step:

    1. stamp each mutation's value with the patch timestamp (milliseconds);
    2. `SyncActionData{index: json(index), value, padding: "", version}`;
    3. AES-256-CBC under the key's `value_encryption`, random 16-byte IV
       **prepended**;
    4. value MAC = `HMAC-SHA512(value_mac_key, op_byte || key_id || iv_ct ||
       u64be(len(key_id)+1))[0..32]` with `op_byte` = **1** for SET (see
       `Whatsmeow.AppState.Hash.content_mac/4`);
    5. index MAC = `HMAC-SHA256(index_key, json(index))`;
    6. value blob = `iv_ct || value_mac`; the record carries the key id;
    7. LTHash update — the previous value MAC for an index (if any) is
       subtracted, the new one added;
    8. `version + 1`; snapshot MAC over the *new* state; patch MAC over
       `snapshot_mac || value_macs || u64be(version) || name`.

  The returned `SyncdPatch` has **no `version`**: Go does not set it either. The
  collection version the server must be at travels as the `version` attribute of
  the IQ, and the server stamps the patch with its own version afterwards.
  """

  alias Whatsmeow.AppState.{Hash, Patch}
  alias Whatsmeow.Crypto.AES

  alias WAServerSync.{KeyId, SyncdIndex, SyncdMutation, SyncdPatch, SyncdRecord, SyncdValue}
  alias WAWebProtobufSyncAction.SyncActionData

  @type prev_mac_fun :: (binary(), non_neg_integer() -> binary() | nil | {:error, term()})

  @type result :: %{
          patch: SyncdPatch.t(),
          bytes: binary(),
          state: Hash.t(),
          warnings: [term()]
        }

  @doc """
  Encode `patch` under `key_id`/`keys` on top of `state`.

  `prev_set_value_mac` is Go's `GetAppStateMutationMAC` lookup: given an index
  MAC, the value MAC of the newest stored SET for it. Unlike decoding, encoding
  consults only the store, never earlier mutations of the same patch.

  Options: `:iv_fun` — `(-> <<_::128>>)`, for deterministic tests only.
  """
  @spec encode_patch(
          Patch.t(),
          binary(),
          Whatsmeow.AppState.Keys.expanded(),
          Hash.t(),
          prev_mac_fun(),
          keyword()
        ) :: {:ok, result()} | {:error, term()}
  def encode_patch(%Patch{} = patch, key_id, keys, %Hash{} = state, prev_set_value_mac, opts \\ [])
      when is_binary(key_id) and is_function(prev_set_value_mac, 2) do
    ts = patch.timestamp_ms || System.os_time(:millisecond)
    iv_fun = Keyword.get(opts, :iv_fun, fn -> :crypto.strong_rand_bytes(16) end)

    mutations = Enum.map(patch.mutations, &encode_mutation(&1, ts, key_id, keys, iv_fun))

    hash_inputs =
      Enum.map(mutations, fn m ->
        blob = m.record.value.blob
        %{operation: :set, value_mac: tail32(blob), index_mac: m.record.index.blob}
      end)

    with {:ok, hashed, warnings} <- Hash.update(state, hash_inputs, prev_set_value_mac) do
      new_state = %{hashed | version: state.version + 1}
      snapshot_mac = Hash.snapshot_mac(new_state, patch.type, keys.snapshot_mac)

      value_macs = Enum.map(hash_inputs, & &1.value_mac)

      patch_mac =
        Hash.patch_mac(snapshot_mac, value_macs, new_state.version, patch.type, keys.patch_mac)

      syncd = %SyncdPatch{
        snapshotMAC: snapshot_mac,
        keyID: %KeyId{ID: key_id},
        mutations: mutations,
        patchMAC: patch_mac
      }

      {:ok,
       %{
         patch: syncd,
         bytes: syncd |> SyncdPatch.encode() |> IO.iodata_to_binary(),
         state: new_state,
         warnings: warnings
       }}
    end
  end

  @doc "Encode one mutation as a `SyncdMutation` SET. Go: the loop body of `EncodePatch`."
  @spec encode_mutation(
          Patch.Mutation.t(),
          integer(),
          binary(),
          Whatsmeow.AppState.Keys.expanded(),
          (-> binary())
        ) :: SyncdMutation.t()
  def encode_mutation(%Patch.Mutation{} = m, ts_ms, key_id, keys, iv_fun) do
    index_json = Jason.encode!(m.index)

    data = %SyncActionData{
      index: index_json,
      value: %{m.value | timestamp: ts_ms},
      padding: <<>>,
      version: m.version
    }

    content = data |> SyncActionData.encode() |> IO.iodata_to_binary()

    iv = iv_fun.()
    iv_and_ct = iv <> AES.CBC.encrypt(keys.value_encryption, iv, content)

    value_mac = Hash.content_mac(:set, iv_and_ct, key_id, keys.value_mac)
    index_mac = Hash.index_mac(index_json, keys.index)

    %SyncdMutation{
      operation: :SET,
      record: %SyncdRecord{
        index: %SyncdIndex{blob: index_mac},
        value: %SyncdValue{blob: iv_and_ct <> value_mac},
        keyID: %KeyId{ID: key_id}
      }
    }
  end

  defp tail32(blob) do
    size = byte_size(blob) - 32
    <<_::binary-size(^size), mac::binary-size(32)>> = blob
    mac
  end
end
