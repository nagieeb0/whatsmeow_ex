defmodule Whatsmeow.Retry do
  @moduledoc """
  Outbound-message retry queue.

  State lives inside `Whatsmeow.Session` (no separate process — keeps the
  one-process-per-session invariant). This module is a stateless helper
  that schedules `Process.send_after/3` timers and computes backoff.

  Ports `whatsmeow-main/retry.go`. Idempotent: a retry doesn't re-encrypt,
  it re-derives from the durable plaintext stored in `whatsmeow_retry_buffer`.
  """

  @initial_delay_ms 1_000
  @max_delay_ms 30_000

  @doc "Compute exponential backoff delay in ms for `attempt` (0-indexed)."
  @spec backoff_ms(non_neg_integer()) :: non_neg_integer()
  def backoff_ms(attempt) when attempt >= 0 do
    min(@max_delay_ms, @initial_delay_ms * Bitwise.bsl(1, attempt))
  end

  @doc "Schedule a retry for `message_id` after the appropriate backoff."
  @spec schedule(pid(), String.t(), non_neg_integer()) :: reference()
  def schedule(session_pid, message_id, attempt)
      when is_pid(session_pid) and is_binary(message_id) do
    Process.send_after(session_pid, {:retry, message_id, attempt + 1}, backoff_ms(attempt))
  end
end
