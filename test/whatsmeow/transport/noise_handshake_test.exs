defmodule Whatsmeow.Transport.NoiseHandshakeTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Transport.{Constants, Frame, NoiseHandshake, NoiseSocket}

  describe "start/3" do
    test "32-byte pattern is used directly as the salt; hash includes the header" do
      pat32 = :crypto.strong_rand_bytes(32)
      nh = NoiseHandshake.new() |> NoiseHandshake.start(pat32, "")
      # salt is set BEFORE authenticate(header), so it matches the raw pattern.
      assert nh.salt == pat32
      # hash is post-authenticate, so it's SHA-256(pat32 || header).
      assert nh.hash == :crypto.hash(:sha256, pat32 <> "")
    end

    test "32-byte Noise pattern is used directly (no SHA-256 of pattern)" do
      # Confirm our pattern is exactly 32 bytes — the protocol-name format
      # uses "Noise_XX_25519_AESGCM_SHA256" (28 bytes) padded with 4 \x00.
      assert byte_size(Constants.noise_start_pattern()) == 32

      nh =
        NoiseHandshake.new()
        |> NoiseHandshake.start(Constants.noise_start_pattern(), <<>>)

      # salt == raw 32-byte pattern; hash == SHA-256(pattern || header="").
      assert nh.salt == Constants.noise_start_pattern()
      assert nh.hash == :crypto.hash(:sha256, Constants.noise_start_pattern())
    end

    test "short pattern (< 32 bytes) is SHA-256-hashed first" do
      short_pat = "short"

      nh = NoiseHandshake.new() |> NoiseHandshake.start(short_pat, <<>>)

      hashed = :crypto.hash(:sha256, short_pat)
      assert nh.salt == hashed
      assert nh.hash == :crypto.hash(:sha256, hashed <> <<>>)
    end

    test "header is authenticated into the hash" do
      nh0 = NoiseHandshake.new() |> NoiseHandshake.start(Constants.noise_start_pattern(), <<>>)

      nh1 =
        NoiseHandshake.new()
        |> NoiseHandshake.start(Constants.noise_start_pattern(), Constants.wa_conn_header())

      assert nh0.hash != nh1.hash
    end
  end

  describe "encrypt/decrypt round-trip" do
    test "Alice/Bob round-trip" do
      pat = Constants.noise_start_pattern()
      hdr = Constants.wa_conn_header()
      alice = NoiseHandshake.new() |> NoiseHandshake.start(pat, hdr)

      {ct, _alice} = NoiseHandshake.encrypt(alice, "hello, server")

      # Mirror Alice's transcript on Bob (same start), then decrypt.
      bob = NoiseHandshake.new() |> NoiseHandshake.start(pat, hdr)
      assert {:ok, "hello, server", _bob} = NoiseHandshake.decrypt(bob, ct)
    end
  end

  describe "X25519 shared-secret mixing" do
    test "two parties derive matching keys after a DH" do
      pat = Constants.noise_start_pattern()
      hdr = Constants.wa_conn_header()

      {a_pub, a_priv} = Curve25519.generate_keypair()
      {b_pub, b_priv} = Curve25519.generate_keypair()

      a = NoiseHandshake.new() |> NoiseHandshake.start(pat, hdr)
      b = NoiseHandshake.new() |> NoiseHandshake.start(pat, hdr)

      a = NoiseHandshake.mix_shared_secret_into_key(a, a_priv, b_pub)
      b = NoiseHandshake.mix_shared_secret_into_key(b, b_priv, a_pub)

      assert a.salt == b.salt
      assert a.key == b.key

      # Now encrypt/decrypt with the post-mix key.
      {ct, _a} = NoiseHandshake.encrypt(a, "after DH")
      assert {:ok, "after DH", _b} = NoiseHandshake.decrypt(b, ct)
    end
  end

  describe "finish/1 → NoiseSocket round-trip" do
    test "write/read keys are interchangeable across sides" do
      pat = Constants.noise_start_pattern()
      hdr = Constants.wa_conn_header()

      {a_pub, a_priv} = Curve25519.generate_keypair()
      {b_pub, b_priv} = Curve25519.generate_keypair()

      a = NoiseHandshake.new() |> NoiseHandshake.start(pat, hdr)
      b = NoiseHandshake.new() |> NoiseHandshake.start(pat, hdr)

      a = NoiseHandshake.mix_shared_secret_into_key(a, a_priv, b_pub)
      b = NoiseHandshake.mix_shared_secret_into_key(b, b_priv, a_pub)

      {:ok, a_write, a_read} = NoiseHandshake.finish(a)
      {:ok, b_write, b_read} = NoiseHandshake.finish(b)

      # The two sides see mirrored write/read pairings: A's write key is B's
      # read key (in the way each side labels them after symmetric extract).
      assert a_write == b_write
      assert a_read == b_read

      # In Noise XX, the initiator labels (k1, k2) as (write, read); the
      # responder labels them swapped (read, write). Model that asymmetry.
      alice = NoiseSocket.new(a_write, a_read)
      bob = NoiseSocket.new(b_read, b_write)

      {ct1, alice} = NoiseSocket.encrypt(alice, "msg-1")
      assert {:ok, "msg-1", bob} = NoiseSocket.decrypt(bob, ct1)

      {ct2, _alice} = NoiseSocket.encrypt(alice, "msg-2")
      assert {:ok, "msg-2", _bob} = NoiseSocket.decrypt(bob, ct2)
    end
  end

  describe "Frame" do
    test "wrap/1 prepends a 3-byte BE length prefix" do
      assert <<0, 0, 5, "hello"::binary>> = Frame.wrap("hello")
    end

    test "read_frames/1 parses zero or more frames out of a buffer" do
      buf = Frame.wrap("a") <> Frame.wrap("bb") <> <<0, 0, 3>>
      assert {["a", "bb"], <<0, 0, 3>>} = Frame.read_frames(buf)
    end

    test "wrap/1 raises on overly large input" do
      too_big = :binary.copy(<<0>>, Constants.frame_max_size())

      assert_raise ArgumentError, ~r/frame too large/, fn ->
        Frame.wrap(too_big)
      end
    end
  end
end
