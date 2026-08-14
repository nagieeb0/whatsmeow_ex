defmodule Whatsmeow.Signal.Lock do
  @moduledoc """
  Per-record serialisation for Signal crypto state.

  ## The race this closes

  A 1:1 Signal session is one opaque blob, written by whole-record overwrite.
  Two independent paths read-modify-write it:

    * **send** — `Whatsmeow.Send.encrypt_plaintext_for_peer/5`, running inside a
      `Task.async_stream` fanout worker;
    * **receive** — `Whatsmeow.Signal.Decrypt`, running in the `Session` process.

  Interleave them and one update is silently lost:

      send:  load v1 ──── encrypt ───────────── store v2
      recv:       load v1 ── decrypt ── store v3
                                                    ^ v3 gone

  Losing v3 throws away the receive chain's skipped-message keys, so the peer's
  next messages fail to decrypt and the chat sticks on "Waiting for this
  message". Losing v2 is worse: the sending chain key is reused, which means a
  repeated message key — a nonce reuse, not just a bug.

  ## The lock

  We already require Postgres, so the cheapest correct mutex is Postgres':
  a transaction-scoped advisory lock keyed by `(our_jid, their_id)`. It is
  released automatically when the transaction ends — including on a crash, which
  is the property a hand-rolled GenServer lock has to work for.

  Being in the database rather than the BEAM also means it holds across nodes:
  two app instances sharing a database serialise against each other for free.

  ## Rules

    * **Take one lock at a time.** No nesting, so no lock-ordering deadlock is
      possible. Callers must never take a session lock while holding another.
    * **Do no I/O inside.** The critical section is a DB read, some crypto, and a
      DB write — microseconds. Anything that waits on the network (a prekey-bundle
      IQ, a socket write) belongs *outside*; it would pin a pool connection for the
      duration of a round-trip and starve the fanout.
    * **Degrade to a plain call when there's no Repo.** Unit-test contexts with no
      database still run the function body, unserialised — there is no concurrent
      writer there to race with.
  """

  require Logger

  # Advisory-lock namespace ("WA"), so our locks can never collide with an
  # advisory lock the host application takes for its own reasons.
  @classid 0x5741

  @doc """
  Run `fun` holding the exclusive lock for one 1:1 Signal session record.

  Returns whatever `fun` returns. See the module doc for what may and may not go
  inside the critical section.
  """
  @spec with_session(String.t(), String.t(), (-> result)) :: result when result: term()
  def with_session(our_jid, their_id, fun)
      when is_binary(our_jid) and is_binary(their_id) and is_function(fun, 0) do
    with_key({:session, our_jid, their_id}, fun)
  end

  @doc """
  Run `fun` holding the exclusive lock for one group sender-key record.

  Group sender keys have a single writer today, but routing them through the same
  gate keeps one uniform rule — no path mutates a crypto record outside its lock —
  and pre-empts a second writer appearing later.
  """
  @spec with_sender_key(String.t(), String.t(), String.t(), (-> result)) :: result
        when result: term()
  def with_sender_key(our_jid, chat_id, sender_id, fun)
      when is_binary(our_jid) and is_binary(chat_id) and is_binary(sender_id) and
             is_function(fun, 0) do
    with_key({:sender_key, our_jid, chat_id, sender_id}, fun)
  end

  defp with_key(key, fun) do
    if repo_up?() do
      objid = :erlang.phash2(key, 0x7FFFFFFF)

      result =
        Whatsmeow.Repo.transaction(
          fn ->
            # Transaction-scoped: released on COMMIT, ROLLBACK, or a dropped
            # connection. Nothing to unwind by hand.
            Ecto.Adapters.SQL.query!(
              Whatsmeow.Repo,
              "SELECT pg_advisory_xact_lock($1, $2)",
              [@classid, objid]
            )

            fun.()
          end,
          timeout: Whatsmeow.Config.lock_timeout_ms()
        )

      case result do
        {:ok, value} ->
          value

        {:error, reason} ->
          # A rolled-back transaction means the body never committed. Surface it
          # rather than pretending the mutation landed.
          Logger.warning("[whatsmeow] signal lock transaction failed: #{inspect(reason)}")
          {:error, {:lock, reason}}
      end
    else
      fun.()
    end
  end

  defp repo_up? do
    Code.ensure_loaded?(Whatsmeow.Repo) and is_pid(Process.whereis(Whatsmeow.Repo))
  end
end
