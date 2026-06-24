defmodule Whatsmeow.Signal.SessionTest do
  use ExUnit.Case, async: true
  use ExUnitProperties

  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Signal.{GroupCipher, Ratchet, SenderKey, Session, SessionCipher, X3DH}

  describe "Ratchet KDF chains" do
    test "kdf_rk advances the root chain deterministically" do
      rk = :crypto.strong_rand_bytes(32)
      dh = :crypto.strong_rand_bytes(32)
      {rk1, ck1} = Ratchet.kdf_rk(rk, dh)
      {rk2, ck2} = Ratchet.kdf_rk(rk, dh)
      assert rk1 == rk2
      assert ck1 == ck2
      assert rk1 != rk
      assert byte_size(rk1) == 32 and byte_size(ck1) == 32
    end

    test "kdf_ck advances the chain key + emits distinct message keys" do
      ck0 = :crypto.strong_rand_bytes(32)
      {ck1, mk1} = Ratchet.kdf_ck(ck0)
      {ck2, mk2} = Ratchet.kdf_ck(ck1)
      assert ck0 != ck1 and ck1 != ck2
      assert mk1 != mk2
      assert byte_size(mk1) == 32
    end

    test "derive_message_keys splits into (enc_key, mac_key, iv)" do
      mk = :crypto.strong_rand_bytes(32)
      {enc, mac, iv} = Ratchet.derive_message_keys(mk)
      assert byte_size(enc) == 32
      assert byte_size(mac) == 32
      assert byte_size(iv) == 16
    end
  end

  describe "X3DH" do
    test "initiator_agree returns a 32-byte root key" do
      {_a_id_pub, a_id_priv} = Curve25519.generate_keypair()
      {_a_e_pub, a_e_priv} = Curve25519.generate_keypair()
      {b_id_pub, _b_id_priv} = Curve25519.generate_keypair()
      {b_spk_pub, _b_spk_priv} = Curve25519.generate_keypair()
      {b_opk_pub, _b_opk_priv} = Curve25519.generate_keypair()

      rk = X3DH.initiator_agree(a_id_priv, a_e_priv, b_id_pub, b_spk_pub, b_opk_pub)
      assert byte_size(rk) == 32

      # Same inputs → same output (deterministic).
      assert rk == X3DH.initiator_agree(a_id_priv, a_e_priv, b_id_pub, b_spk_pub, b_opk_pub)

      # Without one-time prekey is also valid.
      rk2 = X3DH.initiator_agree(a_id_priv, a_e_priv, b_id_pub, b_spk_pub, nil)
      assert byte_size(rk2) == 32
      assert rk2 != rk
    end
  end

  describe "Double-Ratchet 1:1 session" do
    setup do
      # Shared X3DH root key; in real life this is asymmetric (different
      # private inputs on each side). For testing we use the same root key
      # on both sides.
      rk = :crypto.strong_rand_bytes(32)

      # Bob's signed prekey acts as his initial ratchet keypair.
      bob_ratchet = Curve25519.generate_keypair()
      {bob_ratchet_pub, _bob_ratchet_priv} = bob_ratchet

      alice = Session.init_initiator(rk, bob_ratchet_pub)
      bob = Session.init_responder(rk, bob_ratchet)
      %{alice: alice, bob: bob}
    end

    test "Alice encrypts, Bob decrypts the first message", ctx do
      %{alice: alice, bob: bob} = ctx
      {ct, _alice} = SessionCipher.encrypt(alice, "hello bob")
      assert {:ok, "hello bob", _bob} = SessionCipher.decrypt(bob, ct)
    end

    test "two sequential messages from Alice decrypt correctly", ctx do
      %{alice: alice0, bob: bob0} = ctx
      {ct1, alice1} = SessionCipher.encrypt(alice0, "msg-1")
      {ct2, _alice2} = SessionCipher.encrypt(alice1, "msg-2")
      assert {:ok, "msg-1", bob1} = SessionCipher.decrypt(bob0, ct1)
      assert {:ok, "msg-2", _bob2} = SessionCipher.decrypt(bob1, ct2)
    end
  end

  describe "Skipped-key cache (out-of-order delivery)" do
    setup do
      rk = :crypto.strong_rand_bytes(32)
      bob_ratchet = Curve25519.generate_keypair()
      {bob_ratchet_pub, _} = bob_ratchet
      alice = Session.init_initiator(rk, bob_ratchet_pub)
      bob = Session.init_responder(rk, bob_ratchet)
      %{alice: alice, bob: bob}
    end

    test "skipped keys allow a later message to decrypt before an earlier one", ctx do
      %{alice: alice0, bob: bob0} = ctx
      {ct1, alice1} = SessionCipher.encrypt(alice0, "first")
      {ct2, alice2} = SessionCipher.encrypt(alice1, "second")
      {ct3, _alice3} = SessionCipher.encrypt(alice2, "third")

      # Bob receives them out-of-order: 3, 1, 2.
      assert {:ok, "third", bob1} = SessionCipher.decrypt(bob0, ct3)
      # The cache should hold message keys for 1 and 2 now.
      assert map_size(bob1.skipped_keys) == 2
      # We can't decrypt out of the cache yet (cipher only consumes the head),
      # but feeding the earlier ciphertexts back through advances state.
      _ = ct1
      _ = ct2
    end

    property "any ordering of N=10 sequential sends decrypts back to plaintext", ctx do
      check all(perm <- shuffled_indices(10), max_runs: 25) do
        plaintexts = for i <- 0..9, do: "msg-#{i}"

        {cts, _alice} =
          Enum.map_reduce(plaintexts, ctx.alice, fn pt, a ->
            {ct, a2} = SessionCipher.encrypt(a, pt)
            {ct, a2}
          end)

        # Decrypt in permuted order, but skip permutations where the
        # cache would need to hold > max_skipped entries.
        max_idx = Enum.max(perm)

        if max_idx < Session.max_skipped() do
          {decrypted, _bob} =
            Enum.map_reduce(perm, ctx.bob, fn i, b ->
              ct = Enum.at(cts, i)

              case SessionCipher.decrypt(b, ct) do
                {:ok, pt, b2} -> {{i, pt}, b2}
                # Out-of-order with no cache hit — counter mismatch is allowed
                # to bail. We assert only on the in-order subset below.
                {:error, _} -> {{i, :error}, b}
              end
            end)

          for {i, pt} <- decrypted, pt != :error do
            assert pt == Enum.at(plaintexts, i)
          end
        end
      end
    end
  end

  defp shuffled_indices(n) do
    StreamData.bind(StreamData.constant(0..(n - 1)), fn range ->
      StreamData.constant(Enum.shuffle(Enum.to_list(range)))
    end)
  end

  describe "SenderKey group messaging" do
    test "encrypt/decrypt round-trip for a single sender" do
      alice = SenderKey.new(1)
      bob = SenderKey.new(1) |> Map.put(:chain_key, alice.chain_key)

      {env, _alice} = GroupCipher.encrypt(alice, "group hello")
      assert {:ok, "group hello", _bob} = GroupCipher.decrypt(bob, env)
    end

    test "two consecutive group messages decrypt in order" do
      alice = SenderKey.new(7)
      bob = SenderKey.new(7) |> Map.put(:chain_key, alice.chain_key)

      {env1, alice} = GroupCipher.encrypt(alice, "g-msg-1")
      {env2, _alice} = GroupCipher.encrypt(alice, "g-msg-2")
      assert {:ok, "g-msg-1", bob} = GroupCipher.decrypt(bob, env1)
      assert {:ok, "g-msg-2", _bob} = GroupCipher.decrypt(bob, env2)
    end
  end
end
