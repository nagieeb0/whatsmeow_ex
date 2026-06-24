defmodule Whatsmeow.Media.Download do
  @moduledoc """
  Media download pipeline — fetch the signed URL via Finch, verify HMAC,
  decrypt AES-CBC.

  Ports `whatsmeow-main/download.go`.

  ## Entry points

    * `decrypt/3` — verify MAC + AES-CBC decrypt a buffered ciphertext
      blob (used by tests and the streaming path's tail).
    * `fetch_and_decrypt/2` — given a `media_descriptor` (the maps
      produced by `Whatsmeow.Signal.MessageBuilder.from_plaintext/2`),
      pick the right URL, GET it via Finch, then decrypt.

  Two URL modes:

    1. `:url` carries a full https URL — fetch directly.
    2. `:direct_path` carries a `/v/...` path — the caller must pass a
       `%Whatsmeow.Media.Conn{}` so we can join the path against one of
       the cached download hosts (with simple retry across hosts).

  Voice notes (`:voice`) use the same key-expansion info as `:audio` —
  upstream Go maps both to `MediaAudio`.
  """

  alias Whatsmeow.Crypto.{AES, HKDF}
  alias Whatsmeow.Media.{Conn, Finch}

  @type media_type :: :image | :video | :audio | :document | :sticker | :voice

  @doc """
  Fetch a remote ciphertext blob and decrypt under `media_key`.

  Accepts a descriptor map from `Whatsmeow.Signal.MessageBuilder` —
  same shape WhatsApp emits in `imageMessage` / `videoMessage` / …:

      %{
        kind: :image,
        url: "https://mmg.whatsapp.net/...",
        direct_path: "/v/t62.7118-24/...",
        media_key: <<…32 bytes…>>,
        file_sha256: <<…32 bytes…>>,
        file_enc_sha256: <<…32 bytes…>>,
        file_length: 1234,
        mime_type: "image/jpeg",
        ...
      }

  ## Options

    * `:media_conn` — `%Whatsmeow.Media.Conn{}` (required when only
      `:direct_path` is set).
    * `:max_bytes` — abort if the ciphertext exceeds this (defaults to
      100 MiB).
    * `:headers` — extra headers passed to Finch (rare; tests use this).

  Returns `{:ok, plaintext_bytes}` or `{:error, reason}`. On success
  the plaintext is verified against `file_sha256` when present.
  """
  @spec fetch_and_decrypt(map(), keyword()) :: {:ok, binary()} | {:error, term()}
  def fetch_and_decrypt(%{} = descriptor, opts \\ []) do
    with {:ok, urls} <- resolve_urls(descriptor, opts),
         {:ok, body} <- get_first(urls, opts),
         :ok <- check_size(body, opts),
         {:ok, plain} <- decrypt(body, descriptor.media_key, normalise_kind(descriptor.kind)),
         :ok <- verify_sha(plain, descriptor[:file_sha256]) do
      {:ok, plain}
    end
  end

  @doc """
  Decrypt downloaded `ciphertext_with_mac` (the body fetched from the
  upload URL — ciphertext followed by 10-byte MAC) under `media_key`.

  Returns `{:ok, plaintext}` on success.
  """
  @spec decrypt(binary(), binary(), media_type()) :: {:ok, binary()} | {:error, atom()}
  def decrypt(body, media_key, media_type)
      when is_binary(body) and byte_size(media_key) == 32 and is_atom(media_type) do
    if byte_size(body) <= 10 do
      {:error, :body_too_short}
    else
      ct_len = byte_size(body) - 10
      <<ct::binary-size(ct_len), tag::binary-size(10)>> = body

      expansion = HKDF.derive(media_key, <<0::256>>, info_for(media_type), 112)

      <<iv::binary-size(16), enc_key::binary-size(32), mac_key::binary-size(32),
        _ref_key::binary-size(32)>> = expansion

      expected =
        :crypto.mac(:hmac, :sha256, mac_key, iv <> ct) |> binary_part(0, 10)

      if :crypto.hash_equals(expected, tag) do
        AES.CBC.decrypt(enc_key, iv, ct)
      else
        {:error, :mac_mismatch}
      end
    end
  end

  # --- URL resolution -----------------------------------------------------

  defp resolve_urls(descriptor, opts) do
    url = descriptor[:url] || ""
    direct_path = descriptor[:direct_path] || ""

    cond do
      use_url?(url) ->
        {:ok, [url]}

      String.starts_with?(direct_path, "/") ->
        case Keyword.get(opts, :media_conn) do
          %Conn{hosts: [_ | _]} = conn ->
            mms = mms_type(descriptor.kind)
            path_with_query = build_direct_path_query(direct_path, descriptor, mms)
            {:ok, Conn.all_urls(conn, path_with_query)}

          _ ->
            {:error, :media_conn_required}
        end

      true ->
        {:error, :no_url_present}
    end
  end

  # Full WA-CDN URLs are usable as-is; web.whatsapp.net signed URLs are
  # browser-only and reject our Finch fetch, so we route them through
  # the direct-path + media-conn path instead.
  defp use_url?(""), do: false
  defp use_url?("https://web.whatsapp.net" <> _), do: false
  defp use_url?("https://" <> _), do: true
  defp use_url?(_), do: false

  defp build_direct_path_query(path, descriptor, mms) do
    enc_hash = descriptor[:file_enc_sha256] || <<>>
    enc_hash_b64 = Base.url_encode64(enc_hash, padding: true)
    "#{path}&hash=#{enc_hash_b64}&mms-type=#{mms}&__wa-mms="
  end

  defp mms_type(:image), do: "image"
  defp mms_type(:video), do: "video"
  defp mms_type(:audio), do: "audio"
  defp mms_type(:voice), do: "audio"
  defp mms_type(:document), do: "document"
  defp mms_type(:sticker), do: "image"

  # --- HTTP fan-out over hosts -------------------------------------------

  defp get_first([], _opts), do: {:error, :no_hosts}

  defp get_first([url | rest], opts) do
    case fetch_one(url, opts) do
      {:ok, body} -> {:ok, body}
      {:error, reason} when rest == [] -> {:error, {:download, reason}}
      {:error, _} -> get_first(rest, opts)
    end
  end

  defp fetch_one(url, opts) do
    headers = Keyword.get(opts, :headers, []) ++ [{"user-agent", "whatsmeow_ex/0.1"}]

    case Finch.collect_body(url, headers: headers) do
      {:ok, status, iodata} when status in 200..299 ->
        {:ok, IO.iodata_to_binary(iodata)}

      {:ok, status, _} ->
        {:error, {:http_status, status}}

      {:error, _} = err ->
        err
    end
  rescue
    # Finch isn't started, registry not running, etc. — surface as
    # a regular error so the caller can fall through to the next host.
    e -> {:error, {:finch, Exception.message(e)}}
  end

  defp check_size(body, opts) do
    max = Keyword.get(opts, :max_bytes, 100 * 1024 * 1024)
    if byte_size(body) <= max, do: :ok, else: {:error, :too_large}
  end

  # --- integrity ---------------------------------------------------------

  # File SHA-256 verification is optional — older messages don't carry
  # the field. When set, we enforce it; mismatch is fatal.
  defp verify_sha(_plain, nil), do: :ok
  defp verify_sha(_plain, <<>>), do: :ok

  defp verify_sha(plain, expected) when is_binary(expected) and byte_size(expected) == 32 do
    actual = :crypto.hash(:sha256, plain)
    if :crypto.hash_equals(actual, expected), do: :ok, else: {:error, :sha_mismatch}
  end

  defp verify_sha(_plain, _), do: :ok

  defp normalise_kind(:voice), do: :audio
  defp normalise_kind(kind), do: kind

  defp info_for(:image), do: "WhatsApp Image Keys"
  defp info_for(:video), do: "WhatsApp Video Keys"
  defp info_for(:audio), do: "WhatsApp Audio Keys"
  defp info_for(:document), do: "WhatsApp Document Keys"
  defp info_for(:sticker), do: "WhatsApp Image Keys"
end
