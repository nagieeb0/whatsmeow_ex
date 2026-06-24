defmodule Mix.Tasks.WhatsmeowEx.Gen.Migrations do
  @shortdoc "Copy whatsmeow_ex migrations into the host app's priv/repo/migrations/"

  @moduledoc """
  Copies the bundled `whatsmeow_ex` migrations into the host application's
  `priv/repo/migrations/` so the host's `Repo` owns the WhatsApp tables
  (devices, identity keys, sessions, sender keys, app state, contacts, …).

      mix whatsmeow_ex.gen.migrations

  Use this when you don't want a separate `Whatsmeow.Repo` and would rather
  keep everything in one database under e.g. `MyApp.Repo`. After running
  this, set `start_repo?: false` in `config/whatsmeow.exs` so
  `Whatsmeow.Application` skips starting its own repo.

  Each migration is:

    * renamed with a fresh `YYYYMMDDHHMMSS` timestamp so it sorts after the
      host's existing migrations,
    * rewritten so the module is namespaced under the host app
      (`MyApp.Repo.Migrations.*` instead of `Whatsmeow.Repo.Migrations.*`).

  Idempotent — already-copied migrations (matched by the original name
  suffix) are skipped.

  Options:

    * `--repo MyApp.Repo` — override the target Repo module. By default the
      host app name is camel-cased and `.Repo` is appended.
    * `--dest priv/custom/migrations` — write to a different directory.
  """

  use Mix.Task

  @switches [repo: :string, dest: :string]

  defp source_dir do
    :whatsmeow_ex
    |> :code.priv_dir()
    |> Path.join("repo/migrations")
  end

  @impl Mix.Task
  def run(argv) do
    {opts, _, _} = OptionParser.parse(argv, switches: @switches)

    host_app = Mix.Project.config()[:app]

    if host_app == :whatsmeow_ex do
      Mix.raise(
        "mix whatsmeow_ex.gen.migrations must be run from a host application that depends on :whatsmeow_ex, not from inside whatsmeow_ex itself."
      )
    end

    repo_module = opts[:repo] || default_repo_module(host_app)
    dest_dir = opts[:dest] || Path.join(["priv", "repo", "migrations"])

    File.mkdir_p!(dest_dir)

    src_dir = source_dir()

    sources =
      src_dir
      |> File.ls!()
      |> Enum.filter(&String.ends_with?(&1, ".exs"))
      |> Enum.sort()

    if sources == [] do
      Mix.raise("No migrations found at #{src_dir}")
    end

    sources
    |> Enum.with_index()
    |> Enum.each(fn {filename, idx} ->
      copy_one(filename, idx, src_dir, dest_dir, repo_module)
    end)

    Mix.shell().info([
      :green,
      """

      Migrations copied to #{dest_dir}.

      Next steps:

        1. Edit config/whatsmeow.exs and set `start_repo?: false`.
        2. mix ecto.migrate         # uses your host Repo, not Whatsmeow.Repo
      """,
      :reset
    ])
  end

  defp copy_one(filename, idx, src_dir, dest_dir, repo_module) do
    # Strip the original "20260101000001_" prefix to get the bare name.
    bare = Regex.replace(~r/^\d+_/, filename, "")

    case Path.wildcard(Path.join(dest_dir, "*_#{bare}")) do
      [existing | _] ->
        Mix.shell().info([
          :cyan,
          "* skipped ",
          :reset,
          "#{Path.basename(existing)} (already present)"
        ])

      [] ->
        timestamp = fresh_timestamp(idx)
        target = Path.join(dest_dir, "#{timestamp}_#{bare}")

        contents =
          src_dir
          |> Path.join(filename)
          |> File.read!()
          |> String.replace("Whatsmeow.Repo.Migrations.", "#{repo_module}.Migrations.")

        File.write!(target, contents)
        Mix.shell().info([:green, "* created ", :reset, target])
    end
  end

  defp default_repo_module(host_app) do
    host_app
    |> Atom.to_string()
    |> Macro.camelize()
    |> Kernel.<>(".Repo")
  end

  # YYYYMMDDHHMMSS + offset so multiple migrations in one run don't collide.
  defp fresh_timestamp(idx) do
    DateTime.utc_now()
    |> DateTime.add(idx, :second)
    |> Calendar.strftime("%Y%m%d%H%M%S")
  end
end
