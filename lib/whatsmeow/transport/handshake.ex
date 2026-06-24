defmodule Whatsmeow.Transport.Handshake do
  @moduledoc """
  Noise XX handshake driver — orchestrates the three-message pattern with
  WhatsApp's server.

  Ports the body of `doHandshake` in `whatsmeow-main/handshake.go`. Returns
  the post-handshake `Whatsmeow.Transport.NoiseSocket` plus the updated
  transport conn ready for `<message>` / `<iq>` traffic.

  The transport is supplied as a module implementing
  `Whatsmeow.Transport.WebSocket` so this orchestrator is unit-testable
  against an in-memory loopback (see `test/whatsmeow/transport/handshake_test.exs`).

  ## Flow

      1. send  WA header (4 bytes) + framed ClientHello
      2. recv  ServerHello (ephemeral + encrypted static + encrypted cert chain)
      3. mix:  DH(client_eph_priv, server_eph_pub)
      4. dec:  server static; mix DH(client_eph_priv, server_static)
      5. dec:  cert chain; CertVerifier.verify against server static
      6. enc:  client static (device.noise_key public)
      7. mix:  DH(device_noise_priv, server_eph_pub)
      8. enc:  ClientPayload protobuf
      9. send  framed ClientFinish (static_ct || payload_ct)
     10. finalize: derive write/read keys → NoiseSocket
  """

  alias Whatsmeow.ClientPayload
  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Store.Schemas.Device

  alias Whatsmeow.Transport.{
    CertVerifier,
    Constants,
    Frame,
    NoiseHandshake,
    NoiseSocket
  }

  alias WAWebProtobufsWa6.HandshakeMessage
  alias WAWebProtobufsWa6.HandshakeMessage.ClientFinish
  alias WAWebProtobufsWa6.HandshakeMessage.ClientHello

  @type opts :: [
          transport: module(),
          conn: term(),
          device: Device.t(),
          ephemeral_keypair: {binary(), binary()},
          verify_cert?: boolean(),
          cert_verifier_opts: keyword()
        ]

  @type error :: :handshake_failed | atom() | {atom(), term()}

  @doc """
  Run the XX handshake. On success returns the updated transport `conn`
  and the `NoiseSocket` ready for post-handshake traffic.
  """
  @spec run(opts()) ::
          {:ok, conn :: term(), NoiseSocket.t()} | {:error, error()}
  def run(opts) do
    transport = Keyword.fetch!(opts, :transport)
    conn = Keyword.fetch!(opts, :conn)
    device = Keyword.fetch!(opts, :device)
    {eph_pub, eph_priv} = Keyword.get_lazy(opts, :ephemeral_keypair, &Curve25519.generate_keypair/0)
    verify_cert? = Keyword.get(opts, :verify_cert?, true)
    cert_opts = Keyword.get(opts, :cert_verifier_opts, [])

    header = Constants.wa_conn_header()

    nh =
      NoiseHandshake.new()
      |> NoiseHandshake.start(Constants.noise_start_pattern(), header)
      |> NoiseHandshake.authenticate(eph_pub)

    with {:ok, conn} <- send_client_hello(transport, conn, header, eph_pub),
         {:ok, conn, server_resp} <- recv_frame(transport, conn),
         {:ok, srv_eph, srv_static_ct, srv_cert_ct} <- parse_server_hello(server_resp),
         nh = NoiseHandshake.authenticate(nh, srv_eph),
         nh = NoiseHandshake.mix_shared_secret_into_key(nh, eph_priv, srv_eph),
         {:ok, srv_static, nh} <- NoiseHandshake.decrypt(nh, srv_static_ct),
         :ok <- check_static_length(srv_static),
         nh = NoiseHandshake.mix_shared_secret_into_key(nh, eph_priv, srv_static),
         {:ok, cert_chain, nh} <- NoiseHandshake.decrypt(nh, srv_cert_ct),
         :ok <- maybe_verify_cert(verify_cert?, cert_chain, srv_static, cert_opts),
         {client_static_ct, nh} <-
           NoiseHandshake.encrypt(nh, Curve25519.public_for(device.noise_key)),
         nh = NoiseHandshake.mix_shared_secret_into_key(nh, device.noise_key, srv_eph),
         {:ok, payload_bin} <- encode_client_payload(device),
         {payload_ct, nh} <- NoiseHandshake.encrypt(nh, payload_bin),
         {:ok, conn} <- send_client_finish(transport, conn, client_static_ct, payload_ct),
         {:ok, write_key, read_key} <- NoiseHandshake.finish(nh) do
      {:ok, conn, NoiseSocket.new(write_key, read_key)}
    end
  end

  # --- message helpers ------------------------------------------------------

  defp send_client_hello(transport, conn, header, eph_pub) do
    hello =
      HandshakeMessage.encode(%HandshakeMessage{
        clientHello: %ClientHello{ephemeral: eph_pub}
      })

    framed = header <> Frame.wrap(hello)
    transport.send_binary(conn, framed)
  end

  defp send_client_finish(transport, conn, client_static_ct, payload_ct) do
    msg =
      HandshakeMessage.encode(%HandshakeMessage{
        clientFinish: %ClientFinish{static: client_static_ct, payload: payload_ct}
      })

    transport.send_binary(conn, Frame.wrap(msg))
  end

  defp recv_frame(transport, conn) do
    case transport.recv(conn) do
      {:ok, conn, bin} ->
        case Frame.read_frames(bin) do
          {[frame | _], _rest} -> {:ok, conn, frame}
          {[], _} -> {:error, :empty_frame}
        end

      :closed ->
        {:error, :closed}

      err ->
        err
    end
  end

  defp parse_server_hello(bin) do
    case HandshakeMessage.decode(bin) do
      %HandshakeMessage{serverHello: %{ephemeral: e, static: s, payload: p}}
      when is_binary(e) and byte_size(e) == 32 and is_binary(s) and is_binary(p) ->
        {:ok, e, s, p}

      _ ->
        {:error, :bad_server_hello}
    end
  rescue
    _ -> {:error, :malformed_server_hello}
  end

  defp check_static_length(s) when byte_size(s) == 32, do: :ok
  defp check_static_length(_), do: {:error, :bad_static_length}

  defp maybe_verify_cert(false, _cert, _static, _opts), do: :ok

  defp maybe_verify_cert(true, cert, static, opts) do
    case CertVerifier.verify(cert, static, opts) do
      :ok -> :ok
      err -> err
    end
  end

  defp encode_client_payload(device) do
    {:ok, ClientPayload.build(device) |> WAWebProtobufsWa6.ClientPayload.encode()}
  rescue
    e -> {:error, {:encode_payload, e}}
  end
end
