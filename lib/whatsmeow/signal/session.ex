defmodule Whatsmeow.Signal.Session do
  @moduledoc """
  In-memory Double Ratchet session state.

  Persisted via `Whatsmeow.Signal.SessionRecord` (protobuf wire format
  compatible with libsignal's `StorageRecord.proto`).

  Fields mirror the Signal spec's state variables (DHs, DHr, RK, CKs,
  CKr, Ns, Nr, PN, MKSKIPPED). See:

    https://signal.org/docs/specifications/doubleratchet/#state-variables
  """

  alias Whatsmeow.Crypto.Curve25519
  alias Whatsmeow.Signal.Ratchet

  defstruct [
    # DHs: our current ratchet keypair {public, private}
    :dh_self,
    # DHr: their current ratchet public key (or nil)
    :dh_remote,
    # RK: 32-byte root key
    :root_key,
    # CKs: sending chain key (32 bytes or nil)
    :sending_ck,
    # CKr: receiving chain key (32 bytes or nil)
    :receiving_ck,
    # Ns: sending message counter
    sending_n: 0,
    # Nr: receiving message counter
    receiving_n: 0,
    # PN: number of messages sent in the previous sending chain
    previous_n: 0,
    # MKSKIPPED: %{ {dh_remote_pub, n} => message_key } cache of skipped keys
    skipped_keys: %{},
    # `pending_pre_key` — initiator-side X3DH-bootstrap envelope info that
    # must wrap every outbound SignalMessage as a `PreKeySignalMessage`
    # until the peer has actually decrypted at least one of our messages
    # and responded. Mirrors libsignal-java's
    # `SessionState.hasPendingPreKey()` (`SessionState.java`). Set in
    # `Whatsmeow.Signal.WireEncrypt.encrypt_prekey_envelope/5`; cleared by
    # `Whatsmeow.Signal.Decrypt` on the first inbound message that decrypts
    # on this session.
    #
    # Without this, our SECOND outbound on a fresh peer ships as bare
    # `<enc type="msg">` — the recipient has no Signal session for us yet
    # (they never decoded the first pkmsg, or did but we have no proof
    # of it on this side), and silently drops the steady-state envelope.
    # The chat UI shows "Waiting for this message" forever.
    pending_pre_key: nil
  ]

  @typedoc """
  Sender-side pkmsg-wrap parameters. Carries the public-key components
  the peer needs to re-derive X3DH on every outbound until the session
  is acked.
  """
  @type pending_pre_key :: %{
          pre_key_id: non_neg_integer() | nil,
          signed_pre_key_id: non_neg_integer(),
          base_key: <<_::256>>,
          our_identity_pub: <<_::256>>,
          registration_id: non_neg_integer()
        }

  @type keypair :: {pub :: binary(), priv :: binary()}
  @type t :: %__MODULE__{
          dh_self: keypair() | nil,
          dh_remote: binary() | nil,
          root_key: binary(),
          sending_ck: binary() | nil,
          receiving_ck: binary() | nil,
          sending_n: non_neg_integer(),
          receiving_n: non_neg_integer(),
          previous_n: non_neg_integer(),
          skipped_keys: %{optional({binary(), non_neg_integer()}) => binary()},
          pending_pre_key: pending_pre_key() | nil
        }

  @max_skipped 1_000

  @doc """
  Initialise the initiator's state from the X3DH root key and the peer's
  ratchet public key.
  """
  @spec init_initiator(binary(), binary()) :: t()
  def init_initiator(root_key, their_ratchet_pub)
      when byte_size(root_key) == 32 and byte_size(their_ratchet_pub) == 32 do
    dh_self = Curve25519.generate_keypair()
    {pub, priv} = dh_self
    shared = Curve25519.agree(priv, their_ratchet_pub)
    {new_rk, new_ck} = Ratchet.kdf_rk(root_key, shared)

    %__MODULE__{
      dh_self: {pub, priv},
      dh_remote: their_ratchet_pub,
      root_key: new_rk,
      sending_ck: new_ck,
      receiving_ck: nil
    }
  end

  @doc """
  Initialise the responder's state, given the X3DH root key and our own
  ratchet keypair (typically the signed prekey).
  """
  @spec init_responder(binary(), keypair()) :: t()
  def init_responder(root_key, {_pub, priv} = dh_self)
      when byte_size(root_key) == 32 and byte_size(priv) == 32 do
    %__MODULE__{
      dh_self: dh_self,
      dh_remote: nil,
      root_key: root_key,
      sending_ck: nil,
      receiving_ck: nil
    }
  end

  @doc "Limit on the number of skipped message keys we cache per session."
  def max_skipped, do: @max_skipped
end
