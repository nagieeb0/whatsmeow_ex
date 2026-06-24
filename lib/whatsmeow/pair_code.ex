defmodule Whatsmeow.PairCode do
  @moduledoc """
  Phone-number-based pairing flow.

  Instead of scanning a QR, the user enters a phone number on the client.
  We send a `<link_code_companion_reg stage="companion_hello">` IQ and the
  server replies with a `link_code_pairing_ref`. The library returns an
  8-character base32 code (formatted `XXXX-XXXX`) that the user types into
  the WhatsApp app on their phone.

  When the user enters the code, the phone sends a notification IQ
  carrying the primary device's wrapped ephemeral public key + identity
  pub. The Session must:

  1. Decrypt the wrapped key using the linking code (PBKDF2-derived AES-CTR).
  2. Compute the ECDH shared secret (X25519).
  3. Wrap our identity key + the primary's identity key + a random adv-secret
     blob with AES-GCM (key from HKDF over the shared secret).
  4. Send `<link_code_companion_reg stage="companion_finish">` with that
     wrapped key bundle.

  This module ships the **client-side primitives**:

  * `generate_ephemeral_key/0` — fresh X25519 keypair + linking-code-encrypted
    public key (the 80-byte salt+iv+ciphertext blob the server expects)
  * `format_code/1`             — pretty-format `RAW8` → `RAW4-RAW4`
  * `build_hello_iq/4`          — companion_hello IQ
  * `build_finish_iq/4`         — companion_finish IQ
  * `parse_pair_notification/1` — parse the inbound `<notification>` payload
  * `unwrap_primary_ephemeral_pub/2` — AES-CTR decrypt
  * `derive_adv_secret/4`       — final adv-secret HKDF (32 bytes)
  * `derive_key_bundle_key/2`   — HKDF for AES-GCM wrap

  The orchestration (`Session.pair_phone/2`) wires these into the live IQ
  flow. Pure functions here are independently testable.

  Mirrors `whatsmeow-main/pair-code.go`.
  """

  import Bitwise, only: [<<<: 2]

  alias Whatsmeow.Binary.Node
  alias Whatsmeow.Crypto.{Curve25519, HKDF}
  alias Whatsmeow.IQ
  alias Whatsmeow.Session

  # Custom base32 alphabet — WhatsApp uses 1..9 (no 0) + most letters (no I, O, U)
  # for the linking code so users can read it back accurately. The Go upstream
  # uses the same alphabet in `pair-code.go:48`.
  @linking_alphabet ~c"123456789ABCDEFGHJKLMNPQRSTVWXYZ"
  @server_jid "s.whatsapp.net"
  @namespace "md"
  @default_timeout 30_000

  defmodule HelloResult do
    @moduledoc "Cached state returned by `start_link/3` (used by the notification handler)."
    @enforce_keys [:jid, :keypair, :linking_code, :pairing_ref]
    defstruct [:jid, :keypair, :linking_code, :pairing_ref]

    @type t :: %__MODULE__{
            jid: String.t(),
            keypair: {binary(), binary()},
            linking_code: String.t(),
            pairing_ref: binary()
          }
  end

  # --- Public API ------------------------------------------------------------

  @doc """
  Start a phone-number pairing handshake.

  Sends the `companion_hello` IQ and returns the user-facing 8-character
  code (`XXXX-XXXX`) plus a cache the caller passes to the inbound
  notification handler. The phone number must be in international format
  with no `+`, leading zeros, or punctuation (the function normalises by
  stripping non-digit chars).

  Mirrors Go's `PairPhone` (`pair-code.go:90`).
  """
  @spec start_link(pid() | String.t(), String.t(), keyword()) ::
          {:ok, formatted_code :: String.t(), HelloResult.t()} | {:error, term()}
  def start_link(session, phone, opts \\ []) when is_binary(phone) do
    timeout = Keyword.get(opts, :timeout, @default_timeout)
    show_push? = Keyword.get(opts, :show_push_notification?, true)
    client_type = Keyword.get(opts, :client_type, 7)
    client_display = Keyword.get(opts, :client_display, "Chrome (Linux)")
    noise_pub = Keyword.fetch!(opts, :noise_pub)

    with {:ok, phone_digits} <- normalize_phone(phone),
         jid = phone_digits <> "@" <> Whatsmeow.Types.JID.default_user_server(),
         {keypair, ephemeral_blob, linking_code} <- generate_ephemeral_key(),
         iq =
           build_hello_iq(jid, ephemeral_blob, noise_pub, %{
             show_push_notification?: show_push?,
             client_type: client_type,
             client_display: client_display
           }),
         {:ok, resp} <- Session.send_iq(session, iq, timeout),
         {:ok, pairing_ref} <- extract_pairing_ref(resp) do
      cache = %HelloResult{
        jid: jid,
        keypair: keypair,
        linking_code: linking_code,
        pairing_ref: pairing_ref
      }

      {:ok, format_code(linking_code), cache}
    end
  end

  # --- Crypto primitives -----------------------------------------------------

  @doc """
  Generate a fresh companion ephemeral key + the 80-byte wrapped public-key
  blob the server expects.

  Returns `{ {ephemeral_pub, ephemeral_priv}, blob, encoded_linking_code }`.

  The blob layout:

      <<salt::32, iv::16, encrypted_pub::32>>

  Mirrors Go's `generateCompanionEphemeralKey` (`pair-code.go:57`).
  """
  @spec generate_ephemeral_key() ::
          {{binary(), binary()}, binary(), String.t()}
  def generate_ephemeral_key do
    {pub, priv} = Curve25519.generate_keypair()
    salt = :crypto.strong_rand_bytes(32)
    iv = :crypto.strong_rand_bytes(16)
    linking_raw = :crypto.strong_rand_bytes(5)
    encoded_code = base32_encode(linking_raw)

    link_code_key = pbkdf2_sha256(encoded_code, salt, 2 <<< 16, 32)

    encrypted_pub = aes_ctr_xor(link_code_key, iv, pub)

    blob = salt <> iv <> encrypted_pub

    {{pub, priv}, blob, encoded_code}
  end

  @doc """
  Format an 8-character raw linking code (`"ABCDEFGH"`) as `"ABCD-EFGH"`.
  """
  @spec format_code(String.t()) :: String.t()
  def format_code(code) when is_binary(code) and byte_size(code) == 8 do
    String.slice(code, 0, 4) <> "-" <> String.slice(code, 4, 4)
  end

  @doc """
  Build the `<iq xmlns="md" type="set"><link_code_companion_reg stage="companion_hello">…</iq>`.

  Mirrors `pair-code.go:102`.
  """
  @spec build_hello_iq(String.t() | Whatsmeow.Types.JID.t(), binary(), binary(), map()) ::
          Node.t()
  def build_hello_iq(jid, wrapped_pub_blob, noise_pub, opts) do
    id = Map.get(opts, :id) || IQ.generate_id()
    show_push? = Map.get(opts, :show_push_notification?, true)
    client_type = Map.get(opts, :client_type, 7)
    client_display = Map.get(opts, :client_display, "Chrome (Linux)")

    Node.new(
      "iq",
      %{
        "id" => id,
        "to" => @server_jid,
        "type" => "set",
        "xmlns" => @namespace
      },
      [
        Node.new(
          "link_code_companion_reg",
          %{
            # MUST be a `%JID{}` so the binary encoder emits the
            # `@jid_pair` opcode (250). A plain string here tokens as
            # a generic UTF-8 attr value, and the server silently drops
            # the IQ — same shape as the prekey-bundle bug fixed in
            # `Whatsmeow.IQ.build_prekeys_get/2`.
            "jid" => normalize_jid!(jid),
            "stage" => "companion_hello",
            "should_show_push_notification" => to_string(show_push?)
          },
          [
            Node.new(
              "link_code_pairing_wrapped_companion_ephemeral_pub",
              %{},
              wrapped_pub_blob
            ),
            Node.new("companion_server_auth_key_pub", %{}, noise_pub),
            Node.new("companion_platform_id", %{}, Integer.to_string(client_type)),
            Node.new("companion_platform_display", %{}, client_display),
            Node.new("link_code_pairing_nonce", %{}, <<0>>)
          ]
        )
      ]
    )
  end

  @doc """
  Build the `companion_finish` IQ that wraps our identity key + the
  primary's identity key + the adv-secret randomness, all AES-GCM encrypted.

  `wrapped_bundle` is the output of `wrap_key_bundle/5`. `our_identity_pub`
  is the 32-byte X25519 public key. `pairing_ref` is what the server returned
  in the hello response.

  Mirrors `pair-code.go:227`.
  """
  @spec build_finish_iq(
          String.t() | Whatsmeow.Types.JID.t(),
          binary(),
          binary(),
          binary(),
          keyword()
        ) :: Node.t()
  def build_finish_iq(jid, wrapped_bundle, our_identity_pub, pairing_ref, opts \\ []) do
    id = Keyword.get(opts, :id) || IQ.generate_id()

    Node.new(
      "iq",
      %{
        "id" => id,
        "to" => @server_jid,
        "type" => "set",
        "xmlns" => @namespace
      },
      [
        Node.new(
          "link_code_companion_reg",
          %{
            # See `build_hello_iq/4` — must be `%JID{}` so the encoder
            # emits the `@jid_pair` opcode.
            "jid" => normalize_jid!(jid),
            "stage" => "companion_finish"
          },
          [
            Node.new("link_code_pairing_wrapped_key_bundle", %{}, wrapped_bundle),
            Node.new("companion_identity_public", %{}, our_identity_pub),
            Node.new("link_code_pairing_ref", %{}, pairing_ref)
          ]
        )
      ]
    )
  end

  defp normalize_jid!(%Whatsmeow.Types.JID{} = j), do: j

  defp normalize_jid!(s) when is_binary(s) do
    case Whatsmeow.Types.JID.parse(s) do
      {:ok, %Whatsmeow.Types.JID{} = j} -> j
      _ -> raise ArgumentError, "pair_code: invalid jid #{inspect(s)}"
    end
  end

  @doc """
  AES-CTR-decrypt the primary device's wrapped ephemeral public key, then
  derive the ECDH shared secret using our ephemeral private key.

  `wrapped_pub` is the 80-byte blob from the notification:
  `<<primary_salt::32, primary_iv::16, primary_encrypted_pub::32>>`.

  Returns `{:ok, shared_secret_32b}` or `{:error, reason}`.

  Mirrors lines 189-202 of `pair-code.go`.
  """
  @spec unwrap_primary_ephemeral_pub(binary(), binary(), binary()) ::
          {:ok, binary()} | {:error, term()}
  def unwrap_primary_ephemeral_pub(wrapped_pub, linking_code, our_ephemeral_priv)
      when byte_size(wrapped_pub) == 80 do
    <<salt::binary-size(32), iv::binary-size(16), encrypted::binary-size(32)>> = wrapped_pub

    link_code_key = pbkdf2_sha256(linking_code, salt, 2 <<< 16, 32)
    primary_pub = aes_ctr_xor(link_code_key, iv, encrypted)

    case Curve25519.agree(our_ephemeral_priv, primary_pub) do
      shared when is_binary(shared) and byte_size(shared) == 32 ->
        {:ok, shared}

      other ->
        {:error, {:bad_shared_secret, other}}
    end
  end

  def unwrap_primary_ephemeral_pub(_, _, _), do: {:error, :bad_wrapped_pub_length}

  @doc """
  Compute the 32-byte adv-secret used to authenticate the eventual
  `<pair-success>` HMAC.

  Mirrors `pair-code.go:223`.
  """
  @spec derive_adv_secret(binary(), binary(), binary()) :: binary()
  def derive_adv_secret(ephemeral_shared_secret, identity_shared_secret, adv_random)
      when byte_size(adv_random) == 32 do
    input = ephemeral_shared_secret <> identity_shared_secret <> adv_random
    HKDF.expand(HKDF.extract(input, <<>>), "adv_secret", 32)
  end

  @doc "Compute the HKDF key for AES-GCM bundle wrapping."
  @spec derive_key_bundle_key(binary(), binary()) :: binary()
  def derive_key_bundle_key(ephemeral_shared_secret, key_bundle_salt) do
    HKDF.expand(
      HKDF.extract(ephemeral_shared_secret, key_bundle_salt),
      "link_code_pairing_key_bundle_encryption_key",
      32
    )
  end

  @doc """
  Wrap the (our_identity_pub ‖ primary_identity_pub ‖ adv_random) plaintext
  into an AES-GCM-encrypted blob suitable for the `companion_finish` IQ.

  Returns the on-the-wire bytes: `<<bundle_salt::32, nonce::12, ciphertext+tag::*>>`.
  """
  @spec wrap_key_bundle(binary(), binary(), binary(), binary(), binary()) :: binary()
  def wrap_key_bundle(
        ephemeral_shared_secret,
        our_identity_pub,
        primary_identity_pub,
        adv_random,
        opts \\ %{}
      ) do
    salt = Map.get(opts, :salt, :crypto.strong_rand_bytes(32))
    nonce = Map.get(opts, :nonce, :crypto.strong_rand_bytes(12))

    key = derive_key_bundle_key(ephemeral_shared_secret, salt)

    plaintext = our_identity_pub <> primary_identity_pub <> adv_random

    {ct, tag} = :crypto.crypto_one_time_aead(:aes_256_gcm, key, nonce, plaintext, <<>>, true)

    salt <> nonce <> ct <> tag
  end

  @doc """
  Parse the inbound `<notification>` carrying a `link_code_companion_reg`
  child. Returns a map with the keys:

  * `:pairing_ref`              — the same ref returned by hello
  * `:wrapped_primary_pub`      — 80-byte blob to feed into `unwrap_primary_ephemeral_pub/3`
  * `:primary_identity_pub`     — 32-byte primary identity pub

  Mirrors `handleCodePairNotification` (`pair-code.go:150`).
  """
  @spec parse_pair_notification(Node.t()) :: {:ok, map()} | {:error, term()}
  def parse_pair_notification(%Node{} = parent) do
    with %Node{} = inner <- Node.get_child(parent, "link_code_companion_reg"),
         %Node{content: pairing_ref} when is_binary(pairing_ref) <-
           Node.get_child(inner, "link_code_pairing_ref"),
         %Node{content: wrapped} when is_binary(wrapped) and byte_size(wrapped) >= 80 <-
           Node.get_child(inner, "link_code_pairing_wrapped_primary_ephemeral_pub"),
         %Node{content: primary_pub} when is_binary(primary_pub) <-
           Node.get_child(inner, "primary_identity_pub") do
      {:ok,
       %{
         pairing_ref: pairing_ref,
         wrapped_primary_pub: wrapped,
         primary_identity_pub: primary_pub
       }}
    else
      _ -> {:error, :missing_or_malformed_child}
    end
  end

  @doc """
  Validate a phone number string. Returns `{:ok, digits}` or `{:error, reason}`.

  * Strips all non-digit characters first.
  * Rejects numbers <= 6 digits (too short to be a real phone).
  * Rejects numbers starting with 0 (national format, not international).
  """
  @spec normalize_phone(String.t()) :: {:ok, String.t()} | {:error, atom()}
  def normalize_phone(phone) when is_binary(phone) do
    digits = String.replace(phone, ~r/[^0-9]/, "")

    cond do
      byte_size(digits) <= 6 -> {:error, :phone_too_short}
      String.starts_with?(digits, "0") -> {:error, :phone_not_international}
      true -> {:ok, digits}
    end
  end

  @doc """
  Generate a fresh 8-character pairing code (kept for back-compat).
  """
  @spec generate_code() :: String.t()
  def generate_code do
    raw =
      for _ <- 1..8, into: "", do: <<Enum.random(@linking_alphabet)>>

    format_code(raw)
  end

  @doc "Validate a phone number is digits-only and 6-15 chars."
  @spec valid_phone?(String.t()) :: boolean()
  def valid_phone?(phone) when is_binary(phone) do
    Regex.match?(~r/^\d{6,15}$/, phone)
  end

  # --- Internals -------------------------------------------------------------

  defp base32_encode(<<>>), do: ""

  defp base32_encode(bytes) when is_binary(bytes) do
    # Custom base32: 5 bits per char, padding to alphabet.
    # 5 input bytes → 8 output chars.
    encode_base32(bytes, <<>>)
  end

  defp encode_base32(<<>>, acc), do: acc

  defp encode_base32(<<a, b, c, d, e, rest::binary>>, acc) do
    bits = <<a, b, c, d, e>>

    <<i1::5, i2::5, i3::5, i4::5, i5::5, i6::5, i7::5, i8::5>> = bits

    chars =
      <<Enum.at(@linking_alphabet, i1), Enum.at(@linking_alphabet, i2),
        Enum.at(@linking_alphabet, i3), Enum.at(@linking_alphabet, i4),
        Enum.at(@linking_alphabet, i5), Enum.at(@linking_alphabet, i6),
        Enum.at(@linking_alphabet, i7), Enum.at(@linking_alphabet, i8)>>

    encode_base32(rest, acc <> chars)
  end

  defp pbkdf2_sha256(password, salt, iterations, key_length) do
    :crypto.pbkdf2_hmac(:sha256, password, salt, iterations, key_length)
  end

  defp aes_ctr_xor(key, iv, data) do
    :crypto.crypto_one_time(:aes_256_ctr, key, iv, data, true)
  end

  defp extract_pairing_ref(%Node{} = resp) do
    case Node.get_child(resp, "link_code_companion_reg") do
      %Node{} = inner ->
        case Node.get_child(inner, "link_code_pairing_ref") do
          %Node{content: bin} when is_binary(bin) -> {:ok, bin}
          _ -> {:error, :missing_pairing_ref}
        end

      _ ->
        {:error, :missing_link_code_companion_reg}
    end
  end
end
