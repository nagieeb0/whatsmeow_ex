defmodule Whatsmeow.AppState.Decode do
  @moduledoc """
  Decode and verify app-state mutations.

  Ports `decodeMutation` and the MAC checks from
  `whatsmeow-main/appstate/decode.go`. The store-coupled half — applying whole
  snapshots and patches against persisted state — is
  `Whatsmeow.AppState.Processor`.

  ## Error shape

  Every failure is `{:error, {reason, detail}}` where `reason` is one of
  `Whatsmeow.AppState.Errors.t/0` (`:key_not_found`, `:mismatching_content_mac`,
  `:mismatching_index_mac`, `:mismatching_lthash`, `:mismatching_patch_mac`) or
  one of the malformed-input reasons below. `detail` locates it (mutation
  number, key id, version) for logs.

    * `:invalid_value_blob` — a value blob shorter than IV + MAC. Go slices
      `blob[len-32:]` unchecked and would panic; a malformed server frame must
      not crash the process that is holding the app-state lock.
    * `:decrypt_failed`, `:invalid_sync_action`, `:invalid_index` — the envelope
      did not decrypt / parse.
  """

  alias Whatsmeow.AppState.{Hash, Keys}
  alias Whatsmeow.Crypto.AES

  alias WAServerSync.SyncdMutation
  alias WAWebProtobufSyncAction.SyncActionData

  @type expanded_keys :: %{optional(binary()) => Keys.expanded()}

  @type decoded :: %{
          key_id: binary(),
          operation: :set | :remove,
          index_mac: binary(),
          value_mac: binary(),
          index: [String.t()],
          sync_action: SyncActionData.t()
        }

  @doc """
  Decrypt one mutation. `keys` maps key id → expanded keys, resolved by the
  caller; a key id missing from it is `{:key_not_found, key_id}`.

  With `validate_macs` the content MAC (over the ciphertext, under the
  mutation's operation) is checked **before** decrypting, and the index MAC
  (over the decrypted index JSON) after — the order Go uses.
  """
  @spec decode_mutation(SyncdMutation.t(), non_neg_integer(), expanded_keys(), boolean()) ::
          {:ok, decoded()} | {:error, {atom(), term()}}
  def decode_mutation(%SyncdMutation{} = m, i, keys, validate_macs) do
    record = m.record || %WAServerSync.SyncdRecord{}
    key_id = key_id_of(record.keyID)
    blob = (record.value && record.value.blob) || <<>>
    op = operation(m.operation)
    n = i + 1

    with {:ok, k} <- fetch_key(keys, key_id),
         {:ok, iv_and_ct, value_mac} <- split_blob(blob, n),
         :ok <- check_content_mac(validate_macs, op, iv_and_ct, key_id, k.value_mac, value_mac, n),
         {:ok, plaintext} <- decrypt(k.value_encryption, iv_and_ct, n),
         {:ok, action} <- parse_sync_action(plaintext, n),
         index_mac = (record.index && record.index.blob) || <<>>,
         :ok <- check_index_mac(validate_macs, action.index, k.index, index_mac, n),
         {:ok, index} <- parse_index(action.index, n) do
      {:ok,
       %{
         key_id: key_id,
         operation: op,
         index_mac: index_mac,
         value_mac: value_mac,
         index: index,
         sync_action: action
       }}
    end
  end

  @doc "`:SET` → `:set`, `:REMOVE` → `:remove`. Go's getter defaults an unset operation to SET."
  @spec operation(atom() | nil) :: :set | :remove
  def operation(:REMOVE), do: :remove
  def operation(_), do: :set

  @doc "Verify a snapshot MAC. Go: `validateSnapshotMAC`."
  @spec verify_snapshot_mac(Hash.t(), binary(), binary(), binary()) ::
          :ok | {:error, {:mismatching_lthash, non_neg_integer()}}
  def verify_snapshot_mac(%Hash{} = state, name, key, expected_mac) do
    if safe_equal?(Hash.snapshot_mac(state, name, key), expected_mac),
      do: :ok,
      else: {:error, {:mismatching_lthash, state.version}}
  end

  @doc "Verify a patch MAC. Go: the tail of `validatePatch`."
  @spec verify_patch_mac(binary(), [binary()], non_neg_integer(), binary(), binary(), binary()) ::
          :ok | {:error, {:mismatching_patch_mac, non_neg_integer()}}
  def verify_patch_mac(snapshot_mac, value_macs, version, name, key, expected_mac) do
    if safe_equal?(Hash.patch_mac(snapshot_mac, value_macs, version, name, key), expected_mac),
      do: :ok,
      else: {:error, {:mismatching_patch_mac, version}}
  end

  @doc "Verify that `index_json` HMACs to `expected_index_mac`."
  @spec verify_index_mac(binary(), binary(), Keys.expanded()) ::
          :ok | {:error, {:mismatching_index_mac, nil}}
  def verify_index_mac(index_json, expected_index_mac, %{index: key}) do
    if safe_equal?(Hash.index_mac(index_json, key), expected_index_mac),
      do: :ok,
      else: {:error, {:mismatching_index_mac, nil}}
  end

  @doc """
  Constant-time comparison that is also safe on unequal lengths
  (`:crypto.hash_equals/2` raises on those, and a server-supplied MAC can be any
  length).
  """
  @spec safe_equal?(binary(), binary()) :: boolean()
  def safe_equal?(a, b) when is_binary(a) and is_binary(b) and byte_size(a) == byte_size(b),
    do: :crypto.hash_equals(a, b)

  def safe_equal?(_, _), do: false

  # `ID` is capitalised in the proto, so `x.ID` would parse as an alias.
  defp key_id_of(%{ID: id}) when is_binary(id), do: id
  defp key_id_of(_), do: <<>>

  # --- steps ----------------------------------------------------------------

  defp fetch_key(keys, key_id) do
    case Map.fetch(keys, key_id) do
      {:ok, k} -> {:ok, k}
      :error -> {:error, {:key_not_found, key_id}}
    end
  end

  # IV (16) + at least one cipher block (16) + MAC (32).
  defp split_blob(blob, _n) when byte_size(blob) >= 64 do
    size = byte_size(blob) - 32
    <<iv_and_ct::binary-size(^size), mac::binary-size(32)>> = blob
    {:ok, iv_and_ct, mac}
  end

  defp split_blob(blob, n), do: {:error, {:invalid_value_blob, {n, byte_size(blob)}}}

  defp check_content_mac(false, _op, _data, _kid, _key, _mac, _n), do: :ok

  defp check_content_mac(true, op, data, key_id, key, expected, n) do
    if safe_equal?(Hash.content_mac(op, data, key_id, key), expected),
      do: :ok,
      else: {:error, {:mismatching_content_mac, n}}
  end

  defp decrypt(enc_key, iv_and_ct, n) when rem(byte_size(iv_and_ct), 16) == 0 do
    <<iv::binary-size(16), ct::binary>> = iv_and_ct

    case AES.CBC.decrypt(enc_key, iv, ct) do
      {:ok, plaintext} -> {:ok, plaintext}
      {:error, reason} -> {:error, {:decrypt_failed, {n, reason}}}
    end
  end

  defp decrypt(_enc_key, _iv_and_ct, n), do: {:error, {:decrypt_failed, {n, :not_block_aligned}}}

  defp parse_sync_action(plaintext, n) do
    {:ok, SyncActionData.decode(plaintext)}
  rescue
    e -> {:error, {:invalid_sync_action, {n, Exception.message(e)}}}
  end

  defp check_index_mac(false, _index_json, _key, _mac, _n), do: :ok

  defp check_index_mac(true, index_json, key, expected, n) do
    if safe_equal?(Hash.index_mac(index_json || <<>>, key), expected),
      do: :ok,
      else: {:error, {:mismatching_index_mac, n}}
  end

  # Go unmarshals into `[]string`: anything but an array of strings is an error.
  defp parse_index(index_json, n) do
    case Jason.decode(index_json || <<>>) do
      {:ok, list} when is_list(list) ->
        if Enum.all?(list, &is_binary/1),
          do: {:ok, list},
          else: {:error, {:invalid_index, n}}

      _ ->
        {:error, {:invalid_index, n}}
    end
  end
end
