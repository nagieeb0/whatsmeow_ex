defmodule Whatsmeow.Binary.Types do
  @moduledoc """
  WhatsApp binary-XML type-tag byte constants. These are the special token
  bytes that introduce non-string elements (lists, packed strings, JIDs,
  inline binaries, and double-byte dictionary references).

  See `whatsmeow-main/binary/token/token.go` for the upstream values.
  """

  @list_empty 0
  @dict0 236
  @dict1 237
  @dict2 238
  @dict3 239
  @interop_jid 245
  @fb_jid 246
  @ad_jid 247
  @list8 248
  @list16 249
  @jid_pair 250
  @hex8 251
  @binary8 252
  @binary20 253
  @binary32 254
  @nibble8 255

  @packed_max 127
  @single_byte_max 256

  def list_empty, do: @list_empty
  def dict0, do: @dict0
  def dict1, do: @dict1
  def dict2, do: @dict2
  def dict3, do: @dict3
  def interop_jid, do: @interop_jid
  def fb_jid, do: @fb_jid
  def ad_jid, do: @ad_jid
  def list8, do: @list8
  def list16, do: @list16
  def jid_pair, do: @jid_pair
  def hex8, do: @hex8
  def binary8, do: @binary8
  def binary20, do: @binary20
  def binary32, do: @binary32
  def nibble8, do: @nibble8

  def packed_max, do: @packed_max
  def single_byte_max, do: @single_byte_max

  defmacro __using__(_opts) do
    quote do
      @list_empty 0
      @dict0 236
      @dict1 237
      @dict2 238
      @dict3 239
      @interop_jid 245
      @fb_jid 246
      @ad_jid 247
      @list8 248
      @list16 249
      @jid_pair 250
      @hex8 251
      @binary8 252
      @binary20 253
      @binary32 254
      @nibble8 255
      @packed_max 127
    end
  end
end
