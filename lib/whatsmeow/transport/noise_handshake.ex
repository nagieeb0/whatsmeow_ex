defmodule Whatsmeow.Transport.NoiseHandshake do
  @moduledoc """
  Noise_XX_25519_AESGCM_SHA256 handshake state machine.

  Ports `whatsmeow-main/socket/noisehandshake.go`. Implemented as a pure
  functional state struct: every operation returns a new state. The caller
  (`Whatsmeow.Session.Handshake`) sequences the XX message pattern against
  WhatsApp's server.

  See RFC for Noise framework. WhatsApp's binding overlay:

  * `Start(pattern, header)` — initialise state with the protocol-name
    pattern (32-byte hash or short string) and authenticate the WA header.
  * `MixSharedSecretIntoKey(priv, pub)` — X25519 ECDH + HKDF.
  * `Encrypt/Decrypt` — AES-GCM-256 with `hash` as AAD; IV is the counter
    big-endian in the last 4 bytes of a 12-byte zero buffer; counter is
    post-incremented per operation; ciphertext is mixed into the hash.
  * `Finish` — derive the post-handshake write/read keys.
  """

  alias Whatsmeow.Crypto.{AES, Curve25519, HKDF}

  @type t :: %__MODULE__{
          hash: binary(),
          salt: binary(),
          key: binary(),
          counter: non_neg_integer()
        }

  defstruct hash: <<>>, salt: <<>>, key: <<>>, counter: 0

  @doc "Create an empty handshake state."
  @spec new() :: t()
  def new, do: %__MODULE__{}

  @doc """
  Start the handshake. `pattern` is either a 32-byte hash or a short string
  (e.g. `Noise_XX_25519_AESGCM_SHA256\\x00\\x00\\x00\\x00`); `header` is the
  WA connection header (4 bytes) authenticated into the transcript hash.
  """
  @spec start(t(), binary(), binary()) :: t()
  def start(%__MODULE__{} = nh, pattern, header) do
    hash =
      if byte_size(pattern) == 32 do
        pattern
      else
        :crypto.hash(:sha256, pattern)
      end

    %__MODULE__{nh | hash: hash, salt: hash, key: hash, counter: 0}
    |> authenticate(header)
  end

  @doc "Mix `data` into the running transcript hash (SHA-256 of hash||data)."
  @spec authenticate(t(), binary()) :: t()
  def authenticate(%__MODULE__{hash: h} = nh, data) do
    %__MODULE__{nh | hash: :crypto.hash(:sha256, h <> data)}
  end

  @doc """
  Encrypt `plaintext` with AES-GCM under the current `key`, authenticating
  the running `hash` as AAD. Returns `{ciphertext, new_state}`. The
  ciphertext is mixed into the hash before returning.
  """
  @spec encrypt(t(), binary()) :: {binary(), t()}
  def encrypt(%__MODULE__{} = nh, plaintext) do
    {iv, nh1} = next_iv(nh)
    {ct, tag} = AES.GCM.encrypt(nh.key, iv, plaintext, nh.hash)
    blob = ct <> tag
    {blob, authenticate(nh1, blob)}
  end

  @doc """
  Decrypt + verify `ciphertext` (which includes the 16-byte tag at the end).
  Returns `{:ok, plaintext, new_state}` on auth success.
  """
  @spec decrypt(t(), binary()) :: {:ok, binary(), t()} | {:error, :auth_failed}
  def decrypt(%__MODULE__{} = nh, blob) when byte_size(blob) >= 16 do
    ct_len = byte_size(blob) - 16
    <<ct::binary-size(^ct_len), tag::binary-size(16)>> = blob
    {iv, nh1} = next_iv(nh)

    case AES.GCM.decrypt(nh.key, iv, ct, nh.hash, tag) do
      {:ok, plaintext} -> {:ok, plaintext, authenticate(nh1, blob)}
      {:error, :auth_failed} = err -> err
    end
  end

  def decrypt(%__MODULE__{}, _), do: {:error, :auth_failed}

  @doc """
  Mix an X25519 ECDH shared secret into the running key, given our private
  key and the peer's public key (both 32 bytes).
  """
  @spec mix_shared_secret_into_key(t(), binary(), binary()) :: t()
  def mix_shared_secret_into_key(%__MODULE__{} = nh, priv, pub) do
    secret = Curve25519.agree(priv, pub)
    mix_into_key(nh, secret)
  end

  @doc """
  Mix raw input keying material `data` into the running key. Resets the
  counter to 0 (the post-mix key has a fresh nonce stream).
  """
  @spec mix_into_key(t(), binary()) :: t()
  def mix_into_key(%__MODULE__{salt: salt} = nh, data) do
    {write_key, read_key} = extract_and_expand(salt, data)
    %__MODULE__{nh | salt: write_key, key: read_key, counter: 0}
  end

  @doc """
  Finalise the handshake — derive the post-handshake AEAD write/read keys.
  Returns `{:ok, write_key, read_key}`.
  """
  @spec finish(t()) :: {:ok, binary(), binary()}
  def finish(%__MODULE__{salt: salt}) do
    {write, read} = extract_and_expand(salt, <<>>)
    {:ok, write, read}
  end

  defp next_iv(%__MODULE__{counter: c} = nh) do
    iv = <<0::64, c::big-unsigned-32>>
    {iv, %__MODULE__{nh | counter: c + 1}}
  end

  defp extract_and_expand(salt, ikm) do
    okm = HKDF.derive(ikm, salt, <<>>, 64)
    <<write_key::binary-size(32), read_key::binary-size(32)>> = okm
    {write_key, read_key}
  end
end
