defmodule Whatsmeow.Media.Retry do
  @moduledoc """
  Media-retry receipt — ask the sender's phone to re-upload a media payload
  whose CDN copy 404/410'd, then decrypt the response notification.

  WhatsApp media uploads expire from the CDN after a few days. If you download
  an inbound media message a week later, the CDN returns 404. The
  recovery protocol is:

  1. We send a `<receipt type="server-error">` containing an encrypted
     `ServerErrorReceipt` proto (AES-GCM, key = HKDF over the media key
     with info `"WhatsApp Media Retry Notification"`, AAD = message id).
  2. The sender's phone notices, re-uploads, and pushes us a
     `<notification type="server_sync">` with the updated `direct_path`.
  3. We decrypt the notification using the same key, replace
     `direct_path` on our cached media message, retry the download.

  Mirrors `whatsmeow-main/mediaretry.go`. Pure crypto + protobuf — the
  Session integration (route notification → decrypt → re-download) lives
  in the notification-dispatch layer.
  """

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Crypto.HKDF
  alias Whatsmeow.Types.JID

  @info "WhatsApp Media Retry Notification"

  defmodule Notification do
    @moduledoc """
    Parsed `<notification type="server_sync">` (media retry) from the server.

    * `:message_id`  — original outgoing message id
    * `:chat_id`     — `%JID{}` of the chat the message belongs to
    * `:from_me?`    — true when the original message was outbound
    * `:sender_id`   — sender in group chats; `nil` in 1:1
    * `:timestamp`   — unix seconds
    * `:ciphertext`  — AES-GCM ciphertext (decrypt with `decrypt/3`)
    * `:iv`          — 12-byte nonce
    * `:error`       — `{code, "msg"}` set when the phone replied with
                        `<error>` instead of a re-upload payload
    """
    defstruct [:message_id, :chat_id, :from_me?, :sender_id, :timestamp, :ciphertext, :iv, :error]

    @type t :: %__MODULE__{
            message_id: String.t(),
            chat_id: Whatsmeow.Types.JID.t() | nil,
            from_me?: boolean(),
            sender_id: Whatsmeow.Types.JID.t() | nil,
            timestamp: integer() | nil,
            ciphertext: binary() | nil,
            iv: binary() | nil,
            error: {integer(), String.t() | nil} | nil
          }
  end

  @doc """
  Build the `<receipt type="server-error">` retry-request node.

  Mirrors Go's `SendMediaRetryReceipt` (`mediaretry.go:77`). Pure — the
  caller pipes it through `Session.send_node/2`.

  Required positional:
  * `our_jid`     — `%JID{}` of our own (non-AD) account
  * `chat_jid`    — `%JID{}` of the chat the message lives in
  * `message_id`  — outgoing message id we want re-uploaded
  * `media_key`   — the 32-byte HKDF input key from the original send

  Optional opts:
  * `:from_me?`     — true when the original was outbound (default false)
  * `:sender_jid`   — group-chat sender JID (omitted for 1:1)
  * `:iv`           — override the 12-byte nonce (testing)
  """
  @spec build_retry_receipt(
          JID.t(),
          JID.t(),
          String.t(),
          binary(),
          keyword()
        ) :: Node.t()
  def build_retry_receipt(%JID{} = our_jid, %JID{} = chat_jid, message_id, media_key, opts \\ [])
      when is_binary(message_id) and is_binary(media_key) do
    iv = Keyword.get(opts, :iv) || :crypto.strong_rand_bytes(12)
    from_me? = Keyword.get(opts, :from_me?, false)
    sender = Keyword.get(opts, :sender_jid)

    ciphertext = encrypt_receipt(message_id, media_key, iv)

    rmr_attrs =
      %{"jid" => chat_jid, "from_me" => to_string(from_me?)}
      |> maybe_put("participant", sender)

    Node.new(
      "receipt",
      %{
        "id" => message_id,
        "to" => JID.to_non_ad(our_jid),
        "type" => "server-error"
      },
      [
        Node.new("encrypt", %{}, [
          Node.new("enc_p", %{}, ciphertext),
          Node.new("enc_iv", %{}, iv)
        ]),
        Node.new("rmr", rmr_attrs, nil)
      ]
    )
  end

  @doc """
  Parse an inbound `<notification>` carrying a media-retry payload into a
  `%Notification{}`.

  Mirrors Go's `parseMediaRetryNotification` (`mediaretry.go:139`).
  """
  @spec parse_notification(Node.t()) :: {:ok, Notification.t()} | {:error, term()}
  def parse_notification(%Node{} = node) do
    msg_id = Node.attr(node, "id")
    timestamp = coerce_int(Node.attr(node, "t"))

    with %Node{} = rmr <- Node.get_child(node, "rmr") do
      base = %Notification{
        message_id: msg_id,
        chat_id: parse_jid(Node.attr(rmr, "jid")),
        from_me?: truthy?(Node.attr(rmr, "from_me")),
        sender_id: parse_jid_optional(Node.attr(rmr, "participant")),
        timestamp: timestamp
      }

      cond do
        err = Node.get_child(node, "error") ->
          {:ok, %Notification{base | error: {coerce_int(Node.attr(err, "code")) || 0, nil}}}

        true ->
          with %Node{} = enc <- Node.get_child(node, "encrypt"),
               %Node{content: ct} when is_binary(ct) <- Node.get_child(enc, "enc_p"),
               %Node{content: iv} when is_binary(iv) <- Node.get_child(enc, "enc_iv") do
            {:ok, %Notification{base | ciphertext: ct, iv: iv}}
          else
            _ -> {:error, :missing_encrypt_children}
          end
      end
    else
      _ -> {:error, :missing_rmr}
    end
  end

  @doc """
  Decrypt a parsed retry-notification ciphertext using the same media key
  that the original `build_retry_receipt/5` was called with.

  Returns `{:ok, %WAMmsRetry.MediaRetryNotification{}}` or
  `{:error, reason}`. The `:direct_path` field of the decoded proto is the
  new CDN path to feed back into a download retry.

  Mirrors Go's `DecryptMediaRetryNotification` (`mediaretry.go:123`).
  """
  @spec decrypt(Notification.t(), binary()) ::
          {:ok, WAMmsRetry.MediaRetryNotification.t()} | {:error, term()}
  def decrypt(%Notification{error: {code, _}}, _media_key),
    do: {:error, {:server_error, code}}

  def decrypt(%Notification{ciphertext: ct, iv: iv, message_id: msg_id}, media_key)
      when is_binary(ct) and is_binary(iv) and is_binary(media_key) do
    key = derive_key(media_key)

    case aes_gcm_decrypt(key, iv, ct, msg_id) do
      {:ok, plaintext} ->
        case safe_decode(WAMmsRetry.MediaRetryNotification, plaintext) do
          {:ok, notif} -> {:ok, notif}
          err -> err
        end

      err ->
        err
    end
  end

  def decrypt(%Notification{}, _),
    do: {:error, :missing_ciphertext}

  # --- Internals -------------------------------------------------------------

  defp encrypt_receipt(message_id, media_key, iv) do
    plaintext =
      %WAMmsRetry.ServerErrorReceipt{stanzaID: message_id}
      |> WAMmsRetry.ServerErrorReceipt.encode()
      |> IO.iodata_to_binary()

    key = derive_key(media_key)

    {ct, tag} =
      :crypto.crypto_one_time_aead(:aes_256_gcm, key, iv, plaintext, message_id, true)

    ct <> tag
  end

  defp derive_key(media_key), do: HKDF.expand(HKDF.extract(media_key, <<>>), @info, 32)

  defp aes_gcm_decrypt(key, iv, ct_with_tag, aad) do
    if byte_size(ct_with_tag) < 16 do
      {:error, :ciphertext_too_short}
    else
      ct = binary_part(ct_with_tag, 0, byte_size(ct_with_tag) - 16)
      tag = binary_part(ct_with_tag, byte_size(ct_with_tag) - 16, 16)

      case :crypto.crypto_one_time_aead(:aes_256_gcm, key, iv, ct, aad, tag, false) do
        bin when is_binary(bin) -> {:ok, bin}
        :error -> {:error, :aead_auth_failed}
      end
    end
  end

  defp safe_decode(mod, bin) do
    {:ok, mod.decode(bin)}
  rescue
    e -> {:error, {:proto_decode, Exception.message(e)}}
  end

  defp parse_jid(nil), do: nil
  defp parse_jid(%JID{} = j), do: j

  defp parse_jid(s) when is_binary(s) do
    case JID.parse(s) do
      {:ok, j} -> j
      _ -> nil
    end
  end

  defp parse_jid_optional(nil), do: nil
  defp parse_jid_optional(""), do: nil
  defp parse_jid_optional(other), do: parse_jid(other)

  defp coerce_int(nil), do: nil
  defp coerce_int(n) when is_integer(n), do: n

  defp coerce_int(bin) when is_binary(bin) do
    case Integer.parse(bin) do
      {n, ""} -> n
      _ -> nil
    end
  end

  defp truthy?(true), do: true
  defp truthy?("true"), do: true
  defp truthy?("1"), do: true
  defp truthy?(_), do: false

  defp maybe_put(map, _k, nil), do: map
  defp maybe_put(map, k, v), do: Map.put(map, k, v)
end
