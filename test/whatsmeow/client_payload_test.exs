defmodule Whatsmeow.ClientPayloadTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.ClientPayload
  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Store.Schemas.Device

  alias WAWebProtobufsWa6.ClientPayload, as: PBClientPayload

  defp test_device(opts \\ []) do
    {_, noise} = Curve25519.generate_keypair()
    {_, ident} = Curve25519.generate_keypair()
    {_, spk} = Curve25519.generate_keypair()

    %Device{
      jid: Keyword.get(opts, :jid, "device-test-#{System.unique_integer([:positive])}"),
      registration_id: Keyword.get(opts, :registration_id, 0x01020304),
      noise_key: noise,
      identity_key: ident,
      signed_pre_key: spk,
      signed_pre_key_id: 1,
      signed_pre_key_sig: :crypto.strong_rand_bytes(64),
      adv_key: :crypto.strong_rand_bytes(32)
    }
  end

  describe "registration_payload/1" do
    test "encodes & round-trips through the protobuf codec" do
      device = test_device()
      payload = ClientPayload.registration_payload(device)
      bin = PBClientPayload.encode(payload)
      assert is_binary(bin) and byte_size(bin) > 0

      decoded = PBClientPayload.decode(bin)
      assert decoded.passive == false
      assert decoded.pull == false
      assert decoded.connectType == :WIFI_UNKNOWN
      assert decoded.connectReason == :USER_ACTIVATED
      assert decoded.userAgent.platform == :WEB
      assert decoded.userAgent.releaseChannel == :RELEASE
      assert decoded.userAgent.localeLanguageIso6391 == "en"

      data = decoded.devicePairingData
      assert byte_size(data.eRegid) == 4
      assert <<0x01, 0x02, 0x03, 0x04>> == data.eRegid
      assert data.eKeytype == <<5>>
      assert byte_size(data.eIdent) == 32
      assert byte_size(data.eSkeyID) == 3
      assert byte_size(data.eSkeyVal) == 32
      assert byte_size(data.eSkeySig) == 64
      assert byte_size(data.buildHash) == 16
      assert is_binary(data.deviceProps) and byte_size(data.deviceProps) > 0
    end
  end

  describe "login_payload/1" do
    test "uses passive=true, pull=true, and parses user:device JID" do
      device = test_device(jid: "1234567890:7@s.whatsapp.net")
      payload = ClientPayload.login_payload(device)
      bin = PBClientPayload.encode(payload)

      decoded = PBClientPayload.decode(bin)
      assert decoded.passive == true
      assert decoded.pull == true
      assert decoded.lidDbMigrated == true
      assert decoded.username == 1_234_567_890
      assert decoded.device == 7
      assert decoded.lc == 1
    end

    test "handles JID without explicit device suffix (defaults to 0)" do
      device = test_device(jid: "1234567890@s.whatsapp.net")
      payload = ClientPayload.login_payload(device)
      decoded = payload |> PBClientPayload.encode() |> PBClientPayload.decode()
      assert decoded.username == 1_234_567_890
      assert decoded.device == 0
    end
  end

  describe "build/1 dispatch" do
    test "picks registration_payload for unpaired devices (device- prefix JID)" do
      device = test_device(jid: "device-fresh")

      assert %PBClientPayload{
               passive: false,
               pull: false,
               devicePairingData: %WAWebProtobufsWa6.ClientPayload.DevicePairingRegistrationData{}
             } = ClientPayload.build(device)
    end

    test "picks login_payload for paired devices (real JID)" do
      device = test_device(jid: "1234567890:1@s.whatsapp.net")

      assert %PBClientPayload{passive: true, pull: true, devicePairingData: nil} =
               ClientPayload.build(device)
    end

    test "picks registration_payload for any non-@ placeholder JID (e.g. smoke-)" do
      for jid <- ["smoke-12345", "device-fresh", "", "anything-without-at-sign"] do
        device = test_device(jid: jid)

        assert %PBClientPayload{passive: false, pull: false, devicePairingData: %{}} =
                 ClientPayload.build(device),
               "expected registration_payload for jid=#{inspect(jid)}"
      end
    end

    test "registration_payload encodes without raising for a smoke-style JID" do
      device = test_device(jid: "smoke-12345")
      bin = device |> ClientPayload.build() |> PBClientPayload.encode()
      assert is_binary(bin) and byte_size(bin) > 0
    end
  end

  describe "wa_version_hash/0" do
    test "is a 16-byte md5" do
      assert byte_size(ClientPayload.wa_version_hash()) == 16
    end
  end
end
