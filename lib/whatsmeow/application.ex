defmodule Whatsmeow.Application do
  @moduledoc false
  use Application

  @impl true
  def start(_type, _args) do
    children = children(Application.get_env(:whatsmeow_ex, :start_repo?, true))

    # **`:one_for_one`, and headroom.**
    #
    # This was `:rest_for_one` with `Whatsmeow.Repo` as child number one, which
    # means a Repo supervisor exit restarted the Registry, the session
    # DynamicSupervisor and every live session with it. Sessions die with
    # `:shutdown` in that sweep, and `restart: :transient` does not bring them
    # back — so a database hiccup silently ended every WhatsApp connection on
    # the node and only a host application's own watchdog would notice.
    #
    # Nothing in the list actually depends on a *restarted* Repo the way
    # `:rest_for_one` assumes: the sessions hold no Repo state between calls,
    # they check out a connection per query like everything else.
    #
    # And the default intensity is three restarts in five seconds. Exceeding it
    # terminates `:whatsmeow_ex`, which as a permanent application in a release
    # halts the whole VM — so a brief database outage took the container down
    # rather than degrading one clinic.
    opts = [
      strategy: :one_for_one,
      name: Whatsmeow.Supervisor,
      max_restarts: 30,
      max_seconds: 60
    ]

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
      Whatsmeow.User.DeviceCache,
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
      Whatsmeow.User.DeviceCache,
      Whatsmeow.WAVersion.Refresher
    ]
  end
end
