defmodule Mix.Tasks.Whatsmeow.Smoke do
  @shortdoc "Live smoke test against wss://web.whatsapp.com — handshake, render QR, consume <pair-success>, send the ack IQ."

  @moduledoc """
  Interactive live test against WhatsApp's WebSocket endpoint.

  This task spins up an in-memory device, opens a TLS WebSocket to
  `wss://web.whatsapp.com/ws/chat`, drives the Noise XX handshake, then
  loops reading inbound frames. On each frame it dispatches:

  * `<iq><pair-device>` — prints a QR for you to scan, acks the IQ.
  * `<iq><pair-success>` — verifies the ADV HMAC + account signature,
    generates our device signature with `Whatsmeow.Crypto.XEdDSA.sign/3`,
    optionally persists the paired device row to Postgres (`--persist`),
    sends the `<pair-device-sign>` ack IQ, then exits.

  ## Usage

      mix whatsmeow.smoke               # cert verify off, no Postgres
      mix whatsmeow.smoke --persist     # also persist the paired device row
      mix whatsmeow.smoke --verify-cert # XEdDSA-verify the live cert chain
      mix whatsmeow.smoke --timeout 300 # how long to wait for a scan (s)
      mix whatsmeow.smoke --dump-raw    # echo raw decrypted bytes
      mix whatsmeow.smoke --relogin     # after pair-success ack, reconnect
                                        # with login_payload and verify the
                                        # server replies <success>
      mix whatsmeow.smoke --proxy http://user:pass@residential.example:8080
                                        # route through an HTTP CONNECT proxy
                                        # (typical for residential-proxy providers)

  ## Exit codes

  * `0` — paired successfully (or you abandoned the QR — process stays
    alive until you Ctrl-C).
  * `1` — anything went wrong; the error string is printed.

  Persistence (`--persist`) needs Postgres reachable per
  `config :whatsmeow_ex, Whatsmeow.Repo` and a migrated schema. Without
  `--persist`, the task prints what *would* be persisted and exits as if
  it succeeded.
  """

  use Mix.Task

  alias Whatsmeow.Binary
  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Crypto.XEdDSA
  alias Whatsmeow.IQ
  alias Whatsmeow.Login
  alias Whatsmeow.MessageInfo
  alias Whatsmeow.Pair
  alias Whatsmeow.QRChannel
  alias Whatsmeow.Receipt
  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.WAVersion

  alias Whatsmeow.Transport.{
    Frame,
    Handshake,
    NoiseSocket,
    WebSocket.Mint
  }

  @impl Mix.Task
  def run(argv) do
    Application.ensure_all_started(:whatsmeow_ex)

    {opts, _, _} =
      OptionParser.parse(argv,
        switches: [
          verify_cert: :boolean,
          timeout: :integer,
          dump_raw: :boolean,
          persist: :boolean,
          proxy: :string,
          relogin: :boolean,
          load_jid: :string
        ],
        aliases: [v: :verify_cert, t: :timeout, d: :dump_raw, p: :persist, r: :relogin]
      )

    verify_cert? = Keyword.get(opts, :verify_cert, false)
    # Default 5 minutes — enough time to grab your phone and scan.
    timeout = Keyword.get(opts, :timeout, 300)
    dump? = Keyword.get(opts, :dump_raw, false)
    persist? = Keyword.get(opts, :persist, false)
    proxy = Keyword.get(opts, :proxy)
    relogin? = Keyword.get(opts, :relogin, false)
    load_jid = Keyword.get(opts, :load_jid)

    {device, skip_pair?} =
      if load_jid do
        case Whatsmeow.Repo.get(Device, load_jid) do
          nil ->
            Mix.shell().error("✗ --load-jid #{inspect(load_jid)} not found in Postgres.")
            Mix.shell().info("Available paired devices:")

            Whatsmeow.Repo.all(Device)
            |> Enum.each(fn d -> Mix.shell().info("  - #{d.jid}") end)

            System.halt(1)

          %Device{} = d ->
            Mix.shell().info("== loaded paired device from Postgres ==")
            Mix.shell().info("jid       = #{d.jid}")
            Mix.shell().info("lid       = #{d.lid}")
            Mix.shell().info("biz_name  = #{d.business_name}")
            Mix.shell().info("")
            {d, true}
        end
      else
        {ephemeral_device(), false}
      end

    Mix.shell().info("== whatsmeow_ex live smoke ==")
    Mix.shell().info("device_id     = #{device.jid}")
    Mix.shell().info("verify_cert?  = #{verify_cert?}")
    Mix.shell().info("persist?      = #{persist?}")
    Mix.shell().info("relogin?      = #{relogin? or skip_pair?}")
    Mix.shell().info("skip_pair?    = #{skip_pair?}")
    Mix.shell().info("scan_timeout  = #{timeout}s")
    Mix.shell().info("proxy         = #{inspect(redact_proxy(proxy))}")
    Mix.shell().info("")

    refresh_wa_version(proxy)

    # If we're loading a persisted device, skip the QR/pair phase entirely
    # and go straight to a login_payload reconnect.
    if skip_pair? do
      load_then_listen(device, proxy, verify_cert?, dump?)
      Process.sleep(:infinity)
    end

    Mix.shell().info("[1/5] Opening WSS to web.whatsapp.com …")

    connect_opts = if is_nil(proxy), do: [], else: [proxy: proxy]

    case Mint.connect(connect_opts) do
      {:ok, conn} ->
        Mix.shell().info("      ✓ WebSocket upgraded")
        Mix.shell().info("[2/5] Driving Noise XX handshake …")

        case Handshake.run(
               transport: Mint,
               conn: conn,
               device: device,
               verify_cert?: verify_cert?
             ) do
          {:ok, conn, %NoiseSocket{} = ns} ->
            Mix.shell().info("      ✓ Handshake complete (write/read keys derived)")
            Mix.shell().info("[3/5] Waiting for <pair-device> IQ …")

            state = %{
              conn: conn,
              ns: ns,
              device: device,
              dump?: dump?,
              persist?: persist?,
              relogin?: relogin?,
              proxy: proxy,
              verify_cert?: verify_cert?,
              timeout_ms: timeout * 1000,
              qr_shown?: false
            }

            recv_loop(state)

          {:error, reason} ->
            Mix.shell().error("      ✗ Handshake failed: #{inspect(reason)}")
            Mix.shell().info("Re-run with --dump-raw to inspect the server response.")
            System.halt(1)
        end

      {:error, reason} ->
        Mix.shell().error("✗ WebSocket connect failed: #{inspect(reason)}")
        System.halt(1)
    end
  end

  # --- main read loop -------------------------------------------------------

  defp recv_loop(state) do
    case Mint.recv(state.conn, state.timeout_ms) do
      {:ok, conn, ws_payload} ->
        if state.dump?, do: Mix.shell().info("raw ws frame: #{Base.encode16(ws_payload)}")
        {frames, _rest} = Frame.read_frames(ws_payload)
        state = %{state | conn: conn}
        handle_frames(state, frames)

      {:error, :timeout} ->
        Mix.shell().error(
          "      ✗ No frame within #{div(state.timeout_ms, 1000)}s — did you scan in time?"
        )

        System.halt(1)

      :closed ->
        Mix.shell().error(
          "      ✗ Server closed the WebSocket. Either pairing failed " <>
            "(server-side reject of our ClientPayload or ack IQ) or you " <>
            "took longer than the server's grace period."
        )

        System.halt(1)

      other ->
        Mix.shell().error("      ✗ recv error: #{inspect(other)}")
        System.halt(1)
    end
  end

  defp handle_frames(state, []) do
    # Read more.
    recv_loop(state)
  end

  defp handle_frames(state, [ciphertext | rest]) do
    case NoiseSocket.decrypt(state.ns, ciphertext) do
      {:ok, plain, ns2} ->
        if state.dump?, do: Mix.shell().info("raw decrypted: #{Base.encode16(plain)}")

        state = %{state | ns: ns2}

        case unpack_and_decode(plain) do
          {:ok, %Binary.Node{} = node} ->
            case dispatch_node(state, node) do
              {:continue, state2} -> handle_frames(state2, rest)
              {:done, _} -> :ok
            end

          {:error, reason} ->
            Mix.shell().error("      ✗ Failed to parse inbound frame: #{inspect(reason)}")
            handle_frames(state, rest)
        end

      {:error, :auth_failed} ->
        Mix.shell().error(
          "      ✗ AEAD auth failed mid-stream — read counter out of sync " <>
            "with the server. Aborting."
        )

        System.halt(1)
    end
  end

  # --- node dispatch --------------------------------------------------------

  defp dispatch_node(state, %Binary.Node{tag: "iq"} = iq) do
    cond do
      Binary.Node.get_child(iq, "pair-device") != nil ->
        handle_pair_device_iq(state, iq)

      Binary.Node.get_child(iq, "pair-success") != nil ->
        handle_pair_success_iq(state, iq)

      true ->
        Mix.shell().info(
          "      · Inbound <iq> (no pair-device/pair-success child): " <>
            inspect(iq, limit: 4, printable_limit: 80)
        )

        {:continue, state}
    end
  end

  defp dispatch_node(state, %Binary.Node{tag: tag} = node) do
    Mix.shell().info("      · Inbound <#{tag}>: " <> inspect(node, limit: 4, printable_limit: 80))

    {:continue, state}
  end

  # --- pair-device handler --------------------------------------------------

  defp handle_pair_device_iq(state, iq) do
    refs = Pair.handle_pair_device(iq, state.device)

    state =
      case refs do
        [payload | _] when not state.qr_shown? ->
          Mix.shell().info("[4/5] Inbound <pair-device> — rendering QR …")
          Mix.shell().info("")
          Mix.shell().info("=== Scan this QR in WhatsApp → Settings → Linked devices ===")
          Mix.shell().info("")
          Mix.shell().info(QRChannel.render_terminal(payload))
          Mix.shell().info("")
          %{state | qr_shown?: true}

        [_ | _] ->
          # Server rotates QR every ~20s; quietly accept new refs.
          %{state | qr_shown?: state.qr_shown?}

        [] ->
          Mix.shell().info("      (pair-device with no refs — odd)")
          state
      end

    ack = Pair.build_pair_device_ack(iq)

    case send_node(state, ack) do
      {:ok, state2} ->
        {:continue, state2}

      {:error, reason} ->
        Mix.shell().error("      ✗ Failed to ack pair-device: #{inspect(reason)}")
        {:done, state}
    end
  end

  # --- pair-success handler ------------------------------------------------

  defp handle_pair_success_iq(state, iq) do
    Mix.shell().info("[5/5] Inbound <pair-success> — verifying signatures …")

    case Pair.handle_pair_success(iq, state.device) do
      {:ok, %Pair.Result{} = result} ->
        Mix.shell().info("      ✓ HMAC verified")
        Mix.shell().info("      ✓ Account signature verified (XEdDSA)")
        Mix.shell().info("      ✓ Device signature generated (XEdDSA sign)")
        Mix.shell().info("")
        Mix.shell().info("Paired account:")
        Mix.shell().info("  jid           = #{result.jid}")
        Mix.shell().info("  lid           = #{inspect(result.lid)}")
        Mix.shell().info("  business_name = #{inspect(result.business_name)}")
        Mix.shell().info("  platform      = #{inspect(result.platform)}")

        maybe_persist(state.persist?, result.device)
        send_pair_ack(state, result)

      {:error, reason} ->
        Mix.shell().error("      ✗ pair-success rejected: #{inspect(reason)}")
        req_id = Binary.Node.attr(iq, "id", "")
        err_iq = Pair.build_pair_error_iq(req_id, error_code(reason), error_text(reason))
        _ = send_node(state, err_iq)
        System.halt(1)
    end
  end

  defp send_pair_ack(state, %Pair.Result{} = result) do
    case send_node(state, result.ack_iq) do
      {:ok, state2} ->
        Mix.shell().info("      ✓ Sent <pair-device-sign> ack IQ")
        Mix.shell().info("")

        if state.relogin? do
          drain_then_relogin(state2, result.device)
        else
          Mix.shell().info("Pairing complete. The server typically closes the")
          Mix.shell().info("connection now and expects you to reconnect using the")
          Mix.shell().info("login payload — pass `--relogin` to exercise that loop.")
          {:done, state2}
        end

      {:error, reason} ->
        Mix.shell().error("      ✗ Failed to send pair-success ack: #{inspect(reason)}")
        System.halt(1)
    end
  end

  # --- relogin (login_payload reconnect) -----------------------------------

  # After we ack <pair-success>, the server closes the WS in a fraction of a
  # second. Wait for the goodbye instead of racing a TCP teardown, then open
  # a fresh socket and run the handshake with the now-paired Device — which
  # routes `Whatsmeow.ClientPayload.build/1` to `login_payload/1`.
  defp drain_then_relogin(state, %Device{} = paired_device) do
    Mix.shell().info("[6/7] Waiting for server to close the post-pair connection …")
    drain_until_closed(state)

    Mix.shell().info("[7/7] Reconnecting with login_payload (paired JID=#{paired_device.jid}) …")

    connect_opts = if is_nil(state.proxy), do: [], else: [proxy: state.proxy]

    with {:ok, conn} <- Mint.connect(connect_opts),
         _ <- Mix.shell().info("      ✓ WebSocket upgraded"),
         {:ok, conn, %NoiseSocket{} = ns} <-
           Handshake.run(
             transport: Mint,
             conn: conn,
             device: paired_device,
             verify_cert?: state.verify_cert?
           ) do
      Mix.shell().info("      ✓ Handshake complete with login_payload")
      Mix.shell().info("      · Waiting for first post-login stanza …")
      # Critical: propagate the paired_device into state.device so all
      # downstream Signal-session / identity-key inserts use the real
      # WA JID (not the original "smoke-XXX" placeholder) as the FK.
      await_login_outcome(%{state | conn: conn, ns: ns, device: paired_device})
    else
      {:error, reason} ->
        Mix.shell().error("      ✗ Relogin failed: #{inspect(reason)}")
        System.halt(1)
    end
  end

  defp drain_until_closed(state) do
    # Brief deadline — if the server hasn't closed in 5 s after our ack, just
    # tear our side down and reconnect. Either way the next WSS we open is a
    # fresh connection.
    case Mint.recv(state.conn, 5_000) do
      :closed ->
        Mix.shell().info("      ✓ Server closed the WebSocket")

      {:error, :timeout} ->
        Mix.shell().info("      · Server still idle after 5s — proceeding anyway")

      {:ok, conn, _payload} ->
        # Whatever it sent post-ack we don't care about — drain to closure.
        drain_until_closed(%{state | conn: conn})

      other ->
        Mix.shell().info("      · drain finished (#{inspect(other)})")
    end
  end

  defp await_login_outcome(state) do
    case Mint.recv(state.conn, 30_000) do
      {:ok, conn, ws_payload} ->
        if state.dump?,
          do: Mix.shell().info("raw ws frame (login): #{Base.encode16(ws_payload)}")

        {frames, _rest} = Frame.read_frames(ws_payload)
        handle_login_frames(%{state | conn: conn}, frames)

      {:error, :timeout} ->
        Mix.shell().error("      ✗ No <success>/<failure> within 30s after relogin handshake")
        System.halt(1)

      :closed ->
        Mix.shell().error(
          "      ✗ Server closed the WebSocket before sending a login response — " <>
            "treat this like a 503: rate-limited reconnect; back off and retry."
        )

        System.halt(1)

      # Mint's 4-tuple error form. When the server pushes a frame and then
      # closes (the typical `<stream:error>` / `<failure>` shape), Mint
      # returns `{:error, conn, transport_error, responses}` where
      # `responses` already contains the data we need to decrypt.
      # Extract that data, frame-decode + Noise-decrypt it, and report
      # the actual stanza instead of swallowing it.
      {:error, _conn, transport_err, responses} when is_list(responses) ->
        Mix.shell().error("      ✗ Server closed after sending a frame (#{inspect(transport_err)})")
        decode_and_report_final_frame(state, responses)
        System.halt(1)

      other ->
        Mix.shell().error("      ✗ recv error after relogin: #{inspect(other)}")
        System.halt(1)
    end
  end

  # Pull data chunks out of Mint's `responses` list, concatenate into a WS
  # payload, frame-decode it, then Noise-decrypt each frame and pretty-print
  # whatever the server said. Best-effort — if anything fails we just dump
  # the hex so the user (or this task's author) can debug from raw bytes.
  defp decode_and_report_final_frame(state, responses) do
    ws_bytes =
      responses
      |> Enum.flat_map(fn
        {:data, _ref, bytes} -> [bytes]
        _ -> []
      end)
      |> IO.iodata_to_binary()

    if ws_bytes == "" do
      Mix.shell().info("        (no data in final frame — server hung up clean)")
    else
      Mix.shell().info("        raw bytes (#{byte_size(ws_bytes)}): #{Base.encode16(ws_bytes)}")

      # Strip the WS frame header (opcode 0x82 + length).
      payload =
        case ws_bytes do
          <<0x82, len, rest::binary>> when len < 126 ->
            <<chunk::binary-size(^len), _::binary>> = rest
            chunk

          <<0x82, 126, len::big-16, rest::binary>> ->
            <<chunk::binary-size(^len), _::binary>> = rest
            chunk

          other ->
            other
        end

      {framed, _} = Frame.read_frames(payload)

      Enum.each(framed, fn ciphertext ->
        case NoiseSocket.decrypt(state.ns, ciphertext) do
          {:ok, plain, _ns2} ->
            case unpack_and_decode(plain) do
              {:ok, %Binary.Node{} = node} ->
                Mix.shell().info("        decoded: #{inspect(node, limit: 16)}")

                case node do
                  %Binary.Node{tag: "stream:error"} ->
                    code = Binary.Node.attr(node, "code")

                    Mix.shell().info("""

                            >>> server said <stream:error code=#{inspect(code)}>
                            >>> code 515 = "stream replaced" — another session for this
                            >>>   device is open server-side. Wait 30-60 s and retry.
                            >>> code 401 = unauthorized (identity / payload rejected)
                            >>> code 500 = client-outdated (WAVersion drift)
                            >>> code 503 = rate-limited reconnect — back off and retry
                    """)

                  %Binary.Node{tag: "failure"} ->
                    reason = Binary.Node.attr(node, "reason")
                    code = Binary.Node.attr(node, "code")

                    Mix.shell().info("""

                            >>> server said <failure code=#{inspect(code)} reason=#{inspect(reason)}>
                            >>> account may have been unlinked from the phone, or the
                            >>>   ADV signature material got rotated. Re-pair from scratch.
                    """)

                  _ ->
                    :ok
                end

              {:error, why} ->
                Mix.shell().info("        binary-decode failed: #{inspect(why)}")
            end

          {:error, :auth_failed} ->
            Mix.shell().info("        Noise auth_failed — counter or key drift")
        end
      end)
    end
  end

  defp handle_login_frames(state, []) do
    await_login_outcome(state)
  end

  defp handle_login_frames(state, [ciphertext | rest]) do
    case NoiseSocket.decrypt(state.ns, ciphertext) do
      {:ok, plain, ns2} ->
        if state.dump?, do: Mix.shell().info("raw decrypted (login): #{Base.encode16(plain)}")
        state = %{state | ns: ns2}

        case unpack_and_decode(plain) do
          {:ok, %Binary.Node{} = node} ->
            case Login.parse_first_node(node) do
              {:ok, %Login.Result{lid: lid, server_time_offset: dt}} ->
                Mix.shell().info("      ✓ <success> — paired device authenticated")
                Mix.shell().info("        lid                = #{inspect(lid)}")
                Mix.shell().info("        server_time_offset = #{inspect(dt)} s")
                Mix.shell().info("")

                Mix.shell().info("[bootstrap] Sending <iq xmlns=\"passive\"><active/></iq> …")
                state = send_active_iq(state)
                Mix.shell().info("[bootstrap] Sending <presence type=\"available\"> …")
                state = send_available_presence(state)

                Mix.shell().info("[bootstrap] Uploading PreKey bundle (initial=812 OPKs) …")
                state = upload_prekeys(state, initial?: true)
                Mix.shell().info("")

                Mix.shell().info(
                  "Holding the connection open — send yourself a WhatsApp " <>
                    "message from another device and watch for <message> / " <>
                    "<receipt> / <notification> traffic. Ctrl-C to exit."
                )

                Mix.shell().info("")
                listen_for_inbound(state)

              {:error, {:stream_error, code}} ->
                Mix.shell().error(
                  "      ✗ <stream:error code=#{inspect(code)}> on relogin — " <>
                    "almost always ClientPayload/version drift. Retry the smoke " <>
                    "task; if it persists, capture --dump-raw output."
                )

                System.halt(1)

              {:error, {:failure, reason, code}} ->
                Mix.shell().error(
                  "      ✗ <failure reason=#{inspect(reason)} code=#{inspect(code)}> " <>
                    "on relogin — device may have been removed remotely or the " <>
                    "account is locked."
                )

                System.halt(1)

              {:error, :unexpected_node} ->
                Mix.shell().info(
                  "      · Unexpected first post-login node <#{node.tag}> — " <>
                    "continuing read loop"
                )

                handle_login_frames(state, rest)
            end

          {:error, reason} ->
            Mix.shell().error("      ✗ Failed to parse first post-login frame: #{inspect(reason)}")
            System.halt(1)
        end

      {:error, :auth_failed} ->
        Mix.shell().error(
          "      ✗ AEAD auth failed on first post-login frame — read counter " <>
            "drifted from server. Aborting."
        )

        System.halt(1)
    end
  end

  defp maybe_persist(false, %Device{} = device) do
    Mix.shell().info("")
    Mix.shell().info("(skipping persistence — pass --persist to save the device row)")
    Mix.shell().info("would persist: jid=#{device.jid}")
  end

  defp maybe_persist(true, %Device{} = device) do
    Mix.shell().info("")
    Mix.shell().info("Persisting device row to Whatsmeow.Repo …")

    repo = Whatsmeow.Repo

    case ensure_repo(repo) do
      :ok ->
        cs = Device.changeset(%Device{}, Map.from_struct(device))

        case repo.insert(cs, on_conflict: :replace_all, conflict_target: [:jid]) do
          {:ok, _row} -> Mix.shell().info("      ✓ Inserted device row jid=#{device.jid}")
          {:error, cs} -> Mix.shell().error("      ✗ Insert failed: #{inspect(cs.errors)}")
        end

      {:error, reason} ->
        Mix.shell().error(
          "      ✗ Whatsmeow.Repo is not reachable (#{inspect(reason)}). " <>
            "Run `mix ecto.setup` and configure DATABASE_URL."
        )
    end
  end

  defp ensure_repo(repo) do
    case Process.whereis(repo) do
      pid when is_pid(pid) -> :ok
      nil -> {:error, :repo_not_started}
    end
  end

  # --- transport helpers ----------------------------------------------------

  defp send_node(state, %Binary.Node{} = node) do
    plain = Binary.encode(node)
    {ct, ns2} = NoiseSocket.encrypt(state.ns, plain)
    framed = Frame.wrap(ct)

    case Mint.send_binary(state.conn, framed) do
      {:ok, conn2} -> {:ok, %{state | conn: conn2, ns: ns2}}
      {:error, _} = err -> err
    end
  end

  defp unpack_and_decode(plain) do
    with {:ok, payload} <- unpack(plain) do
      case Binary.decode(payload, strip_flag?: false) do
        {:ok, node} -> {:ok, node}
        {:error, reason} -> {:error, {:binary_decode, reason}}
      end
    end
  end

  defp unpack(<<flag, rest::binary>>) do
    if Bitwise.band(flag, 2) > 0 do
      try do
        {:ok, :zlib.uncompress(rest)}
      rescue
        e -> {:error, {:zlib, Exception.message(e)}}
      end
    else
      {:ok, rest}
    end
  end

  defp unpack(<<>>), do: {:error, :empty_frame}

  # --- pair-error mapping ---------------------------------------------------

  defp error_code(:hmac_mismatch), do: 401
  defp error_code(:account_signature_invalid), do: 401
  defp error_code(:missing_account_signature), do: 401
  defp error_code(:missing_account_signature_key), do: 401
  defp error_code(_), do: 500

  defp error_text(:hmac_mismatch), do: "hmac-mismatch"
  defp error_text(:account_signature_invalid), do: "signature-mismatch"
  defp error_text(:missing_account_signature), do: "signature-mismatch"
  defp error_text(:missing_account_signature_key), do: "signature-mismatch"
  defp error_text(_), do: "internal-error"

  # --- version refresh ------------------------------------------------------

  defp refresh_wa_version(proxy) do
    Mix.shell().info("[0/5] Refreshing WA web version from web.whatsapp.com …")

    refresh_opts =
      [timeout: 10_000]
      |> then(fn opts -> if is_nil(proxy), do: opts, else: [{:proxy, proxy} | opts] end)

    case WAVersion.refresh(refresh_opts) do
      {:ok, {a, b, c} = version} ->
        Mix.shell().info("      ✓ Using #{a}.#{b}.#{c} (live revision)")
        version

      {:error, reason} ->
        {a, b, c} = cached = WAVersion.cached()

        Mix.shell().error("      ! Failed to fetch latest version (#{inspect(reason)}).")

        Mix.shell().info(
          "      Falling back to cached/default #{a}.#{b}.#{c} — " <>
            "expect <stream:error 500> if this is stale."
        )

        cached
    end
  end

  # --- load-paired-device fast path ----------------------------------------

  # Skip the QR/pair dance entirely — load a previously-paired Device from
  # Postgres and reconnect with login_payload. Same flow as the post-pair
  # `--relogin` branch, but without first scanning a QR.
  defp load_then_listen(%Device{} = device, proxy, verify_cert?, dump?) do
    connect_opts = if is_nil(proxy), do: [], else: [proxy: proxy]

    Mix.shell().info("[1/3] Opening WSS with login_payload (paired JID=#{device.jid}) …")

    with {:ok, conn} <- Mint.connect(connect_opts),
         _ = Mix.shell().info("      ✓ WebSocket upgraded"),
         {:ok, conn, %NoiseSocket{} = ns} <-
           Handshake.run(
             transport: Mint,
             conn: conn,
             device: device,
             verify_cert?: verify_cert?
           ) do
      Mix.shell().info("      ✓ Handshake complete (login_payload)")

      state = %{
        conn: conn,
        ns: ns,
        device: device,
        dump?: dump?,
        persist?: false,
        relogin?: false,
        proxy: proxy,
        verify_cert?: verify_cert?,
        timeout_ms: 120_000,
        qr_shown?: false
      }

      Mix.shell().info("[2/3] Awaiting <success> …")
      await_login_outcome(state)
    else
      {:error, reason} ->
        Mix.shell().error("✗ load-then-listen failed: #{inspect(reason)}")
        System.halt(1)
    end
  end

  # --- post-login bootstrap (active IQ + presence) -------------------------

  # Without these the server quietly drops the connection within seconds of
  # <success>, assuming we're an abandoned client. Mirrors Go's
  # `SetPassive(false)` + `SendPresence(types.PresenceAvailable)`.
  defp send_active_iq(state) do
    iq = IQ.build_set_passive(false)

    case send_node(state, iq) do
      {:ok, state2} ->
        Mix.shell().info("      ✓ active IQ sent (id=#{Binary.Node.attr(iq, "id")})")
        state2

      {:error, reason} ->
        Mix.shell().error("      ✗ failed to send active IQ: #{inspect(reason)}")
        state
    end
  end

  defp upload_prekeys(state, opts) do
    initial? = Keyword.get(opts, :initial?, false)
    count = if initial?, do: 32, else: Whatsmeow.PreKeys.wanted_count()

    case Whatsmeow.PreKeys.get_or_generate(state.device.jid, count) do
      {:ok, prekeys} ->
        iq = Whatsmeow.PreKeys.build_upload_iq(prekeys, state.device)

        Mix.shell().info(
          "      · Uploading #{length(prekeys)} OPKs, iq id=#{Binary.Node.attr(iq, "id")}"
        )

        case send_node(state, iq) do
          {:ok, state2} ->
            # We don't wait for the IQ result here — the listen loop
            # will see it as a regular <iq type="result"> later. Mark
            # them uploaded optimistically.
            last_id = prekeys |> List.last() |> Map.get(:key_id)
            _ = Whatsmeow.PreKeys.mark_uploaded(state.device.jid, last_id)
            Mix.shell().info("      ✓ PreKey upload sent (last id=#{last_id})")
            state2

          {:error, reason} ->
            Mix.shell().error("      ✗ failed to send prekey upload: #{inspect(reason)}")
            state
        end

      {:error, reason} when reason in [:no_repo, :no_store] ->
        Mix.shell().info(
          "      · skipping prekey upload — Postgres not reachable. " <>
            "Pre-key bundles only matter for peer-first-contact; this won't " <>
            "block inbound msg/pkmsg decrypt."
        )

        state

      {:error, reason} ->
        Mix.shell().error("      ✗ prekey generation failed: #{inspect(reason)}")
        state
    end
  end

  defp send_available_presence(state) do
    # The smoke device has no push_name yet — Go would refuse to send
    # presence without one, but during a smoke we just want the server to
    # see *some* outbound activity. Use "whatsmeow_ex" as a stand-in.
    presence = IQ.build_presence(:available, "whatsmeow_ex")

    case send_node(state, presence) do
      {:ok, state2} ->
        Mix.shell().info("      ✓ presence sent (type=available)")
        state2

      {:error, reason} ->
        Mix.shell().error("      ✗ failed to send presence: #{inspect(reason)}")
        state
    end
  end

  # --- post-login listen loop ----------------------------------------------

  # After <success> we hold the WSS open, ack inbound traffic, and
  # surface anything interesting on stdout. This is the Phase-9 dry-run:
  # everything except the Signal-wire decode of <enc> bodies works.
  defp listen_for_inbound(state) do
    state = schedule_keepalive(state)

    case Mint.recv(state.conn, 120_000) do
      {:ok, conn, ws_payload} ->
        if state.dump?, do: Mix.shell().info("raw ws frame: #{Base.encode16(ws_payload)}")
        {frames, _rest} = Frame.read_frames(ws_payload)
        state = %{state | conn: conn}
        state = Enum.reduce(frames, state, &handle_inbound_ciphertext/2)
        listen_for_inbound(state)

      {:error, :timeout} ->
        # No traffic for 2 min — push a keepalive and keep going.
        case send_keepalive(state) do
          {:ok, state2} -> listen_for_inbound(state2)
          _ -> System.halt(1)
        end

      :closed ->
        Mix.shell().info("")

        Mix.shell().info(
          "Server closed the connection. Common reasons:\n" <>
            "  · we didn't send the post-login bootstrap (active IQ + presence)\n" <>
            "  · keepalive missed (> ~30 s of silence)\n" <>
            "  · we returned a malformed reply to a server <iq><ping/></iq>\n" <>
            "Re-run the task to reconnect."
        )

        :ok

      other ->
        Mix.shell().error("      ✗ recv error: #{inspect(other)}")

        Mix.shell().info("If reason was {:closed}, see notes above. Re-run to reconnect.")

        :ok
    end
  end

  defp schedule_keepalive(state) do
    now = System.monotonic_time(:millisecond)
    last = Map.get(state, :last_keepalive_ms, 0)

    if now - last >= 25_000 do
      case send_keepalive(state) do
        {:ok, state2} -> state2
        _ -> state
      end
    else
      state
    end
  end

  defp send_keepalive(state) do
    iq = IQ.build_keepalive()
    Mix.shell().info("      → keepalive #{Binary.Node.attr(iq, "id")}")

    case send_node(state, iq) do
      {:ok, state2} ->
        {:ok, Map.put(state2, :last_keepalive_ms, System.monotonic_time(:millisecond))}

      err ->
        err
    end
  end

  defp handle_inbound_ciphertext(ciphertext, state) do
    case NoiseSocket.decrypt(state.ns, ciphertext) do
      {:ok, plain, ns2} ->
        if state.dump?, do: Mix.shell().info("raw decrypted: #{Base.encode16(plain)}")
        state = %{state | ns: ns2}

        case unpack_and_decode(plain) do
          {:ok, %Binary.Node{} = node} ->
            handle_inbound_node(state, node)

          {:error, reason} ->
            Mix.shell().error("      ✗ decode failed: #{inspect(reason)}")
            state
        end

      {:error, :auth_failed} ->
        Mix.shell().error("      ✗ AEAD auth failed — read counter drifted")
        System.halt(1)
    end
  end

  defp handle_inbound_node(state, %Binary.Node{tag: "message"} = msg) do
    case MessageInfo.from_node(msg, parse_jid_or_nil(state.device.jid)) do
      {:ok, info} ->
        enc = Binary.Node.get_children(msg, "enc")

        Mix.shell().info("")
        Mix.shell().info("=== <message> id=#{info.id} ===")
        Mix.shell().info("  from        = #{inspect(info.from)}")
        Mix.shell().info("  type        = #{inspect(info.type)}")
        Mix.shell().info("  push_name   = #{inspect(info.push_name)}")
        Mix.shell().info("  is_group?   = #{info.is_group?}")
        Mix.shell().info("  timestamp   = #{DateTime.to_iso8601(info.timestamp)}")
        Mix.shell().info("  <enc> count = #{length(enc)}")

        Enum.each(enc, fn e ->
          ct_len = if is_binary(e.content), do: byte_size(e.content), else: 0

          Mix.shell().info(
            "    enc v=#{inspect(Binary.Node.attr(e, "v"))} " <>
              "type=#{inspect(Binary.Node.attr(e, "type"))} " <>
              "ciphertext_bytes=#{ct_len}"
          )
        end)

        # Try decrypt: pkmsg (first-contact) uses the inline bundle;
        # msg (steady-state) loads the persisted Signal session from
        # Postgres keyed by (our_jid, their_jid).
        attempt_decrypt(state, enc, info)

        ack = Receipt.build_ack(msg)
        send_node_silent(state, ack)

      {:error, reason} ->
        Mix.shell().info("      · malformed <message>: #{inspect(reason)} — sending Nack")
        ack = Receipt.build_ack(msg, 1)
        send_node_silent(state, ack)
    end
  end

  defp handle_inbound_node(state, %Binary.Node{tag: "receipt"} = node) do
    Mix.shell().info(
      "      · <receipt> id=#{inspect(Binary.Node.attr(node, "id"))} " <>
        "type=#{inspect(Binary.Node.attr(node, "type"))}"
    )

    ack = Receipt.build_ack(node)
    send_node_silent(state, ack)
  end

  defp handle_inbound_node(state, %Binary.Node{tag: "iq", attrs: %{"type" => t}} = iq)
       when t in ["result", "error"] do
    Mix.shell().info("      · <iq type=#{inspect(t)}> id=#{inspect(Binary.Node.attr(iq, "id"))}")
    state
  end

  defp handle_inbound_node(state, %Binary.Node{tag: "ib"} = node) do
    # <ib> = "info broadcast". Server pushes config (edge routing, offline
    # preview, dirty state). No protocol-level ack required, but we print
    # the children so it's clear what the server thinks is going on.
    children = Binary.Node.children(node)
    child_tags = Enum.map(children, & &1.tag) |> Enum.uniq()

    Mix.shell().info(
      "      · <ib> from=#{inspect(Binary.Node.attr(node, "from"))} " <>
        "children=#{inspect(child_tags)}"
    )

    Enum.each(children, fn child ->
      Mix.shell().info(
        "          <#{child.tag}> attrs=#{inspect(child.attrs, limit: 5)} " <>
          "content=#{inspect(child.content, limit: 8, printable_limit: 80)}"
      )
    end)

    state
  end

  defp handle_inbound_node(state, %Binary.Node{tag: "iq", attrs: %{"type" => "get"}} = iq) do
    # Server queries us (e.g. <iq><ping/></iq>). Reply with a bare-bones
    # result IQ so the server doesn't escalate to a disconnect. Skip the
    # reply entirely if there's no `id` attribute — the server rejects
    # results with empty ids and may close the stream.
    case Binary.Node.attr(iq, "id") do
      id when is_binary(id) and id != "" ->
        Mix.shell().info(
          "      · <iq type=get> id=#{inspect(id)} — replying with empty <iq type=result>"
        )

        from = Binary.Node.attr(iq, "from", "s.whatsapp.net")
        reply = Binary.Node.new("iq", %{"to" => from, "type" => "result", "id" => id}, nil)
        send_node_silent(state, reply)

      _ ->
        Mix.shell().info(
          "      · <iq type=get> with no id — skipping reply " <>
            "(content=#{inspect(iq.content, limit: 4)})"
        )

        state
    end
  end

  defp handle_inbound_node(state, %Binary.Node{tag: tag} = node) do
    Mix.shell().info(
      "      · inbound <#{tag}> attrs=#{inspect(node.attrs, limit: 5)} " <>
        "content=#{inspect(node.content, limit: 6, printable_limit: 80)}"
    )

    state
  end

  defp parse_jid_or_nil(nil), do: nil

  defp parse_jid_or_nil(s) when is_binary(s) do
    case Whatsmeow.Types.JID.parse(s) do
      {:ok, j} -> j
      _ -> nil
    end
  end

  defp send_node_silent(state, node) do
    case send_node(state, node) do
      {:ok, state2} ->
        state2

      {:error, reason} ->
        Mix.shell().error("      ✗ failed to send ack: #{inspect(reason)}")
        state
    end
  end

  # --- decrypt attempt (libsignal wire decode of <enc type="pkmsg"/msg>) ---

  defp attempt_decrypt(state, enc_children, %MessageInfo{} = info) do
    # Prefer pkmsg (first-contact, brings X3DH bundle inline). Fall back
    # to msg (steady-state — needs an existing persisted Signal session).
    pkmsg = Enum.find(enc_children, &(Binary.Node.attr(&1, "type") == "pkmsg"))
    msg = Enum.find(enc_children, &(Binary.Node.attr(&1, "type") == "msg"))

    cond do
      pkmsg && is_binary(pkmsg.content) -> decrypt_pkmsg(state, pkmsg.content, info)
      msg && is_binary(msg.content) -> decrypt_msg(state, msg.content, info)
      true -> Mix.shell().info("  · no usable <enc> child — skipping decrypt")
    end
  end

  defp decrypt_pkmsg(state, envelope, %MessageInfo{from: their_jid}) do
    %{device: device} = state
    their_id = Whatsmeow.Types.JID.to_string(their_jid)

    case Whatsmeow.Signal.WireDecrypt.decrypt_prekey_envelope(
           envelope,
           device.identity_key,
           device.signed_pre_key,
           # No published one-time pre-keys yet — sender uses signed pre-key only.
           nil
         ) do
      {:ok, plain, session, pkmsg_struct} ->
        log_decrypted(
          plain,
          "pkmsg",
          " (preKeyId=#{inspect(pkmsg_struct.preKeyId)}, " <>
            "signedPreKeyId=#{pkmsg_struct.signedPreKeyId})"
        )

        persist_session(device.jid, their_id, session)

        stash_identity_pub(
          device.jid,
          their_id,
          Whatsmeow.Signal.Wire.strip_djb_type(pkmsg_struct.identityKey || <<>>)
        )

      {:error, reason} ->
        Mix.shell().info("  · pkmsg decrypt failed: #{inspect(reason)}")
    end
  rescue
    e -> Mix.shell().info("  · pkmsg decrypt crashed: #{inspect(Exception.message(e))}")
  end

  defp decrypt_msg(state, envelope, %MessageInfo{from: their_jid}) do
    %{device: device} = state
    their_id = Whatsmeow.Types.JID.to_string(their_jid)

    with {:ok, sess} <- Whatsmeow.Signal.Store.Postgres.get(device.jid, their_id),
         their_id_pub when is_binary(their_id_pub) <-
           lookup_their_identity_pub(device.jid, their_id) do
      our_id_pub = Whatsmeow.Crypto.Curve25519.public_for(device.identity_key)

      case Whatsmeow.Signal.WireDecrypt.decrypt_signal_envelope(
             envelope,
             sess,
             our_id_pub,
             their_id_pub
           ) do
        {:ok, plain, new_sess} ->
          log_decrypted(plain, "msg", "")
          persist_session(device.jid, their_id, new_sess)

        {:error, reason} ->
          Mix.shell().info("  · msg decrypt failed: #{inspect(reason)}")
      end
    else
      :not_found ->
        Mix.shell().info(
          "  · msg decrypt skipped — no persisted session with #{their_id}. " <>
            "Their first message from this device should be a pkmsg."
        )

      nil ->
        Mix.shell().info("  · msg decrypt skipped — no stored identity pub for #{their_id}")

      {:error, reason} ->
        Mix.shell().info("  · msg decrypt skipped — store error: #{inspect(reason)}")
    end
  rescue
    e -> Mix.shell().info("  · msg decrypt crashed: #{inspect(Exception.message(e))}")
  end

  defp log_decrypted(plain, kind, suffix) do
    Mix.shell().info("  ✓ DECRYPTED (#{kind}) — plaintext = #{byte_size(plain)} bytes#{suffix}")

    Mix.shell().info(
      "    hex(first 64): #{Base.encode16(binary_part(plain, 0, min(64, byte_size(plain))))}"
    )

    case maybe_decode_e2e_message(plain) do
      {:ok, summary} -> Mix.shell().info("    " <> summary)
      :skip -> :ok
    end
  end

  defp persist_session(our_jid, their_id, session) do
    case Whatsmeow.Signal.Store.Postgres.put(our_jid, their_id, session) do
      :ok ->
        Mix.shell().info("    ✓ Signal session persisted (their_id=#{their_id})")

      {:error, reason} ->
        Mix.shell().info("    · session persist failed: #{inspect(reason)}")
    end
  end

  defp stash_identity_pub(_, _, nil), do: :ok
  defp stash_identity_pub(_, _, <<>>), do: :ok

  defp stash_identity_pub(our_jid, their_id, identity_pub) when byte_size(identity_pub) == 32 do
    %Whatsmeow.Store.Schemas.IdentityKey{}
    |> Whatsmeow.Store.Schemas.IdentityKey.changeset(%{
      our_jid: our_jid,
      their_id: their_id,
      identity: identity_pub
    })
    |> Whatsmeow.Repo.insert(
      on_conflict: {:replace, [:identity]},
      conflict_target: [:our_jid, :their_id]
    )
    |> case do
      {:ok, _} -> :ok
      {:error, reason} -> Mix.shell().info("    · identity stash failed: #{inspect(reason)}")
    end
  rescue
    e -> Mix.shell().info("    · identity stash crashed: #{inspect(Exception.message(e))}")
  end

  defp lookup_their_identity_pub(our_jid, their_id) do
    case Whatsmeow.Repo.get_by(Whatsmeow.Store.Schemas.IdentityKey,
           our_jid: our_jid,
           their_id: their_id
         ) do
      %Whatsmeow.Store.Schemas.IdentityKey{identity: id_pub}
      when is_binary(id_pub) and byte_size(id_pub) == 32 ->
        id_pub

      _ ->
        nil
    end
  rescue
    _ -> nil
  end

  defp maybe_decode_e2e_message(plain) do
    if Code.ensure_loaded?(WAWebProtobufsE2E.Message) do
      try do
        msg = WAWebProtobufsE2E.Message.decode(plain)

        cond do
          is_binary(msg.conversation) and msg.conversation != "" ->
            {:ok, ~s(plaintext message: "#{msg.conversation}")}

          not is_nil(msg.extendedTextMessage) ->
            text = msg.extendedTextMessage.text
            {:ok, ~s(extendedTextMessage: "#{text}")}

          true ->
            present =
              Map.from_struct(msg)
              |> Enum.reject(fn {_, v} -> is_nil(v) end)
              |> Enum.take(3)
              |> Enum.map(&elem(&1, 0))

            {:ok, "WaE2E.Message fields present: #{inspect(present)}"}
        end
      rescue
        e -> {:ok, "(could not parse as WaE2E.Message: #{inspect(Exception.message(e))})"}
      end
    else
      :skip
    end
  end

  # --- proxy redaction (so credentials never land in pasted output) --------

  defp redact_proxy(nil), do: nil

  defp redact_proxy(url) when is_binary(url) do
    case URI.parse(url) do
      %URI{userinfo: nil} -> url
      %URI{} = uri -> URI.to_string(%URI{uri | userinfo: "***"})
    end
  end

  defp redact_proxy({_, _, _, _} = proxy_tuple), do: proxy_tuple
  defp redact_proxy(other), do: other

  # --- device factory -------------------------------------------------------

  defp ephemeral_device do
    {_, noise} = Curve25519.generate_keypair()
    {_, ident} = Curve25519.generate_keypair()
    {spk_pub, spk} = Curve25519.generate_keypair()

    # Mirror Go's keypair.Sign: XEdDSA over DjbType(5) ‖ signed_pre_key.pub
    # using the identity key's private scalar. Random bytes here trigger
    # <stream:error code="500"> immediately after handshake.
    spk_sig = XEdDSA.sign(ident, <<5, spk_pub::binary>>)

    %Device{
      jid: "smoke-#{System.unique_integer([:positive])}",
      registration_id: :rand.uniform(0xFFFFFFFF),
      noise_key: noise,
      identity_key: ident,
      signed_pre_key: spk,
      signed_pre_key_id: 1,
      signed_pre_key_sig: spk_sig,
      adv_key: :crypto.strong_rand_bytes(32),
      adv_details: <<>>,
      adv_account_sig: :crypto.strong_rand_bytes(64),
      adv_account_sig_key: :crypto.strong_rand_bytes(32),
      adv_device_sig: :crypto.strong_rand_bytes(64)
    }
  end
end
