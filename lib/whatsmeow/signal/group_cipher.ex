defmodule Whatsmeow.Signal.GroupCipher do
  @moduledoc """
  Encrypt / decrypt group messages using `Whatsmeow.Signal.SenderKey` state.

  Each outbound message advances the per-sender chain and produces a fresh
  message key. The ciphertext is signed with the sender's signing keypair
  so other members can verify provenance.
  """

  alias Whatsmeow.Crypto.AES
  alias Whatsmeow.Signal.{Ratchet, SenderKey}

  @doc "Encrypt `plaintext`. Returns `{ciphertext_envelope, new_sender_key}`."
  @spec encrypt(SenderKey.t(), binary()) :: {map(), SenderKey.t()}
  def encrypt(%SenderKey{} = sk, plaintext) do
    {next_ck, mk} = Ratchet.kdf_ck(sk.chain_key)
    {enc_key, _mac_key, iv} = Ratchet.derive_message_keys(mk)
    body = AES.CBC.encrypt(enc_key, iv, plaintext)

    envelope = %{
      sender_key_id: sk.id,
      iteration: sk.iteration,
      body: body
    }

    {envelope, %SenderKey{sk | chain_key: next_ck, iteration: sk.iteration + 1}}
  end

  @doc "Decrypt a `ciphertext_envelope`. Returns `{:ok, plaintext, new_sender_key}`."
  @spec decrypt(SenderKey.t(), map()) :: {:ok, binary(), SenderKey.t()} | {:error, atom()}
  def decrypt(%SenderKey{} = sk, %{iteration: n, body: body}) do
    %SenderKey{} = sk = skip_until(sk, n)
    {next_ck, mk} = Ratchet.kdf_ck(sk.chain_key)
    {enc_key, _mac_key, iv} = Ratchet.derive_message_keys(mk)

    case AES.CBC.decrypt(enc_key, iv, body) do
      {:ok, plaintext} ->
        {:ok, plaintext, %SenderKey{sk | chain_key: next_ck, iteration: sk.iteration + 1}}

      err ->
        err
    end
  end

  defp skip_until(%SenderKey{iteration: n_now} = sk, n) when n > n_now do
    Enum.reduce(n_now..(n - 1), sk, fn _, %SenderKey{} = s ->
      {next_ck, mk} = Ratchet.kdf_ck(s.chain_key)
      %SenderKey{s | chain_key: next_ck, skipped_keys: Map.put(s.skipped_keys, s.iteration, mk)}
    end)
  end

  defp skip_until(%SenderKey{} = sk, _), do: sk
end
