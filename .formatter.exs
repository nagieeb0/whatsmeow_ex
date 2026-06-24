[
  # Re-enable import_deps after `mix deps.get` succeeds.
  # import_deps: [:ecto, :ecto_sql, :phoenix_pubsub],
  inputs: [
    "{mix,.formatter,.credo,.dialyzer_ignore}.exs",
    "{config,lib,test}/**/*.{ex,exs}",
    "priv/repo/migrations/*.exs"
  ],
  line_length: 100
]
