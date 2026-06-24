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
end
