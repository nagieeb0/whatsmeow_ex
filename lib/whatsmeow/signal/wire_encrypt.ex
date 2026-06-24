defmodule Whatsmeow.Signal.WireEncrypt do
  @moduledoc """
  libsignal-wire-compatible encrypt pipeline — the inverse of
  `Whatsmeow.Signal.WireDecrypt`.

  Used by `Whatsmeow.Send.send_text/3` to produce the bytes that go into
  `<message><enc>` for outbound messages. Mirrors libsignal's
  `SessionCipher.encrypt`:

      message_key = KDF_CK(sending_chain_key)
      (enc_key, mac_key, iv) = HKDF(message_key, "WhisperMessageKeys", 80)
      ciphertext = AES-256-CBC(enc_key, iv, pad(plaintext))
      proto = SignalMessage{ratchetKey: 0x05 ‖ our_ratchet_pub,
                            counter, previousCounter, ciphertext}
      mac = HMAC[mac_key, 0x05‖our_id_pub ‖ 0x05‖their_id_pub ‖ 0x33 ‖ proto][0..7]
      envelope = 0x33 ‖ proto ‖ mac

  ## Entry points

    * `encrypt_signal_envelope/4` — steady-state. Caller already has a
      `%Whatsmeow.Signal.Session{}` with a sending chain.
    * `encrypt_prekey_envelope/5` — first contact. Performs initiator
      X3DH against the peer's `%Whatsmeow.PreKeyBundle{}`, runs the
      first DH ratchet, encrypts the inner SignalMessage, wraps it in
      a `PreKeySignalMessage` envelope.
  """

  alias Whatsmeow.Crypto.{AES, Curve25519}
  alias Whatsmeow.MessagePadding
  alias Whatsmeow.PreKeyBundle
  alias Whatsmeow.Signal.{Ratchet, Session, Wire, X3DH}
  alias Whatsmeow.Signal.Wire.{PreKeySignalMessage, SignalMessage}

  @typedoc "Reasons encrypt may fail."
  @type error :: :no_sending_chain | {:aes, term()}

  @doc """
  Encrypt `plaintext` against an existing Signal session. Returns the
  `<enc type="msg">`-ready envelope plus the advanced session.

  `our_id_pub` / `their_id_pub` are the 32-byte raw X25519 identity
  public keys; the function adds the DjbType prefix internally.
  """
  @spec encrypt_signal_envelope(binary(), Session.t(), <<_::256>>, <<_::256>>) ::
          {:ok, envelope :: binary(), Session.t()} | {:error, error()}
  def encrypt_signal_envelope(_plaintext, %Session{sending_ck: nil}, _, _),
    do: {:error, :no_sending_chain}

  def encrypt_signal_envelope(plaintext, %Session{} = sess, our_id_pub, their_id_pub)
      when is_binary(plaintext) and byte_size(our_id_pub) == 32 and
             byte_size(their_id_pub) == 32 do
    {next_ck, mk} = Ratchet.kdf_ck(sess.sending_ck)
    {enc_key, mac_key, iv} = Ratchet.derive_message_keys(mk)

    padded = MessagePadding.pad(plaintext)
    ciphertext = AES.CBC.encrypt(enc_key, iv, padded)
    {our_ratchet_pub, _} = sess.dh_self

    msg = %SignalMessage{
      ratchetKey: Wire.with_djb_type(our_ratchet_pub),
      counter: sess.sending_n,
      previousCounter: sess.previous_n,
      ciphertext: ciphertext
    }

    # Encode without MAC, compute MAC, re-encode with MAC. (We compute the
    # full envelope twice rather than splitting the wire codec because the
    # MAC is over the version byte + proto bytes, and `encode_signal_message`
    # owns that prefix.)
    placeholder = Wire.encode_signal_message(msg, <<0::64>>)
    mac_input = binary_part(placeholder, 0, byte_size(placeholder) - 8)
    mac = Wire.compute_mac(mac_key, our_id_pub, their_id_pub, mac_input)
    envelope = Wire.encode_signal_message(msg, mac)

    new_sess = %{sess | sending_ck: next_ck, sending_n: sess.sending_n + 1}
    {:ok, envelope, new_sess}
  rescue
    e -> {:error, {:aes, Exception.message(e)}}
  end

  @doc """
  Encrypt `plaintext` for a peer we've never messaged. Performs initiator
  X3DH against `bundle`, runs the first DH ratchet step, encrypts the
  inner SignalMessage, wraps it in a PreKeySignalMessage envelope, and
  returns both the wrapped envelope (for `<enc type="pkmsg">`) and the
  freshly-minted session for persistence.

    * `our_identity_priv` — 32-byte X25519 private. Stored on the Device row.
    * `our_registration_id` — for the embedded `registrationId` field.
    * `bundle` — parsed `%Whatsmeow.PreKeyBundle{}` from a
      `Whatsmeow.IQ.build_prekeys_get/2` response.
    * `our_ephemeral_keypair` — optional fixed keypair for tests;
      defaults to a fresh `Curve25519.generate_keypair/0`.
  """
  @spec encrypt_prekey_envelope(
          binary(),
          <<_::256>>,
          non_neg_integer(),
          PreKeyBundle.t(),
          keyword()
        ) :: {:ok, envelope :: binary(), Session.t()} | {:error, error()}
  def encrypt_prekey_envelope(
        plaintext,
        our_id_priv,
        our_registration_id,
        %PreKeyBundle{} = bundle,
        opts \\ []
      )
      when is_binary(plaintext) and byte_size(our_id_priv) == 32 do
    {eph_pub, eph_priv} =
      Keyword.get_lazy(opts, :our_ephemeral_keypair, &Curve25519.generate_keypair/0)

    {ratchet_pub, ratchet_priv} =
      Keyword.get_lazy(opts, :our_ratchet_keypair, &Curve25519.generate_keypair/0)

    # 1. X3DH initiator-side agree → root_key
    rk =
      X3DH.initiator_agree(
        our_id_priv,
        eph_priv,
        bundle.identity_pub,
        bundle.signed_pre_key_pub,
        bundle.pre_key_pub
      )

    # 2. First DH ratchet: DH(our_ratchet_priv, bob_spk_pub) mixed into rk
    #    → (new_rk, sending_ck). Matches libsignal's RootKey.createChain.
    shared = Curve25519.agree(ratchet_priv, bundle.signed_pre_key_pub)
    {new_rk, send_ck} = Ratchet.kdf_rk(rk, shared)

    our_id_pub = Curve25519.public_for(our_id_priv)

    # `pending_pre_key` is the X3DH-bootstrap parameter set the recipient
    # needs to derive a fresh session on EVERY outbound until they've
    # actually acked one of our messages. We stash it on the session and
    # `Whatsmeow.Send.encrypt_plaintext_for_peer/5` re-uses it to wrap
    # subsequent SignalMessages as PreKeySignalMessages. Cleared on first
    # successful inbound decrypt against this session.
    pending = %{
      pre_key_id: bundle.pre_key_id,
      signed_pre_key_id: bundle.signed_pre_key_id,
      base_key: eph_pub,
      our_identity_pub: our_id_pub,
      registration_id: our_registration_id
    }

    sess = %Session{
      dh_self: {ratchet_pub, ratchet_priv},
      dh_remote: bundle.signed_pre_key_pub,
      root_key: new_rk,
      sending_ck: send_ck,
      receiving_ck: nil,
      sending_n: 0,
      receiving_n: 0,
      previous_n: 0,
      skipped_keys: %{},
      pending_pre_key: pending
    }

    # 3. Encrypt the inner SignalMessage.
    case encrypt_signal_envelope(plaintext, sess, our_id_pub, bundle.identity_pub) do
      {:ok, inner_envelope, sess2} ->
        envelope = wrap_as_pkmsg(inner_envelope, pending)
        {:ok, envelope, sess2}

      err ->
        err
    end
  end

  @doc """
  Build a `PreKeySignalMessage` envelope around an already-encrypted
  `SignalMessage`. Used by both the initial `encrypt_prekey_envelope/5`
  call and by `Whatsmeow.Send.encrypt_plaintext_for_peer/5` on every
  subsequent outbound until the session is acked by the peer.

  baseKey / identityKey carry the 0x05 DjbType prefix on the wire —
  that's what every libsignal counterpart strips on decode.
  """
  @spec wrap_as_pkmsg(binary(), Session.pending_pre_key()) :: binary()
  def wrap_as_pkmsg(inner_envelope, %{
        pre_key_id: pre_key_id,
        signed_pre_key_id: spk_id,
        base_key: base_key,
        our_identity_pub: our_id_pub,
        registration_id: reg_id
      })
      when is_binary(inner_envelope) and is_binary(base_key) and is_binary(our_id_pub) do
    pkmsg = %PreKeySignalMessage{
      preKeyId: pre_key_id,
      baseKey: Wire.with_djb_type(base_key),
      identityKey: Wire.with_djb_type(our_id_pub),
      message: inner_envelope,
      registrationId: reg_id,
      signedPreKeyId: spk_id
    }

    Wire.encode_prekey_signal_message(pkmsg)
  end
end
