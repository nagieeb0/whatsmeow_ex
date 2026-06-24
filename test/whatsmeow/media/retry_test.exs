defmodule Whatsmeow.Media.RetryTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Media.Retry
  alias Whatsmeow.Media.Retry.Notification
  alias Whatsmeow.Types.JID

  defp our_jid, do: %JID{user: "447400000000", server: "s.whatsapp.net"}
  defp chat_jid, do: %JID{user: "99999", server: "s.whatsapp.net"}

  describe "build_retry_receipt/5" do
    test "produces canonical <receipt type=server-error> shape" do
      media_key = :crypto.strong_rand_bytes(32)

      node = Retry.build_retry_receipt(our_jid(), chat_jid(), "MSG-1", media_key)

      assert node.tag == "receipt"
      assert node.attrs["type"] == "server-error"
      assert node.attrs["id"] == "MSG-1"
      assert node.attrs["to"].user == "447400000000"

      [encrypt, rmr] = node.content
      assert encrypt.tag == "encrypt"
      [enc_p, enc_iv] = encrypt.content
      assert enc_p.tag == "enc_p"
      assert is_binary(enc_p.content)
      assert enc_iv.tag == "enc_iv"
      assert byte_size(enc_iv.content) == 12

      assert rmr.tag == "rmr"
      assert rmr.attrs["jid"] == chat_jid()
      assert rmr.attrs["from_me"] == "false"
      refute Map.has_key?(rmr.attrs, "participant")
    end

    test "group context includes participant attr" do
      media_key = :crypto.strong_rand_bytes(32)
      sender = %JID{user: "55555", server: "s.whatsapp.net"}

      node =
        Retry.build_retry_receipt(our_jid(), chat_jid(), "MSG-1", media_key,
          from_me?: true,
          sender_jid: sender
        )

      [_encrypt, rmr] = node.content
      assert rmr.attrs["from_me"] == "true"
      assert rmr.attrs["participant"] == sender
    end
  end

  describe "round-trip: build → parse → decrypt" do
    test "decryption returns the MediaRetryNotification proto" do
      media_key = :crypto.strong_rand_bytes(32)
      iv = :crypto.strong_rand_bytes(12)
      msg_id = "MSG-XYZ"

      # 1. Build the retry receipt (this encrypts a ServerErrorReceipt, NOT
      #    what we'd parse on the receive side — but we use the same key
      #    derivation, so we can simulate a server-side encryption of a
      #    MediaRetryNotification by manually building the ciphertext).
      receipt_node = Retry.build_retry_receipt(our_jid(), chat_jid(), msg_id, media_key)
      assert receipt_node.tag == "receipt"

      # 2. Simulate the server's response: encrypt a MediaRetryNotification
      #    proto under the same key, AAD = msg_id.
      notif_proto = %WAMmsRetry.MediaRetryNotification{
        stanzaID: msg_id,
        directPath: "/v/t62/replaced-direct-path"
      }

      plain = notif_proto |> WAMmsRetry.MediaRetryNotification.encode() |> IO.iodata_to_binary()

      key =
        Whatsmeow.Crypto.HKDF.expand(
          Whatsmeow.Crypto.HKDF.extract(media_key, <<>>),
          "WhatsApp Media Retry Notification",
          32
        )

      {ct, tag} = :crypto.crypto_one_time_aead(:aes_256_gcm, key, iv, plain, msg_id, true)

      simulated_notif =
        Node.new(
          "notification",
          %{"id" => msg_id, "t" => "1715000000"},
          [
            Node.new("rmr", %{"jid" => chat_jid(), "from_me" => "true"}, nil),
            Node.new("encrypt", %{}, [
              Node.new("enc_p", %{}, ct <> tag),
              Node.new("enc_iv", %{}, iv)
            ])
          ]
        )

      # 3. Parse + decrypt
      assert {:ok, %Notification{} = parsed} = Retry.parse_notification(simulated_notif)
      assert parsed.message_id == msg_id
      assert parsed.from_me? == true
      assert parsed.timestamp == 1_715_000_000

      assert {:ok, decoded} = Retry.decrypt(parsed, media_key)
      assert decoded.directPath == "/v/t62/replaced-direct-path"
    end

    test "decrypt/2 surfaces server-error code instead of decrypting" do
      err_notif =
        Node.new(
          "notification",
          %{"id" => "X", "t" => "1"},
          [
            Node.new("rmr", %{"jid" => chat_jid(), "from_me" => "true"}, nil),
            Node.new("error", %{"code" => "2"}, nil)
          ]
        )

      assert {:ok, parsed} = Retry.parse_notification(err_notif)
      assert {:server_error, 2} = elem(Retry.decrypt(parsed, :crypto.strong_rand_bytes(32)), 1)
    end

    test "decrypt/2 fails on tampered ciphertext (AEAD auth)" do
      media_key = :crypto.strong_rand_bytes(32)

      # Build a legitimate ciphertext then flip a bit.
      iv = :crypto.strong_rand_bytes(12)
      plain = "anything"

      key =
        Whatsmeow.Crypto.HKDF.expand(
          Whatsmeow.Crypto.HKDF.extract(media_key, <<>>),
          "WhatsApp Media Retry Notification",
          32
        )

      {ct, tag} = :crypto.crypto_one_time_aead(:aes_256_gcm, key, iv, plain, "MSG", true)

      <<head, rest::binary>> = ct
      tampered_ct = <<Bitwise.bxor(head, 1)>> <> rest

      notif = %Notification{
        message_id: "MSG",
        chat_id: chat_jid(),
        ciphertext: tampered_ct <> tag,
        iv: iv,
        from_me?: false
      }

      assert {:error, _} = Retry.decrypt(notif, media_key)
    end
  end

  describe "parse_notification/1 — error paths" do
    test "missing rmr → :missing_rmr" do
      node = Node.new("notification", %{"id" => "X"}, [])
      assert {:error, :missing_rmr} = Retry.parse_notification(node)
    end

    test "missing encrypt children → :missing_encrypt_children" do
      node =
        Node.new("notification", %{"id" => "X"}, [
          Node.new("rmr", %{"jid" => chat_jid(), "from_me" => "true"}, nil),
          Node.new("encrypt", %{}, [])
        ])

      assert {:error, :missing_encrypt_children} = Retry.parse_notification(node)
    end
  end
end
