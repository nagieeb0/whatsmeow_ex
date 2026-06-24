defmodule Whatsmeow.Crypto.XEdDSATest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.XEdDSA

  describe "montgomery_pub_to_ed25519/1" do
    test "rejects degenerate u = p - 1 case (denominator zero)" do
      # p - 1 in 32-byte little-endian
      p_minus_1 =
        :crypto.mod_pow(0, 1, Bitwise.bsl(1, 255) - 19)
        |> :binary.decode_unsigned()
        |> Kernel.+(Bitwise.bsl(1, 255) - 20)
        |> :binary.encode_unsigned(:little)
        |> pad_to(32)

      # u = -1 mod p => u + 1 ≡ 0 mod p, no inverse exists
      assert :error = XEdDSA.montgomery_pub_to_ed25519(p_minus_1)
    end

    test "produces a 32-byte Ed25519-shaped output for ordinary u" do
      # Use the WhatsApp pinned root key from handshake.go line 27.
      u =
        <<0x14, 0x23, 0x75, 0x57, 0x4D, 0x0A, 0x58, 0x71, 0x66, 0xAA, 0xE7, 0x1E, 0xBE, 0x51, 0x64,
          0x37, 0xC4, 0xA2, 0x8B, 0x73, 0xE3, 0x69, 0x5C, 0x6C, 0xE1, 0xF7, 0xF9, 0x54, 0x5D, 0xA8,
          0xEE, 0x6B>>

      assert {:ok, ed} = XEdDSA.montgomery_pub_to_ed25519(u)
      assert byte_size(ed) == 32
      # Top bit (sign) must be 0 — verify spec.
      <<_::binary-size(31), last>> = ed
      assert Bitwise.band(last, 0x80) == 0
    end

    test "is deterministic for the same input" do
      u = :crypto.strong_rand_bytes(32)

      case XEdDSA.montgomery_pub_to_ed25519(u) do
        {:ok, e1} ->
          assert {:ok, ^e1} = XEdDSA.montgomery_pub_to_ed25519(u)

        :error ->
          # Skip the unlikely degenerate roll.
          :ok
      end
    end
  end

  describe "verify/3" do
    test "returns false for garbage signature with valid-shape key" do
      u = :crypto.strong_rand_bytes(32)
      bad_sig = :crypto.strong_rand_bytes(64)
      refute XEdDSA.verify(u, "hello", bad_sig)
    end

    test "returns false for wrong-length signature" do
      u = :crypto.strong_rand_bytes(32)
      refute XEdDSA.verify(u, "hello", <<0::8>>)
    end

    test "returns false for wrong-length pubkey" do
      refute XEdDSA.verify(<<0::8>>, "hello", :crypto.strong_rand_bytes(64))
    end

    test "does not crash on completely malformed input" do
      refute XEdDSA.verify(:not_a_binary, "hello", :crypto.strong_rand_bytes(64))
    end
  end

  defp pad_to(bin, n) when byte_size(bin) >= n, do: binary_part(bin, 0, n)
  defp pad_to(bin, n), do: bin <> :binary.copy(<<0>>, n - byte_size(bin))
end
