defmodule Whatsmeow.Store.DETS do
  @moduledoc """
  On-disk device store — the account records, with no database.

  Implements `Whatsmeow.Store` against DETS. Paired with
  `Whatsmeow.Signal.Store.DETS` this is the whole persistence layer, so a bot can
  pair, reconnect, and decrypt with nothing but a directory:

      config :whatsmeow_ex,
        store: Whatsmeow.Store.DETS,
        signal_store: Whatsmeow.Signal.Store.DETS,
        store_dir: "./whatsmeow_data",
        start_repo?: false

  ## What lands on disk

  A device row is this account's **live identity**: the Noise key, the Signal
  identity key, and the adv credentials that prove the pairing. Anyone with the
  file can impersonate the account. Add the directory to `.gitignore` and keep it
  out of images, backups you don't control, and logs.

  Note that `Whatsmeow.Vault` encryption-at-rest applies to the Postgres columns
  via Ecto types — it does **not** apply here. These blobs are written in the
  clear, which is the trade for not needing a database.

  ## Keying

  Rows are keyed by `client_id`, not `jid`. Pairing rewrites the jid — a device
  starts as `"user-42"` and becomes `"12345@s.whatsapp.net"` — so a jid-keyed
  store ends up with two rows and the paired credentials in whichever one the
  next boot doesn't read. That is the bug that makes a linked device ask for a
  fresh QR every restart.

  ## Limits

  Single node, 2 GB per file. Devices are a handful of rows, so neither binds in
  practice — the reason to reach for Postgres is the rest of the library
  (`Whatsmeow.Signal.Lock` needs it to serialise send against receive), not this.
  """

  @behaviour Whatsmeow.Store

  require Logger

  alias Whatsmeow.Store.Schemas

  @table :whatsmeow_dets_devices

  # --- Devices ---------------------------------------------------------------

  @impl true
  def new_device(opts) do
    device = Whatsmeow.Store.build_device(opts)

    case put_device(device) do
      :ok -> {:ok, device}
      {:error, _} = err -> err
    end
  end

  @impl true
  def put_device(%Schemas.Device{} = device) do
    with {:ok, table} <- open() do
      :dets.insert(table, {device_key(device), device})
      # Sync on every write: a device record lost to an unflushed buffer is a
      # pairing lost, and the only recovery is scanning a QR again.
      :dets.sync(table)
      :ok
    end
  end

  @impl true
  def get_device(device_id) when is_binary(device_id) do
    # `device_id` is whatever `Whatsmeow.start_session/2` keyed the session by —
    # the client_id when there is one, otherwise the jid. Try the key first, then
    # fall back to a jid scan so a device paired before it had a client_id still
    # resolves.
    with {:ok, table} <- open() do
      case :dets.lookup(table, device_id) do
        [{_key, %Schemas.Device{} = device}] ->
          {:ok, device}

        _ ->
          find_by(table, fn d -> d.jid == device_id end)
      end
    end
  end

  def get_device(_), do: {:error, :not_found}

  @impl true
  def get_device_by_client_id(client_id) when is_binary(client_id) do
    with {:ok, table} <- open() do
      find_by(table, fn d -> d.client_id == client_id end)
    end
  end

  @impl true
  def list_devices do
    case open() do
      {:ok, table} -> :dets.foldl(fn {_k, d}, acc -> [d | acc] end, [], table)
      _ -> []
    end
  rescue
    _ -> []
  end

  @impl true
  def delete_device(device_id) when is_binary(device_id) do
    with {:ok, table} <- open() do
      # Delete by key, and by jid, since either may be what the caller holds.
      :dets.delete(table, device_id)

      # `:dets.foldl/3` is (fun, acc, table) — the table is the *last* argument,
      # not the first. Piping into it silently produces an ArgumentError.
      :dets.foldl(
        fn {k, d}, acc -> if d.jid == device_id, do: [k | acc], else: acc end,
        [],
        table
      )
      |> Enum.each(&:dets.delete(table, &1))

      :dets.sync(table)
      :ok
    end
  end

  # --- Signal callbacks ------------------------------------------------------
  #
  # `Whatsmeow.Store` declares these, but nothing routes through them: the Signal
  # layer has its own seam (`Whatsmeow.Signal.Store.Adapter`) because its records
  # need locking and a different lifecycle. They delegate so the behaviour is
  # satisfied and so anyone calling them by hand gets the right store rather than
  # a silent no-op.

  @impl true
  def put_identity(our_jid, their_id, identity),
    do: Whatsmeow.Signal.Store.Adapter.save_identity(our_jid, their_id, identity)

  @impl true
  def get_identity(our_jid, their_id) do
    case Whatsmeow.Signal.Store.Adapter.load_identity(our_jid, their_id) do
      nil -> {:error, :not_found}
      pub -> {:ok, pub}
    end
  end

  @impl true
  def put_session(our_jid, their_id, session),
    do: Whatsmeow.Signal.Store.Adapter.save_session(our_jid, their_id, session)

  @impl true
  def get_session(our_jid, their_id) do
    case Whatsmeow.Signal.Store.Adapter.load_session(our_jid, their_id) do
      {:ok, session} -> {:ok, session}
      _ -> {:error, :not_found}
    end
  end

  @impl true
  def put_pre_key(our_jid, key_id, key, _uploaded?),
    do: Whatsmeow.Signal.Store.Adapter.save_prekeys(our_jid, [%{key_id: key_id, priv: key}])

  @impl true
  def get_pre_key(our_jid, key_id) do
    case Whatsmeow.Signal.Store.Adapter.load_prekey(our_jid, key_id) do
      nil -> {:error, :not_found}
      priv -> {:ok, priv}
    end
  end

  @doc "Close the table. Call on shutdown, or between tests."
  @spec close() :: :ok
  def close do
    case :dets.info(@table) do
      :undefined -> :ok
      _ -> :dets.close(@table)
    end

    :ok
  end

  # --- Internals -------------------------------------------------------------

  defp device_key(%Schemas.Device{client_id: cid}) when is_binary(cid) and cid != "", do: cid
  defp device_key(%Schemas.Device{jid: jid}), do: jid

  defp find_by(table, fun) do
    :dets.foldl(
      fn {_k, d}, acc -> if acc == nil and fun.(d), do: d, else: acc end,
      nil,
      table
    )
    |> case do
      nil -> {:error, :not_found}
      %Schemas.Device{} = device -> {:ok, device}
    end
  rescue
    _ -> {:error, :not_found}
  end

  defp open do
    case :dets.info(@table) do
      :undefined -> do_open()
      _ -> {:ok, @table}
    end
  end

  defp do_open do
    dir = Application.get_env(:whatsmeow_ex, :store_dir, "./whatsmeow_data")
    File.mkdir_p!(dir)
    path = dir |> Path.join("#{@table}.dets") |> String.to_charlist()

    case :dets.open_file(@table, file: path, type: :set, auto_save: 1_000) do
      {:ok, @table} ->
        {:ok, @table}

      {:error, reason} ->
        Logger.error("[whatsmeow] failed to open device store #{path}: #{inspect(reason)}")
        {:error, {:dets, reason}}
    end
  rescue
    e -> {:error, {:dets, Exception.message(e)}}
  end
end
