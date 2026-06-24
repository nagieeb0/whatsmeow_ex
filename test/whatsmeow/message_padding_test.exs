defmodule Whatsmeow.MessagePaddingTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.MessagePadding

  describe "pad/1 + unpad/2 round-trip" do
    test "any plaintext + pad/unpad/0 returns the original" do
      for _ <- 1..200 do
        plain = :crypto.strong_rand_bytes(:rand.uniform(256))
        padded = MessagePadding.pad(plain)
        assert byte_size(padded) > byte_size(plain)
        assert {:ok, ^plain} = MessagePadding.unpad(padded, 2)
      end
    end

    test "padding is 1-15 bytes (low-nibble + non-zero invariant)" do
      Enum.each(1..100, fn _ ->
        plain = "hi"
        padded = MessagePadding.pad(plain)
        added = byte_size(padded) - byte_size(plain)
        assert added in 1..15
        assert :binary.last(padded) == added
      end)
    end
  end

  describe "unpad/2" do
    test "v=3 (Armadillo) is a passthrough — Armadillo isn't padded" do
      bin = "not padded — but v3 ignores it"
      assert {:ok, ^bin} = MessagePadding.unpad(bin, 3)
    end

    test "empty input is rejected" do
      assert {:error, :empty} = MessagePadding.unpad(<<>>, 2)
    end

    test "trailing bytes inconsistent → :bad_padding" do
      # Last byte says 4 (so strip 4 trailing 4s) but the run is broken.
      bad = "hello" <> <<3, 4, 4, 4>>
      assert {:error, :bad_padding} = MessagePadding.unpad(bad, 2)
    end

    test "claimed pad length larger than payload is rejected" do
      # last byte says strip 200 bytes from a 10-byte payload — impossible
      bin = <<0, 1, 2, 3, 4, 5, 6, 7, 8, 200>>
      assert {:error, :bad_padding} = MessagePadding.unpad(bin, 2)
    end
  end
end
