defmodule Whatsmeow.Transport.Constants do
  @moduledoc """
  Constants used by the WhatsApp transport layer.

  Ports `whatsmeow-main/socket/constants.go`.
  """

  @origin "https://web.whatsapp.com"
  @url "wss://web.whatsapp.com/ws/chat"
  @noise_start_pattern "Noise_XX_25519_AESGCM_SHA256\x00\x00\x00\x00"
  @wa_magic_value 6
  @dict_version 3
  @wa_conn_header <<?W, ?A, @wa_magic_value, @dict_version>>
  @frame_max_size Bitwise.bsl(1, 24)
  @frame_length_size 3

  def origin, do: @origin
  def url, do: @url
  def noise_start_pattern, do: @noise_start_pattern
  def wa_magic_value, do: @wa_magic_value
  def dict_version, do: @dict_version
  def wa_conn_header, do: @wa_conn_header
  def frame_max_size, do: @frame_max_size
  def frame_length_size, do: @frame_length_size
end
