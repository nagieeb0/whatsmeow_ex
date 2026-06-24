defmodule Whatsmeow.Media.DownloadTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Media.{Conn, Download, Upload}

  describe "decrypt/3 round-trip" do
    test "voice notes share the audio key-info string" do
      pt = "hello voice"
      enc = Upload.encrypt(pt, :audio)
      body = enc.ciphertext <> enc.mac
      # Voice is just PTT-flagged audio — same HKDF info, same outcome.
      assert {:ok, ^pt} = Download.decrypt(body, enc.media_key, :audio)
    end
  end

  describe "fetch_and_decrypt/2 — URL resolution" do
    test "missing both url + direct_path returns :no_url_present" do
      descriptor = %{
        kind: :image,
        url: nil,
        direct_path: nil,
        media_key: :crypto.strong_rand_bytes(32),
        file_sha256: nil,
        file_enc_sha256: nil
      }

      assert {:error, :no_url_present} = Download.fetch_and_decrypt(descriptor)
    end

    test "direct_path without a media_conn returns :media_conn_required" do
      descriptor = %{
        kind: :image,
        url: nil,
        direct_path: "/v/t62/foo",
        media_key: :crypto.strong_rand_bytes(32),
        file_sha256: nil,
        file_enc_sha256: <<0::256>>
      }

      assert {:error, :media_conn_required} = Download.fetch_and_decrypt(descriptor)
    end

    test "web.whatsapp.net URLs are skipped (require direct_path fallback)" do
      descriptor = %{
        kind: :image,
        url: "https://web.whatsapp.net/foo",
        direct_path: nil,
        media_key: :crypto.strong_rand_bytes(32),
        file_sha256: nil,
        file_enc_sha256: nil
      }

      assert {:error, :no_url_present} = Download.fetch_and_decrypt(descriptor)
    end

    test "direct_path with a populated media_conn builds proper URLs (just not fetched here)" do
      # Pure URL construction — we can't actually fetch in a unit test, but
      # we can prove the resolver picked the direct-path path by getting
      # past it to the download stage, where it'll fail on the unreachable
      # host (which is what we assert here).
      conn = %Conn{
        hosts: ["nonexistent.invalid"],
        fetched_at: DateTime.utc_now(),
        ttl: 3600
      }

      descriptor = %{
        kind: :image,
        url: nil,
        direct_path: "/v/t62/foo",
        media_key: :crypto.strong_rand_bytes(32),
        file_sha256: nil,
        file_enc_sha256: <<0::256>>
      }

      assert {:error, {:download, _}} = Download.fetch_and_decrypt(descriptor, media_conn: conn)
    end
  end
end
