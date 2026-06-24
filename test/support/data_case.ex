defmodule Whatsmeow.DataCase do
  @moduledoc """
  ExUnit case template for tests that touch the database.

  Each test runs inside a Postgres SQL sandbox transaction that is rolled back
  at teardown, so tests are isolated and `async: true` is safe.
  """

  use ExUnit.CaseTemplate

  using do
    quote do
      alias Whatsmeow.Repo

      import Ecto
      import Ecto.Changeset
      import Ecto.Query
      import Whatsmeow.DataCase
    end
  end

  setup tags do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Whatsmeow.Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    :ok
  end

  @doc """
  Convert changeset errors into a flat map for assertion ergonomics.
  """
  def errors_on(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {message, opts} ->
      Regex.replace(~r"%{(\w+)}", message, fn _, key ->
        opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
      end)
    end)
  end
end
