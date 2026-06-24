defmodule Whatsmeow.NotImplementedError do
  @moduledoc """
  Raised by Phase-0 placeholder functions when called before their owning
  phase has landed. Carries the target phase number and the missing feature
  so callers know when to expect support.
  """

  defexception [:phase, :feature, :message]

  @impl true
  def exception(opts) do
    phase = Keyword.fetch!(opts, :phase)
    feature = Keyword.fetch!(opts, :feature)

    %__MODULE__{
      phase: phase,
      feature: feature,
      message: "#{feature} is not implemented yet (scheduled for Phase #{phase}). See plan.md."
    }
  end
end
