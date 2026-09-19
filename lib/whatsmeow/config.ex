defmodule Whatsmeow.Config do
  @moduledoc """
  Runtime configuration helpers. Centralises reads of `Application.get_env/3`
  so callers don't sprinkle config lookups through the codebase.
  """

  @spec repo() :: module()
  def repo, do: Application.get_env(:whatsmeow_ex, :repo, Whatsmeow.Repo)

  @spec pubsub() :: atom()
  def pubsub, do: Application.get_env(:whatsmeow_ex, :pubsub, Whatsmeow.PubSub)

  @spec transport() :: module()
  def transport,
    do: Application.get_env(:whatsmeow_ex, :transport, Whatsmeow.Transport.WebSocket.Mint)

  @spec endpoint() :: String.t()
  def endpoint,
    do: Application.get_env(:whatsmeow_ex, :endpoint, "wss://web.whatsapp.com/ws/chat")

  @doc """
  Max parallel encryption tasks per fanout (DM multi-device, group SKDM
  distribution, peer-message fanout, prekey generation, app-state patch
  decode). Default `8` — scheduler-friendly on small VMs. Override with:

      config :whatsmeow_ex, :send_concurrency, 16
  """
  @spec send_concurrency() :: pos_integer()
  def send_concurrency,
    do: Application.get_env(:whatsmeow_ex, :send_concurrency, 8)

  @doc """
  How long a `Whatsmeow.Signal.Lock` critical section may hold its database
  transaction, in ms. Defaults to 15 s.

  The work inside is a local read, some crypto, and a local write — under a
  millisecond. This bound is not for the work; it is so that a lock nobody can
  acquire surfaces as an error instead of a hung send.

  ## Keep this under your pool size

  Every held lock holds one Ecto connection. Raising `:send_concurrency` above
  `pool_size - 1` means a fanout can take every connection while the session
  process is still waiting for one to release a lock — the classic pool
  deadlock. With the defaults (concurrency 8, pool 10) there is headroom; if you
  raise one, raise the other.
  """
  @spec lock_timeout_ms() :: pos_integer()
  def lock_timeout_ms,
    do: Application.get_env(:whatsmeow_ex, :lock_timeout_ms, 15_000)

  @doc """
  Per-fanout-task timeout in ms (used as `:timeout` on `Task.async_stream`
  for the send fanout). Defaults to 15 s — comfortably above the 5 s default
  `:bundle_timeout` so a single slow prekey-bundle IQ does not kill the whole
  fanout.

  ## Why these numbers came down

  They were 60 s over 30 s, which is a batch-job budget on an interactive path.
  The fanout is drained in full before the stanza goes out, so every one of
  these seconds is a second the patient spends looking at a clinic that has not
  answered. A device that has not produced a prekey bundle in five seconds is
  not going to save this message; the reply going out to the devices that did
  answer is worth more than waiting for the one that did not.
  """
  @spec fanout_task_timeout_ms() :: pos_integer()
  def fanout_task_timeout_ms,
    do: Application.get_env(:whatsmeow_ex, :fanout_task_timeout_ms, 15_000)
end
