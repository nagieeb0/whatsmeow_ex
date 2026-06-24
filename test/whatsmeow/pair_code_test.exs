defmodule Whatsmeow.PairCodeTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.PairCode

  describe "generate_ephemeral_key/0" do
    test "returns a 32-byte keypair + 80-byte wrapped blob + 8-char linking code" do
      {{pub, priv}, blob, code} = PairCode.generate_ephemeral_key()

      assert byte_size(pub) == 32
      assert byte_size(priv) == 32
      assert byte_size(blob) == 80
      assert byte_size(code) == 8

      # Code uses the custom base32 alphabet
      assert String.match?(code, ~r/^[123456789ABCDEFGHJKLMNPQRSTVWXYZ]{8}$/)
    end

    test "successive calls produce distinct keys + blobs" do
      {{a_pub, _}, a_blob, a_code} = PairCode.generate_ephemeral_key()
      {{b_pub, _}, b_blob, b_code} = PairCode.generate_ephemeral_key()

      refute a_pub == b_pub
      refute a_blob == b_blob
      refute a_code == b_code
    end
  end

  describe "format_code/1" do
    test "splits 8-char raw into XXXX-XXXX" do
      assert PairCode.format_code("ABCDEFGH") == "ABCD-EFGH"
    end
  end

  describe "normalize_phone/1" do
    test "strips non-digit chars" do
      assert {:ok, "447400000000"} = PairCode.normalize_phone("+44 7400 000 000")
    end

    test "rejects too-short numbers" do
      assert {:error, :phone_too_short} = PairCode.normalize_phone("12345")
    end

    test "rejects leading-zero (national-format) numbers" do
      assert {:error, :phone_not_international} = PairCode.normalize_phone("07400000000")
    end

    test "accepts pure-digit international format" do
      assert {:ok, "447400000000"} = PairCode.normalize_phone("447400000000")
    end
  end

  describe "build_hello_iq/4" do
    test "produces the canonical md-namespaced IQ shape" do
      blob = :crypto.strong_rand_bytes(80)
      noise_pub = :crypto.strong_rand_bytes(32)

      iq =
        PairCode.build_hello_iq("447400000000@s.whatsapp.net", blob, noise_pub, %{
          id: "FIXED",
          client_type: 7,
          client_display: "Chrome (Linux)",
          show_push_notification?: true
        })

      assert iq.tag == "iq"
      assert iq.attrs["xmlns"] == "md"
      assert iq.attrs["type"] == "set"
      assert iq.attrs["id"] == "FIXED"

      [reg] = iq.content
      assert reg.tag == "link_code_companion_reg"
      assert reg.attrs["stage"] == "companion_hello"
      # jid is a %JID{} struct so the binary encoder emits the @jid_pair opcode
      # (a plain string makes the server silently drop the IQ).
      assert to_string(reg.attrs["jid"]) == "447400000000@s.whatsapp.net"
      assert reg.attrs["should_show_push_notification"] == "true"

      child_tags = Enum.map(reg.content, & &1.tag)

      assert "link_code_pairing_wrapped_companion_ephemeral_pub" in child_tags
      assert "companion_server_auth_key_pub" in child_tags
      assert "companion_platform_id" in child_tags
      assert "companion_platform_display" in child_tags
      assert "link_code_pairing_nonce" in child_tags

      wrapped_node =
        Enum.find(reg.content, &(&1.tag == "link_code_pairing_wrapped_companion_ephemeral_pub"))

      assert wrapped_node.content == blob
    end
  end

  describe "build_finish_iq/4" do
    test "wraps the bundle + identity + pairing ref" do
      bundle = :crypto.strong_rand_bytes(80)
      id_pub = :crypto.strong_rand_bytes(32)

      iq =
        PairCode.build_finish_iq("447400000000@s.whatsapp.net", bundle, id_pub, "REF-1", id: "F")

      [reg] = iq.content
      assert reg.attrs["stage"] == "companion_finish"

      tags = Enum.map(reg.content, & &1.tag)
      assert "link_code_pairing_wrapped_key_bundle" in tags
      assert "companion_identity_public" in tags
      assert "link_code_pairing_ref" in tags
    end
  end

  describe "unwrap_primary_ephemeral_pub/3 (round-trip vs generate_ephemeral_key/0)" do
    test "decrypts the wrapped pub blob → ECDH shared secret matches" do
      # Simulate the phone side: it generates its own keypair + wraps the pub
      # the same way we do. Then we (the companion) unwrap and DH.
      {{_phone_pub, phone_priv}, phone_blob, phone_code} = PairCode.generate_ephemeral_key()

      # We must also have an ephemeral keypair on our side to compute the
      # shared secret.
      {our_pub, our_priv} = Curve25519.generate_keypair()

      assert {:ok, shared} = PairCode.unwrap_primary_ephemeral_pub(phone_blob, phone_code, our_priv)
      assert byte_size(shared) == 32

      # The shared secret we computed (our_priv ⋅ phone_pub) should match
      # the one the phone would compute on the other side (phone_priv ⋅ our_pub).
      phone_side_shared = Curve25519.agree(phone_priv, our_pub)
      assert shared == phone_side_shared
    end

    test "rejects wrong-length wrapped pubs" do
      assert {:error, :bad_wrapped_pub_length} =
               PairCode.unwrap_primary_ephemeral_pub(
                 <<1, 2, 3>>,
                 "ABCDEFGH",
                 :crypto.strong_rand_bytes(32)
               )
    end
  end

  describe "derive_adv_secret/3" do
    test "is deterministic per input triple" do
      a = :crypto.strong_rand_bytes(32)
      b = :crypto.strong_rand_bytes(32)
      r = :crypto.strong_rand_bytes(32)

      assert PairCode.derive_adv_secret(a, b, r) == PairCode.derive_adv_secret(a, b, r)
    end

    test "32-byte output" do
      a = :crypto.strong_rand_bytes(32)
      b = :crypto.strong_rand_bytes(32)
      r = :crypto.strong_rand_bytes(32)
      assert byte_size(PairCode.derive_adv_secret(a, b, r)) == 32
    end
  end

  describe "wrap_key_bundle/5 round-trip" do
    test "encrypts the (our_id || primary_id || adv_random) triple under HKDF-derived key" do
      ephemeral_shared = :crypto.strong_rand_bytes(32)
      our_id = :crypto.strong_rand_bytes(32)
      primary_id = :crypto.strong_rand_bytes(32)
      adv_random = :crypto.strong_rand_bytes(32)

      wrapped =
        PairCode.wrap_key_bundle(ephemeral_shared, our_id, primary_id, adv_random)

      # Output is <<salt::32, nonce::12, ct::32+32+32, tag::16>>
      assert byte_size(wrapped) == 32 + 12 + 32 + 32 + 32 + 16
    end

    test "round-trip decrypts cleanly" do
      ephemeral_shared = :crypto.strong_rand_bytes(32)
      our_id = :crypto.strong_rand_bytes(32)
      primary_id = :crypto.strong_rand_bytes(32)
      adv_random = :crypto.strong_rand_bytes(32)

      salt = :crypto.strong_rand_bytes(32)
      nonce = :crypto.strong_rand_bytes(12)

      wrapped =
        PairCode.wrap_key_bundle(ephemeral_shared, our_id, primary_id, adv_random, %{
          salt: salt,
          nonce: nonce
        })

      <<^salt::binary-size(32), ^nonce::binary-size(12), ct_and_tag::binary>> = wrapped
      ct = binary_part(ct_and_tag, 0, byte_size(ct_and_tag) - 16)
      tag = binary_part(ct_and_tag, byte_size(ct_and_tag) - 16, 16)

      key = PairCode.derive_key_bundle_key(ephemeral_shared, salt)

      assert ^our_id <> ^primary_id <> ^adv_random =
               :crypto.crypto_one_time_aead(:aes_256_gcm, key, nonce, ct, <<>>, tag, false)
    end
  end

  describe "parse_pair_notification/1" do
    test "extracts all three fields cleanly" do
      pairing_ref = "REF-123"
      wrapped = :crypto.strong_rand_bytes(80)
      primary_id = :crypto.strong_rand_bytes(32)

      parent =
        Node.new("notification", %{}, [
          Node.new("link_code_companion_reg", %{}, [
            Node.new("link_code_pairing_ref", %{}, pairing_ref),
            Node.new("link_code_pairing_wrapped_primary_ephemeral_pub", %{}, wrapped),
            Node.new("primary_identity_pub", %{}, primary_id)
          ])
        ])

      assert {:ok, parsed} = PairCode.parse_pair_notification(parent)
      assert parsed.pairing_ref == pairing_ref
      assert parsed.wrapped_primary_pub == wrapped
      assert parsed.primary_identity_pub == primary_id
    end

    test "returns :missing_or_malformed_child when wrapped pub is too short" do
      parent =
        Node.new("notification", %{}, [
          Node.new("link_code_companion_reg", %{}, [
            Node.new("link_code_pairing_ref", %{}, "X"),
            Node.new("link_code_pairing_wrapped_primary_ephemeral_pub", %{}, <<1, 2, 3>>),
            Node.new("primary_identity_pub", %{}, :crypto.strong_rand_bytes(32))
          ])
        ])

      assert {:error, :missing_or_malformed_child} =
               PairCode.parse_pair_notification(parent)
    end

    test "returns :missing_or_malformed_child when registration child absent" do
      assert {:error, :missing_or_malformed_child} =
               PairCode.parse_pair_notification(Node.new("notification", %{}, []))
    end
  end
end
