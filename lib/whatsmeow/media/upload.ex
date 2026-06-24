defmodule Whatsmeow.Media.Upload do
  @moduledoc """
  Media upload pipeline — AES-CBC encrypt with a per-message media key,
  HMAC-SHA256 the ciphertext, then PUT to the signed upload URL via Finch.

  Ports `whatsmeow-main/upload.go`.

  Phase 10 status: encryption + iodata-shaping helpers in place; the live
  HTTP PUT to WhatsApp's media-conn host requires the `Whatsmeow.Media.Conn`
  token-refresh GenServer (also Phase 10).
  """

  alias Whatsmeow.Crypto.{AES, HKDF}

  @typedoc "Encrypted media payload ready to be PUT to the upload host."
  @type encrypted :: %{
          ciphertext: binary(),
          mac: binary(),
          sha256_plain: binary(),
          sha256_enc: binary(),
          media_key: binary(),
          media_key_expansion: binary()
        }

  @doc """
  Encrypt `plaintext` for upload under a fresh 32-byte media key. Returns
  all the fields needed by the `<media>` IQ.

  `media_type` is one of `:image | :video | :audio | :document | :sticker`
  and selects the HKDF info string.
  """
  @spec encrypt(binary(), atom()) :: encrypted()
  def encrypt(plaintext, media_type) when is_binary(plaintext) and is_atom(media_type) do
    media_key = :crypto.strong_rand_bytes(32)
    expansion = HKDF.derive(media_key, <<0::256>>, info_for(media_type), 112)

    <<iv::binary-size(16), enc_key::binary-size(32), mac_key::binary-size(32),
      _ref_key::binary-size(32)>> = expansion

    ct = AES.CBC.encrypt(enc_key, iv, plaintext)
    mac = :crypto.mac(:hmac, :sha256, mac_key, iv <> ct) |> binary_part(0, 10)

    %{
      ciphertext: ct,
      mac: mac,
      sha256_plain: :crypto.hash(:sha256, plaintext),
      sha256_enc: :crypto.hash(:sha256, ct <> mac),
      media_key: media_key,
      media_key_expansion: expansion
    }
  end

  @typedoc """
  Result of a completed upload: the four fields the protobuf media
  message (e.g. `WAWebProtobufsE2E.ImageMessage`) needs.
  """
  @type upload_result :: %{
          url: String.t(),
          direct_path: String.t(),
          handle: String.t() | nil,
          object_id: String.t() | nil,
          media_key: binary(),
          file_sha256: binary(),
          file_enc_sha256: binary(),
          file_length: non_neg_integer()
        }

  @doc """
  Run a full encrypt + upload cycle.

  Returns a map with `url`, `direct_path`, `media_key`, `file_sha256`,
  `file_enc_sha256`, and `file_length` — paste these straight into a
  `WAWebProtobufsE2E.ImageMessage` (or VideoMessage/AudioMessage/…).

  Required option:
    * `:media_conn` — `%Whatsmeow.Media.Conn{}` (fetch via
      `Whatsmeow.Media.Refresh.refresh/2`).

  Optional:
    * `:newsletter?` — newsletter upload (different path prefix).
    * `:origin` — Origin/Referer header (default `https://web.whatsapp.com`).
  """
  @spec upload(binary(), atom(), keyword()) :: {:ok, upload_result()} | {:error, term()}
  def upload(plaintext, media_type, opts \\ [])
      when is_binary(plaintext) and is_atom(media_type) do
    case Keyword.fetch(opts, :media_conn) do
      {:ok, %Whatsmeow.Media.Conn{hosts: [host | _]} = conn} when is_binary(host) ->
        enc = encrypt(plaintext, media_type)
        do_post(enc, plaintext, media_type, conn, opts)

      {:ok, _} ->
        {:error, :media_conn_missing_hosts}

      :error ->
        {:error, :media_conn_required}
    end
  end

  defp do_post(enc, plaintext, media_type, %Whatsmeow.Media.Conn{} = conn, opts) do
    body = enc.ciphertext <> enc.mac
    token = Base.url_encode64(enc.sha256_enc, padding: true)
    mms = mms_type(media_type, Keyword.get(opts, :newsletter?, false))
    prefix = if Keyword.get(opts, :newsletter?, false), do: "newsletter", else: "mms"

    query =
      URI.encode_query(%{
        "auth" => conn.auth || "",
        "token" => token
      })

    origin = Keyword.get(opts, :origin, "https://web.whatsapp.com")
    host = List.first(conn.hosts)
    url = "https://#{host}/#{prefix}/#{mms}/#{token}?#{query}"

    headers = [
      {"origin", origin},
      {"referer", origin <> "/"},
      {"content-length", Integer.to_string(byte_size(body))}
    ]

    case do_http_post(url, headers, body) do
      {:ok, parsed} ->
        {:ok,
         %{
           url: parsed["url"] || "",
           direct_path: parsed["direct_path"] || "",
           handle: parsed["handle"],
           object_id: parsed["object_id"],
           media_key: enc.media_key,
           file_sha256: :crypto.hash(:sha256, plaintext),
           file_enc_sha256: enc.sha256_enc,
           file_length: byte_size(plaintext)
         }}

      {:error, _} = err ->
        err
    end
  end

  defp do_http_post(url, headers, body) do
    finch_name = Application.get_env(:whatsmeow_ex, :finch_name, Whatsmeow.Finch)

    case Finch.build(:post, url, headers, body) |> Finch.request(finch_name) do
      {:ok, %Finch.Response{status: status, body: resp_body}} when status in 200..299 ->
        case Jason.decode(resp_body) do
          {:ok, parsed} -> {:ok, parsed}
          {:error, reason} -> {:error, {:bad_response, reason}}
        end

      {:ok, %Finch.Response{status: status, body: resp_body}} ->
        {:error, {:http_status, status, resp_body}}

      {:error, _} = err ->
        err
    end
  rescue
    e -> {:error, {:finch, Exception.message(e)}}
  end

  defp mms_type(:image, _), do: "image"
  defp mms_type(:video, _), do: "video"
  defp mms_type(:audio, _), do: "audio"
  defp mms_type(:voice, _), do: "audio"
  defp mms_type(:document, _), do: "document"
  defp mms_type(:sticker, _), do: "image"

  defp info_for(:image), do: "WhatsApp Image Keys"
  defp info_for(:video), do: "WhatsApp Video Keys"
  defp info_for(:audio), do: "WhatsApp Audio Keys"
  defp info_for(:document), do: "WhatsApp Document Keys"
  defp info_for(:sticker), do: "WhatsApp Image Keys"
end
