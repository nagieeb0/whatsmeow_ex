defmodule Whatsmeow.Transport.CertVerifier do
  @moduledoc """
  Verifies WhatsApp's Noise certificate chain returned during the XX
  handshake. Ports `verifyServerCert` from `whatsmeow-main/handshake.go`.

  Two checks:

  1. **Structural** — both intermediate and leaf cert details + signatures
     are present, sigs are 64 bytes, the leaf cert's key matches the
     server's decrypted static public key, and validity dates contain
     `now`.
  2. **Cryptographic** — each signature is verified with Signal's XEdDSA
     scheme over Curve25519 (`Whatsmeow.Crypto.XEdDSA`).

  The root issuer key (`@wa_cert_pub_key`) is hard-coded to match upstream
  Go. Set the `:wa_cert_pub_key` application env to override for testing.
  """

  alias Whatsmeow.Crypto.XEdDSA

  alias WACert.CertChain
  alias WACert.CertChain.NoiseCertificate, as: NestedCert
  alias WACert.CertChain.NoiseCertificate.Details, as: NestedDetails

  # WhatsApp's pinned root issuer public key (Curve25519 u-coordinate).
  # Same constant as `WACertPubKey` in handshake.go line 27.
  @wa_cert_pub_key <<0x14, 0x23, 0x75, 0x57, 0x4D, 0x0A, 0x58, 0x71, 0x66, 0xAA, 0xE7, 0x1E, 0xBE,
                     0x51, 0x64, 0x37, 0xC4, 0xA2, 0x8B, 0x73, 0xE3, 0x69, 0x5C, 0x6C, 0xE1, 0xF7,
                     0xF9, 0x54, 0x5D, 0xA8, 0xEE, 0x6B>>

  @wa_cert_issuer_serial 0

  @typedoc "Reasons cert verification can fail."
  @type error ::
          :malformed_cert
          | :missing_parts
          | :bad_sig_length
          | :bad_key_length
          | :intermediate_sig_invalid
          | :intermediate_issuer_mismatch
          | :leaf_sig_invalid
          | :leaf_issuer_mismatch
          | :leaf_key_mismatch
          | :cert_not_yet_valid
          | :cert_expired

  @doc """
  Verify `cert_chain_bin` (the decrypted ciphertext from the handshake's
  third frame) against the server's decrypted static key.

  Returns `:ok` on success or `{:error, reason}`.
  """
  @spec verify(binary(), binary(), keyword()) :: :ok | {:error, error()}
  def verify(cert_chain_bin, server_static, opts \\ [])
      when is_binary(cert_chain_bin) and is_binary(server_static) do
    root_pub = Keyword.get(opts, :root_pub, root_pub())
    now_unix = Keyword.get(opts, :now, System.system_time(:second))

    with {:ok, %CertChain{intermediate: inter, leaf: leaf}} <- decode_chain(cert_chain_bin),
         {:ok, inter_details_raw, inter_sig} <- extract(inter),
         {:ok, leaf_details_raw, leaf_sig} <- extract(leaf),
         :ok <- sig_length(inter_sig),
         :ok <- sig_length(leaf_sig),
         :ok <- verify_sig(root_pub, inter_details_raw, inter_sig, :intermediate_sig_invalid),
         {:ok, inter_details} <- decode_details(inter_details_raw),
         :ok <- check_issuer(inter_details, @wa_cert_issuer_serial, :intermediate_issuer_mismatch),
         :ok <- check_key_length(inter_details),
         :ok <- verify_sig(inter_details.key, leaf_details_raw, leaf_sig, :leaf_sig_invalid),
         :ok <- check_validity(inter_details, now_unix),
         {:ok, leaf_details} <- decode_details(leaf_details_raw),
         :ok <- check_issuer(leaf_details, inter_details.serial, :leaf_issuer_mismatch),
         :ok <- check_leaf_key(leaf_details, server_static),
         :ok <- check_validity(leaf_details, now_unix) do
      :ok
    end
  end

  defp verify_sig(pub, msg, sig, err) do
    if XEdDSA.verify(pub, msg, sig), do: :ok, else: {:error, err}
  end

  @doc "Return the pinned root pubkey (overridable via application env for tests)."
  @spec root_pub() :: binary()
  def root_pub do
    Application.get_env(:whatsmeow_ex, :wa_cert_pub_key, @wa_cert_pub_key)
  end

  # --- internals ------------------------------------------------------------

  defp decode_chain(bin) do
    {:ok, CertChain.decode(bin)}
  rescue
    _ -> {:error, :malformed_cert}
  end

  defp decode_details(bin) do
    {:ok, NestedDetails.decode(bin)}
  rescue
    _ -> {:error, :malformed_cert}
  end

  defp extract(%NestedCert{details: d, signature: s})
       when is_binary(d) and is_binary(s),
       do: {:ok, d, s}

  defp extract(_), do: {:error, :missing_parts}

  defp sig_length(sig) when byte_size(sig) == 64, do: :ok
  defp sig_length(_), do: {:error, :bad_sig_length}

  defp check_key_length(%NestedDetails{key: k}) when byte_size(k) == 32, do: :ok
  defp check_key_length(_), do: {:error, :bad_key_length}

  defp check_issuer(%NestedDetails{issuerSerial: got}, expected, _err) when got == expected,
    do: :ok

  defp check_issuer(_, _expected, err), do: {:error, err}

  defp check_leaf_key(%NestedDetails{key: k}, server_static)
       when is_binary(k) and is_binary(server_static) do
    if :crypto.hash_equals(k, server_static), do: :ok, else: {:error, :leaf_key_mismatch}
  end

  defp check_validity(%NestedDetails{notBefore: nb, notAfter: na}, now) do
    cond do
      is_integer(nb) and now < nb -> {:error, :cert_not_yet_valid}
      is_integer(na) and now > na -> {:error, :cert_expired}
      true -> :ok
    end
  end
end
