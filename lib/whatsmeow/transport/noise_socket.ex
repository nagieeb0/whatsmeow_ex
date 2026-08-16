defmodule Whatsmeow.Transport.NoiseSocket do
  @moduledoc """
  Post-handshake AEAD channel state.

  Ports `whatsmeow-main/socket/noisesocket.go`. The handshake produces a
  write key and a read key (32 bytes each). All subsequent traffic in each
  direction is AES-GCM-256 with a per-direction monotonic counter as the
  IV's last 32 bits, no AAD.
  """

  alias Whatsmeow.Crypto.AES

  @type t :: %__MODULE__{
          write_key: binary(),
          read_key: binary(),
          write_counter: non_neg_integer(),
          read_counter: non_neg_integer()
        }

  defstruct write_key: <<>>, read_key: <<>>, write_counter: 0, read_counter: 0

  @doc "Create a post-handshake socket from the two derived keys."
  @spec new(binary(), binary()) :: t()
  def new(write_key, read_key)
      when byte_size(write_key) == 32 and byte_size(read_key) == 32 do
    %__MODULE__{write_key: write_key, read_key: read_key}
  end

  @doc """
  Encrypt outbound `plaintext`. Returns `{ciphertext_with_tag, new_state}`.
  """
  @spec encrypt(t(), binary()) :: {binary(), t()}
  def encrypt(%__MODULE__{} = ns, plaintext) do
    iv = <<0::64, ns.write_counter::big-unsigned-32>>
    {ct, tag} = AES.GCM.encrypt(ns.write_key, iv, plaintext, <<>>)
    {ct <> tag, %__MODULE__{ns | write_counter: ns.write_counter + 1}}
  end

  @doc """
  Decrypt inbound `ciphertext` (containing the 16-byte tag at the end).
  Returns `{:ok, plaintext, new_state}` on auth success.
  """
  @spec decrypt(t(), binary()) :: {:ok, binary(), t()} | {:error, :auth_failed}
  def decrypt(%__MODULE__{} = ns, blob) when byte_size(blob) >= 16 do
    ct_len = byte_size(blob) - 16
    <<ct::binary-size(^ct_len), tag::binary-size(16)>> = blob
    iv = <<0::64, ns.read_counter::big-unsigned-32>>

    case AES.GCM.decrypt(ns.read_key, iv, ct, <<>>, tag) do
      {:ok, plaintext} ->
        {:ok, plaintext, %__MODULE__{ns | read_counter: ns.read_counter + 1}}

      err ->
        err
    end
  end

  def decrypt(%__MODULE__{}, _), do: {:error, :auth_failed}
end
