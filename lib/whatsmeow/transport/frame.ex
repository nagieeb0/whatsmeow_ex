defmodule Whatsmeow.Transport.Frame do
  @moduledoc """
  3-byte big-endian length-prefix framing used by WhatsApp on top of the
  WebSocket transport.

  Ports the framing logic in `whatsmeow-main/socket/framesocket.go`. Pure
  helpers — the live socket layer is in `Whatsmeow.Transport.WebSocket`.
  """

  alias Whatsmeow.Transport.Constants

  @max_size Constants.frame_max_size()

  @doc """
  Wrap `payload` in a 3-byte big-endian length prefix. Raises if the payload
  exceeds the 16 MiB frame limit.
  """
  @spec wrap(binary()) :: binary()
  def wrap(payload) when is_binary(payload) do
    size = byte_size(payload)

    if size >= @max_size do
      raise ArgumentError, "frame too large: #{size} >= #{@max_size}"
    end

    <<size::big-unsigned-24, payload::binary>>
  end

  @doc """
  Parse zero or more length-prefixed frames out of `buf`. Returns
  `{frames, remaining_buf}`.
  """
  @spec read_frames(binary()) :: {[binary()], binary()}
  def read_frames(buf), do: read_frames(buf, [])

  defp read_frames(<<size::big-unsigned-24, payload::binary-size(size), rest::binary>>, acc) do
    read_frames(rest, [payload | acc])
  end

  defp read_frames(buf, acc), do: {Enum.reverse(acc), buf}
end
