defmodule Whatsmeow.Media.UploadTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Media.{Download, Upload}

  for media_type <- [:image, :video, :audio, :document, :sticker] do
    test "round-trip for #{media_type}" do
      plaintext = :crypto.strong_rand_bytes(4096)
      enc = Upload.encrypt(plaintext, unquote(media_type))
      body = enc.ciphertext <> enc.mac

      assert {:ok, ^plaintext} = Download.decrypt(body, enc.media_key, unquote(media_type))
    end
  end

  test "tampered MAC is detected" do
    pt = "tiny"
    enc = Upload.encrypt(pt, :image)
    bad = enc.ciphertext <> :crypto.exor(enc.mac, <<1, 0::72>>)
    assert {:error, :mac_mismatch} = Download.decrypt(bad, enc.media_key, :image)
  end
end
