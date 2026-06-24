defmodule Whatsmeow.Binary.Encoder do
  @moduledoc """
  Encode a `Whatsmeow.Binary.Node` tree to a WhatsApp binary-XML frame.

  Ports `whatsmeow-main/binary/encoder.go`. The output is the wire bytes
  with the 1-byte compression-flag prefix (currently always 0).
  """

  use Whatsmeow.Binary.Types

  alias Whatsmeow.Binary.{Node, Token}
  alias Whatsmeow.Types.JID

  @doc """
  Encode `node` to its wire representation as iodata. Use
  `:erlang.iolist_to_binary/1` if you need a flat binary.
  """
  @spec encode(Node.t()) :: iodata()
  def encode(%Node{} = node) do
    [0, encode_node(node)]
  end

  @doc "Encode a node to a flat binary."
  @spec encode_binary(Node.t()) :: binary()
  def encode_binary(%Node{} = node), do: IO.iodata_to_binary(encode(node))

  # ---- Node ----------------------------------------------------------------

  defp encode_node(%Node{tag: "0"}), do: [<<@list8>>, <<@list_empty>>]

  defp encode_node(%Node{tag: tag, attrs: attrs, content: content}) do
    has_content = if is_nil(content), do: 0, else: 1
    attr_count = count_attrs(attrs)

    [
      list_start(2 * attr_count + 1 + has_content),
      write_string(tag),
      write_attrs(attrs),
      if(has_content == 1, do: write_value(content), else: [])
    ]
  end

  defp write_attrs(attrs) when is_map(attrs) do
    attrs
    |> Enum.reject(fn {_k, v} -> v == "" or is_nil(v) end)
    |> Enum.map(fn {k, v} -> [write_string(k), write_value(v)] end)
  end

  defp count_attrs(attrs) when is_map(attrs) do
    Enum.count(attrs, fn {_k, v} -> v != "" and not is_nil(v) end)
  end

  # ---- Value dispatch ------------------------------------------------------

  defp write_value(nil), do: <<@list_empty>>
  defp write_value(%JID{} = jid), do: write_jid(jid)
  defp write_value(s) when is_binary(s), do: write_binary_or_string(s)
  defp write_value(i) when is_integer(i), do: write_string(Integer.to_string(i))
  defp write_value(b) when is_boolean(b), do: write_string(if(b, do: "true", else: "false"))

  defp write_value(list) when is_list(list) do
    if Enum.all?(list, &match?(%Node{}, &1)) do
      [list_start(length(list)) | Enum.map(list, &encode_node/1)]
    else
      raise ArgumentError, "list value must be a list of %Node{} — got: #{inspect(list)}"
    end
  end

  # ---- Strings -------------------------------------------------------------

  # A "string" attribute value: we try the single/double-byte token tables
  # first, then nibble/hex packing, then raw binary length-prefix encoding.
  defp write_binary_or_string(s) do
    case Token.single_index(s) do
      {:ok, idx} ->
        <<idx>>

      :error ->
        case Token.double_index(s) do
          {:ok, dict, idx} ->
            <<@dict0 + dict, idx>>

          :error ->
            cond do
              validate_nibble(s) -> pack(s, :nibble)
              validate_hex(s) -> pack(s, :hex)
              true -> write_string_raw(s)
            end
        end
    end
  end

  defp write_string(s) when is_binary(s), do: write_binary_or_string(s)

  defp write_string_raw(s) do
    [byte_length_prefix(byte_size(s)), s]
  end

  defp byte_length_prefix(len) when len < 256, do: [<<@binary8>>, <<len>>]

  defp byte_length_prefix(len) when len < 0x100000 do
    [
      <<@binary20>>,
      <<Bitwise.band(Bitwise.bsr(len, 16), 0x0F)>>,
      <<Bitwise.band(Bitwise.bsr(len, 8), 0xFF)>>,
      <<Bitwise.band(len, 0xFF)>>
    ]
  end

  defp byte_length_prefix(len) when len < 0x7FFFFFFF do
    [<<@binary32>>, <<len::big-unsigned-32>>]
  end

  defp byte_length_prefix(len), do: raise(ArgumentError, "string too long: #{len}")

  # ---- Lists ---------------------------------------------------------------

  defp list_start(0), do: <<@list_empty>>
  defp list_start(n) when n < 256, do: [<<@list8>>, <<n>>]
  defp list_start(n) when n < 65_536, do: [<<@list16>>, <<n::big-unsigned-16>>]

  # ---- JIDs ----------------------------------------------------------------

  defp write_jid(%JID{} = jid) do
    cond do
      (jid.server == JID.default_user_server() or jid.server == JID.hidden_user_server()) and
          jid.device > 0 ->
        ad_jid_bytes(jid)

      jid.server == JID.hosted_server() or jid.server == JID.hosted_lid_server() ->
        ad_jid_bytes(jid)

      jid.server == JID.messenger_server() ->
        [
          <<@fb_jid>>,
          write_value(jid.user),
          <<jid.device::big-unsigned-16>>,
          write_value(jid.server)
        ]

      jid.server == JID.interop_server() ->
        [
          <<@interop_jid>>,
          write_value(jid.user),
          <<jid.device::big-unsigned-16>>,
          <<jid.integrator::big-unsigned-16>>,
          write_value(jid.server)
        ]

      true ->
        user_bytes = if jid.user == "", do: <<@list_empty>>, else: write_value(jid.user)
        [<<@jid_pair>>, user_bytes, write_value(jid.server)]
    end
  end

  defp ad_jid_bytes(%JID{} = jid) do
    agent = JID.actual_agent(jid)
    [<<@ad_jid>>, <<agent>>, <<jid.device>>, write_string(jid.user)]
  end

  # ---- Packed nibble/hex ---------------------------------------------------

  defp pack(s, mode) do
    bytes = :erlang.binary_to_list(s)
    n = length(bytes)

    if n > @packed_max do
      raise ArgumentError, "too many bytes to pack: #{n}"
    end

    rounded = div(n + 1, 2)
    flag = if rem(n, 2) == 1, do: Bitwise.bor(rounded, 0x80), else: rounded

    tag_byte =
      case mode do
        :nibble -> @nibble8
        :hex -> @hex8
      end

    [<<tag_byte>>, <<flag>>, pack_pairs(bytes, mode, [])]
  end

  defp pack_pairs([a, b | rest], mode, acc) do
    pack_pairs(rest, mode, [pack_pair(a, b, mode) | acc])
  end

  defp pack_pairs([a], mode, acc) do
    Enum.reverse([pack_pair(a, 0, mode) | acc])
  end

  defp pack_pairs([], _mode, acc), do: Enum.reverse(acc)

  defp pack_pair(a, b, mode) do
    <<Bitwise.bor(Bitwise.bsl(pack_byte(a, mode), 4), pack_byte(b, mode))>>
  end

  defp pack_byte(?-, :nibble), do: 10
  defp pack_byte(?., :nibble), do: 11
  defp pack_byte(0, :nibble), do: 15
  defp pack_byte(c, :nibble) when c >= ?0 and c <= ?9, do: c - ?0

  defp pack_byte(c, :hex) when c >= ?0 and c <= ?9, do: c - ?0
  defp pack_byte(c, :hex) when c >= ?A and c <= ?F, do: 10 + c - ?A
  defp pack_byte(0, :hex), do: 15

  defp validate_nibble(""), do: false

  defp validate_nibble(s) do
    byte_size(s) <= @packed_max and
      :erlang.binary_to_list(s)
      |> Enum.all?(fn c -> (c >= ?0 and c <= ?9) or c == ?- or c == ?. end)
  end

  defp validate_hex(""), do: false

  defp validate_hex(s) do
    byte_size(s) <= @packed_max and
      :erlang.binary_to_list(s)
      |> Enum.all?(fn c -> (c >= ?0 and c <= ?9) or (c >= ?A and c <= ?F) end)
  end
end
