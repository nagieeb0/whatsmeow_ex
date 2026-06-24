defmodule Whatsmeow.Signal.GroupSession do
  @moduledoc """
  Per-(chat, sender) state for libsignal-wire group messaging.

  Mirrors libsignal-protocol-java's `SenderKeyState` — the chain key, current
  iteration, peer signing public key (verify-only on the receive side) and a
  cache of skipped message keys for out-of-order delivery.

  This is the libsignal-wire counterpart to `Whatsmeow.Signal.SenderKey` (the
  home-grown variant kept for the internal `GroupCipher` round-trip tests).
  Where `SenderKey` was symmetric and unsigned, `GroupSession` carries the
  peer's `signing_pub` so each inbound `SenderKeyMessage` can be verified
  against an XEdDSA signature.

  Seed a `%GroupSession{}` from a decoded
  `Whatsmeow.Signal.SenderKeyWire.SenderKeyDistributionMessage` via
  `from_distribution/1`. The signing public key in the distribution message
  carries libsignal's leading `0x05` DjbType byte; `from_distribution/1`
  strips it.
  """

  alias Whatsmeow.Signal.SenderKeyWire.SenderKeyDistributionMessage
  alias Whatsmeow.Signal.Wire

  @typedoc "Cached message keys for replayed / out-of-order iterations."
  @type skipped_keys :: %{optional(non_neg_integer()) => binary()}

  @typedoc "Group-cipher state for a single (chat, sender) pair."
  @type t :: %__MODULE__{
          id: non_neg_integer(),
          chain_key: <<_::256>>,
          iteration: non_neg_integer(),
          signing_pub: <<_::256>>,
          signing_priv: <<_::256>> | nil,
          skipped_keys: skipped_keys()
        }

  @derive {Inspect, except: [:chain_key, :signing_priv, :skipped_keys]}
  defstruct [
    :id,
    :chain_key,
    :iteration,
    :signing_pub,
    :signing_priv,
    skipped_keys: %{}
  ]

  @max_skip 2_000

  @doc """
  Build a `%GroupSession{}` from a decoded
  `SenderKeyDistributionMessage`.

  Returns `{:ok, %GroupSession{}}` on success, `{:error, atom}` if the
  signing key field is missing or the chain key is the wrong size.
  """
  @spec from_distribution(SenderKeyDistributionMessage.t()) ::
          {:ok, t()} | {:error, :bad_signing_key | :bad_chain_key}
  def from_distribution(%SenderKeyDistributionMessage{} = sdkm) do
    cond do
      not is_binary(sdkm.chainKey) or byte_size(sdkm.chainKey) != 32 ->
        {:error, :bad_chain_key}

      true ->
        case Wire.strip_djb_type(sdkm.signingKey || <<>>) do
          nil ->
            {:error, :bad_signing_key}

          <<signing_pub::binary-size(32)>> ->
            {:ok,
             %__MODULE__{
               id: sdkm.id || 0,
               chain_key: sdkm.chainKey,
               iteration: sdkm.iteration || 0,
               signing_pub: signing_pub,
               signing_priv: nil,
               skipped_keys: %{}
             }}
        end
    end
  end

  @doc """
  Build a fresh outbound `%GroupSession{}` for sending. Generates an XEdDSA
  signing keypair, a random chain key, and starts iteration at 0.

  Use the matching `to_distribution/1` to derive the
  `SenderKeyDistributionMessage` that other group members need to seed
  their own session.
  """
  @spec new(non_neg_integer()) :: t()
  def new(id) when is_integer(id) and id >= 0 do
    {signing_pub, signing_priv} = Whatsmeow.Crypto.Curve25519.generate_keypair()

    %__MODULE__{
      id: id,
      chain_key: :crypto.strong_rand_bytes(32),
      iteration: 0,
      signing_pub: signing_pub,
      signing_priv: signing_priv,
      skipped_keys: %{}
    }
  end

  @doc """
  Produce a `SenderKeyDistributionMessage` from an outbound session — used
  by senders to seed their peers' inbound sessions on the first group
  message. The signing key is wire-prefixed with `0x05` per libsignal.

  Raises if the session has no `signing_priv` (i.e. it was created from a
  peer's distribution message, not via `new/1`).
  """
  @spec to_distribution(t()) :: SenderKeyDistributionMessage.t()
  def to_distribution(%__MODULE__{signing_pub: pub, chain_key: ck} = gs)
      when is_binary(pub) and is_binary(ck) do
    %SenderKeyDistributionMessage{
      id: gs.id,
      iteration: gs.iteration,
      chainKey: gs.chain_key,
      signingKey: Wire.with_djb_type(gs.signing_pub)
    }
  end

  @doc """
  Configurable upper bound on how far ahead an `iteration` may jump before
  we treat the message as malicious / replay. Mirrors libsignal-java's
  `MAX_MESSAGE_KEYS = 2000`.
  """
  @spec max_skip() :: pos_integer()
  def max_skip, do: @max_skip
end
