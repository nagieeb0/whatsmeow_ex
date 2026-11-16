defmodule Whatsmeow.AppState.Processor do
  @moduledoc """
  Applies and builds app-state patches against persisted state.

  Ports `appstate.Processor` — `DecodePatches`, `decodeSnapshot`, `validatePatch`,
  `EncodePatch`, `GetMissingKeyIDs` — from `whatsmeow-main/appstate/{keys,decode,encode}.go`.

  A processor is just `our_jid` plus the store module; it holds no state of its
  own, so it is cheap to build per call. Serialising callers per device is the
  `Whatsmeow.AppState.Coordinator`'s job.

  ## What is verified, and when

  For a **snapshot**: the LTHash over all its records must reproduce the
  snapshot MAC, then every record's content MAC and index MAC.

  For each **patch**: the LTHash after applying it must reproduce the snapshot
  MAC it carries, its patch MAC must match, then each mutation's content and
  index MACs. Each patch that passes is persisted (version, hash, MACs) *before*
  the next one is looked at, so a failure partway leaves the collection at the
  last good version — never half a patch.

  Nothing is ever applied with `validate_macs: false` on the live path; the flag
  exists because Go has it.
  """

  require Logger

  alias Whatsmeow.AppState.{Decode, Encode, Hash, Keys, Mutation, Patch, PatchList, Store}

  alias WAServerSync.{SyncdMutation, SyncdPatch, SyncdRecord, SyncdSnapshot}

  @enforce_keys [:our_jid, :store]
  defstruct [:our_jid, :store]

  @type t :: %__MODULE__{our_jid: String.t(), store: module()}

  @spec new(String.t(), keyword()) :: t()
  def new(our_jid, opts \\ []) when is_binary(our_jid) do
    %__MODULE__{
      our_jid: our_jid,
      store: Keyword.get(opts, :store) || Store.impl()
    }
  end

  # --- keys -------------------------------------------------------------------

  @doc "Expanded keys for each id; `{:error, {:key_not_found, id}}` for the first unknown one."
  @spec resolve_keys(t(), [binary()]) :: {:ok, Decode.expanded_keys()} | {:error, term()}
  def resolve_keys(%__MODULE__{} = p, key_ids) do
    key_ids
    |> Enum.uniq()
    |> Enum.reduce_while({:ok, %{}}, fn id, {:ok, acc} ->
      case p.store.get_key(p.our_jid, id) do
        {:ok, %{data: data}} -> {:cont, {:ok, Map.put(acc, id, Keys.expand(data))}}
        :not_found -> {:halt, {:error, {:key_not_found, id}}}
        {:error, reason} -> {:halt, {:error, {:store, reason}}}
      end
    end)
  end

  @doc """
  The newest sync key, with its expanded form — the one new patches are
  encrypted under. `{:error, :no_app_state_keys}` when the phone never shared one
  (Go: "no app state keys found, creating app state keys is not yet supported").
  """
  @spec latest_key(t()) :: {:ok, binary(), Keys.expanded()} | {:error, term()}
  def latest_key(%__MODULE__{} = p) do
    case p.store.latest_key_id(p.our_jid) do
      {:ok, key_id} ->
        with {:ok, keys} <- resolve_keys(p, [key_id]), do: {:ok, key_id, Map.fetch!(keys, key_id)}

      :none ->
        {:error, :no_app_state_keys}

      {:error, reason} ->
        {:error, {:store, reason}}
    end
  end

  @doc """
  Key ids this patch list needs and we do not have. Go: `GetMissingKeyIDs`.

  Looks at the snapshot's key and its records' keys, and each patch's own key. A
  store *error* is logged and treated as "not missing" — asking the phone for a
  key we may merely have failed to read would just be noise.
  """
  @spec missing_key_ids(t(), PatchList.t()) :: [binary()]
  def missing_key_ids(%__MODULE__{} = p, %PatchList{} = pl) do
    snapshot_ids =
      case pl.snapshot do
        %SyncdSnapshot{} = s -> [key_id_of(s.keyID) | Enum.map(s.records, &key_id_of(&1.keyID))]
        _ -> []
      end

    (snapshot_ids ++ Enum.map(pl.patches, &key_id_of(&1.keyID)))
    |> Enum.reject(&is_nil/1)
    |> Enum.uniq()
    |> Enum.filter(fn id ->
      case p.store.get_key(p.our_jid, id) do
        :not_found ->
          true

        {:ok, _} ->
          false

        {:error, reason} ->
          Logger.warning(
            "[whatsmeow] app-state: could not check key #{Base.encode16(id)}: #{inspect(reason)}"
          )

          false
      end
    end)
  end

  # --- decode -----------------------------------------------------------------

  @doc """
  Decode every snapshot and patch in `list`, advancing `state`. Go: `DecodePatches`.

  Returns `{:ok, mutations, final_state}`. Mutations come back in wire order,
  snapshot first.
  """
  @spec decode_patches(t(), PatchList.t(), Hash.t(), boolean()) ::
          {:ok, [Mutation.t()], Hash.t()} | {:error, term()}
  def decode_patches(%__MODULE__{} = p, %PatchList{} = list, %Hash{} = state, validate_macs) do
    with {:ok, muts, state} <- decode_snapshot_step(p, list, state, validate_macs) do
      decode_patch_steps(p, list, list.patches, state, validate_macs, muts)
    end
  end

  defp decode_snapshot_step(_p, %PatchList{snapshot: nil}, state, _validate), do: {:ok, [], state}

  defp decode_snapshot_step(
         p,
         %PatchList{name: name, snapshot: %SyncdSnapshot{} = ss},
         state,
         validate
       ),
       do: decode_snapshot(p, name, ss, state, validate)

  defp decode_patch_steps(_p, _list, [], state, _validate, acc), do: {:ok, acc, state}

  defp decode_patch_steps(p, list, [%SyncdPatch{} = patch | rest], state, validate, acc) do
    with {:ok, new_state, warnings} <- validate_patch(p, list.name, patch, state, validate),
         _ = log_warnings(list.name, warnings),
         {:ok, out} <- decode_patch_mutations(p, patch, new_state.version, validate),
         :ok <- store_state(p, list.name, new_state, out) do
      decode_patch_steps(p, list, rest, new_state, validate, acc ++ out.mutations)
    end
  end

  # Go: decodeSnapshot
  defp decode_snapshot(p, name, %SyncdSnapshot{} = ss, initial, validate) do
    version = (ss.version && ss.version.version) || 0
    current = %{initial | version: version}

    mutations =
      Enum.map(ss.records, fn %SyncdRecord{} = r -> %SyncdMutation{operation: :SET, record: r} end)

    snapshot_key_id = key_id_of(ss.keyID)

    key_ids =
      [snapshot_key_id | Enum.map(ss.records, &key_id_of(&1.keyID))] |> Enum.reject(&is_nil/1)

    with {:ok, inputs} <- hash_inputs(mutations),
         # No previous SETs: a snapshot is the whole collection, not a delta.
         {:ok, hashed, warnings} <- Hash.update(current, inputs, fn _index_mac, _i -> nil end),
         {:ok, keys} <- resolve_keys(p, key_ids),
         :ok <- verify_snapshot(validate, hashed, name, keys, snapshot_key_id, ss.mac, warnings),
         {:ok, out} <- decode_mutations(mutations, keys, validate, hashed.version),
         :ok <- store_state(p, name, hashed, out) do
      {:ok, out.mutations, hashed}
    else
      {:error, _} = err -> err
    end
  end

  defp verify_snapshot(false, _state, _name, _keys, _kid, _mac, _warnings), do: :ok

  defp verify_snapshot(true, state, name, keys, key_id, expected_mac, warnings) do
    case keys[key_id] do
      nil ->
        {:error, {:key_not_found, key_id || <<>>}}

      %{snapshot_mac: key} ->
        case Decode.verify_snapshot_mac(state, name, key, expected_mac || <<>>) do
          :ok ->
            :ok

          {:error, _} = err ->
            log_warnings(name, warnings)
            err
        end
    end
  end

  # Go: validatePatch
  defp validate_patch(p, name, %SyncdPatch{} = patch, current, validate) do
    version = (patch.version && patch.version.version) || 0
    new_state = %{current | version: version}
    patch_key_id = key_id_of(patch.keyID)

    with {:ok, inputs} <- hash_inputs(patch.mutations),
         {:ok, hashed, warnings} <-
           Hash.update(new_state, inputs, prev_mac_fun(p, name, inputs)),
         {:ok, keys} <- maybe_resolve_patch_key(p, validate, patch_key_id),
         :ok <- verify_patch(validate, hashed, name, patch, keys, patch_key_id, version, inputs) do
      {:ok, hashed, warnings}
    end
  end

  defp maybe_resolve_patch_key(_p, false, _key_id), do: {:ok, %{}}
  defp maybe_resolve_patch_key(_p, true, nil), do: {:error, {:key_not_found, <<>>}}
  defp maybe_resolve_patch_key(p, true, key_id), do: resolve_keys(p, [key_id])

  defp verify_patch(false, _s, _n, _patch, _k, _kid, _v, _inputs), do: :ok

  defp verify_patch(true, state, name, patch, keys, key_id, version, inputs) do
    k = keys[key_id]

    snapshot_mac = patch.snapshotMAC || <<>>

    with :ok <- Decode.verify_snapshot_mac(state, name, k.snapshot_mac, snapshot_mac) do
      Decode.verify_patch_mac(
        snapshot_mac,
        Enum.map(inputs, & &1.value_mac),
        version,
        name,
        k.patch_mac,
        patch.patchMAC || <<>>
      )
    end
  end

  # The previous value MAC for a mutation's index: the nearest *earlier mutation
  # in this same patch* wins (a REMOVE there means "no previous value"); only
  # when the patch has no earlier mention do we ask the store.
  defp prev_mac_fun(p, name, inputs) do
    by_index =
      inputs
      |> Enum.with_index()
      |> Enum.group_by(fn {m, _i} -> m.index_mac end, fn {m, i} -> {i, m} end)

    fn index_mac, max_index ->
      earlier =
        by_index
        |> Map.get(index_mac, [])
        |> Enum.filter(fn {i, _m} -> i < max_index end)
        |> Enum.max_by(fn {i, _m} -> i end, fn -> nil end)

      case earlier do
        {_i, %{operation: :set, value_mac: mac}} -> mac
        {_i, %{operation: :remove}} -> nil
        nil -> store_prev_mac(p, name, index_mac)
      end
    end
  end

  defp store_prev_mac(p, name, index_mac) do
    case p.store.get_mutation_mac(p.our_jid, name, index_mac) do
      {:ok, mac} -> mac
      :not_found -> nil
      {:error, reason} -> {:error, reason}
    end
  end

  # SyncdMutation protos -> the maps `Hash.update/3` takes. A value blob shorter
  # than a MAC is malformed input; Go would slice out of bounds.
  defp hash_inputs(mutations) do
    mutations
    |> Enum.with_index(1)
    |> Enum.reduce_while({:ok, []}, fn {%SyncdMutation{} = m, n}, {:ok, acc} ->
      blob = (m.record && m.record.value && m.record.value.blob) || <<>>
      index_mac = (m.record && m.record.index && m.record.index.blob) || <<>>

      if byte_size(blob) >= 32 do
        size = byte_size(blob) - 32
        <<_::binary-size(^size), value_mac::binary-size(32)>> = blob
        op = Decode.operation(m.operation)
        {:cont, {:ok, [%{operation: op, value_mac: value_mac, index_mac: index_mac} | acc]}}
      else
        {:halt, {:error, {:invalid_value_blob, {n, byte_size(blob)}}}}
      end
    end)
    |> case do
      {:ok, list} -> {:ok, Enum.reverse(list)}
      err -> err
    end
  end

  defp decode_patch_mutations(p, %SyncdPatch{} = patch, version, validate) do
    key_ids = Enum.map(patch.mutations, &mutation_key_id/1)

    with {:ok, keys} <- resolve_keys(p, key_ids) do
      decode_mutations(patch.mutations, keys, validate, version)
    end
  end

  defp mutation_key_id(%SyncdMutation{record: %SyncdRecord{keyID: %{ID: id}}}), do: id
  defp mutation_key_id(_), do: <<>>

  # Go: decodeMutations + patchOutput
  defp decode_mutations(mutations, keys, validate, patch_version) do
    mutations
    |> Enum.with_index()
    |> Enum.reduce_while({:ok, %{removed: [], added: [], mutations: []}}, fn {m, i}, {:ok, out} ->
      case Decode.decode_mutation(m, i, keys, validate) do
        {:ok, d} ->
          {:cont, {:ok, record(out, d, patch_version)}}

        {:error, _} = err ->
          {:halt, err}
      end
    end)
    |> case do
      {:ok, out} ->
        {:ok,
         %{
           out
           | mutations: Enum.reverse(out.mutations),
             added: Enum.reverse(out.added),
             removed: Enum.reverse(out.removed)
         }}

      err ->
        err
    end
  end

  defp record(out, d, patch_version) do
    out =
      case d.operation do
        # patchOutput.RemoveMAC: also forget a SET of the same index made earlier
        # in this very patch.
        :remove ->
          %{
            out
            | removed: [d.index_mac | out.removed],
              added: Enum.reject(out.added, fn {i, _} -> i == d.index_mac end)
          }

        :set ->
          %{out | added: [{d.index_mac, d.value_mac} | out.added]}
      end

    mutation = %Mutation{
      key_id: d.key_id,
      operation: d.operation,
      action: d.sync_action.value,
      version: d.sync_action.version,
      index: d.index,
      index_mac: d.index_mac,
      value_mac: d.value_mac,
      patch_version: patch_version
    }

    %{out | mutations: [mutation | out.mutations]}
  end

  # Go: storeMACs, but one atomic write (see `Whatsmeow.AppState.Store`).
  defp store_state(p, name, %Hash{} = state, out) do
    case p.store.apply_patch_state(
           p.our_jid,
           name,
           state.version,
           state.hash,
           out.removed,
           out.added
         ) do
      :ok -> :ok
      {:error, reason} -> {:error, {:store, reason}}
    end
  end

  # --- encode -----------------------------------------------------------------

  @doc """
  Encode `patch` on top of `state` under the latest key. Go: `EncodePatch`.

  Returns the `Encode.result/0`; nothing is persisted — the new state is only
  real once the server accepts the patch and we re-read it.
  """
  @spec encode_patch(t(), Patch.t(), Hash.t()) :: {:ok, Encode.result()} | {:error, term()}
  def encode_patch(%__MODULE__{} = p, %Patch{} = patch, %Hash{} = state) do
    with {:ok, key_id, keys} <- latest_key(p),
         {:ok, result} <-
           Encode.encode_patch(patch, key_id, keys, state, fn index_mac, _i ->
             store_prev_mac(p, patch.type, index_mac)
           end) do
      log_warnings(patch.type, result.warnings)
      {:ok, result}
    end
  end

  @doc """
  Decode and fully verify an *encoded* patch without persisting anything.

  Used as a pre-send self-check: the patch bytes `encode_patch/3` produced are
  stamped with `version` (what the server will assign) and run through the same
  verification the phone will apply — snapshot MAC, patch MAC, every mutation's
  content and index MAC. The server cannot do this check for us: it never holds
  the keys, so it will accept and forward a patch whose MACs are wrong, and it is
  then the phone that rejects it.
  """
  @spec dry_decode(t(), String.t(), binary(), non_neg_integer(), Hash.t()) ::
          {:ok, [Mutation.t()], Hash.t()} | {:error, term()}
  def dry_decode(%__MODULE__{} = p, name, bytes, version, %Hash{} = state) do
    patch = SyncdPatch.decode(bytes)
    patch = %{patch | version: %WAServerSync.SyncdVersion{version: version}}

    with {:ok, new_state, _warnings} <- validate_patch(p, name, patch, state, true),
         {:ok, out} <- decode_patch_mutations(p, patch, new_state.version, true) do
      {:ok, out.mutations, new_state}
    end
  rescue
    e -> {:error, {:invalid_sync_action, Exception.message(e)}}
  end

  # --- helpers ----------------------------------------------------------------

  defp key_id_of(%{ID: id}) when is_binary(id), do: id
  defp key_id_of(_), do: nil

  defp log_warnings(_name, []), do: :ok

  defp log_warnings(name, warnings) do
    Logger.warning(
      "[whatsmeow] app-state: warnings while updating hash for #{name}: #{inspect(warnings)}"
    )
  end
end
