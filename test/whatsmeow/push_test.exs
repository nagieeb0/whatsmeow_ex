defmodule Whatsmeow.PushTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Push
  alias Whatsmeow.Push.{APNs, FCM, Web}

  describe "build_register_iq/2 — FCM" do
    test "produces gcm-platform config with token" do
      iq = Push.build_register_iq(%FCM{token: "fcm-token-xyz"}, id: "ID-1")

      assert iq.tag == "iq"
      assert iq.attrs["xmlns"] == "urn:xmpp:whatsapp:push"
      assert iq.attrs["type"] == "set"
      assert iq.attrs["id"] == "ID-1"

      [config] = iq.content
      assert config.tag == "config"
      assert config.attrs["platform"] == "gcm"
      assert config.attrs["id"] == "fcm-token-xyz"
      assert config.attrs["num_acc"] == "1"
    end
  end

  describe "build_register_iq/2 — APNs" do
    test "includes apple platform + base64-url-encoded pkey" do
      key = :crypto.strong_rand_bytes(32)

      iq =
        Push.build_register_iq(%APNs{token: "ios-token", msg_id_enc_key: key},
          id: "ID-2"
        )

      [config] = iq.content
      assert config.attrs["platform"] == "apple"
      assert config.attrs["id"] == "ios-token"
      assert config.attrs["pkey"] == Base.url_encode64(key, padding: false)
    end

    test "auto-generates a 32-byte msg_id_enc_key when nil" do
      iq = Push.build_register_iq(%APNs{token: "x"})
      [config] = iq.content
      decoded = Base.url_decode64!(config.attrs["pkey"], padding: false)
      assert byte_size(decoded) == 32
    end

    test "voip_token attached when set" do
      iq = Push.build_register_iq(%APNs{token: "x", voip_token: "voip-abc"})
      [config] = iq.content
      assert config.attrs["voip"] == "voip-abc"
    end

    test "voip attr absent when voip_token is nil" do
      iq = Push.build_register_iq(%APNs{token: "x"})
      [config] = iq.content
      refute Map.has_key?(config.attrs, "voip")
    end
  end

  describe "build_register_iq/2 — Web" do
    test "produces web-platform config with base64-encoded auth + p256dh" do
      iq =
        Push.build_register_iq(%Web{
          endpoint: "https://fcm.googleapis.com/fcm/send/abc",
          auth: <<1, 2, 3>>,
          p256dh: <<4, 5, 6, 7>>
        })

      [config] = iq.content
      assert config.attrs["platform"] == "web"
      assert config.attrs["endpoint"] == "https://fcm.googleapis.com/fcm/send/abc"
      assert config.attrs["auth"] == Base.encode64(<<1, 2, 3>>)
      assert config.attrs["p256dh"] == Base.encode64(<<4, 5, 6, 7>>)
    end
  end
end
