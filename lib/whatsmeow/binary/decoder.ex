defmodule Whatsmeow.Binary.Decoder do
  @moduledoc """
  Decode a WhatsApp binary-XML frame to a `Whatsmeow.Binary.Node` tree.

  Ports `whatsmeow-main/binary/decoder.go`. Pure functional — operates on
  binaries, never raises on bad input (returns `{:error, reason}`).
  """

  use Whatsmeow.Binary.Types

  alias Whatsmeow.Binary.{Node, Token}
  alias Whatsmeow.Types.JID

  @typedoc "Decoded value of a binary-XML element."
  @type value :: nil | binary() | String.t() | JID.t() | [Node.t()]

  @doc """
  Decode a single root node from a frame.

  The first byte is a "compression" flag (currently always 0 — the upstream
  Go reader strips it before calling the decoder). If `strip_flag?` is
  true, the leading byte is dropped.
  """
  @spec decode(binary(), keyword()) :: {:ok, Node.t()} | {:error, atom()}
  def decode(data, opts \\ []) when is_binary(data) do
    bin = if Keyword.get(opts, :strip_flag?, true), do: drop_flag(data), else: data

    case read_node(bin) do
      {:ok, %Node{} = node, _rest} -> {:ok, node}
      {:error, _} = e -> e
    end
  end

  defp drop_flag(<<_flag, rest::binary>>), do: rest
  defp drop_flag(<<>>), do: <<>>

  @doc false
  def read_node(bin) do
    with {:ok, size, bin} <- read_int_be(bin, 1),
         {:ok, list_size, bin} <- read_list_size(size, bin),
         {:ok, raw_tag, bin} <- read_value(bin, true) do
      cond do
        list_size == 0 ->
          {:error, :invalid_node}

        not is_binary(raw_tag) or raw_tag == "" ->
          {:error, :invalid_node}

        true ->
          attr_count = div(list_size - 1, 2)

          with {:ok, attrs, bin} <- read_attributes(bin, attr_count) do
            if rem(list_size, 2) == 1 do
              {:ok, %Node{tag: raw_tag, attrs: attrs, content: nil}, bin}
            else
              with {:ok, content, bin} <- read_value(bin, false) do
                {:ok, %Node{tag: raw_tag, attrs: attrs, content: content}, bin}
              end
            end
          end
      end
    end
  end

  # ---- Tag dispatch --------------------------------------------------------

  @doc false
  def read_value(<<>>, _as_string?), do: {:error, :eof}

  def read_value(<<tag, _rest::binary>> = bin, as_string?) do
    <<_, after_tag::binary>> = bin
    dispatch(tag, after_tag, as_string?)
  end

  defp dispatch(@list_empty, rest, _as_string?), do: {:ok, nil, rest}

  defp dispatch(tag, rest, _as_string?) when tag in [@list8, @list16] do
    case read_list_size(tag, rest) do
      {:ok, size, rest} -> read_list_n(rest, size, [])
      err -> err
    end
  end

  defp dispatch(@binary8, rest, as_string?) do
    with {:ok, size, rest} <- read_int_be(rest, 1),
         {:ok, data, rest} <- read_raw(rest, size) do
      {:ok, bin_or_string(data, as_string?), rest}
    end
  end

  defp dispatch(@binary20, rest, as_string?) do
    case rest do
      <<a, b, c, after_size::binary>> ->
        size = Bitwise.bsl(Bitwise.band(a, 0x0F), 16) + Bitwise.bsl(b, 8) + c

        case read_raw(after_size, size) do
          {:ok, data, rest} -> {:ok, bin_or_string(data, as_string?), rest}
          err -> err
        end

      _ ->
        {:error, :eof}
    end
  end

  defp dispatch(@binary32, rest, as_string?) do
    with {:ok, size, rest} <- read_int_be(rest, 4),
         {:ok, data, rest} <- read_raw(rest, size) do
      {:ok, bin_or_string(data, as_string?), rest}
    end
  end

  defp dispatch(tag, rest, _as_string?) when tag in [@dict0, @dict1, @dict2, @dict3] do
    case rest do
      <<i, rest::binary>> ->
        case Token.at_double(tag - @dict0, i) do
          {:ok, str} -> {:ok, str, rest}
          :error -> {:error, :invalid_dictionary_index}
        end

      _ ->
        {:error, :eof}
    end
  end

  defp dispatch(@jid_pair, rest, _as_string?), do: read_jid_pair(rest)
  defp dispatch(@ad_jid, rest, _as_string?), do: read_ad_jid(rest)
  defp dispatch(@fb_jid, rest, _as_string?), do: read_fb_jid(rest)
  defp dispatch(@interop_jid, rest, _as_string?), do: read_interop_jid(rest)
  defp dispatch(@nibble8, rest, _as_string?), do: read_packed(rest, :nibble)
  defp dispatch(@hex8, rest, _as_string?), do: read_packed(rest, :hex)

  defp dispatch(tag, rest, _as_string?) when tag >= 1 and tag < 236 do
    case Token.at_single(tag) do
      {:ok, str} -> {:ok, str, rest}
      :error -> {:error, :invalid_token}
    end
  end

  defp dispatch(_tag, _rest, _as_string?), do: {:error, :invalid_token}

  # ---- Lists ---------------------------------------------------------------

  defp read_list_size(@list_empty, bin), do: {:ok, 0, bin}
  defp read_list_size(@list8, bin), do: read_int_be(bin, 1)
  defp read_list_size(@list16, bin), do: read_int_be(bin, 2)
  defp read_list_size(_tag, _bin), do: {:error, :invalid_list_tag}

  defp read_list_n(bin, 0, acc), do: {:ok, Enum.reverse(acc), bin}

  defp read_list_n(bin, n, acc) when n > 0 do
    case read_node(bin) do
      {:ok, node, rest} -> read_list_n(rest, n - 1, [node | acc])
      err -> err
    end
  end

  # ---- Attributes ----------------------------------------------------------

  defp read_attributes(bin, 0), do: {:ok, %{}, bin}

  defp read_attributes(bin, n) when n > 0 do
    Enum.reduce_while(1..n, {:ok, %{}, bin}, fn _, {:ok, acc, bin} ->
      case read_value(bin, true) do
        {:ok, key, bin} when is_binary(key) ->
          case read_value(bin, true) do
            {:ok, val, bin} -> {:cont, {:ok, Map.put(acc, key, val), bin}}
            err -> {:halt, err}
          end

        {:ok, _non_string, _bin} ->
          {:halt, {:error, :non_string_attr_key}}

        err ->
          {:halt, err}
      end
    end)
  end

  # ---- JIDs ----------------------------------------------------------------

  defp read_jid_pair(bin) do
    with {:ok, user, bin} <- read_value(bin, true),
         {:ok, server, bin} <- read_value(bin, true) do
      cond do
        server == nil ->
          {:error, :invalid_jid_type}

        user == nil ->
          {:ok, %JID{user: "", server: to_string_if_bin(server)}, bin}

        true ->
          {:ok, %JID{user: to_string_if_bin(user), server: to_string_if_bin(server)}, bin}
      end
    end
  end

  defp read_ad_jid(<<agent, device, rest::binary>>) do
    with {:ok, user, rest} <- read_value(rest, true) do
      {:ok, JID.new_ad(to_string_if_bin(user), agent, device), rest}
    end
  end

  defp read_ad_jid(_), do: {:error, :eof}

  defp read_fb_jid(bin) do
    with {:ok, user, bin} <- read_value(bin, true),
         {:ok, device, bin} <- read_int_be(bin, 2),
         {:ok, server, bin} <- read_value(bin, true) do
      if server == JID.messenger_server() do
        {:ok,
         %JID{
           user: to_string_if_bin(user),
           device: device,
           server: JID.messenger_server()
         }, bin}
      else
        {:error, :invalid_jid_type}
      end
    end
  end

  defp read_interop_jid(bin) do
    with {:ok, user, bin} <- read_value(bin, true),
         {:ok, device, bin} <- read_int_be(bin, 2),
         {:ok, integrator, bin} <- read_int_be(bin, 2),
         {:ok, server, bin} <- read_value(bin, true) do
      if server == JID.interop_server() do
        {:ok,
         %JID{
           user: to_string_if_bin(user),
           device: device,
           integrator: integrator,
           server: JID.interop_server()
         }, bin}
      else
        {:error, :invalid_jid_type}
      end
    end
  end

  # ---- Packed nibble/hex ---------------------------------------------------

  defp read_packed(<<start, rest::binary>>, mode) do
    n_pairs = Bitwise.band(start, 0x7F)
    has_trailing? = Bitwise.bsr(start, 7) == 1

    case read_raw(rest, n_pairs) do
      {:ok, data, rest} ->
        case unpack_pairs(data, mode, []) do
          {:ok, str} ->
            str =
              if has_trailing? and byte_size(str) > 0,
                do: binary_part(str, 0, byte_size(str) - 1),
                else: str

            {:ok, str, rest}

          err ->
            err
        end

      err ->
        err
    end
  end

  defp read_packed(_, _), do: {:error, :eof}

  defp unpack_pairs(<<>>, _mode, acc), do: {:ok, IO.iodata_to_binary(Enum.reverse(acc))}

  defp unpack_pairs(<<b, rest::binary>>, mode, acc) do
    upper = Bitwise.bsr(Bitwise.band(b, 0xF0), 4)
    lower = Bitwise.band(b, 0x0F)

    with {:ok, hi} <- unpack_byte(mode, upper),
         {:ok, lo} <- unpack_byte(mode, lower) do
      unpack_pairs(rest, mode, [<<hi, lo>> | acc])
    end
  end

  defp unpack_byte(:nibble, v) when v < 10, do: {:ok, ?0 + v}
  defp unpack_byte(:nibble, 10), do: {:ok, ?-}
  defp unpack_byte(:nibble, 11), do: {:ok, ?.}
  defp unpack_byte(:nibble, 15), do: {:ok, 0}
  defp unpack_byte(:nibble, _), do: {:error, :invalid_nibble}

  defp unpack_byte(:hex, v) when v < 10, do: {:ok, ?0 + v}
  defp unpack_byte(:hex, v) when v < 16, do: {:ok, ?A + v - 10}
  defp unpack_byte(:hex, _), do: {:error, :invalid_hex}

  # ---- Low-level readers ---------------------------------------------------

  defp read_int_be(bin, n) when byte_size(bin) >= n do
    <<value::big-unsigned-size(^n)-unit(8), rest::binary>> = bin
    {:ok, value, rest}
  end

  defp read_int_be(_bin, _n), do: {:error, :eof}

  defp read_raw(bin, n) when byte_size(bin) >= n do
    <<data::binary-size(^n), rest::binary>> = bin
    {:ok, data, rest}
  end

  defp read_raw(_bin, _n), do: {:error, :eof}

  defp bin_or_string(data, true), do: data
  defp bin_or_string(data, false), do: data

  defp to_string_if_bin(s) when is_binary(s), do: s
  defp to_string_if_bin(nil), do: ""
end
