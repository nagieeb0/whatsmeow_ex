defmodule Whatsmeow.PairTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Crypto.{Curve25519, XEdDSA}
  alias Whatsmeow.Pair
  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.Types.JID

  alias WAAdv.ADVDeviceIdentity
  alias WAAdv.ADVSignedDeviceIdentity
  alias WAAdv.ADVSignedDeviceIdentityHMAC

  # --- fixtures -------------------------------------------------------------

  defp fresh_device do
    {_, noise} = Curve25519.generate_keypair()
    {_, ident} = Curve25519.generate_keypair()
    {_, spk} = Curve25519.generate_keypair()

    %Device{
      jid: "smoke-#{System.unique_integer([:positive])}",
      registration_id: 0xCAFEBABE,
      noise_key: noise,
      identity_key: ident,
      signed_pre_key: spk,
      signed_pre_key_id: 1,
      signed_pre_key_sig: :crypto.strong_rand_bytes(64),
      adv_key: :crypto.strong_rand_bytes(32)
    }
  end

  defp build_pair_success_iq(device, opts \\ []) do
    # Account-signing keypair belongs to the *phone* in production. The phone
    # uses XEdDSA to sign the device-identity details with its main identity
    # key. We simulate that here.
    {acct_pub, acct_priv} = Curve25519.generate_keypair()

    dev_id =
      %ADVDeviceIdentity{
        rawID: 1234,
        timestamp: 1_700_000_000,
        keyIndex: Keyword.get(opts, :key_index, 1),
        accountType: :E2EE,
        deviceType: :E2EE
      }
      |> ADVDeviceIdentity.encode()
      |> IO.iodata_to_binary()

    our_identity_pub = Curve25519.public_for(device.identity_key)

    # The phone's account signature is XEdDSA(acct_priv) over
    # `0x06,0x00 || dev_id || our_identity_pub`.
    acct_sig_msg = <<6, 0>> <> dev_id <> our_identity_pub
    acct_sig = XEdDSA.sign(acct_priv, acct_sig_msg, :crypto.strong_rand_bytes(64))

    signed_id =
      %ADVSignedDeviceIdentity{
        details: dev_id,
        accountSignatureKey: acct_pub,
        accountSignature: acct_sig,
        deviceSignature: nil
      }
      |> ADVSignedDeviceIdentity.encode()
      |> IO.iodata_to_binary()

    # Outer HMAC over the signed-id bytes.
    mac =
      :crypto.mac(:hmac, :sha256, Keyword.get(opts, :hmac_key, device.adv_key), [<<>>, signed_id])

    container =
      %ADVSignedDeviceIdentityHMAC{
        details: signed_id,
        HMAC: Keyword.get(opts, :override_mac, mac),
        accountType: :E2EE
      }
      |> ADVSignedDeviceIdentityHMAC.encode()
      |> IO.iodata_to_binary()

    jid = JID.new(Integer.to_string(Keyword.get(opts, :user_int, 1_234_567_890)), "s.whatsapp.net")
    lid = JID.new("9876543210", "lid")

    Node.new(
      "iq",
      %{
        "id" => Keyword.get(opts, :req_id, "test-req-1"),
        "from" => "s.whatsapp.net",
        "type" => "set"
      },
      [
        Node.new("pair-success", %{}, [
          Node.new("device-identity", %{}, container),
          Node.new("device", %{"jid" => jid, "lid" => lid}, nil),
          Node.new("biz", %{"name" => Keyword.get(opts, :business_name, "Acme")}, nil),
          Node.new("platform", %{"name" => Keyword.get(opts, :platform, "android")}, nil)
        ])
      ]
    )
  end

  # --- happy path -----------------------------------------------------------

  describe "handle_pair_success/2 — happy path" do
    test "decodes the IQ, verifies signatures, and produces an updated device + ack node" do
      device = fresh_device()
      iq = build_pair_success_iq(device, req_id: "req-42", business_name: "Hi", platform: "ios")

      assert {:ok, %Pair.Result{} = result} = Pair.handle_pair_success(iq, device)

      assert result.req_id == "req-42"
      assert result.business_name == "Hi"
      assert result.platform == "ios"
      assert result.jid =~ "@s.whatsapp.net"
      assert is_binary(result.lid)

      # Device fields populated.
      assert byte_size(result.device.adv_details) > 0
      assert byte_size(result.device.adv_account_sig) == 64
      assert byte_size(result.device.adv_account_sig_key) == 32
      assert byte_size(result.device.adv_device_sig) == 64
      assert result.device.business_name == "Hi"
      assert result.device.platform == "ios"

      # Ack IQ shape.
      assert %Node{tag: "iq", attrs: %{"type" => "result", "id" => "req-42"}} = result.ack_iq

      assert %Node{tag: "pair-device-sign", content: [%Node{tag: "device-identity"} = di]} =
               Node.get_child(result.ack_iq, "pair-device-sign")

      assert Node.attr(di, "key-index") == "1"
      assert is_binary(di.content)
      assert byte_size(di.content) > 0
    end

    test "device signature is a real XEdDSA signature that round-trips" do
      device = fresh_device()
      iq = build_pair_success_iq(device)

      {:ok, result} = Pair.handle_pair_success(iq, device)

      # Decode the self-signed identity from the ack and check the device
      # signature verifies against *our* identity pubkey.
      di = Node.get_child(result.ack_iq, "pair-device-sign") |> Node.get_child("device-identity")
      self_signed = ADVSignedDeviceIdentity.decode(di.content)

      our_identity_pub = Curve25519.public_for(device.identity_key)

      # Reconstruct the message the device signature was computed over.
      # We need the original accountSignatureKey, which we cleared from the
      # ack payload — pull it from the result.device.
      sig_msg =
        <<6, 1>> <>
          self_signed.details <>
          our_identity_pub <>
          result.device.adv_account_sig_key

      assert XEdDSA.verify(our_identity_pub, sig_msg, self_signed.deviceSignature)
    end

    test "self-signed identity in the ack has accountSignatureKey stripped" do
      device = fresh_device()
      iq = build_pair_success_iq(device)

      {:ok, result} = Pair.handle_pair_success(iq, device)

      di = Node.get_child(result.ack_iq, "pair-device-sign") |> Node.get_child("device-identity")
      self_signed = ADVSignedDeviceIdentity.decode(di.content)

      # AccountSignatureKey is nil in protobuf when not set, decoded as <<>>.
      assert self_signed.accountSignatureKey in [nil, <<>>]
      # But details + accountSignature + deviceSignature are present.
      assert byte_size(self_signed.details) > 0
      assert byte_size(self_signed.accountSignature) == 64
      assert byte_size(self_signed.deviceSignature) == 64
    end
  end

  # --- error paths ----------------------------------------------------------

  describe "handle_pair_success/2 — error paths" do
    test "returns :hmac_mismatch when the HMAC doesn't match adv_key" do
      device = fresh_device()
      iq = build_pair_success_iq(device, override_mac: <<0::256>>)

      assert {:error, :hmac_mismatch} = Pair.handle_pair_success(iq, device)
    end

    test "returns :hmac_mismatch when adv_key was rotated" do
      device = fresh_device()
      iq = build_pair_success_iq(device, hmac_key: :crypto.strong_rand_bytes(32))

      assert {:error, :hmac_mismatch} = Pair.handle_pair_success(iq, device)
    end

    test "returns :no_pair_success_child when the inner element is missing" do
      iq = Node.new("iq", %{"id" => "x", "type" => "set"}, [])
      device = fresh_device()

      assert {:error, :no_pair_success_child} = Pair.handle_pair_success(iq, device)
    end

    test "returns :missing_device_identity when <device-identity> is absent" do
      device = fresh_device()
      iq = Node.new("iq", %{"id" => "x", "type" => "set"}, [Node.new("pair-success", %{}, [])])

      assert {:error, :missing_device_identity} = Pair.handle_pair_success(iq, device)
    end
  end

  # --- pair-device ack builder ---------------------------------------------

  describe "build_pair_device_ack/1" do
    test "echoes id and from with type=result and no children" do
      iq = Node.new("iq", %{"id" => "abc", "from" => "s.whatsapp.net", "type" => "set"}, [])
      ack = Pair.build_pair_device_ack(iq)

      assert ack.tag == "iq"
      assert ack.attrs["id"] == "abc"
      assert ack.attrs["to"] == "s.whatsapp.net"
      assert ack.attrs["type"] == "result"
      assert ack.content == nil
    end
  end

  describe "build_pair_error_iq/3" do
    test "builds an <iq type=\"error\"> with the given code and text" do
      iq = Pair.build_pair_error_iq("req-7", 401, "hmac-mismatch")

      assert iq.tag == "iq"
      assert iq.attrs["type"] == "error"
      assert iq.attrs["id"] == "req-7"

      err = Node.get_child(iq, "error")
      assert err.attrs["code"] == "401"
      assert err.attrs["text"] == "hmac-mismatch"
    end
  end
end
