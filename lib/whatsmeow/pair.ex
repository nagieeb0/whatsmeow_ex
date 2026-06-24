defmodule Whatsmeow.Pair do
  @moduledoc """
  Server-initiated device pairing flow (QR-scan path).

  After the Noise handshake completes for a fresh device, WhatsApp sends a
  `<pair-device>` IQ containing reference strings. The host application
  shows a QR code (see `Whatsmeow.QRChannel`); once the user scans it on
  the WhatsApp phone app, the server sends a `<pair-success>` IQ with the
  account details and a signed device-identity blob.

  This module ports `whatsmeow-main/pair.go`. The pair-success handler:

  1. Decodes the inbound `<pair-success>` IQ.
  2. Decodes the `ADVSignedDeviceIdentityHMAC` protobuf wrapper.
  3. HMAC-verifies it with our `adv_key` (the ADV secret).
  4. Decodes the inner `ADVSignedDeviceIdentity` and the `ADVDeviceIdentity`
     metadata.
  5. XEdDSA-verifies the **server's** account signature
     (`6,0 ‖ details ‖ ourIdentityPub`).
  6. XEdDSA-**signs** our device signature
     (`6,1 ‖ details ‖ ourIdentityPub ‖ accountSignatureKey`) with our
     identity key, embeds it in a clone of `ADVSignedDeviceIdentity` (with
     `accountSignatureKey` cleared), and builds the ack IQ
     `<iq><pair-device-sign><device-identity key-index="…">…</></></>`.

  The returned `Pair.Result` packages the parsed account info, an updated
  `Device.t()` (with `jid`, `business_name`, `platform`, `adv_*` fields
  populated), and the ready-to-send ack `Node`. The caller persists the
  device and sends the ack — this module makes no I/O calls.
  """

  require Logger

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Crypto.{Curve25519, XEdDSA}
  alias Whatsmeow.Store.Schemas.Device
  alias Whatsmeow.Types.Events
  alias Whatsmeow.Types.JID

  alias WAAdv.ADVDeviceIdentity
  alias WAAdv.ADVSignedDeviceIdentity
  alias WAAdv.ADVSignedDeviceIdentityHMAC

  # 4-byte signature-domain prefixes used by the ADV blob.
  # See `pair.go`: AdvAccountSignaturePrefix / AdvDeviceSignaturePrefix etc.
  @account_sig_prefix <<6, 0>>
  @device_sig_prefix <<6, 1>>
  @hosted_account_sig_prefix <<6, 5>>
  @hosted_device_sig_prefix <<6, 6>>

  defmodule Result do
    @moduledoc "Parsed `<pair-success>` outcome ready to persist + ack."
    @enforce_keys [:device, :ack_iq, :req_id, :jid, :lid, :business_name, :platform]
    defstruct [:device, :ack_iq, :req_id, :jid, :lid, :business_name, :platform]

    @type t :: %__MODULE__{
            device: Whatsmeow.Store.Schemas.Device.t(),
            ack_iq: Whatsmeow.Binary.Node.t(),
            req_id: String.t(),
            jid: String.t(),
            lid: String.t() | nil,
            business_name: String.t(),
            platform: String.t()
          }
  end

  @typedoc "Top-level error atom returned to the caller."
  @type error ::
          :no_pair_success_child
          | :missing_device_identity
          | :decode_signed_id_hmac
          | :hmac_mismatch
          | :decode_signed_id
          | :decode_device_identity
          | :missing_account_signature
          | :missing_account_signature_key
          | :account_signature_invalid
          | :marshal_self_signed_identity

  @doc """
  Handle an inbound `<pair-device>` IQ. Returns the QR payload strings.

  This is unchanged from before — the ack for `<pair-device>` is a simple
  `<iq type="result">` reply with no children, which the caller can build
  via `build_pair_device_ack/1`.
  """
  @spec handle_pair_device(Node.t(), Device.t()) :: [String.t()]
  def handle_pair_device(%Node{tag: "iq"} = node, %Device{} = device) do
    refs =
      node
      |> Node.get_child("pair-device")
      |> case do
        %Node{content: children} when is_list(children) -> children
        _ -> []
      end
      |> Enum.flat_map(fn
        %Node{tag: "ref", content: ref} when is_binary(ref) -> [ref]
        _ -> []
      end)

    Enum.map(refs, &Whatsmeow.QRChannel.build_payload(&1, device))
  end

  @doc """
  Build the simple `<iq type="result">` ack for a `<pair-device>` IQ.
  WhatsApp sends a fresh `<pair-device>` every ~20s until the user scans;
  each one must be acknowledged.
  """
  @spec build_pair_device_ack(Node.t()) :: Node.t()
  def build_pair_device_ack(%Node{tag: "iq"} = node) do
    Node.new(
      "iq",
      %{
        "to" => Node.attr(node, "from", "s.whatsapp.net"),
        "id" => Node.attr(node, "id", ""),
        "type" => "result"
      },
      nil
    )
  end

  @doc """
  Handle a `<pair-success>` IQ — decode it, verify all signatures, and
  produce a `Result` containing the updated `Device` row plus the ack
  `Node` ready to encode and send.

  Returns `{:error, atom()}` if any step fails. The caller should send a
  `<failure>` IQ back to the server (see `build_pair_error_iq/3`) before
  giving up.
  """
  @spec handle_pair_success(Node.t(), Device.t()) :: {:ok, Result.t()} | {:error, error()}
  def handle_pair_success(%Node{tag: "iq"} = node, %Device{} = device) do
    # Per-step logging — `{:error, atom}` from the `with` chain is the
    # only signal callers get for *which* validation failed. When the
    # host sees "QR appears, scan does nothing" it almost always means
    # one of these steps returned `:error` and the resulting `PairError`
    # event was silently dropped upstream. The logs here give us a
    # surgical breadcrumb without changing the public contract.
    Logger.info("[whatsmeow.pair] handle_pair_success start",
      req_id: Node.attr(node, "id", ""),
      device_jid: device.jid,
      adv_key_bytes: byte_size(device.adv_key || <<>>),
      identity_key_bytes: byte_size(device.identity_key || <<>>)
    )

    with {:ok, ps} <- step(:get_pair_success, fn -> get_pair_success(node) end),
         {:ok, dev_id_bytes} <-
           step(:extract_device_identity_bytes, fn -> extract_device_identity_bytes(ps) end),
         {:ok, container} <-
           step(:decode_signed_id_hmac, fn -> decode_signed_id_hmac(dev_id_bytes) end),
         :ok <- step(:verify_hmac, fn -> verify_hmac(container, device.adv_key) end),
         {:ok, signed_id} <-
           step(:decode_signed_id, fn -> decode_signed_id(container.details) end),
         {:ok, dev_id} <-
           step(:decode_device_identity, fn -> decode_device_identity(signed_id.details) end),
         :ok <-
           step(:verify_account_signature, fn ->
             verify_account_signature(signed_id, device.identity_key, dev_id)
           end),
         {:ok, device_sig} <-
           step(:generate_device_signature, fn ->
             generate_device_signature(signed_id, device.identity_key, dev_id)
           end),
         updated_signed = put_device_signature(signed_id, device_sig),
         {:ok, self_signed_bytes} <-
           step(:marshal_self_signed, fn -> marshal_self_signed(updated_signed) end) do
      req_id = Node.attr(node, "id", "")
      jid = parse_jid_attr(ps, "device", "jid")
      lid = parse_jid_attr(ps, "device", "lid")
      business_name = parse_attr(ps, "biz", "name") || ""
      platform = parse_attr(ps, "platform", "name") || ""

      ack_iq =
        build_pair_device_sign_iq(
          req_id,
          self_signed_bytes,
          dev_id.keyIndex || 0
        )

      updated =
        %Device{
          device
          | jid: jid,
            lid: lid,
            business_name: business_name,
            platform: platform,
            adv_details: signed_id.details,
            adv_account_sig: signed_id.accountSignature,
            adv_account_sig_key: signed_id.accountSignatureKey,
            adv_device_sig: device_sig,
            persona:
              device.persona ||
                Whatsmeow.ClientPayload.Persona.to_map(Whatsmeow.ClientPayload.Persona.configured())
        }

      maybe_broadcast_pair_success(updated, business_name, platform)

      {:ok,
       %Result{
         device: updated,
         ack_iq: ack_iq,
         req_id: req_id,
         jid: jid,
         lid: lid,
         business_name: business_name,
         platform: platform
       }}
    end
  end

  @doc """
  Build a `<failure>` reply for a rejected `<pair-success>` IQ. The Go
  client sends one with a numeric `code` and a textual `text` when any
  step (HMAC, signature, persistence) fails.
  """
  @spec build_pair_error_iq(String.t(), non_neg_integer(), String.t()) :: Node.t()
  def build_pair_error_iq(req_id, code, text)
      when is_binary(req_id) and is_integer(code) and is_binary(text) do
    # `to` must be a typed `%JID{}` value (binary-encoder serialises JIDs
    # with the `@jid_pair` opcode, distinct from a plain string).
    server_jid = %JID{user: "", server: JID.default_user_server()}

    Node.new(
      "iq",
      %{
        "to" => server_jid,
        "type" => "error",
        "id" => req_id
      },
      [
        Node.new(
          "error",
          %{"code" => Integer.to_string(code), "text" => text},
          nil
        )
      ]
    )
  end

  # --- internals ------------------------------------------------------------

  # Trace helper: runs `fun`, logs the step name + outcome, and returns
  # the original result unchanged. Adds zero behaviour, only visibility.
  defp step(name, fun) do
    case fun.() do
      {:ok, _} = ok ->
        Logger.debug("[whatsmeow.pair] step ok", step: name)
        ok

      :ok ->
        Logger.debug("[whatsmeow.pair] step ok", step: name)
        :ok

      {:error, reason} = err ->
        Logger.error("[whatsmeow.pair] step FAILED", step: name, reason: inspect(reason))
        err

      other ->
        Logger.error("[whatsmeow.pair] step unexpected return",
          step: name,
          got: inspect(other)
        )

        other
    end
  end

  defp get_pair_success(%Node{} = node) do
    case Node.get_child(node, "pair-success") do
      %Node{} = ps -> {:ok, ps}
      _ -> {:error, :no_pair_success_child}
    end
  end

  defp extract_device_identity_bytes(%Node{} = ps) do
    case Node.get_child(ps, "device-identity") do
      %Node{content: bytes} when is_binary(bytes) -> {:ok, bytes}
      _ -> {:error, :missing_device_identity}
    end
  end

  defp decode_signed_id_hmac(bytes) do
    {:ok, ADVSignedDeviceIdentityHMAC.decode(bytes)}
  rescue
    _ -> {:error, :decode_signed_id_hmac}
  end

  defp decode_signed_id(bytes) do
    {:ok, ADVSignedDeviceIdentity.decode(bytes)}
  rescue
    _ -> {:error, :decode_signed_id}
  end

  defp decode_device_identity(bytes) do
    {:ok, ADVDeviceIdentity.decode(bytes)}
  rescue
    _ -> {:error, :decode_device_identity}
  end

  defp verify_hmac(%ADVSignedDeviceIdentityHMAC{} = container, adv_key)
       when is_binary(adv_key) do
    prefix = if hosted_account?(container.accountType), do: @hosted_account_sig_prefix, else: <<>>
    details = container.details || <<>>
    expected_mac = :crypto.mac(:hmac, :sha256, adv_key, [prefix, details])
    actual_mac = Map.get(container, :HMAC) || <<>>

    if :crypto.hash_equals(expected_mac, actual_mac),
      do: :ok,
      else: {:error, :hmac_mismatch}
  end

  defp verify_account_signature(%ADVSignedDeviceIdentity{} = signed, identity_priv, dev_id)
       when is_binary(identity_priv) do
    cond do
      not is_binary(signed.accountSignatureKey) or byte_size(signed.accountSignatureKey) != 32 ->
        {:error, :missing_account_signature_key}

      not is_binary(signed.accountSignature) or byte_size(signed.accountSignature) != 64 ->
        {:error, :missing_account_signature}

      true ->
        prefix =
          if hosted_account?(dev_id.deviceType),
            do: @hosted_account_sig_prefix,
            else: @account_sig_prefix

        our_identity_pub = Curve25519.public_for(identity_priv)
        message = [prefix, signed.details || <<>>, our_identity_pub]

        if XEdDSA.verify(
             signed.accountSignatureKey,
             IO.iodata_to_binary(message),
             signed.accountSignature
           ),
           do: :ok,
           else: {:error, :account_signature_invalid}
    end
  end

  defp generate_device_signature(%ADVSignedDeviceIdentity{} = signed, identity_priv, dev_id) do
    prefix =
      if hosted_account?(dev_id.deviceType), do: @hosted_device_sig_prefix, else: @device_sig_prefix

    our_identity_pub = Curve25519.public_for(identity_priv)

    message =
      IO.iodata_to_binary([
        prefix,
        signed.details || <<>>,
        our_identity_pub,
        signed.accountSignatureKey || <<>>
      ])

    {:ok, XEdDSA.sign(identity_priv, message)}
  end

  defp put_device_signature(%ADVSignedDeviceIdentity{} = signed, sig) do
    %ADVSignedDeviceIdentity{signed | deviceSignature: sig}
  end

  defp marshal_self_signed(%ADVSignedDeviceIdentity{} = signed) do
    # Per upstream: clear AccountSignatureKey before marshaling the ack
    # payload (the phone already knows it).
    stripped = %ADVSignedDeviceIdentity{signed | accountSignatureKey: nil}
    {:ok, ADVSignedDeviceIdentity.encode(stripped) |> IO.iodata_to_binary()}
  rescue
    _ -> {:error, :marshal_self_signed_identity}
  end

  defp build_pair_device_sign_iq(req_id, self_signed_bytes, key_index) do
    # `to` MUST be the typed `%JID{}` value, not the plain string
    # "s.whatsapp.net". The encoder serialises a JID with the `@jid_pair`
    # opcode (see `Whatsmeow.Binary.Encoder.write_jid/1`) — a plain
    # string would be tokenised differently on the wire. Go's `pair.go`
    # uses `types.ServerJID` here for the same reason; sending a string
    # makes the server reject our `<pair-device-sign>` ack and report
    # "failed to connect device" to the phone.
    server_jid = %JID{user: "", server: JID.default_user_server()}

    Node.new(
      "iq",
      %{
        "to" => server_jid,
        "type" => "result",
        "id" => req_id
      },
      [
        Node.new("pair-device-sign", %{}, [
          Node.new(
            "device-identity",
            %{"key-index" => Integer.to_string(key_index)},
            self_signed_bytes
          )
        ])
      ]
    )
  end

  # protoc-gen-elixir deserializes enum values as atoms.
  defp hosted_account?(:HOSTED), do: true
  defp hosted_account?(1), do: true
  defp hosted_account?(_), do: false

  defp parse_attr(%Node{} = parent, child_tag, attr) do
    case Node.get_child(parent, child_tag) do
      %Node{} = child -> Node.attr(child, attr)
      _ -> nil
    end
  end

  defp parse_jid_attr(%Node{} = parent, child_tag, attr) do
    case parse_attr(parent, child_tag, attr) do
      nil -> nil
      %JID{} = jid -> JID.to_string(jid)
      bin when is_binary(bin) -> bin
      _ -> nil
    end
  end

  defp maybe_broadcast_pair_success(%Device{} = device, business_name, platform) do
    if Code.ensure_loaded?(Whatsmeow.Config) and function_exported?(Whatsmeow.Config, :pubsub, 0) and
         function_exported?(Whatsmeow, :topic_for, 1) do
      with pubsub when not is_nil(pubsub) <- safe_apply(Whatsmeow.Config, :pubsub, []),
           topic when is_binary(topic) <- safe_apply(Whatsmeow, :topic_for, [device.jid]),
           {:ok, jid_struct} <- JID.parse(device.jid || "") do
        Phoenix.PubSub.broadcast(
          pubsub,
          topic,
          {:whatsmeow,
           %Events.PairSuccess{
             device_id: device.jid,
             jid: jid_struct,
             business_name: business_name,
             platform: platform
           }}
        )
      else
        _ -> :ok
      end
    end

    :ok
  end

  defp safe_apply(mod, fun, args) do
    apply(mod, fun, args)
  rescue
    _ -> nil
  end
end
