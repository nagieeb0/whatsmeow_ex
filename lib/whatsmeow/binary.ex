defmodule Whatsmeow.Binary do
  @moduledoc """
  WhatsApp binary-XML codec — encode/decode `%Whatsmeow.Binary.Node{}` trees.

  Used by the transport layer (`Whatsmeow.Transport.NoiseSocket`) to
  serialise IQ / message / receipt nodes.
  """

  alias Whatsmeow.Binary.{Decoder, Encoder, Node}

  @doc "Decode a binary-XML frame to a `Node`. See `Decoder`."
  @spec decode(binary()) :: {:ok, Node.t()} | {:error, atom()}
  defdelegate decode(bin), to: Decoder

  @doc "Decode without stripping the leading compression-flag byte."
  @spec decode(binary(), keyword()) :: {:ok, Node.t()} | {:error, atom()}
  defdelegate decode(bin, opts), to: Decoder

  @doc "Encode a `Node` to binary. See `Encoder`."
  @spec encode(Node.t()) :: binary()
  defdelegate encode(node), to: Encoder, as: :encode_binary

  @doc "Encode a `Node` to iodata."
  @spec encode_iodata(Node.t()) :: iodata()
  defdelegate encode_iodata(node), to: Encoder, as: :encode
end
