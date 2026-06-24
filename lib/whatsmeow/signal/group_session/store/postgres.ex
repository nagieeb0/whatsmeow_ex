defmodule Whatsmeow.Signal.GroupSession.Store.Postgres do
  @moduledoc """
  Postgres-backed persistence for `%Whatsmeow.Signal.GroupSession{}`.

  Sessions are serialized via `:erlang.term_to_binary/2` with `[:compressed]`
  into the `whatsmeow_sender_keys.sender_key` column. One row per
  `(our_jid, chat_id, sender_id)` triple.

  Mirrors `Whatsmeow.Signal.Store.Postgres` for the 1:1 case. `binary_to_term/2`
  is called with `[:safe]` to defend against atom-exhaustion on a corrupt
  row.
  """

  alias Whatsmeow.Repo
  alias Whatsmeow.Signal.GroupSession
  alias Whatsmeow.Store.Schemas

  @doc """
  Persist a group session for `(our_jid, chat_id, sender_id)`. Upserts on
  conflict.
  """
  @spec put(String.t(), String.t(), String.t(), GroupSession.t()) ::
          :ok | {:error, term()}
  def put(our_jid, chat_id, sender_id, %GroupSession{} = gs)
      when is_binary(our_jid) and is_binary(chat_id) and is_binary(sender_id) do
    blob = :erlang.term_to_binary(gs, [:compressed])

    %Schemas.SenderKey{}
    |> Schemas.SenderKey.changeset(%{
      our_jid: our_jid,
      chat_id: chat_id,
      sender_id: sender_id,
      sender_key: blob
    })
    |> Repo.insert(
      on_conflict: {:replace, [:sender_key]},
      conflict_target: [:our_jid, :chat_id, :sender_id]
    )
    |> case do
      {:ok, _} -> :ok
      {:error, _} = err -> err
    end
  rescue
    e -> {:error, {:repo, Exception.message(e)}}
  end

  @doc """
  Load a group session by `(our_jid, chat_id, sender_id)`. Returns
  `{:ok, %GroupSession{}}` on hit, `:not_found` on miss, or
  `{:error, reason}` on Postgres / decode error.
  """
  @spec get(String.t(), String.t(), String.t()) ::
          {:ok, GroupSession.t()} | :not_found | {:error, term()}
  def get(our_jid, chat_id, sender_id)
      when is_binary(our_jid) and is_binary(chat_id) and is_binary(sender_id) do
    case Repo.get_by(Schemas.SenderKey,
           our_jid: our_jid,
           chat_id: chat_id,
           sender_id: sender_id
         ) do
      nil ->
        :not_found

      %Schemas.SenderKey{sender_key: blob} when is_binary(blob) ->
        case safe_term(blob) do
          {:ok, %GroupSession{} = gs} -> {:ok, gs}
          err -> err
        end

      _ ->
        :not_found
    end
  rescue
    e -> {:error, {:repo, Exception.message(e)}}
  end

  defp safe_term(blob) do
    {:ok, :erlang.binary_to_term(blob, [:safe])}
  rescue
    _ -> {:error, :corrupt_sender_key_blob}
  end
end
