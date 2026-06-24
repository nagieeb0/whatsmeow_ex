ExUnit.start(exclude: [:integration, :external])

# Ecto sandbox is set up at the per-test level via Whatsmeow.DataCase.
if Code.ensure_loaded?(Whatsmeow.Repo) and Process.whereis(Whatsmeow.Repo) do
  Ecto.Adapters.SQL.Sandbox.mode(Whatsmeow.Repo, :manual)
end
