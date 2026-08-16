defmodule Whatsmeow.AppState.Decode do
  @moduledoc """
  Decode WhatsApp app-state `SyncdMutation` payloads.

  Ports the verifying/decrypting half of `whatsmeow-main/appstate/decode.go`.

  Like `Whatsmeow.AppState.Encode`, this module operates on byte fragments
  (the encrypted value blob, index MAC, key id, operation) so that wire
  unmarshalling can stay in the protobuf layer.
  """

  alias Whatsmeow.AppState.{Hash, Keys}
  alias Whatsmeow.Crypto.AES

  @type encoded_mutation :: %{
          required(:operation) => :set | :remove,
          required(:value_blob) => binary(),
          required(:index_mac) => binary(),
          required(:key_id) => binary()
        }

  @type decoded_mutation :: %{
          operation: :set | :remove,
          key_id: binary(),
          index_mac: binary(),
          value_mac: binary(),
          plaintext: binary()
        }

  @doc """
  Decode and verify a single mutation.

  Returns the decrypted plaintext + the index/value MACs on success, or an
  `{:error, reason}` tuple where reason is one of
  `:mismatching_content_mac`, `:mismatching_index_mac`, `:bad_padding`.

  When `index_json` is provided, the index MAC is also verified. (For the
  WhatsApp wire format the index JSON is recovered from the decrypted
  `SyncActionData.index` — pass it back in for validation.)
  """
  @spec decode_mutation(encoded_mutation(), Keys.expanded(), validate_macs :: boolean()) ::
          {:ok, decoded_mutation()} | {:error, atom()}
  def decode_mutation(
        %{operation: op, value_blob: blob, index_mac: index_mac, key_id: key_id},
        %{value_encryption: enc_key, value_mac: vmac_key},
        validate_macs
      )
      when op in [:set, :remove] and is_binary(blob) and byte_size(blob) >= 16 + 32 do
    blob_size = byte_size(blob)
    ct_size = blob_size - 32
    <<iv_and_ct::binary-size(^ct_size), value_mac::binary-size(32)>> = blob

    with :ok <- maybe_verify_content_mac(validate_macs, op, iv_and_ct, key_id, vmac_key, value_mac) do
      <<iv::binary-size(16), ct::binary>> = iv_and_ct

      case AES.CBC.decrypt(enc_key, iv, ct) do
        {:ok, plaintext} ->
          {:ok,
           %{
             operation: op,
             key_id: key_id,
             index_mac: index_mac,
             value_mac: value_mac,
             plaintext: plaintext
           }}

        err ->
          err
      end
    end
  end

  @doc """
  Verify that a decoded mutation's index JSON HMACs to the supplied
  index MAC. Returns `:ok` or `{:error, :mismatching_index_mac}`.
  """
  @spec verify_index_mac(binary(), binary(), Keys.expanded()) ::
          :ok | {:error, :mismatching_index_mac}
  def verify_index_mac(index_json, expected_index_mac, %{index: key})
      when is_binary(index_json) and is_binary(expected_index_mac) do
    actual = Hash.index_mac(index_json, key)

    if :crypto.hash_equals(actual, expected_index_mac) do
      :ok
    else
      {:error, :mismatching_index_mac}
    end
  end

  @doc """
  Verify a snapshot MAC against the computed value.
  """
  @spec verify_snapshot_mac(Hash.t(), binary(), binary(), binary()) ::
          :ok | {:error, :mismatching_lthash}
  def verify_snapshot_mac(%Hash{} = state, name, key, expected_mac) do
    actual = Hash.snapshot_mac(state, name, key)

    if :crypto.hash_equals(actual, expected_mac) do
      :ok
    else
      {:error, :mismatching_lthash}
    end
  end

  @doc """
  Verify the patch MAC for a list of value MACs.
  """
  @spec verify_patch_mac(binary(), [binary()], non_neg_integer(), binary(), binary(), binary()) ::
          :ok | {:error, :mismatching_patch_mac}
  def verify_patch_mac(snapshot_mac, value_macs, version, name, key, expected_mac) do
    actual = Hash.patch_mac(snapshot_mac, value_macs, version, name, key)

    if :crypto.hash_equals(actual, expected_mac) do
      :ok
    else
      {:error, :mismatching_patch_mac}
    end
  end

  defp maybe_verify_content_mac(false, _op, _data, _key_id, _key, _expected), do: :ok

  defp maybe_verify_content_mac(true, op, data, key_id, key, expected) do
    actual = Hash.content_mac(op, data, key_id, key)

    if :crypto.hash_equals(actual, expected) do
      :ok
    else
      {:error, :mismatching_content_mac}
    end
  end
end
