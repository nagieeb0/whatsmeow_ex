defmodule Whatsmeow.Signal.MessageBuilder do
  @moduledoc """
  Build a `%Whatsmeow.Types.Message{}` from decrypted `WAWebProtobufsE2E.Message`
  bytes + the surrounding `%Whatsmeow.MessageInfo{}`.

  Decoding rules — extract text, media attachments, and the most common
  envelope wrappers WhatsApp uses today:

    * `conversation` — bare text body.
    * `extendedTextMessage.text` — formatted text body.
    * `ephemeralMessage.message.*` — disappearing-message wrapper.
    * `viewOnceMessage{,V2,V2Extension}.message.*` — view-once wrapper.
    * `imageMessage` / `videoMessage` / `audioMessage` / `documentMessage`
      / `stickerMessage` — flattened into the `attachments` field with the
      bits a downloader needs (url, directPath, mediaKey, mimetype, …).

  Returns `{:ok, %Whatsmeow.Types.Message{}, [media_descriptor]}` where
  the second element is the list of media descriptors that
  `Whatsmeow.Media.Download.fetch_and_decrypt/1` can consume directly.
  The original decoded WaE2E.Message lives on the message's `:raw`
  field so callers can pull anything else out themselves.
  """

  alias Whatsmeow.MessageInfo
  alias Whatsmeow.Types.{JID, Message}

  @type media_kind :: :image | :video | :audio | :document | :sticker | :voice

  @type media_descriptor :: %{
          kind: media_kind(),
          mime_type: String.t() | nil,
          url: String.t() | nil,
          direct_path: String.t() | nil,
          media_key: binary() | nil,
          file_sha256: binary() | nil,
          file_enc_sha256: binary() | nil,
          file_length: non_neg_integer() | nil,
          duration_seconds: non_neg_integer() | nil,
          ptt?: boolean(),
          caption: String.t() | nil,
          file_name: String.t() | nil,
          width: non_neg_integer() | nil,
          height: non_neg_integer() | nil
        }

  @doc """
  Decode `plaintext` (raw `WaE2E.Message` bytes) and project it into a
  `%Message{}` plus a list of `media_descriptor()`.

  Returns `{:ok, %Message{}, media_descriptors}` or `{:error, reason}`
  if the bytes don't decode as a `WaE2E.Message`.
  """
  @spec from_plaintext(binary(), MessageInfo.t()) ::
          {:ok, Message.t(), [media_descriptor()]} | {:error, term()}
  def from_plaintext(plaintext, %MessageInfo{} = info) when is_binary(plaintext) do
    e2e = WAWebProtobufsE2E.Message.decode(plaintext)
    inner = unwrap(e2e)

    {body, view_once?} = extract_text_and_view_once(inner)
    attachments = extract_attachments(inner)

    {chat, sender} = derive_chat_and_sender(info)
    sender_alt = resolve_sender_alt(info, sender)

    msg = %Message{
      id: info.id,
      from: info.from,
      chat: chat,
      sender: sender,
      sender_alt: sender_alt,
      timestamp: info.timestamp,
      push_name: info.push_name,
      body: body,
      raw: e2e,
      is_from_me: info.is_from_me?,
      is_group: info.is_group?,
      is_ephemeral: ephemeral?(e2e),
      is_view_once: view_once?,
      attachments: Enum.map(attachments, &drop_nil/1)
    }

    {:ok, msg, attachments}
  rescue
    e -> {:error, {:proto_decode, Exception.message(e)}}
  end

  # Walk the wrapper protos so plain code can match on
  # `imageMessage` / `audioMessage` / … without caring whether the
  # message arrived inside an ephemeral / view-once / device-sent
  # envelope.
  defp unwrap(%WAWebProtobufsE2E.Message{ephemeralMessage: %{message: inner}})
       when not is_nil(inner),
       do: unwrap(inner)

  defp unwrap(%WAWebProtobufsE2E.Message{viewOnceMessage: %{message: inner}})
       when not is_nil(inner),
       do: unwrap(inner)

  defp unwrap(%WAWebProtobufsE2E.Message{viewOnceMessageV2: %{message: inner}})
       when not is_nil(inner),
       do: unwrap(inner)

  defp unwrap(%WAWebProtobufsE2E.Message{viewOnceMessageV2Extension: %{message: inner}})
       when not is_nil(inner),
       do: unwrap(inner)

  defp unwrap(%WAWebProtobufsE2E.Message{deviceSentMessage: %{message: inner}})
       when not is_nil(inner),
       do: unwrap(inner)

  defp unwrap(%WAWebProtobufsE2E.Message{} = msg), do: msg
  defp unwrap(other), do: other

  defp extract_text_and_view_once(%WAWebProtobufsE2E.Message{} = msg) do
    cond do
      is_binary(msg.conversation) and msg.conversation != "" ->
        {msg.conversation, false}

      is_struct(msg.extendedTextMessage) and is_binary(msg.extendedTextMessage.text) ->
        {msg.extendedTextMessage.text, false}

      not is_nil(msg.viewOnceMessage) or not is_nil(msg.viewOnceMessageV2) ->
        {nil, true}

      true ->
        {nil, false}
    end
  end

  defp extract_text_and_view_once(_), do: {nil, false}

  defp ephemeral?(%WAWebProtobufsE2E.Message{ephemeralMessage: nil}), do: false
  defp ephemeral?(%WAWebProtobufsE2E.Message{}), do: true
  defp ephemeral?(_), do: false

  defp extract_attachments(%WAWebProtobufsE2E.Message{} = msg) do
    [
      build_image(msg.imageMessage),
      build_video(msg.videoMessage),
      build_audio(msg.audioMessage),
      build_document(msg.documentMessage),
      build_sticker(msg.stickerMessage)
    ]
    |> Enum.reject(&is_nil/1)
  end

  defp extract_attachments(_), do: []

  defp build_image(nil), do: nil

  defp build_image(%WAWebProtobufsE2E.ImageMessage{} = im) do
    %{
      kind: :image,
      mime_type: im.mimetype,
      url: Map.get(im, :URL),
      direct_path: im.directPath,
      media_key: im.mediaKey,
      file_sha256: im.fileSHA256,
      file_enc_sha256: im.fileEncSHA256,
      file_length: im.fileLength,
      duration_seconds: nil,
      ptt?: false,
      caption: im.caption,
      file_name: nil,
      width: im.width,
      height: im.height
    }
  end

  defp build_video(nil), do: nil

  defp build_video(%WAWebProtobufsE2E.VideoMessage{} = vm) do
    %{
      kind: :video,
      mime_type: vm.mimetype,
      url: Map.get(vm, :URL),
      direct_path: vm.directPath,
      media_key: vm.mediaKey,
      file_sha256: vm.fileSHA256,
      file_enc_sha256: vm.fileEncSHA256,
      file_length: vm.fileLength,
      duration_seconds: vm.seconds,
      ptt?: false,
      caption: vm.caption,
      file_name: nil,
      width: vm.width,
      height: vm.height
    }
  end

  defp build_audio(nil), do: nil

  defp build_audio(%WAWebProtobufsE2E.AudioMessage{} = am) do
    ptt = Map.get(am, :PTT) == true

    %{
      kind: if(ptt, do: :voice, else: :audio),
      mime_type: am.mimetype,
      url: Map.get(am, :URL),
      direct_path: am.directPath,
      media_key: am.mediaKey,
      file_sha256: am.fileSHA256,
      file_enc_sha256: am.fileEncSHA256,
      file_length: am.fileLength,
      duration_seconds: am.seconds,
      ptt?: ptt,
      caption: nil,
      file_name: nil,
      width: nil,
      height: nil
    }
  end

  defp build_document(nil), do: nil

  defp build_document(%WAWebProtobufsE2E.DocumentMessage{} = dm) do
    %{
      kind: :document,
      mime_type: dm.mimetype,
      url: Map.get(dm, :URL),
      direct_path: dm.directPath,
      media_key: dm.mediaKey,
      file_sha256: dm.fileSHA256,
      file_enc_sha256: dm.fileEncSHA256,
      file_length: dm.fileLength,
      duration_seconds: nil,
      ptt?: false,
      caption: dm.caption,
      file_name: dm.fileName,
      width: nil,
      height: nil
    }
  end

  defp build_sticker(nil), do: nil

  defp build_sticker(%WAWebProtobufsE2E.StickerMessage{} = sm) do
    %{
      kind: :sticker,
      mime_type: sm.mimetype,
      url: Map.get(sm, :URL),
      direct_path: sm.directPath,
      media_key: sm.mediaKey,
      file_sha256: sm.fileSHA256,
      file_enc_sha256: sm.fileEncSHA256,
      file_length: sm.fileLength,
      duration_seconds: nil,
      ptt?: false,
      caption: nil,
      file_name: nil,
      width: sm.width,
      height: sm.height
    }
  end

  defp drop_nil(descriptor), do: descriptor

  # Individual chats: chat == sender == info.from.
  # Group chats: chat == info.from (g.us), sender == info.participant.
  # The stanza usually carries the sender's other address outright. When it does
  # not — the server only volunteers it some of the time — fall back to what
  # earlier stanzas and the history sync taught us. Without the fallback, the
  # phone number appears on the first message from a contact and then vanishes
  # on the second, which is worse than never having it.
  defp resolve_sender_alt(%MessageInfo{sender_alt: %JID{} = alt}, _sender), do: alt

  defp resolve_sender_alt(_info, %JID{server: server} = sender) do
    if server in [JID.hidden_user_server(), JID.hosted_lid_server()] do
      Whatsmeow.LIDMap.pn_for(sender)
    end
  end

  defp resolve_sender_alt(_info, _sender), do: nil

  defp derive_chat_and_sender(%MessageInfo{is_group?: true, from: chat, participant: %JID{} = p}),
    do: {chat, p}

  defp derive_chat_and_sender(%MessageInfo{from: %JID{} = from}),
    do: {from, from}

  defp derive_chat_and_sender(_), do: {nil, nil}
end
