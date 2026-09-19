defmodule Whatsmeow.SessionClosedSocketTest do
  @moduledoc """
  A batch of frames outliving the socket that was decrypting it.

  ## The crash

  `Frame.read_frames/1` splits one websocket payload into many stanzas, and
  WhatsApp coalesces them freely. When one of those stanzas is
  `<stream:error code="515">` — the *normal* re-handshake the server asks for
  immediately after pairing — `handle_disconnect/2` sets `noise_socket: nil`
  and leaves `:disconnected`.

  `Enum.reduce/3` knew nothing about that and handed the next frame of the same
  batch to `NoiseSocket.decrypt(nil, …)`, which has no `nil` clause:

      ** (FunctionClauseError) no function clause matching in
         Whatsmeow.Transport.NoiseSocket.decrypt/2

  The session GenServer died on every re-pair, taking the rest of the batch
  with it.
  """
  use ExUnit.Case, async: true

  defmodule TwoFrameTransport do
    @moduledoc "Hands the session one websocket payload, verbatim."
    def process_message(conn, {:fake_payload, payloads}), do: {:ok, conn, payloads}
    def process_message(_conn, _msg), do: :unknown
    def close(_conn), do: :ok
  end

  # `Frame.read_frames/1` splits on a 3-byte big-endian length prefix, and
  # `NoiseSocket.decrypt/2` wants at least the 16-byte GCM tag. Two of these in
  # one payload is the coalescing WhatsApp does routinely — and the reason the
  # reduce had a second frame to hand to a socket the first one had closed.
  defp payload_of_two_frames do
    frame = :binary.copy(<<0xAB>>, 20)
    <<0, 0, 20>> <> frame <> <<0, 0, 20>> <> frame
  end

  test "a frame arriving after the socket closed is dropped, not decrypted" do
    pid =
      start_supervised!(
        {Whatsmeow.Session,
         device_id: "closed-socket-test",
         transport: TwoFrameTransport,
         auto_reconnect?: false,
         offline?: true}
      )

    # The state a mid-batch 515 leaves behind: a live connection object, no
    # noise socket. Set directly because reaching it for real needs a paired
    # device and a served handshake, and the bug is in what happens next.
    :sys.replace_state(pid, fn state ->
      %{state | transport_conn: :fake_conn, noise_socket: nil}
    end)

    send(pid, {:fake_payload, [payload_of_two_frames()]})

    # `:sys.get_state/1` is a call, so it returns only once the message above
    # has been handled — no sleeping, and no race.
    assert %{noise_socket: nil} = :sys.get_state(pid)
    assert Process.alive?(pid)
  end
end
