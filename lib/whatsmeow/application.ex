defmodule Whatsmeow.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = children(Application.get_env(:whatsmeow_ex, :start_repo?, true))

    opts = [strategy: :rest_for_one, name: Whatsmeow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp children(true) do
    [
      Whatsmeow.Repo,
      Whatsmeow.Telemetry,
      {Phoenix.PubSub, name: Whatsmeow.PubSub},
      {Registry,
       keys: :unique, name: Whatsmeow.Sessions.Registry, partitions: System.schedulers_online()},
      {DynamicSupervisor, name: Whatsmeow.Sessions.Supervisor, strategy: :one_for_one},
      {Task.Supervisor, name: Whatsmeow.Media.TaskSup},
      {Task.Supervisor, name: Whatsmeow.Sessions.TaskSup},
      Whatsmeow.Retry.RecentCache,
      Whatsmeow.Media.HKDFCache,
      Whatsmeow.WAVersion.Refresher
    ]
  end

  defp children(false) do
    [
      Whatsmeow.Telemetry,
      {Phoenix.PubSub, name: Whatsmeow.PubSub},
      {Registry,
       keys: :unique, name: Whatsmeow.Sessions.Registry, partitions: System.schedulers_online()},
      {DynamicSupervisor, name: Whatsmeow.Sessions.Supervisor, strategy: :one_for_one},
      {Task.Supervisor, name: Whatsmeow.Media.TaskSup},
      {Task.Supervisor, name: Whatsmeow.Sessions.TaskSup},
      Whatsmeow.Retry.RecentCache,
      Whatsmeow.Media.HKDFCache,
      Whatsmeow.WAVersion.Refresher
    ]
  end
end
