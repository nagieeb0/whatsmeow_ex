defmodule Whatsmeow.Signal.Store.Postgres do
  @moduledoc """
  Postgres-backed persistence for `%Whatsmeow.Signal.Session{}` structs.

  Sessions are serialized via `:erlang.term_to_binary/2` with `[:compressed]`
  into the `whatsmeow_sessions.session` column (`bytea`). One row per
  `(our_jid, their_id)` pair.

  This is the simplest portable encoding — a future migration can swap
  it for libsignal's `StorageRecord.proto` if we ever need to interop
  with a different language runtime. For now we just need the session
  to survive across `mix whatsmeow.smoke` runs so that steady-state
  `<enc type="msg">` decryption works.

  Returns `{:ok, term}` / `{:error, atom}` so callers can degrade
  gracefully if Postgres isn't reachable (e.g. unit-test contexts).
  """

  alias Whatsmeow.Repo
  alias Whatsmeow.Signal.Session
  alias Whatsmeow.Store.Schemas

  @doc """
  Persist a Signal session for `(our_jid, their_id)`. Upserts on conflict.
  """
  @spec put(String.t(), String.t(), Session.t()) :: :ok | {:error, term()}
  def put(our_jid, their_id, %Session{} = sess)
      when is_binary(our_jid) and is_binary(their_id) do
    blob = :erlang.term_to_binary(sess, [:compressed])

    %Schemas.Session{}
    |> Schemas.Session.changeset(%{
      our_jid: our_jid,
      their_id: their_id,
      session: blob
    })
    |> Repo.insert(
      on_conflict: {:replace, [:session]},
      conflict_target: [:our_jid, :their_id]
    )
    |> case do
      {:ok, _} -> :ok
      {:error, _} = err -> err
    end
  rescue
    e -> {:error, {:repo, Exception.message(e)}}
  end

  @doc """
  Load a Signal session. Returns `{:ok, %Session{}}` if one exists,
  `:not_found` otherwise. Errors propagate as `{:error, reason}`.
  """
  @spec get(String.t(), String.t()) ::
          {:ok, Session.t()} | :not_found | {:error, term()}
  def get(our_jid, their_id) when is_binary(our_jid) and is_binary(their_id) do
    case Repo.get_by(Schemas.Session, our_jid: our_jid, their_id: their_id) do
      nil ->
        :not_found

      %Schemas.Session{session: blob} when is_binary(blob) ->
        case safe_term(blob) do
          {:ok, %Session{} = sess} -> {:ok, sess}
          err -> err
        end

      _ ->
        :not_found
    end
  rescue
    e -> {:error, {:repo, Exception.message(e)}}
  end

  # Guard `:erlang.binary_to_term/2` with `[:safe]` so we can't be
  # tricked into materializing arbitrary atoms from a corrupted row.
  defp safe_term(blob) do
    {:ok, :erlang.binary_to_term(blob, [:safe])}
  rescue
    _ -> {:error, :corrupt_session_blob}
  end
end
