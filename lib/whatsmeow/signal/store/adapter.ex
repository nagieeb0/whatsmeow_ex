defmodule Whatsmeow.Signal.Store.Adapter do
  @moduledoc """
  The single seam every Signal crypto read and write goes through.

  Two adapters ship:

    * `Whatsmeow.Signal.Store.Postgres` (default) — relational, multi-node,
      and the only one where `Whatsmeow.Signal.Lock` can actually serialise the
      send and receive paths against each other;
    * `Whatsmeow.Signal.Store.DETS` — on-disk, single-node, no database.

  Select with:

      config :whatsmeow_ex, signal_store: Whatsmeow.Signal.Store.DETS

  ## Why the indirection exists

  Session and sender-key records were read and written by direct calls to the
  Postgres module scattered across the send and receive paths. That made
  "run this without a database" impossible without editing five files, and it
  made every call site responsible for its own `repo_up?` fallback — several got
  it subtly different. One seam, one fallback rule.

  ## The no-store fallback

  When the configured adapter isn't usable (Postgres selected but not running —
  the normal state in unit tests), reads return `:not_found` and writes return
  `{:error, :no_store}`. That is deliberately silent rather than raising: the
  crypto layer's own tests exercise the ratchets without any persistence, and a
  hard failure there would force every one of them to stand up a database.

  It is *not* silent in production, because a missing Repo means the supervision
  tree never started.
  """

  alias Whatsmeow.Signal.{GroupSession, Session}

  @doc "The configured adapter module."
  @spec impl() :: module()
  def impl, do: Application.get_env(:whatsmeow_ex, :signal_store, Whatsmeow.Signal.Store.Postgres)

  @doc "True when the configured adapter is usable right now."
  @spec available?() :: boolean()
  def available? do
    case impl() do
      Whatsmeow.Signal.Store.Postgres ->
        Code.ensure_loaded?(Whatsmeow.Repo) and is_pid(Process.whereis(Whatsmeow.Repo))

      module ->
        Code.ensure_loaded?(module)
    end
  end

  # --- 1:1 sessions ----------------------------------------------------------

  @spec load_session(String.t(), String.t()) :: {:ok, Session.t()} | :not_found | {:error, term()}
  def load_session(our_jid, their_id) do
    if available?(), do: impl().get(our_jid, their_id), else: :not_found
  end

  @spec save_session(String.t(), String.t(), Session.t()) :: :ok | {:error, term()}
  def save_session(our_jid, their_id, session) do
    if available?(), do: impl().put(our_jid, their_id, session), else: {:error, :no_store}
  end

  # --- Group sender keys -----------------------------------------------------

  @spec load_sender_key(String.t(), String.t(), String.t()) ::
          {:ok, GroupSession.t()} | :not_found | {:error, term()}
  def load_sender_key(our_jid, chat_id, sender_id) do
    if available?() do
      case impl() do
        Whatsmeow.Signal.Store.Postgres ->
          Whatsmeow.Signal.GroupSession.Store.Postgres.get(our_jid, chat_id, sender_id)

        module ->
          module.get_sender_key(our_jid, chat_id, sender_id)
      end
    else
      :not_found
    end
  end

  @spec save_sender_key(String.t(), String.t(), String.t(), GroupSession.t()) ::
          :ok | {:error, term()}
  def save_sender_key(our_jid, chat_id, sender_id, gs) do
    if available?() do
      case impl() do
        Whatsmeow.Signal.Store.Postgres ->
          Whatsmeow.Signal.GroupSession.Store.Postgres.put(our_jid, chat_id, sender_id, gs)

        module ->
          module.put_sender_key(our_jid, chat_id, sender_id, gs)
      end
    else
      {:error, :no_store}
    end
  end

  # --- Peer identity keys ----------------------------------------------------

  @doc """
  A peer's 32-byte identity public key, or `nil`.

  Steady-state decryption needs this alongside the session — a session without
  its peer identity key cannot verify the envelope, so an adapter that stores one
  and not the other is not usable on its own.
  """
  @spec load_identity(String.t(), String.t()) :: binary() | nil
  def load_identity(our_jid, their_id) do
    if available?() do
      case impl() do
        Whatsmeow.Signal.Store.Postgres -> postgres_load_identity(our_jid, their_id)
        module -> module.get_identity(our_jid, their_id)
      end
    end
  end

  @spec save_identity(String.t(), String.t(), binary()) :: :ok | {:error, term()}
  def save_identity(our_jid, their_id, identity_pub) do
    if available?() do
      case impl() do
        Whatsmeow.Signal.Store.Postgres -> postgres_save_identity(our_jid, their_id, identity_pub)
        module -> module.put_identity(our_jid, their_id, identity_pub)
      end
    else
      {:error, :no_store}
    end
  end

  # --- One-time prekeys ------------------------------------------------------

  @doc "Store freshly generated `%{key_id:, priv:, pub:}` prekeys, not yet uploaded."
  @spec save_prekeys(String.t(), [map()]) :: :ok | {:error, term()}
  def save_prekeys(our_jid, keys) do
    if available?() do
      case impl() do
        Whatsmeow.Signal.Store.Postgres -> Whatsmeow.PreKeys.persist_bulk(our_jid, keys)
        module -> module.put_prekeys(our_jid, keys)
      end
    else
      {:error, :no_store}
    end
  end

  @doc "Up to `count` prekeys we haven't uploaded yet, lowest id first."
  @spec load_unuploaded_prekeys(String.t(), pos_integer()) :: [map()]
  def load_unuploaded_prekeys(our_jid, count) do
    if available?() do
      case impl() do
        Whatsmeow.Signal.Store.Postgres -> Whatsmeow.PreKeys.unuploaded(our_jid, count)
        module -> module.unuploaded_prekeys(our_jid, count)
      end
    else
      []
    end
  end

  @doc "The highest prekey id we have stored, or 0."
  @spec max_prekey_id(String.t()) :: non_neg_integer()
  def max_prekey_id(our_jid) do
    if available?() do
      case impl() do
        Whatsmeow.Signal.Store.Postgres -> Whatsmeow.PreKeys.max_id(our_jid)
        module -> module.max_prekey_id(our_jid)
      end
    else
      0
    end
  end

  @doc """
  One prekey's private half by id, or `nil`.

  The pkmsg path needs this: a peer's first message names the one-time prekey it
  used for X3DH, and without that key's private half the derived root key is
  wrong and the envelope fails its MAC.
  """
  @spec load_prekey(String.t(), non_neg_integer()) :: binary() | nil
  def load_prekey(our_jid, key_id) do
    if available?() do
      case impl() do
        Whatsmeow.Signal.Store.Postgres -> Whatsmeow.PreKeys.get_private(our_jid, key_id)
        module -> module.get_prekey(our_jid, key_id)
      end
    end
  end

  @doc "Mark every prekey up to and including `max_key_id` as uploaded."
  @spec mark_prekeys_uploaded(String.t(), non_neg_integer()) :: {:ok, non_neg_integer()}
  def mark_prekeys_uploaded(our_jid, max_key_id) do
    if available?() do
      case impl() do
        Whatsmeow.Signal.Store.Postgres -> Whatsmeow.PreKeys.mark_uploaded(our_jid, max_key_id)
        module -> module.mark_prekeys_uploaded(our_jid, max_key_id)
      end
    else
      {:ok, 0}
    end
  end

  # --- Postgres identity helpers ---------------------------------------------

  defp postgres_load_identity(our_jid, their_id) do
    case Whatsmeow.Repo.get_by(Whatsmeow.Store.Schemas.IdentityKey,
           our_jid: our_jid,
           their_id: their_id
         ) do
      %{identity: pub} when is_binary(pub) and byte_size(pub) == 32 -> pub
      _ -> nil
    end
  rescue
    _ -> nil
  end

  defp postgres_save_identity(our_jid, their_id, identity_pub)
       when is_binary(identity_pub) and byte_size(identity_pub) == 32 do
    %Whatsmeow.Store.Schemas.IdentityKey{}
    |> Whatsmeow.Store.Schemas.IdentityKey.changeset(%{
      our_jid: our_jid,
      their_id: their_id,
      identity: identity_pub
    })
    |> Whatsmeow.Repo.insert(
      on_conflict: {:replace, [:identity]},
      conflict_target: [:our_jid, :their_id]
    )
    |> case do
      {:ok, _} -> :ok
      {:error, _} = err -> err
    end
  rescue
    e -> {:error, {:repo, Exception.message(e)}}
  end

  defp postgres_save_identity(_our_jid, _their_id, _), do: :ok
end
