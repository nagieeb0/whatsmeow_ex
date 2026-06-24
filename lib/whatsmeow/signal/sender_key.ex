defmodule Whatsmeow.Signal.SenderKey do
  @moduledoc """
  Sender-key state for group messaging (Signal Group v2).

  Per (sender, group) pair the state is:

  * `id` — the sender-key identifier
  * `chain_key` — 32-byte symmetric chain key (advanced per outbound message)
  * `iteration` — current message counter
  * `signing_key` — Curve25519 keypair used to sign each ciphertext so other
    group members can verify authenticity

  Skipped keys are cached just like in 1:1 sessions to tolerate out-of-order
  delivery.
  """

  defstruct [
    :id,
    :chain_key,
    :signing_key,
    iteration: 0,
    skipped_keys: %{}
  ]

  @type t :: %__MODULE__{
          id: non_neg_integer(),
          chain_key: binary(),
          signing_key: {binary(), binary()},
          iteration: non_neg_integer(),
          skipped_keys: %{optional(non_neg_integer()) => binary()}
        }

  @doc "Fresh sender-key state with a random chain key and signing keypair."
  @spec new(non_neg_integer()) :: t()
  def new(id) when is_integer(id) and id >= 0 do
    %__MODULE__{
      id: id,
      chain_key: :crypto.strong_rand_bytes(32),
      signing_key: Whatsmeow.Crypto.Curve25519.generate_keypair()
    }
  end
end
