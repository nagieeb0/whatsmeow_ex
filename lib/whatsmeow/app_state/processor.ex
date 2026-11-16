defmodule Whatsmeow.AppState.Processor do
  @moduledoc """
  Verify, decrypt and persist a `%Sync.PatchList{}` against the stored state
  of its collection.

  Ports `Processor.DecodePatches` and everything under it from
  `whatsmeow-main/appstate/decode.go`, in Go's order:

    * **snapshot** (only into an empty state): every record is a SET; the
      LTHash is built from their value MACs, the snapshot MAC is checked
      under the snapshot's key, then each record is decrypted and its
      content and index MACs checked; then version + hash + every
      `{index_mac, value_mac}` are stored;
    * **each patch**, in order: the LTHash is advanced — the value to
      subtract for an index is the latest earlier SET *in this patch*, else
      the stored one — the snapshot MAC and the patch MAC are checked under
      the patch's key, every mutation is decrypted and MAC-checked, and the
      result is stored before the next patch is looked at.

  A failure stops at that point; what was stored before it stays, as in Go.
  Nothing is stored for a patch that does not verify.

  Context: `%{jid: our_jid, store: module}` (see `Whatsmeow.AppState.Store`).
  """

  alias Whatsmeow.AppState.{Decode, Hash, KeyStore, Keys}
  alias Whatsmeow.AppState.Sync.PatchList

  @type mutation :: %{
          key_id: binary(),
          operation: :set | :remove,
          action: struct() | nil,
          version: integer() | nil,
          index: [String.t()],
          index_mac: binary(),
          value_mac: binary(),
          patch_version: non_neg_integer()
        }

  @type ctx :: %{
          required(:jid) => String.t(),
          required(:store) => module(),
          optional(atom()) => any()
        }

  @doc """
  Apply `list` on top of `state`. Returns the decoded mutations and the new
  state, or the first error — `{:key_not_found, key_id}` when a key is
  missing (the caller asks our phone for it), `:mismatching_lthash`,
  `:mismatching_patch_mac`, `:mismatching_content_mac`,
  `:mismatching_index_mac`, or a store / decode error.
  """
  @spec decode_patches(ctx(), PatchList.t(), Hash.t(), boolean()) ::
          {:ok, [mutation()], Hash.t()} | {:error, term()}
  def decode_patches(ctx, %PatchList{name: name} = list, %Hash{} = state, validate? \\ true) do
    with {:ok, muts, state} <- maybe_snapshot(ctx, name, list.snapshot, state, validate?) do
      Enum.reduce_while(list.patches || [], {:ok, muts, state}, fn patch, {:ok, acc, st} ->
        case decode_patch(ctx, name, patch, st, validate?) do
          {:ok, new_muts, new_st} -> {:cont, {:ok, acc ++ new_muts, new_st}}
          {:error, _} = err -> {:halt, err}
        end
      end)
    end
  catch
    {:store_error, reason} -> {:error, {:store, reason}}
  end

  @doc """
  Key ids in `list` that the store does not hold — Go's `GetMissingKeyIDs`:
  the snapshot's key, each snapshot record's key, and each patch's key.
  """
  @spec missing_key_ids(ctx(), PatchList.t()) :: [binary()]
  def missing_key_ids(ctx, %PatchList{} = list) do
    snapshot_ids =
      case list.snapshot do
        %WAServerSync.SyncdSnapshot{} = ss ->
          [key_id_of(ss.keyID) | Enum.map(ss.records || [], &key_id_of(&1.keyID))]

        _ ->
          []
      end

    (snapshot_ids ++ Enum.map(list.patches || [], &key_id_of(&1.keyID)))
    |> Enum.reject(&(&1 in [nil, ""]))
    |> Enum.uniq()
    |> Enum.filter(fn id ->
      KeyStore.get_key(ctx.jid, id, store: ctx.store) == {:error, :key_not_found}
    end)
  end

  # --- Snapshot ---------------------------------------------------------------

  defp maybe_snapshot(_ctx, _name, nil, state, _validate?), do: {:ok, [], state}

  defp maybe_snapshot(ctx, name, %WAServerSync.SyncdSnapshot{} = ss, %Hash{} = state, validate?) do
    version = version_of(ss.version)
    records = ss.records || []
    mutations = Enum.map(records, &%WAServerSync.SyncdMutation{operation: :SET, record: &1})

    with {:ok, inputs} <- hash_inputs(mutations),
         {:ok, keys} <-
           keys_for(ctx, [key_id_of(ss.keyID) | Enum.map(records, &key_id_of(&1.keyID))]) do
      {:ok, hashed, _warnings} =
        Hash.update(%Hash{state | version: version}, inputs, fn _, _ -> nil end)

      with :ok <- maybe_verify_snapshot(validate?, hashed, name, keys, ss.keyID, ss.mac),
           {:ok, decoded, removed, added} <- decode_mutations(mutations, keys, validate?, version),
           :ok <- store(ctx, name, hashed, removed, added, reset?: true) do
        {:ok, decoded, hashed}
      end
    end
  end

  # --- Patch ------------------------------------------------------------------

  defp decode_patch(ctx, name, %WAServerSync.SyncdPatch{} = patch, %Hash{} = state, validate?) do
    version = version_of(patch.version)
    mutations = patch.mutations || []

    with {:ok, inputs} <- hash_inputs(mutations),
         {:ok, keys} <-
           keys_for(ctx, [key_id_of(patch.keyID) | Enum.map(mutations, &key_id_of(&1.record.keyID))]) do
      in_patch = List.to_tuple(inputs)

      {:ok, hashed, _warnings} =
        Hash.update(%Hash{state | version: version}, inputs, fn index_mac, i ->
          case previous_in_patch(in_patch, index_mac, i - 1) do
            :not_found -> stored_mac!(ctx, name, index_mac)
            found -> found
          end
        end)

      value_macs = Enum.map(inputs, & &1.value_mac)

      with :ok <-
             maybe_verify_snapshot(validate?, hashed, name, keys, patch.keyID, patch.snapshotMAC),
           :ok <- maybe_verify_patch_mac(validate?, patch, value_macs, version, name, keys),
           {:ok, decoded, removed, added} <- decode_mutations(mutations, keys, validate?, version),
           :ok <- store(ctx, name, hashed, removed, added, []) do
        {:ok, decoded, hashed}
      end
    end
  end

  # Go's validatePatch closure: walk back from i-1; a SET gives its value
  # MAC, a REMOVE means "no previous value", nothing means ask the store.
  defp previous_in_patch(_inputs, _index_mac, i) when i < 0, do: :not_found

  defp previous_in_patch(inputs, index_mac, i) do
    case elem(inputs, i) do
      %{index_mac: ^index_mac, operation: :set, value_mac: mac} -> mac
      %{index_mac: ^index_mac, operation: :remove} -> nil
      _ -> previous_in_patch(inputs, index_mac, i - 1)
    end
  end

  defp stored_mac!(ctx, name, index_mac) do
    case ctx.store.get_mutation_mac(ctx.jid, name, index_mac) do
      {:ok, mac} -> mac
      {:error, reason} -> throw({:store_error, reason})
    end
  end

  # --- MACs -------------------------------------------------------------------

  defp maybe_verify_snapshot(false, _state, _name, _keys, _key_id, _mac), do: :ok

  defp maybe_verify_snapshot(true, state, name, keys, key_id, expected) do
    %{snapshot_mac: key} = Map.fetch!(keys, key_id_of(key_id))
    Decode.verify_snapshot_mac(state, name, key, expected || <<>>)
  end

  defp maybe_verify_patch_mac(false, _patch, _macs, _version, _name, _keys), do: :ok

  defp maybe_verify_patch_mac(true, patch, value_macs, version, name, keys) do
    %{patch_mac: key} = Map.fetch!(keys, key_id_of(patch.keyID))

    Decode.verify_patch_mac(
      patch.snapshotMAC || <<>>,
      value_macs,
      version,
      name,
      key,
      patch.patchMAC || <<>>
    )
  end

  # --- Mutations --------------------------------------------------------------

  # The shape `Hash.update/3` reads. A record whose value blob cannot hold an
  # IV, one block and a MAC is malformed; Go would panic slicing it.
  defp hash_inputs(mutations) do
    mutations
    |> Enum.with_index(1)
    |> Enum.reduce_while({:ok, []}, fn {m, i}, {:ok, acc} ->
      with %WAServerSync.SyncdRecord{} = rec <- m.record,
           %WAServerSync.SyncdValue{blob: blob} when is_binary(blob) and byte_size(blob) >= 64 <-
             rec.value,
           %WAServerSync.SyncdIndex{blob: index_mac} when is_binary(index_mac) <- rec.index do
        input = %{
          operation: operation(m.operation),
          value_mac: binary_part(blob, byte_size(blob) - 32, 32),
          index_mac: index_mac
        }

        {:cont, {:ok, [input | acc]}}
      else
        _ -> {:halt, {:error, {:malformed_mutation, i}}}
      end
    end)
    |> case do
      {:ok, list} -> {:ok, Enum.reverse(list)}
      err -> err
    end
  end

  # Go's `decodeMutations` + `patchOutput`: a REMOVE drops any earlier add of
  # the same index from this patch's adds and is deleted from the store.
  defp decode_mutations(mutations, keys, validate?, patch_version) do
    mutations
    |> Enum.with_index(1)
    |> Enum.reduce_while({:ok, [], [], []}, fn {m, i}, {:ok, decoded, removed, added} ->
      case decode_mutation(m, keys, validate?, patch_version) do
        {:ok, %{operation: :remove, index_mac: imac} = mut} ->
          added = Enum.reject(added, fn {a, _} -> :crypto.hash_equals(a, imac) end)
          {:cont, {:ok, [mut | decoded], [imac | removed], added}}

        {:ok, %{operation: :set, index_mac: imac, value_mac: vmac} = mut} ->
          {:cont, {:ok, [mut | decoded], removed, added ++ [{imac, vmac}]}}

        {:error, reason} ->
          {:halt, {:error, {reason, {:mutation, i}}}}
      end
    end)
    |> case do
      {:ok, decoded, removed, added} -> {:ok, Enum.reverse(decoded), Enum.reverse(removed), added}
      err -> err
    end
  end

  defp decode_mutation(%WAServerSync.SyncdMutation{record: rec} = m, keys, validate?, patch_version) do
    key_id = key_id_of(rec.keyID)
    op = operation(m.operation)
    key = Map.fetch!(keys, key_id)

    encoded = %{
      operation: op,
      value_blob: rec.value.blob,
      index_mac: rec.index.blob,
      key_id: key_id
    }

    with {:ok, %{plaintext: plain, value_mac: value_mac}} <-
           Decode.decode_mutation(encoded, key, validate?),
         {:ok, data} <- decode_action(plain),
         index_json = data.index || <<>>,
         :ok <- maybe_verify_index(validate?, index_json, rec.index.blob, key),
         {:ok, index} <- decode_index(index_json) do
      {:ok,
       %{
         key_id: key_id,
         operation: op,
         action: data.value,
         version: data.version,
         index: index,
         index_mac: rec.index.blob,
         value_mac: value_mac,
         patch_version: patch_version
       }}
    end
  end

  defp decode_action(plain) do
    {:ok, WAWebProtobufSyncAction.SyncActionData.decode(plain)}
  rescue
    e -> {:error, {:proto_decode, Exception.message(e)}}
  end

  defp maybe_verify_index(false, _json, _mac, _key), do: :ok
  defp maybe_verify_index(true, json, mac, key), do: Decode.verify_index_mac(json, mac, key)

  defp decode_index(json) do
    case Jason.decode(json) do
      {:ok, list} when is_list(list) -> {:ok, list}
      {:ok, _} -> {:error, :index_not_a_list}
      {:error, e} -> {:error, {:index_json, Exception.message(e)}}
    end
  end

  # --- Keys + store -----------------------------------------------------------

  defp keys_for(ctx, key_ids) do
    key_ids
    |> Enum.uniq()
    |> Enum.reduce_while({:ok, %{}}, fn id, {:ok, acc} ->
      case KeyStore.get_key(ctx.jid, id || <<>>, store: ctx.store) do
        {:ok, %{key_data: data}} -> {:cont, {:ok, Map.put(acc, id, Keys.expand(data))}}
        {:error, :key_not_found} -> {:halt, {:error, {:key_not_found, id}}}
        {:error, reason} -> {:halt, {:error, {:store, reason}}}
      end
    end)
  end

  defp store(ctx, name, state, removed, added, opts) do
    case ctx.store.store_patch(ctx.jid, name, state, removed, added, opts) do
      :ok -> :ok
      {:error, reason} -> {:error, {:store, reason}}
    end
  end

  # Go's getters: an unset enum is its zero value, SET.
  defp operation(:REMOVE), do: :remove
  defp operation(_), do: :set

  defp version_of(%WAServerSync.SyncdVersion{version: v}) when is_integer(v), do: v
  defp version_of(_), do: 0

  defp key_id_of(%WAServerSync.KeyId{ID: id}), do: id
  defp key_id_of(_), do: nil
end
