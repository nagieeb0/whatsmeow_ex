defmodule Whatsmeow.MsgSecret.Store do
  @moduledoc """
  Persistence for per-message secrets.

  `Whatsmeow.MsgSecret` owns the crypto — deriving a use-case key from a message
  secret and encrypting/decrypting under it. This owns the other half: keeping
  the secrets around long enough to use them.

  A reaction, poll vote, or edit is encrypted against the *original* message's
  secret, which travelled with that original message and nowhere else. Drop it
  and every later interaction with that message is undecryptable — the reaction
  arrives, decrypts to nothing, and is silently discarded.

  Secrets arrive from two places:

    * the live receive path, in `messageContextInfo.messageSecret` on an inbound
      message;
    * history sync, in bulk — the only way to get secrets for messages that
      predate this device (`Whatsmeow.HistorySync`).
  """

  alias Whatsmeow.Store.Schemas.MessageSecret
  alias Whatsmeow.Types.JID

  @type jid :: JID.t() | String.t()

  # Rows per `insert_all`. Postgres has a 65535-parameter limit per statement and
  # these rows carry 5 columns, so this stays well inside it while keeping the
  # number of round-trips for a large history in the tens, not the thousands.
  @insert_chunk_size 1_000

  @doc """
  Store the secret for one message.

  `sender` is who sent the original message — `nil` for our own, which is stored
  as `our_jid`. Ignores incomplete input rather than raising: callers feed this
  straight from decoded protobufs where every field is optional.
  """
  @spec put(String.t(), jid() | nil, jid() | nil, String.t() | nil, binary() | nil) :: :ok
  def put(our_jid, chat, sender, message_id, secret)

  def put(our_jid, chat, sender, message_id, secret)
      when is_binary(our_jid) and is_binary(message_id) and message_id != "" and
             is_binary(secret) and byte_size(secret) > 0 do
    with chat_s when is_binary(chat_s) <- to_string_jid(chat),
         sender_s when is_binary(sender_s) <- to_string_jid(sender) || our_jid,
         true <- repo_up?() do
      %MessageSecret{}
      |> MessageSecret.changeset(%{
        our_jid: our_jid,
        chat_jid: chat_s,
        sender_jid: sender_s,
        message_id: message_id,
        key: secret
      })
      |> Whatsmeow.Repo.insert(
        on_conflict: {:replace, [:key]},
        conflict_target: [:our_jid, :chat_jid, :sender_jid, :message_id]
      )
      |> case do
        {:ok, _} -> :ok
        {:error, _} -> :ok
      end
    else
      _ -> :ok
    end

    :ok
  rescue
    _ -> :ok
  end

  def put(_our_jid, _chat, _sender, _message_id, _secret), do: :ok

  @doc """
  Store many secrets at once.

  History sync hands over thousands in a single chunk. One `insert_all` per
  batch, not one `insert` per secret: the difference on a first link is seconds
  against minutes.

  Chunked so a very large history doesn't build one enormous statement, and
  deduplicated first — `insert_all` raises on duplicate keys within the same
  statement, and a history blob can legitimately mention the same message twice.

  Returns the number of rows written.
  """
  @spec put_all(String.t(), [{jid(), jid() | nil, String.t(), binary()}]) :: non_neg_integer()
  def put_all(our_jid, entries) when is_binary(our_jid) and is_list(entries) do
    if repo_up?() do
      entries
      |> Enum.flat_map(&row(our_jid, &1))
      |> Enum.uniq_by(fn row -> {row.our_jid, row.chat_jid, row.sender_jid, row.message_id} end)
      |> Enum.chunk_every(@insert_chunk_size)
      |> Enum.reduce(0, fn chunk, acc ->
        {count, _} =
          Whatsmeow.Repo.insert_all(MessageSecret, chunk,
            on_conflict: {:replace, [:key]},
            conflict_target: [:our_jid, :chat_jid, :sender_jid, :message_id]
          )

        acc + count
      end)
    else
      0
    end
  rescue
    _ -> 0
  end

  defp row(our_jid, {chat, sender, id, secret})
       when is_binary(id) and id != "" and is_binary(secret) and byte_size(secret) > 0 do
    with chat_s when is_binary(chat_s) <- to_string_jid(chat),
         sender_s when is_binary(sender_s) <- to_string_jid(sender) || our_jid do
      [
        %{
          our_jid: our_jid,
          chat_jid: chat_s,
          sender_jid: sender_s,
          message_id: id,
          key: secret
        }
      ]
    else
      _ -> []
    end
  end

  defp row(_our_jid, _entry), do: []

  @doc "Load the secret for one message, or `:not_found`."
  @spec get(String.t(), jid(), jid(), String.t()) :: {:ok, binary()} | :not_found
  def get(our_jid, chat, sender, message_id)
      when is_binary(our_jid) and is_binary(message_id) do
    with chat_s when is_binary(chat_s) <- to_string_jid(chat),
         sender_s when is_binary(sender_s) <- to_string_jid(sender) || our_jid,
         true <- repo_up?(),
         %MessageSecret{key: key} when is_binary(key) <-
           Whatsmeow.Repo.get_by(MessageSecret,
             our_jid: our_jid,
             chat_jid: chat_s,
             sender_jid: sender_s,
             message_id: message_id
           ) do
      {:ok, key}
    else
      _ -> :not_found
    end
  rescue
    _ -> :not_found
  end

  defp to_string_jid(nil), do: nil
  defp to_string_jid(%JID{} = j), do: JID.to_string(j)
  defp to_string_jid(""), do: nil
  defp to_string_jid(s) when is_binary(s), do: s
  defp to_string_jid(_), do: nil

  defp repo_up? do
    Code.ensure_loaded?(Whatsmeow.Repo) and is_pid(Process.whereis(Whatsmeow.Repo))
  end
end
