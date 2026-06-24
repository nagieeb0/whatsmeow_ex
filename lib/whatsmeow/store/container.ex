defmodule Whatsmeow.Store.Container do
  @moduledoc """
  Loads existing devices on boot and offers a thin facade for spawning new
  ones. A thin `Agent` wrapping `Whatsmeow.Store.list_devices/0`.

  Ports `whatsmeow-main/store/sqlstore/container.go`.
  """

  use Agent

  def start_link(_args) do
    Agent.start_link(fn -> nil end, name: __MODULE__)
  end

  @doc "Load devices from the store. Pass-through to `Whatsmeow.Store.list_devices/0`."
  def list_devices do
    if function_exported?(Whatsmeow.Repo, :__adapter__, 0) and Process.whereis(Whatsmeow.Repo) do
      Whatsmeow.Store.list_devices()
    else
      []
    end
  end
end
