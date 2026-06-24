defmodule Whatsmeow.MsgSecret do
  @moduledoc """
  Derive per-use-case secret keys for WhatsApp message secrets.

  Ports `whatsmeow-main/msgsecret.go`.

  A `MsgSecret` is a 32-byte random value the sender of an original
  message (poll, comment, event, etc.) generates and ships alongside the
  message. Subsequent operations on that message (votes, reactions,
  edits, comments, reports, bot answers) derive their AES-256-GCM
  encryption key by HKDF-SHA256 over `msg_secret`, with an `info` string
  composed of:

      orig_msg_id || orig_sender_jid || modification_sender_jid || use_case

  Plus an `additional_data` string used as AEAD AAD for the two
  use-cases where the protocol mandates it (`:poll_vote`,
  `:event_response`, and the legacy unnamed bucket).
  """

  alias Whatsmeow.Crypto.HKDF

  @use_cases %{
    poll_vote: "Poll Vote",
    reaction: "Enc Reaction",
    comment: "Enc Comment",
    report_token: "Report Token",
    event_response: "Event Response",
    event_edit: "Event Edit",
    message_edit: "Message Edit",
    poll_edit: "Poll Edit",
    poll_add_option: "Poll Add Option",
    bot_message: "Bot Message"
  }

  @type use_case :: unquote(@use_cases |> Map.keys() |> Enum.reduce(&{:|, [], [&1, &2]}))

  @doc "Known use-case atoms recognised by `derive/5`."
  @spec use_cases() :: [atom()]
  def use_cases, do: Map.keys(@use_cases)

  @doc """
  Derive the 32-byte AES-256-GCM key and the optional additional data
  string for a message-secret modification.

  Returns `{key, aad_or_nil}`.

  * `use_case` is one of the atoms in `use_cases/0`.
  * `modification_sender` is the JID of the user performing the action
    (e.g. the voter). Pass it as the `User@Server` string with no AD
    component.
  * `orig_msg_id` is the message id (string) of the original message.
  * `orig_msg_sender` is the JID of the original message's sender, same
    format as `modification_sender`.
  * `orig_msg_secret` is the 32-byte secret carried by the original
    message.
  """
  @spec derive(use_case(), binary(), binary(), binary(), binary()) ::
          {binary(), binary() | nil}
  def derive(use_case, modification_sender, orig_msg_id, orig_msg_sender, orig_msg_secret)
      when is_atom(use_case) and is_binary(modification_sender) and is_binary(orig_msg_id) and
             is_binary(orig_msg_sender) and is_binary(orig_msg_secret) do
    label = Map.fetch!(@use_cases, use_case)
    info = orig_msg_id <> orig_msg_sender <> modification_sender <> label
    key = HKDF.derive(orig_msg_secret, nil, info, 32)
    {key, additional_data(use_case, orig_msg_id, modification_sender)}
  end

  @doc """
  HKDF the `bot_message` secret variant (no use-case info, no AAD).

  This is the form used to encrypt bot replies and is also the
  per-message secret consumed by `Send` when emitting an outbound bot
  payload.
  """
  @spec apply_bot_message_hkdf(binary()) :: binary()
  def apply_bot_message_hkdf(message_secret) when byte_size(message_secret) == 32 do
    HKDF.derive(message_secret, nil, Map.fetch!(@use_cases, :bot_message), 32)
  end

  defp additional_data(:poll_vote, orig_msg_id, modification_sender) do
    orig_msg_id <> <<0>> <> modification_sender
  end

  defp additional_data(:event_response, orig_msg_id, modification_sender) do
    orig_msg_id <> <<0>> <> modification_sender
  end

  defp additional_data(_use_case, _orig_msg_id, _modification_sender), do: nil

  # --- Encrypt / decrypt envelopes ------------------------------------------

  @doc """
  Encrypt `plaintext` under the message-secret derived for `use_case`.

  Returns `{ciphertext_with_tag, iv}`. Internally:

  * Derives the AES-256-GCM key + optional AAD via `derive/5`.
  * Generates a 12-byte random nonce.
  * Calls `:crypto.crypto_one_time_aead/7` with the AAD (or empty bytes
    when not required for this use case).

  The output ciphertext is the AES-GCM ciphertext concatenated with the
  16-byte tag, matching Go's `gcmutil.Encrypt` output shape used in
  `msgsecret.go`. Mirrors Go's `encryptMsgSecret` (`msgsecret.go:114`).
  """
  @spec encrypt(use_case(), binary(), binary(), binary(), binary(), binary()) ::
          {binary(), binary()}
  def encrypt(
        use_case,
        modification_sender,
        orig_msg_id,
        orig_msg_sender,
        orig_msg_secret,
        plaintext
      )
      when is_atom(use_case) and is_binary(modification_sender) and is_binary(orig_msg_id) and
             is_binary(orig_msg_sender) and is_binary(orig_msg_secret) and is_binary(plaintext) do
    {key, aad} =
      derive(use_case, modification_sender, orig_msg_id, orig_msg_sender, orig_msg_secret)

    iv = :crypto.strong_rand_bytes(12)

    {ct, tag} = :crypto.crypto_one_time_aead(:aes_256_gcm, key, iv, plaintext, aad || <<>>, true)

    {ct <> tag, iv}
  end

  @doc """
  Decrypt a message-secret payload. `ct_with_tag` is the encrypted blob
  with its 16-byte tag appended (the same shape `encrypt/6` produces).

  Returns `{:ok, plaintext}` or `{:error, :aead_auth_failed}`.

  Mirrors Go's `decryptMsgSecret` (`msgsecret.go:84`).
  """
  @spec decrypt(use_case(), binary(), binary(), binary(), binary(), binary(), binary()) ::
          {:ok, binary()} | {:error, atom()}
  def decrypt(
        use_case,
        modification_sender,
        orig_msg_id,
        orig_msg_sender,
        orig_msg_secret,
        ct_with_tag,
        iv
      )
      when is_binary(ct_with_tag) and is_binary(iv) do
    if byte_size(ct_with_tag) < 16 do
      {:error, :ciphertext_too_short}
    else
      {key, aad} =
        derive(use_case, modification_sender, orig_msg_id, orig_msg_sender, orig_msg_secret)

      ct = binary_part(ct_with_tag, 0, byte_size(ct_with_tag) - 16)
      tag = binary_part(ct_with_tag, byte_size(ct_with_tag) - 16, 16)

      case :crypto.crypto_one_time_aead(:aes_256_gcm, key, iv, ct, aad || <<>>, tag, false) do
        bin when is_binary(bin) -> {:ok, bin}
        :error -> {:error, :aead_auth_failed}
      end
    end
  end

  @doc """
  Hash poll-option names with SHA-256.

  WhatsApp identifies selected options in a poll vote by the SHA-256 of the
  option string, not the string itself — that's what gets encrypted +
  shipped in the `PollVoteMessage.selectedOptions` field.

  Mirrors Go's `HashPollOptions` (`msgsecret.go:293`).
  """
  @spec hash_poll_options([String.t()]) :: [<<_::256>>]
  def hash_poll_options(option_names) when is_list(option_names) do
    Enum.map(option_names, fn name when is_binary(name) ->
      :crypto.hash(:sha256, name)
    end)
  end
end
