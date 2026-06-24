defmodule Whatsmeow.Telemetry do
  @moduledoc """
  Telemetry event surface for the library.

  Phases emit `[:whatsmeow, area, event]` spans. Hosts can attach handlers
  to integrate with their own metrics pipeline (Prometheus, AppSignal,
  Datadog…). See the module's `events/0` for the full list.

  This module is a thin Supervisor placeholder; we add handlers as later
  phases land.
  """

  use Supervisor

  @doc false
  def start_link(args), do: Supervisor.start_link(__MODULE__, args, name: __MODULE__)

  @impl true
  def init(_) do
    Supervisor.init([], strategy: :one_for_one)
  end

  @doc """
  Documented telemetry events that the library emits.

  Each entry is `{event_name, measurements, metadata}` describing the shape
  consumers can rely on.
  """
  @spec events() :: [{[atom()], map(), map()}]
  def events do
    [
      {[:whatsmeow, :handshake, :start], %{system_time: 0}, %{device_id: ""}},
      {[:whatsmeow, :handshake, :stop], %{duration: 0}, %{device_id: "", result: :ok}},
      {[:whatsmeow, :send, :start], %{system_time: 0}, %{device_id: "", to: ""}},
      {[:whatsmeow, :send, :stop], %{duration: 0}, %{device_id: "", result: :ok}},
      {[:whatsmeow, :recv], %{bytes: 0}, %{device_id: "", kind: :message}},
      {[:whatsmeow, :retry], %{attempt: 0}, %{device_id: "", message_id: ""}}
    ]
  end
end
