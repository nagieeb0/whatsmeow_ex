defmodule Whatsmeow.QRChannelTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.QRChannel

  # The payload size doesn't matter for the render shape — pick something
  # representative of an actual whatsmeow QR ref.
  @sample_payload "ref,dGVzdF9ub2lzZQ==,dGVzdF9pZGVudA==,dGVzdF9hZHY="

  describe "render_terminal/1 — half-block compaction" do
    test "returns a non-empty multi-line string" do
      rendered = QRChannel.render_terminal(@sample_payload)

      assert is_binary(rendered)
      assert byte_size(rendered) > 0
      assert String.contains?(rendered, "\n")
    end

    test "uses only half-block characters (▀ ▄ █ space) and ANSI escapes" do
      rendered = QRChannel.render_terminal(@sample_payload)

      stripped =
        rendered
        |> String.replace("\e[30;107m", "")
        |> String.replace("\e[0m", "")
        |> String.replace("\n", "")

      allowed = ["█", "▀", "▄", " "]

      stripped
      |> String.graphemes()
      |> Enum.each(fn ch ->
        assert ch in allowed, "unexpected glyph in rendered QR: #{inspect(ch)}"
      end)
    end

    test "wraps each line with the ANSI black-on-white sequence" do
      rendered = QRChannel.render_terminal(@sample_payload)

      lines =
        rendered
        |> String.trim_trailing("\n")
        |> String.split("\n")

      Enum.each(lines, fn line ->
        assert String.starts_with?(line, "\e[30;107m"),
               "line missing ANSI prefix: #{inspect(line)}"

        assert String.ends_with?(line, "\e[0m"),
               "line missing ANSI reset: #{inspect(line)}"
      end)
    end

    test "compacts to roughly half the height of the matrix + quiet zones" do
      rendered = QRChannel.render_terminal(@sample_payload)

      lines = rendered |> String.trim_trailing("\n") |> String.split("\n")

      {:ok, %QQR.BitMatrix{height: h}} = QQR.encode(@sample_payload, ec_level: :low)

      # 2 module rows per terminal row, plus quiet zone (4 modules top + 4 bottom).
      # Allow ±1 for the odd-height rounding.
      total_module_rows = h + 8
      expected_lines = Integer.floor_div(total_module_rows + 1, 2)

      assert_in_delta length(lines), expected_lines, 1
    end

    test "non-empty payloads with different content yield different output" do
      a = QRChannel.render_terminal("ref-A,a,b,c")
      b = QRChannel.render_terminal("ref-B,a,b,c")

      assert a != b
    end
  end
end
