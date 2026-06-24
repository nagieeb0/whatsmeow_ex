import Config

config :whatsmeow_ex,
  ecto_repos: [Whatsmeow.Repo]

config :whatsmeow_ex, Whatsmeow.Repo,
  migration_primary_key: [name: :id, type: :binary_id],
  migration_foreign_key: [type: :binary_id],
  migration_timestamps: [type: :utc_datetime_usec]

config :logger,
  level: :info,
  truncate: 4096

import_config "#{config_env()}.exs"
