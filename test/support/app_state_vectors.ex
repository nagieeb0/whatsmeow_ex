defmodule Whatsmeow.Test.AppStateVectors do
  @moduledoc """
  Loader for `test/fixtures/app_state/go_vectors.json`, produced by
  `scripts/app_state_vectors/run.sh gen` from Go whatsmeow's *real* `appstate`
  package (see that directory). Everything in the file is Go's output, not ours.
  """

  @path Path.expand("../fixtures/app_state/go_vectors.json", __DIR__)
  @external_resource @path

  def load, do: @path |> File.read!() |> Jason.decode!()

  def d(hex) when is_binary(hex), do: Base.decode16!(hex, case: :lower)
  def e(bin) when is_binary(bin), do: Base.encode16(bin, case: :lower)
end
