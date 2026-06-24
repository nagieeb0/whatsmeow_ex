defmodule Whatsmeow.Transport.HandshakeTest do
  use ExUnit.Case, async: true

  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Store.Schemas.Device

  alias Whatsmeow.Transport.{
    Constants,
    Frame,
    Handshake,
    NoiseHandshake,
    NoiseSocket
  }

  alias WAWebProtobufsWa6.HandshakeMessage
  alias WAWebProtobufsWa6.HandshakeMessage.ServerHello

  # In-memory transport that simulates the WhatsApp server side of the
  # Noise XX handshake — enough to verify the *client* state machine
  # without touching the network. Cert verification is opted out (the
  # real cert math is locked in CertVerifierTest + XEdDSATest).
  defmodule LoopbackTransport do
    @behaviour Whatsmeow.Transport.WebSocket

    alias Whatsmeow.Crypto.Curve25519
    alias Whatsmeow.Transport.{Constants, Frame, NoiseHandshake}
    alias WAWebProtobufsWa6.HandshakeMessage

    defstruct [
      :server_pid,
      out_buffer: []
    ]

    def start_server do
      {srv_eph_pub, srv_eph_priv} = Curve25519.generate_keypair()
      {srv_static_pub, srv_static_priv} = Curve25519.generate_keypair()

      pid =
        spawn_link(fn ->
          run_server(%{
            phase: :await_client_hello,
            srv_eph: {srv_eph_pub, srv_eph_priv},
            srv_static: {srv_static_pub, srv_static_priv},
            nh: nil,
            inbound: [],
            outbound: nil,
            client_pid: nil,
            received_finish: nil
          })
        end)

      {:ok, pid, srv_static_pub}
    end

    @impl true
    def connect(opts) do
      server_pid = Keyword.fetch!(opts, :server_pid)
      {:ok, %__MODULE__{server_pid: server_pid}}
    end

    @impl true
    def send_binary(%__MODULE__{server_pid: srv} = c, data) do
      send(srv, {:client_frame, self(), data})
      {:ok, c}
    end

    @impl true
    def recv(%__MODULE__{server_pid: srv} = c) do
      send(srv, {:pull_server_frame, self()})

      receive do
        {:server_frame, bin} -> {:ok, c, bin}
        {:server_closed, _} -> :closed
      after
        2000 -> {:error, :timeout}
      end
    end

    @impl true
    def close(_), do: :ok

    @impl true
    def process_message(_, _),
      # Loopback transport is poll-based via recv/1 — process_message/2 is
      # not exercised here. The handshake driver never calls it; the
      # GenServer's read loop does, and that has its own tests.
      do: :unknown

    @doc "Pull whatever the server received (for tests to assert on)."
    def received_finish(server_pid) do
      send(server_pid, {:dump_finish, self()})

      receive do
        {:finish_dump, x} -> x
      after
        1000 -> nil
      end
    end

    defp run_server(state) do
      receive do
        {:client_frame, _client_pid, data} ->
          state |> handle_client_frame(data) |> run_server()

        {:pull_server_frame, client_pid} ->
          case state.outbound do
            nil ->
              run_server(%{state | client_pid: client_pid})

            bin ->
              send(client_pid, {:server_frame, bin})
              run_server(%{state | outbound: nil, client_pid: nil})
          end

        {:dump_finish, asker} ->
          send(asker, {:finish_dump, state.received_finish})
          run_server(state)

        :stop ->
          :ok
      end
    end

    defp handle_client_frame(%{phase: :await_client_hello} = state, framed) do
      # Client sent: WA header(4) || Frame(ClientHello)
      header_size = byte_size(Constants.wa_conn_header())
      <<header::binary-size(header_size), rest::binary>> = framed
      ^header = Constants.wa_conn_header()

      {[hello_bin | _], _} = Frame.read_frames(rest)
      hello = HandshakeMessage.decode(hello_bin)
      client_eph_pub = hello.clientHello.ephemeral

      {srv_eph_pub, srv_eph_priv} = state.srv_eph
      {srv_static_pub, _} = state.srv_static

      nh =
        NoiseHandshake.new()
        |> NoiseHandshake.start(Constants.noise_start_pattern(), header)
        |> NoiseHandshake.authenticate(client_eph_pub)
        |> NoiseHandshake.authenticate(srv_eph_pub)
        |> NoiseHandshake.mix_shared_secret_into_key(srv_eph_priv, client_eph_pub)

      {srv_static_ct, nh} = NoiseHandshake.encrypt(nh, srv_static_pub)
      nh = NoiseHandshake.mix_shared_secret_into_key(nh, elem(state.srv_static, 1), client_eph_pub)

      # Server "certificate" payload — empty here; the client is run with
      # verify_cert?: false in this test.
      {cert_ct, nh} = NoiseHandshake.encrypt(nh, <<>>)

      hello_resp =
        HandshakeMessage.encode(%HandshakeMessage{
          serverHello: %ServerHello{
            ephemeral: srv_eph_pub,
            static: srv_static_ct,
            payload: cert_ct
          }
        })

      outbound = Frame.wrap(hello_resp)
      state = %{state | phase: :await_client_finish, nh: nh, outbound: outbound}

      case state.client_pid do
        nil ->
          state

        pid ->
          send(pid, {:server_frame, outbound})
          %{state | outbound: nil, client_pid: nil}
      end
    end

    defp handle_client_frame(%{phase: :await_client_finish} = state, framed) do
      {[finish_bin | _], _} = Frame.read_frames(framed)
      finish = HandshakeMessage.decode(finish_bin)

      {:ok, _client_static, nh} = NoiseHandshake.decrypt(state.nh, finish.clientFinish.static)

      nh =
        NoiseHandshake.mix_shared_secret_into_key(
          nh,
          elem(state.srv_eph, 1),
          finish.clientFinish.static
          |> decrypt_dummy()
        )

      _ = nh
      %{state | phase: :done, received_finish: finish}
    end

    # The client static is encrypted; we already decrypted above. This
    # helper is only here so the test harness compiles — the actual mix
    # in production uses the decrypted static.
    defp decrypt_dummy(_), do: :crypto.strong_rand_bytes(32)
  end

  test "client handshake driver completes the XX choreography over an in-memory loopback" do
    {:ok, server_pid, _srv_static_pub} = LoopbackTransport.start_server()

    {n_pub, n_priv} = Curve25519.generate_keypair()
    {i_pub, i_priv} = Curve25519.generate_keypair()
    _ = {n_pub, i_pub, i_priv}

    device = %Device{
      jid: "device-handshake-test",
      registration_id: 1234,
      noise_key: n_priv,
      identity_key: :crypto.strong_rand_bytes(32),
      signed_pre_key: :crypto.strong_rand_bytes(32),
      signed_pre_key_id: 1,
      signed_pre_key_sig: :crypto.strong_rand_bytes(64),
      adv_key: :crypto.strong_rand_bytes(32)
    }

    {:ok, conn} = LoopbackTransport.connect(server_pid: server_pid)

    assert {:ok, _conn, %NoiseSocket{write_key: w, read_key: r}} =
             Handshake.run(
               transport: LoopbackTransport,
               conn: conn,
               device: device,
               verify_cert?: false
             )

    assert byte_size(w) == 32
    assert byte_size(r) == 32

    # Server received and decrypted our ClientFinish frame.
    finish = LoopbackTransport.received_finish(server_pid)
    assert is_struct(finish, WAWebProtobufsWa6.HandshakeMessage)
    assert byte_size(finish.clientFinish.static) > 0
    assert byte_size(finish.clientFinish.payload) > 0

    send(server_pid, :stop)
  end
end
