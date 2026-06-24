defmodule Whatsmeow.AppState.Recovery do
  @moduledoc """
  Parse and apply snapshot-recovery payloads.

  Ports `whatsmeow-main/appstate/recovery.go`.

  When the server signals a fatal hash mismatch, it can send back a
  `SyncdSnapshotRecovery` blob — a list of mutation records plus the
  authoritative LTHash. This module exposes:

  * `parse/2` — decompress (gzip) the recovery payload, returning the
    raw bytes ready for protobuf unmarshalling.
  * `process/3` — given a parsed recovery (as a plain map), compute the
    index MACs for each mutation under the supplied key map.

  Protobuf marshalling is done in the wire layer; we work on maps.
  """

  alias Whatsmeow.AppState.Hash
  alias Whatsmeow.AppState.Keys

  @type recovery :: %{
          collection_name: String.t(),
          collection_lthash: binary(),
          version: non_neg_integer(),
          mutation_records: [recovery_record()]
        }

  @type recovery_record :: %{
          key_id: binary(),
          index_json: binary(),
          mac: binary(),
          value: term()
        }

  @doc """
  Decompress the raw `collection_snapshot` bytes if the response says they
  are compressed (gzip). Returns the protobuf-ready bytes.
  """
  @spec decompress(binary(), boolean()) :: {:ok, binary()} | {:error, term()}
  def decompress(data, false) when is_binary(data), do: {:ok, data}

  def decompress(data, true) when is_binary(data) do
    try do
      {:ok, :zlib.gunzip(data)}
    rescue
      e -> {:error, e}
    end
  end

  @doc """
  Compute the index MAC for each mutation record using the lookup
  function `get_keys.(key_id)`, which must return `{:ok, expanded}` or
  `{:error, :key_not_found}`.

  Returns `{:ok, processed}` where each `processed` entry has the input
  `value`, `key_id`, the computed `index_mac`, and the original
  `value_mac` (from `mac`).
  """
  @spec process(recovery(), (binary() -> {:ok, Keys.expanded()} | {:error, atom()})) ::
          {:ok, %{lthash: binary(), version: non_neg_integer(), mutations: [map()]}}
          | {:error, term()}
  def process(%{collection_lthash: lthash}, _get_keys)
      when byte_size(lthash) != 128 do
    {:error, {:invalid_lthash_length, byte_size(lthash)}}
  end

  def process(%{mutation_records: records, version: version, collection_lthash: lthash}, get_keys)
      when is_list(records) and is_function(get_keys, 1) do
    Enum.reduce_while(records, {:ok, []}, fn record, {:ok, acc} ->
      case get_keys.(record.key_id) do
        {:ok, keys} ->
          mac = Hash.index_mac(record.index_json, keys.index)

          processed = %{
            key_id: record.key_id,
            index_mac: mac,
            value_mac: record.mac,
            value: record.value,
            patch_version: version
          }

          {:cont, {:ok, [processed | acc]}}

        {:error, _} = err ->
          {:halt, err}
      end
    end)
    |> case do
      {:ok, mutations} ->
        {:ok, %{lthash: lthash, version: version, mutations: Enum.reverse(mutations)}}

      err ->
        err
    end
  end
end
