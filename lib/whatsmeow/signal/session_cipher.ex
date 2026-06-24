defmodule Whatsmeow.Signal.SessionCipher do
  @moduledoc """
  Encrypt and decrypt single messages against a `Whatsmeow.Signal.Session`.

  Implements the Double Ratchet encrypt/decrypt routines:

  * `encrypt/2` — advances the sending chain, derives a message key,
    AES-256-CBC + HMAC-SHA256 over the plaintext, returns the wire envelope
    and the updated session.
  * `decrypt/3` — given the sender's current ratchet pub and message
    counter, advances the receiving chain (performing a DH step if the
    sender's key changed), derives the corresponding message key, verifies
    the MAC, decrypts, returns the plaintext and updated session.

  The encrypted wire format is:

      version_byte (0x33 — v3) || HMAC[0..8]

  with the body being the protobuf-encoded `SignalMessage`. This module
  returns the AES ciphertext and MAC separately; the wire envelope
  packaging is done by `Whatsmeow.Signal.Protocol.Message` (Phase 9).
  """

  alias Whatsmeow.Crypto.{AES, Curve25519}
  alias Whatsmeow.Signal.{Ratchet, Session}

  @typedoc "An encrypted message ready for serialisation."
  @type ciphertext :: %{
          ratchet_pub: binary(),
          counter: non_neg_integer(),
          previous_counter: non_neg_integer(),
          body: binary(),
          mac: binary()
        }

  @doc """
  Encrypt `plaintext`. Returns `{ciphertext, new_session}`.

  Requires that the session has an active sending chain (initiator path
  taken or post-first-receive).
  """
  @spec encrypt(Session.t(), binary()) :: {ciphertext(), Session.t()}
  def encrypt(%Session{sending_ck: ck} = sess, plaintext)
      when is_binary(ck) and byte_size(ck) == 32 do
    {next_ck, message_key} = Ratchet.kdf_ck(ck)
    {enc_key, mac_key, iv} = Ratchet.derive_message_keys(message_key)

    body = AES.CBC.encrypt(enc_key, iv, plaintext)
    {our_pub, _our_priv} = sess.dh_self

    mac_input = our_pub <> <<sess.sending_n::big-unsigned-32>> <> body
    mac = :crypto.mac(:hmac, :sha256, mac_key, mac_input) |> :binary.part(0, 8)

    ct = %{
      ratchet_pub: our_pub,
      counter: sess.sending_n,
      previous_counter: sess.previous_n,
      body: body,
      mac: mac
    }

    {ct, %Session{sess | sending_ck: next_ck, sending_n: sess.sending_n + 1}}
  end

  def encrypt(%Session{sending_ck: nil}, _) do
    raise ArgumentError, "session has no sending chain — needs an outbound DH step first"
  end

  @doc """
  Decrypt `ct` (an inbound message). Returns `{:ok, plaintext, new_session}`
  on success.

  If the inbound `ratchet_pub` differs from our `dh_remote`, perform a DH
  step first: advance the receiving chain to the right of the current
  sending chain, then start a fresh sending chain.
  """
  @spec decrypt(Session.t(), ciphertext()) ::
          {:ok, binary(), Session.t()} | {:error, atom()}
  def decrypt(%Session{} = sess, %{ratchet_pub: rpub} = ct) when byte_size(rpub) == 32 do
    sess = maybe_dh_ratchet(sess, ct)
    do_decrypt(sess, ct)
  end

  @doc false
  # Public for `Whatsmeow.Signal.WireDecrypt`. Same ratchet-step logic
  # whether the caller arrived via the home-grown encrypt/decrypt format
  # or the libsignal wire format.
  def maybe_dh_ratchet_pub(sess, ct), do: maybe_dh_ratchet(sess, ct)

  defp maybe_dh_ratchet(%Session{dh_remote: rpub} = sess, %{ratchet_pub: rpub}), do: sess

  defp maybe_dh_ratchet(%Session{} = sess, %{ratchet_pub: new_rpub}) do
    {_their_old_pub, our_priv} = ensure_self_kp(sess)

    # 1. Mix in DH of our old private with their new public → new receiving chain.
    dh1 = Curve25519.agree(our_priv, new_rpub)
    {rk1, new_recv_ck} = Ratchet.kdf_rk(sess.root_key, dh1)

    # 2. Generate a fresh DH key on our side; mix → new sending chain.
    new_self = Curve25519.generate_keypair()
    {_new_self_pub, new_self_priv} = new_self
    dh2 = Curve25519.agree(new_self_priv, new_rpub)
    {rk2, new_send_ck} = Ratchet.kdf_rk(rk1, dh2)

    %Session{
      sess
      | dh_self: new_self,
        dh_remote: new_rpub,
        root_key: rk2,
        receiving_ck: new_recv_ck,
        sending_ck: new_send_ck,
        previous_n: sess.sending_n,
        sending_n: 0,
        receiving_n: 0
    }
  end

  defp do_decrypt(%Session{receiving_ck: nil}, _ct), do: {:error, :no_receiving_chain}

  defp do_decrypt(%Session{} = sess, %{counter: n} = ct) do
    cached_key = {sess.dh_remote, n}

    case Map.fetch(sess.skipped_keys, cached_key) do
      {:ok, mk} ->
        decrypt_with_message_key(mk, ct, fn ->
          %Session{sess | skipped_keys: Map.delete(sess.skipped_keys, cached_key)}
        end)

      :error ->
        %Session{} = sess = skip_message_keys(sess, n)
        {next_ck, message_key} = Ratchet.kdf_ck(sess.receiving_ck)

        decrypt_with_message_key(message_key, ct, fn ->
          %Session{sess | receiving_ck: next_ck, receiving_n: sess.receiving_n + 1}
        end)
    end
  end

  defp decrypt_with_message_key(mk, ct, advance_session) do
    {enc_key, mac_key, iv} = Ratchet.derive_message_keys(mk)

    expected_mac =
      :crypto.mac(
        :hmac,
        :sha256,
        mac_key,
        ct.ratchet_pub <> <<ct.counter::big-unsigned-32>> <> ct.body
      )
      |> :binary.part(0, 8)

    if not :crypto.hash_equals(expected_mac, ct.mac) do
      {:error, :mac_mismatch}
    else
      case AES.CBC.decrypt(enc_key, iv, ct.body) do
        {:ok, plaintext} -> {:ok, plaintext, advance_session.()}
        err -> err
      end
    end
  end

  @doc false
  def skip_message_keys_pub(sess, n), do: skip_message_keys(sess, n)

  defp skip_message_keys(%Session{receiving_n: n_now} = sess, n) when n > n_now do
    Enum.reduce(n_now..(n - 1), sess, fn i, %Session{} = s ->
      {next_ck, mk} = Ratchet.kdf_ck(s.receiving_ck)
      key = {s.dh_remote, i}

      %Session{
        s
        | receiving_ck: next_ck,
          receiving_n: i + 1,
          skipped_keys: Map.put(s.skipped_keys, key, mk)
      }
    end)
  end

  defp skip_message_keys(%Session{} = sess, _), do: sess

  defp ensure_self_kp(%Session{dh_self: {pub, priv}}), do: {pub, priv}

  defp ensure_self_kp(%Session{dh_self: nil}) do
    raise ArgumentError, "session has no DH keypair — invalid state for ratchet step"
  end
end
