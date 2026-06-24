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
  Per-fanout-task timeout in ms (used as `:timeout` on `Task.async_stream`
  for the send fanout). Defaults to 60 s — comfortably above the 30 s
  default `:bundle_timeout` so a single slow prekey-bundle IQ doesn't
  kill the whole fanout.
  """
  @spec fanout_task_timeout_ms() :: pos_integer()
  def fanout_task_timeout_ms,
    do: Application.get_env(:whatsmeow_ex, :fanout_task_timeout_ms, 60_000)
end
