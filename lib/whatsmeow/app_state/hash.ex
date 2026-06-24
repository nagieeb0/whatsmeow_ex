defmodule Whatsmeow.AppState.Hash do
  @moduledoc """
  WhatsApp app-state collection hash state and MAC helpers.

  Ports `whatsmeow-main/appstate/hash.go`.

  A `HashState` is the running LTHash over all SET mutations applied to a
  collection plus the integer version. SET mutations append a 32-byte
  value-MAC; REMOVE mutations refer to a previously-stored value-MAC. The
  LTHash is pointwise-summed (or subtracted on remove) per mutation.

  Snapshot MAC =
    HMAC-SHA256(snapshot_mac_key, hash || u64_be(version) || patch_name)

  Patch MAC =
    HMAC-SHA256(patch_mac_key,
      snapshot_mac || value_mac_1 || ... || u64_be(version) || patch_name)

  Content MAC =
    HMAC-SHA512(value_mac_key, op_byte || key_id || ciphertext ||
                               u64_be(len(key_id) + 1))[0..32]

  where `op_byte = op + 1` (SET=2, REMOVE=3) following the upstream wire
  encoding.
  """

  alias Whatsmeow.AppState.LTHash

  @type t :: %__MODULE__{version: non_neg_integer(), hash: binary()}

  defstruct version: 0, hash: <<0::1024>>

  @doc "A fresh, zero-version hash with a zero 128-byte LTHash buffer."
  @spec new() :: t()
  def new, do: %__MODULE__{}

  @doc """
  Apply a list of mutations to a `HashState` and return the new state.

  `mutations` is a list of maps shaped like the decoded `SyncdMutation`
  protobuf:

      %{
        operation: :set | :remove,
        # last 32 bytes of the encrypted value blob (the value MAC).
        value_mac: <<...32 bytes...>>,
        # the HMAC over the JSON index, identifying which slot this is.
        index_mac: <<...32 bytes...>>
      }

  `prev_set_value_mac.(index_mac, i)` is invoked for every mutation (both
  SET and REMOVE) and must return the value MAC of the previous SET on
  that index (or `nil` if none / unknown). It receives the current
  mutation index `i` so the caller can look only at earlier entries.
  """
  @spec update(t(), [map()], (binary(), non_neg_integer() -> binary() | nil)) ::
          {:ok, t()} | {:error, term()}
  def update(%__MODULE__{hash: hash} = state, mutations, prev_set_value_mac)
      when is_list(mutations) and is_function(prev_set_value_mac, 2) do
    {added, removed, warnings} =
      mutations
      |> Enum.with_index()
      |> Enum.reduce({[], [], []}, fn {m, i}, {add, rem, warn} ->
        op = m[:operation]

        add =
          if op == :set do
            [m.value_mac | add]
          else
            add
          end

        case {prev_set_value_mac.(m.index_mac, i), op} do
          {nil, :remove} ->
            {add, rem, [{:missing_previous_set_value, m.index_mac} | warn]}

          {nil, _} ->
            {add, rem, warn}

          {prev, _} when is_binary(prev) ->
            {add, [prev | rem], warn}
        end
      end)

    new_hash = LTHash.subtract_then_add(hash, Enum.reverse(removed), Enum.reverse(added))
    {:ok, %__MODULE__{state | hash: new_hash}, Enum.reverse(warnings)}
  end

  @doc """
  Compute the snapshot MAC for the current state and patch name.
  """
  @spec snapshot_mac(t(), binary(), binary()) :: binary()
  def snapshot_mac(%__MODULE__{hash: hash, version: version}, name, key)
      when is_binary(name) and is_binary(key) and byte_size(key) == 32 do
    hmac_sha256(key, [hash, <<version::big-unsigned-64>>, name])
  end

  @doc """
  Compute the patch MAC over a list of value MACs, the version, and the
  patch name.

  `value_macs` should be in the same order as the mutations in the patch.
  `snapshot_mac` is the snapshot MAC already computed for the patch.
  """
  @spec patch_mac(binary(), [binary()], non_neg_integer(), binary(), binary()) :: binary()
  def patch_mac(snapshot_mac, value_macs, version, name, key)
      when is_binary(snapshot_mac) and is_list(value_macs) and is_binary(name) and
             is_binary(key) and byte_size(key) == 32 do
    hmac_sha256(key, [snapshot_mac | value_macs] ++ [<<version::big-unsigned-64>>, name])
  end

  @doc """
  Compute the content MAC for a mutation.

  `op` is `:set` or `:remove`. `data` is the encrypted mutation blob
  (IV || ciphertext, no trailing 32-byte MAC yet). The returned MAC is 32
  bytes, taken from the first 32 of HMAC-SHA512 output.
  """
  @spec content_mac(:set | :remove, binary(), binary(), binary()) :: binary()
  def content_mac(op, data, key_id, key)
      when op in [:set, :remove] and is_binary(data) and is_binary(key_id) and
             is_binary(key) and byte_size(key) == 32 do
    op_byte = if op == :set, do: 2, else: 3
    key_len = byte_size(key_id) + 1

    :crypto.mac(:hmac, :sha512, key, [
      <<op_byte>>,
      key_id,
      data,
      <<key_len::big-unsigned-64>>
    ])
    |> :binary.part(0, 32)
  end

  @doc """
  Compute the index MAC of a JSON-encoded mutation index.
  """
  @spec index_mac(binary(), binary()) :: binary()
  def index_mac(index_json, key)
      when is_binary(index_json) and is_binary(key) and byte_size(key) == 32 do
    hmac_sha256(key, [index_json])
  end

  defp hmac_sha256(key, iodata) when is_binary(key) do
    :crypto.mac(:hmac, :sha256, key, iodata)
  end
end
