defmodule Whatsmeow.Signal.Store do
  @moduledoc """
  Behaviour for storing Signal protocol state.

  Decouples the protocol code from Ecto so tests can use ETS-backed mocks
  via Mox. The default implementation is `Whatsmeow.Signal.Store.Ecto`,
  delegating to `Whatsmeow.Store`.
  """

  alias Whatsmeow.Signal.{SenderKey, Session}

  @type our_jid :: String.t()
  @type their_jid :: String.t()
  @type chat_jid :: String.t()

  @callback load_session(our_jid, their_jid) :: {:ok, Session.t()} | {:error, :not_found}
  @callback save_session(our_jid, their_jid, Session.t()) :: :ok | {:error, term()}

  @callback load_sender_key(our_jid, chat_jid, their_jid) ::
              {:ok, SenderKey.t()} | {:error, :not_found}
  @callback save_sender_key(our_jid, chat_jid, their_jid, SenderKey.t()) ::
              :ok | {:error, term()}

  @callback load_identity(our_jid, their_jid) :: {:ok, binary()} | {:error, :not_found}
  @callback save_identity(our_jid, their_jid, binary()) :: :ok | {:error, term()}
end
