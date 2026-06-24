defmodule Whatsmeow.Signal.GroupDecrypt do
  @moduledoc """
  libsignal-wire-compatible decrypt for `<enc type="skmsg">` envelopes
  (WhatsApp group messages).

  Counterpart of `Whatsmeow.Signal.WireDecrypt` (1:1 messages). Where 1:1
  authenticates each `SignalMessage` with an HMAC over the participants'
  identity keys, group messages are signed by the sender's per-group
  XEdDSA signing key — the verification key is carried in the matching
  `SenderKeyDistributionMessage` and seeded into `%GroupSession{}`.

  ## Pipeline

      <enc type="skmsg" content>
          │
          ▼
      SenderKeyWire.decode_sender_key_message/1
          │  ({:ok, %SenderKeyMessage{}, signed_input, sig})
          ▼
      XEdDSA.verify(gs.signing_pub, signed_input, sig)
          │
          ▼
      advance chain to iteration ─ derives 32-byte message key
          │
          ▼
      HKDF(message_key, info: "WhisperGroup", 48 bytes)
          │  → iv[0..16] ‖ cipher_key[16..48]
          ▼
      AES-256-CBC decrypt
          │
          ▼
      MessagePadding.unpad/2 → raw `WaE2E.Message` bytes

  Skipped keys are cached up to `GroupSession.max_skip/0` iterations
  ahead to tolerate out-of-order delivery (mirrors libsignal-java's
  `SenderKeyState.MAX_MESSAGE_KEYS = 2000`).
  """

  alias Whatsmeow.Crypto.{AES, HKDF, XEdDSA}
  alias Whatsmeow.MessagePadding
  alias Whatsmeow.Signal.{GroupSession, Ratchet, SenderKeyWire}
  alias Whatsmeow.Signal.SenderKeyWire.SenderKeyMessage

  @info "WhisperGroup"

  @typedoc "Reasons a group decrypt may fail."
  @type error ::
          :bad_signature
          | :bad_padding
          | :empty
          | :iteration_too_far_ahead
          | :duplicate_message
          | {:aes, term()}
          | {:wire_decode, term()}

  @doc """
  Decrypt a `<enc type="skmsg">` envelope. Returns the plaintext
  `WaE2E.Message` bytes plus the advanced `%GroupSession{}` so the caller
  can persist it.
  """
  @spec decrypt_envelope(binary(), GroupSession.t()) ::
          {:ok, binary(), GroupSession.t()} | {:error, error()}
  def decrypt_envelope(envelope, %GroupSession{} = gs) when is_binary(envelope) do
    case SenderKeyWire.decode_sender_key_message(envelope) do
      {:ok, %SenderKeyMessage{} = msg, signed_input, sig} ->
        if XEdDSA.verify(gs.signing_pub, signed_input, sig) do
          decrypt_after_verify(gs, msg)
        else
          {:error, :bad_signature}
        end

      {:error, reason} ->
        {:error, {:wire_decode, reason}}
    end
  end

  @doc """
  Encrypt a single plaintext into a `<enc type="skmsg">` wire envelope.

  Requires the session to carry a `signing_priv` — i.e. it must have been
  built with `GroupSession.new/1`, not seeded from a peer's distribution
  message. Returns `{envelope, advanced_session}`.
  """
  @spec encrypt_envelope(GroupSession.t(), binary()) :: {binary(), GroupSession.t()}
  def encrypt_envelope(
        %GroupSession{signing_priv: <<signing_priv::binary-size(32)>>} = gs,
        plaintext
      )
      when is_binary(plaintext) do
    padded = MessagePadding.pad(plaintext)
    {next_ck, mk} = Ratchet.kdf_ck(gs.chain_key)
    {iv, cipher_key} = derive_keys(mk)
    ciphertext = AES.CBC.encrypt(cipher_key, iv, padded)

    proto = %SenderKeyMessage{
      id: gs.id,
      iteration: gs.iteration,
      ciphertext: ciphertext
    }

    signed_input =
      <<SenderKeyWire.version_byte()>> <> IO.iodata_to_binary(SenderKeyMessage.encode(proto))

    sig = XEdDSA.sign(signing_priv, signed_input)
    envelope = signed_input <> sig

    new_gs = %GroupSession{gs | chain_key: next_ck, iteration: gs.iteration + 1}

    {envelope, new_gs}
  end

  # --- internals -----------------------------------------------------------

  defp decrypt_after_verify(%GroupSession{} = gs, %SenderKeyMessage{} = msg) do
    iteration = msg.iteration || 0

    with {:ok, gs2, mk} <- advance_to(gs, iteration),
         {iv, cipher_key} <- derive_keys(mk),
         {:ok, padded} <- aes_decrypt(cipher_key, iv, msg.ciphertext),
         {:ok, plain} <- MessagePadding.unpad(padded, 2) do
      {:ok, plain, gs2}
    end
  rescue
    e -> {:error, {:crash, Exception.message(e)}}
  end

  # In the common (fast) case `iteration == current_iteration` — we derive
  # the message key from the current chain key in one step.
  defp advance_to(%GroupSession{iteration: cur} = gs, target) when target == cur do
    {next_ck, mk} = Ratchet.kdf_ck(gs.chain_key)
    {:ok, %GroupSession{gs | chain_key: next_ck, iteration: cur + 1}, mk}
  end

  # Skipped: cache intermediate keys so out-of-order arrivals decrypt later.
  defp advance_to(%GroupSession{iteration: cur} = gs, target)
       when target > cur and target - cur <= 2_000 do
    do_skip(gs, target)
  end

  defp advance_to(%GroupSession{iteration: cur}, target) when target > cur do
    {:error, :iteration_too_far_ahead}
  end

  # Replayed / out-of-order arrival: try the skip cache.
  defp advance_to(%GroupSession{} = gs, target) do
    case Map.fetch(gs.skipped_keys, target) do
      {:ok, mk} ->
        {:ok, %GroupSession{gs | skipped_keys: Map.delete(gs.skipped_keys, target)}, mk}

      :error ->
        {:error, :duplicate_message}
    end
  end

  defp do_skip(%GroupSession{} = gs, target) do
    Enum.reduce(
      gs.iteration..(target - 1),
      gs,
      fn n, %GroupSession{} = acc ->
        {next_ck, mk} = Ratchet.kdf_ck(acc.chain_key)

        %GroupSession{
          acc
          | chain_key: next_ck,
            iteration: n + 1,
            skipped_keys: Map.put(acc.skipped_keys, n, mk)
        }
      end
    )
    |> then(fn %GroupSession{chain_key: ck, iteration: cur} = acc ->
      {next_ck, mk} = Ratchet.kdf_ck(ck)
      {:ok, %GroupSession{acc | chain_key: next_ck, iteration: cur + 1}, mk}
    end)
  end

  defp derive_keys(message_key) when byte_size(message_key) == 32 do
    <<iv::binary-size(16), cipher_key::binary-size(32)>> =
      HKDF.derive(message_key, nil, @info, 48)

    {iv, cipher_key}
  end

  defp aes_decrypt(cipher_key, iv, ciphertext) when is_binary(ciphertext) do
    case AES.CBC.decrypt(cipher_key, iv, ciphertext) do
      {:ok, _} = ok -> ok
      err -> {:error, {:aes, err}}
    end
  end
end
