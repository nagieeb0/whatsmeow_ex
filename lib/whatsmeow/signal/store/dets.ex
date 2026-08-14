defmodule Whatsmeow.Signal.Store.DETS do
  @moduledoc """
  On-disk Signal crypto storage with no database.

  A drop-in alternative to `Whatsmeow.Signal.Store.Postgres` covering everything
  the Signal layer needs to pair and to decrypt:

    * 1:1 sessions and group sender keys — opaque `term_to_binary` blobs keyed by
      a tuple, which is exactly what DETS is for;
    * peer identity keys, without which a steady-state envelope cannot be
      verified;
    * one-time prekeys, without which a first-contact `pkmsg` derives the wrong
      root key and fails its MAC.

  All four matter. An adapter with only the first is not usable on its own.

  ## When to use it

  Running a single bot on one machine, or a dev setup where standing up Postgres
  is more work than the problem is worth. Select it with:

      config :whatsmeow_ex, signal_store: Whatsmeow.Signal.Store.DETS
      config :whatsmeow_ex, signal_store_dir: "./whatsmeow_data"

  That directory holds live account key material. Treat it like a secret: keep it
  out of version control, images, and logs.

  ## When not to

  DETS is single-node and has a 2 GB file limit. More importantly,
  `Whatsmeow.Signal.Lock` degrades to a plain function call without a Repo — so
  with this adapter and no database, the send and receive paths are **not**
  serialised against each other. Within one BEAM node the fanout and the session
  process can still interleave on the same record. One quiet bot is fine; a busy
  one, or a cluster, is not. Use Postgres there.

  The rest of the library's state — the device record, app-state, contacts, chat
  settings — still requires the Repo. This adapter covers the Signal layer only.
  """

  require Logger

  alias Whatsmeow.Signal.{GroupSession, Session}

  @sessions :whatsmeow_dets_sessions
  @sender_keys :whatsmeow_dets_sender_keys
  @identities :whatsmeow_dets_identities
  @prekeys :whatsmeow_dets_prekeys

  # --- 1:1 sessions ----------------------------------------------------------

  @doc "Persist a Signal session for `(our_jid, their_id)`."
  @spec put(String.t(), String.t(), Session.t()) :: :ok | {:error, term()}
  def put(our_jid, their_id, %Session{} = session)
      when is_binary(our_jid) and is_binary(their_id) do
    with {:ok, table} <- open(@sessions) do
      :dets.insert(table, {{our_jid, their_id}, session})
      # Sync on every write. A Signal session lost to an unflushed buffer after a
      # crash is not a stale cache entry — it is a broken conversation that only
      # a re-pair fixes.
      :dets.sync(table)
      :ok
    end
  end

  @doc "Load a Signal session, or `:not_found`."
  @spec get(String.t(), String.t()) :: {:ok, Session.t()} | :not_found | {:error, term()}
  def get(our_jid, their_id) when is_binary(our_jid) and is_binary(their_id) do
    with {:ok, table} <- open(@sessions) do
      case :dets.lookup(table, {our_jid, their_id}) do
        [{_key, %Session{} = session}] -> {:ok, session}
        _ -> :not_found
      end
    end
  end

  # --- Group sender keys -----------------------------------------------------

  @doc "Persist a group sender-key record."
  @spec put_sender_key(String.t(), String.t(), String.t(), GroupSession.t()) ::
          :ok | {:error, term()}
  def put_sender_key(our_jid, chat_id, sender_id, %GroupSession{} = gs) do
    with {:ok, table} <- open(@sender_keys) do
      :dets.insert(table, {{our_jid, chat_id, sender_id}, gs})
      :dets.sync(table)
      :ok
    end
  end

  @doc "Load a group sender-key record, or `:not_found`."
  @spec get_sender_key(String.t(), String.t(), String.t()) ::
          {:ok, GroupSession.t()} | :not_found | {:error, term()}
  def get_sender_key(our_jid, chat_id, sender_id) do
    with {:ok, table} <- open(@sender_keys) do
      case :dets.lookup(table, {our_jid, chat_id, sender_id}) do
        [{_key, %GroupSession{} = gs}] -> {:ok, gs}
        _ -> :not_found
      end
    end
  end

  # --- Peer identity keys ----------------------------------------------------

  @doc "Persist a peer's 32-byte identity public key."
  @spec put_identity(String.t(), String.t(), binary()) :: :ok | {:error, term()}
  def put_identity(our_jid, their_id, identity_pub)
      when is_binary(identity_pub) and byte_size(identity_pub) == 32 do
    with {:ok, table} <- open(@identities) do
      :dets.insert(table, {{our_jid, their_id}, identity_pub})
      :dets.sync(table)
      :ok
    end
  end

  def put_identity(_our_jid, _their_id, _), do: :ok

  @doc "Load a peer's identity public key, or `nil`."
  @spec get_identity(String.t(), String.t()) :: binary() | nil
  def get_identity(our_jid, their_id) do
    case open(@identities) do
      {:ok, table} ->
        case :dets.lookup(table, {our_jid, their_id}) do
          [{_key, pub}] when is_binary(pub) -> pub
          _ -> nil
        end

      _ ->
        nil
    end
  end

  # --- One-time prekeys ------------------------------------------------------
  #
  # Stored one row per key, `{{our_jid, key_id}, priv, uploaded?}`. The Postgres
  # side does this with ordered queries and a bulk UPDATE; here the pool is ~800
  # keys per account, so scanning and sorting in Elixir is cheaper than any index
  # DETS could offer.

  @doc "Store many `%{key_id:, priv:}` prekeys as not-yet-uploaded."
  @spec put_prekeys(String.t(), [map()]) :: :ok | {:error, term()}
  def put_prekeys(our_jid, keys) when is_list(keys) do
    with {:ok, table} <- open(@prekeys) do
      Enum.each(keys, fn %{key_id: id, priv: priv} ->
        :dets.insert(table, {{our_jid, id}, priv, false})
      end)

      :dets.sync(table)
      :ok
    end
  end

  @doc "Up to `count` prekeys not yet uploaded, lowest id first."
  @spec unuploaded_prekeys(String.t(), pos_integer()) :: [map()]
  def unuploaded_prekeys(our_jid, count) do
    case open(@prekeys) do
      {:ok, table} ->
        table
        |> :dets.match_object({{our_jid, :_}, :_, false})
        |> Enum.map(fn {{_jid, id}, priv, _} -> %{key_id: id, priv: priv} end)
        |> Enum.sort_by(& &1.key_id)
        |> Enum.take(count)

      _ ->
        []
    end
  rescue
    _ -> []
  end

  @doc "The highest prekey id stored for `our_jid`, or 0 when there are none."
  @spec max_prekey_id(String.t()) :: non_neg_integer()
  def max_prekey_id(our_jid) do
    case open(@prekeys) do
      {:ok, table} ->
        table
        |> :dets.match({{our_jid, :"$1"}, :_, :_})
        |> Enum.map(fn [id] -> id end)
        |> Enum.max(fn -> 0 end)

      _ ->
        0
    end
  rescue
    _ -> 0
  end

  @doc "Load one prekey's private half by id, or `nil` if it was never stored."
  @spec get_prekey(String.t(), non_neg_integer()) :: binary() | nil
  def get_prekey(our_jid, key_id) do
    case open(@prekeys) do
      {:ok, table} ->
        case :dets.lookup(table, {our_jid, key_id}) do
          [{_key, priv, _uploaded}] when is_binary(priv) -> priv
          _ -> nil
        end

      _ ->
        nil
    end
  rescue
    _ -> nil
  end

  @doc "Mark every prekey up to and including `max_key_id` as uploaded."
  @spec mark_prekeys_uploaded(String.t(), non_neg_integer()) :: {:ok, non_neg_integer()}
  def mark_prekeys_uploaded(our_jid, max_key_id) do
    case open(@prekeys) do
      {:ok, table} ->
        marked =
          table
          |> :dets.match_object({{our_jid, :_}, :_, false})
          |> Enum.filter(fn {{_jid, id}, _priv, _} -> id <= max_key_id end)
          |> Enum.map(fn {key, priv, _} -> :dets.insert(table, {key, priv, true}) end)
          |> length()

        :dets.sync(table)
        {:ok, marked}

      _ ->
        {:ok, 0}
    end
  rescue
    _ -> {:ok, 0}
  end

  @doc "Close every open table. Call on shutdown, or between tests."
  @spec close() :: :ok
  def close do
    Enum.each([@sessions, @sender_keys, @identities, @prekeys], fn table ->
      case :dets.info(table) do
        :undefined -> :ok
        _ -> :dets.close(table)
      end
    end)
  end

  # --- Internals -------------------------------------------------------------

  defp open(table) do
    case :dets.info(table) do
      :undefined -> do_open(table)
      _ -> {:ok, table}
    end
  end

  defp do_open(table) do
    dir = Application.get_env(:whatsmeow_ex, :signal_store_dir, "./whatsmeow_data")
    File.mkdir_p!(dir)
    path = Path.join(dir, "#{table}.dets") |> String.to_charlist()

    case :dets.open_file(table, file: path, type: :set, auto_save: 1_000) do
      {:ok, ^table} ->
        {:ok, table}

      {:error, reason} ->
        Logger.error("[whatsmeow] failed to open DETS table #{table}: #{inspect(reason)}")
        {:error, {:dets, reason}}
    end
  rescue
    e -> {:error, {:dets, Exception.message(e)}}
  end
end
