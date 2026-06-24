defmodule Whatsmeow.PreKeyBundle do
  @moduledoc """
  Parsed response to a `<iq xmlns="encrypt" type="get">` PreKey bundle
  fetch — everything needed to seed an X3DH initiation against a peer
  we've never messaged before.

  Mirrors libsignal's `prekey.Bundle` shape and Go's
  `nodeToPreKeyBundle` in `whatsmeow-main/prekeys.go`.

  Server response shape (one `<user>` per peer):

      <iq xmlns="encrypt" type="result">
        <list>
          <user jid="…">
            <registration>...4 bytes BE...</registration>
            <identity>...32 bytes...</identity>
            <key>                          (optional — one-time pre-key)
              <id>...3 bytes BE...</id>
              <value>...32 bytes...</value>
            </key>
            <skey>                         (signed pre-key)
              <id>...3 bytes BE...</id>
              <value>...32 bytes...</value>
              <signature>...64 bytes...</signature>
            </skey>
          </user>
          ...
        </list>
      </iq>

  Some responses wrap the keys inside a `<keys>` child of `<user>`;
  `from_user_node/1` tolerates both.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Types.JID

  defstruct [
    :jid,
    :device_id,
    :registration_id,
    :identity_pub,
    :pre_key_id,
    :pre_key_pub,
    :signed_pre_key_id,
    :signed_pre_key_pub,
    :signed_pre_key_sig
  ]

  @type t :: %__MODULE__{
          jid: JID.t() | nil,
          device_id: non_neg_integer(),
          registration_id: non_neg_integer(),
          identity_pub: <<_::256>>,
          pre_key_id: non_neg_integer() | nil,
          pre_key_pub: <<_::256>> | nil,
          signed_pre_key_id: non_neg_integer(),
          signed_pre_key_pub: <<_::256>>,
          signed_pre_key_sig: <<_::512>>
        }

  @typedoc "Failure modes for `from_user_node/1`."
  @type error ::
          :missing_registration
          | :missing_identity
          | :missing_signed_pre_key
          | :missing_id_in_key
          | :missing_value_in_key
          | :missing_signature
          | :invalid_byte_length
          | {:server_error, String.t() | nil}

  @doc """
  Parse a top-level `<iq type="result">` response into a list of
  `%PreKeyBundle{}` (one per peer the request asked for).

  Returns `{:ok, [%PreKeyBundle{} | error tuple]}` — the outer ok wraps
  the whole IQ; per-user failures are kept inline so partial successes
  are usable.
  """
  @spec from_iq_response(Node.t()) :: {:ok, [{JID.t() | nil, t() | {:error, error()}}]}
  def from_iq_response(%Node{tag: "iq"} = iq) do
    list = Node.get_child(iq, "list")

    users =
      if list, do: Node.get_children(list, "user"), else: []

    pairs =
      Enum.map(users, fn user ->
        jid = jid_attr(user)
        result = from_user_node(user)
        {jid, result}
      end)

    {:ok,
     Enum.map(pairs, fn
       {jid, {:ok, bundle}} -> {jid, %{bundle | jid: jid}}
       {jid, {:error, _} = err} -> {jid, err}
     end)}
  end

  @doc """
  Parse a single `<user>` node into a `%PreKeyBundle{}`.

  Returns `{:error, {:server_error, msg}}` if the node contains a
  `<error>` child — the server returns this when a JID has no published
  bundle (the peer hasn't completed pre-key upload yet, for instance).
  """
  @spec from_user_node(Node.t()) :: {:ok, t()} | {:error, error()}
  def from_user_node(%Node{tag: "user"} = node) do
    case Node.get_child(node, "error") do
      %Node{} = err ->
        msg = Node.attr(err, "text") || Node.attr(err, "code")
        {:error, {:server_error, msg}}

      _ ->
        # Some responses wrap the keys in <keys>; flatten.
        keys_node = Node.get_child(node, "keys") || node
        device_id = device_id_from_jid(jid_attr(node))

        with {:ok, reg} <- get_registration(node),
             {:ok, identity} <- get_identity(keys_node),
             {:ok, skey_id, skey_pub, skey_sig} <- parse_signed_pre_key(keys_node),
             {pre_id, pre_pub} <- parse_optional_pre_key(keys_node) do
          {:ok,
           %__MODULE__{
             device_id: device_id,
             registration_id: reg,
             identity_pub: identity,
             pre_key_id: pre_id,
             pre_key_pub: pre_pub,
             signed_pre_key_id: skey_id,
             signed_pre_key_pub: skey_pub,
             signed_pre_key_sig: skey_sig
           }}
        end
    end
  end

  def from_user_node(%Node{}), do: {:error, :missing_signed_pre_key}

  # --- internals ----------------------------------------------------------

  defp get_registration(node) do
    case Node.get_child(node, "registration") do
      %Node{content: <<reg::big-unsigned-32>>} -> {:ok, reg}
      _ -> {:error, :missing_registration}
    end
  end

  defp get_identity(node) do
    case Node.get_child(node, "identity") do
      %Node{content: <<bytes::binary-size(32)>>} -> {:ok, bytes}
      _ -> {:error, :missing_identity}
    end
  end

  defp parse_signed_pre_key(node) do
    case Node.get_child(node, "skey") do
      %Node{} = skey ->
        with {:ok, id} <- parse_key_id(skey),
             {:ok, pub} <- parse_key_value(skey),
             {:ok, sig} <- parse_signature(skey) do
          {:ok, id, pub, sig}
        end

      _ ->
        {:error, :missing_signed_pre_key}
    end
  end

  defp parse_optional_pre_key(node) do
    case Node.get_child(node, "key") do
      %Node{} = key ->
        with {:ok, id} <- parse_key_id(key),
             {:ok, pub} <- parse_key_value(key) do
          {id, pub}
        else
          _ -> {nil, nil}
        end

      _ ->
        {nil, nil}
    end
  end

  # Go encodes the key id as a 3-byte big-endian uint24 inside a 4-byte uint32.
  defp parse_key_id(node) do
    case Node.get_child(node, "id") do
      %Node{content: <<id::big-unsigned-24>>} -> {:ok, id}
      _ -> {:error, :missing_id_in_key}
    end
  end

  defp parse_key_value(node) do
    case Node.get_child(node, "value") do
      %Node{content: <<bytes::binary-size(32)>>} -> {:ok, bytes}
      _ -> {:error, :missing_value_in_key}
    end
  end

  defp parse_signature(node) do
    case Node.get_child(node, "signature") do
      %Node{content: <<bytes::binary-size(64)>>} -> {:ok, bytes}
      _ -> {:error, :missing_signature}
    end
  end

  defp jid_attr(%Node{} = node) do
    case Node.attr(node, "jid") do
      %JID{} = j ->
        j

      bin when is_binary(bin) ->
        JID.parse(bin)
        |> case do
          {:ok, j} -> j
          _ -> nil
        end

      _ ->
        nil
    end
  end

  defp device_id_from_jid(%JID{device: d}) when is_integer(d), do: d
  defp device_id_from_jid(_), do: 0
end
