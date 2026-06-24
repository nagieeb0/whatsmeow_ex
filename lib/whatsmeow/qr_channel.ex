defmodule Whatsmeow.QRChannel do
  @moduledoc """
  QR-code pairing flow.

  WhatsApp emits a series of `<pair-device>` IQs over the handshaked socket
  containing reference strings. We combine each reference with our
  identity public key, advertised public key, and ADV secret into the
  canonical QR payload format and hand it back to the host application
  for rendering.

  QR rendering itself is delegated to `:qqr` (pure-Elixir QR code lib).

  Format of a single QR payload (from upstream Go):

      <ref>,<base64 noise_pub>,<base64 identity_pub>,<base64 adv_secret>
  """

  alias Whatsmeow.Store.Schemas.Device

  @doc """
  Build the canonical QR payload string for the given reference + device.
  """
  @spec build_payload(String.t(), Device.t()) :: String.t()
  def build_payload(ref, %Device{} = device)
      when is_binary(ref) and byte_size(device.noise_key) == 32 do
    noise_pub = Whatsmeow.Crypto.Curve25519.public_for(device.noise_key)
    identity_pub = Whatsmeow.Crypto.Curve25519.public_for(device.identity_key)

    Enum.join(
      [
        ref,
        Base.encode64(noise_pub, padding: true),
        Base.encode64(identity_pub, padding: true),
        Base.encode64(device.adv_key, padding: true)
      ],
      ","
    )
  end

  @doc """
  Render `payload` as a terminal-friendly QR using `:qqr`.

  Each QR module is **one** terminal cell wide; vertically, two module
  rows are packed into a single terminal row using Unicode half-block
  characters (▀ ▄ █) plus space. The result is roughly square in a
  typical monospace font and roughly half the height of the equivalent
  two-cells-per-module rendering.

  We emit explicit ANSI `black fg on white bg` so the QR scans regardless
  of the host terminal's color scheme.

  Returns a multi-line string ready to print.
  """
  @spec render_terminal(String.t()) :: String.t()
  def render_terminal(payload) when is_binary(payload) do
    case QQR.encode(payload, ec_level: :low) do
      {:ok, matrix} -> matrix_to_terminal(matrix)
      {:error, reason} -> "[QR encode failed: #{inspect(reason)}]\n#{payload}\n"
    end
  end

  @doc """
  Render `payload` as an SVG using `:qqr`. Returns the SVG document as a
  string.
  """
  @spec render_svg(String.t()) :: String.t()
  def render_svg(payload) when is_binary(payload) do
    QQR.to_svg(payload, ec_level: :low)
  end

  # --- internals ------------------------------------------------------------

  # ANSI: black foreground, bright-white background. Wrap each rendered
  # line so it scans regardless of the user's terminal color scheme.
  @ansi_start "\e[30;107m"
  @ansi_reset "\e[0m"
  @quiet_zone 4

  # Half-block characters. 4 combinations of {top, bottom}.
  @full_block "█"
  @upper_half "▀"
  @lower_half "▄"
  @blank " "

  defp matrix_to_terminal(%QQR.BitMatrix{width: w, height: h} = m) do
    qz = @quiet_zone
    x_range = -qz..(w + qz - 1)//1

    # Two QR module rows per terminal row. Step y by 2 to pair them up.
    y_pairs = Enum.to_list(-qz..(h + qz - 1)//2)

    lines =
      Enum.map_join(y_pairs, "\n", fn y ->
        cells =
          Enum.map_join(x_range, "", fn x ->
            top = module_dark?(m, x, y, w, h)
            bot = module_dark?(m, x, y + 1, w, h)
            half_block_char(top, bot)
          end)

        @ansi_start <> cells <> @ansi_reset
      end)

    lines <> "\n"
  end

  defp half_block_char(true, true), do: @full_block
  defp half_block_char(true, false), do: @upper_half
  defp half_block_char(false, true), do: @lower_half
  defp half_block_char(false, false), do: @blank

  defp module_dark?(%QQR.BitMatrix{} = m, x, y, w, h) do
    x >= 0 and y >= 0 and x < w and y < h and QQR.BitMatrix.get(m, x, y)
  end
end
