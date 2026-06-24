defmodule Whatsmeow.Signal.X3DH do
  @moduledoc """
  X3DH — Extended Triple Diffie-Hellman initial key agreement.

  Used at the start of a Signal session to derive the initial root key
  from four DH exchanges:

      DH1 = DH(IK_a, SPK_b)        # our identity + their signed prekey
      DH2 = DH(EK_a, IK_b)         # our ephemeral + their identity
      DH3 = DH(EK_a, SPK_b)        # our ephemeral + their signed prekey
      DH4 = DH(EK_a, OPK_b)        # our ephemeral + their one-time prekey (if any)

      master_secret = DH1 || DH2 || DH3 [|| DH4]
      root_key = HKDF(master_secret, info: "WhisperText", L: 32)

  This module implements the initiator's side. The responder runs the
  mirror computation using their own private keys.

  Reference: https://signal.org/docs/specifications/x3dh/
  """

  alias Whatsmeow.Crypto.{Curve25519, HKDF}

  @info "WhisperText"

  # X3DH "discontinuity" prefix: 32 bytes of 0xFF. Beware Elixir bit syntax —
  # `<<0xFF::256>>` is NOT 32×0xFF; it's the integer 0xFF zero-padded to 256
  # bits big-endian, i.e. 31 zero bytes + one 0xFF. The actual spec wants
  # `byte[32]` with every byte = 0xFF, which is what `:binary.copy/2` builds.
  @discontinuity :binary.copy(<<0xFF>>, 32)

  @doc """
  Compute the initial root key as the initiator.

  All key arguments are 32-byte raw X25519 keys.
  """
  @spec initiator_agree(
          our_identity_priv :: binary(),
          our_ephemeral_priv :: binary(),
          their_identity_pub :: binary(),
          their_signed_prekey_pub :: binary(),
          their_one_time_prekey_pub :: binary() | nil
        ) :: binary()
  def initiator_agree(
        our_identity_priv,
        our_ephemeral_priv,
        their_identity_pub,
        their_signed_prekey_pub,
        their_one_time_prekey_pub
      ) do
    dh1 = Curve25519.agree(our_identity_priv, their_signed_prekey_pub)
    dh2 = Curve25519.agree(our_ephemeral_priv, their_identity_pub)
    dh3 = Curve25519.agree(our_ephemeral_priv, their_signed_prekey_pub)

    dh4 =
      case their_one_time_prekey_pub do
        nil -> <<>>
        opk when byte_size(opk) == 32 -> Curve25519.agree(our_ephemeral_priv, opk)
      end

    master = dh1 <> dh2 <> dh3 <> dh4
    HKDF.derive(@discontinuity <> master, <<0::256>>, @info, 32)
  end

  @doc """
  Compute the initial root key as the **responder** (the receiver of
  the first `PreKeySignalMessage`).

  The two sides produce the same 32-byte root key by symmetric DH:

      initiator                   ↔  responder
      ─────────────────────────────────────────────────────────────
      DH1 = DH(IK_a_priv, SPK_b_pub)  =  DH(SPK_b_priv, IK_a_pub)
      DH2 = DH(EK_a_priv, IK_b_pub)   =  DH(IK_b_priv,  EK_a_pub)
      DH3 = DH(EK_a_priv, SPK_b_pub)  =  DH(SPK_b_priv, EK_a_pub)
      DH4 = DH(EK_a_priv, OPK_b_pub)  =  DH(OPK_b_priv, EK_a_pub)

  `their_base_key_pub` is the sender's ephemeral key (also called the
  "base key" in libsignal; it lives on `PreKeySignalMessage.baseKey`).
  Pass `nil` for `our_one_time_prekey_priv` when the sender didn't use
  an OPK (rare, but happens when the pool is exhausted).
  """
  @spec responder_agree(
          our_identity_priv :: binary(),
          our_signed_prekey_priv :: binary(),
          our_one_time_prekey_priv :: binary() | nil,
          their_identity_pub :: binary(),
          their_base_key_pub :: binary()
        ) :: binary()
  def responder_agree(
        our_identity_priv,
        our_signed_prekey_priv,
        our_one_time_prekey_priv,
        their_identity_pub,
        their_base_key_pub
      )
      when byte_size(our_identity_priv) == 32 and byte_size(our_signed_prekey_priv) == 32 and
             byte_size(their_identity_pub) == 32 and byte_size(their_base_key_pub) == 32 do
    dh1 = Curve25519.agree(our_signed_prekey_priv, their_identity_pub)
    dh2 = Curve25519.agree(our_identity_priv, their_base_key_pub)
    dh3 = Curve25519.agree(our_signed_prekey_priv, their_base_key_pub)

    dh4 =
      case our_one_time_prekey_priv do
        nil -> <<>>
        opk when byte_size(opk) == 32 -> Curve25519.agree(opk, their_base_key_pub)
      end

    master = dh1 <> dh2 <> dh3 <> dh4
    HKDF.derive(@discontinuity <> master, <<0::256>>, @info, 32)
  end
end
