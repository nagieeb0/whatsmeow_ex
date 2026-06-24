import Config

# The Ecto repo is not started by the application in tests by default. Tests
# that need the database opt in via `use Whatsmeow.DataCase` and the Phase 6
# migrations are present. This keeps the bootstrap test run silent.
config :whatsmeow_ex, start_repo?: false

config :whatsmeow_ex, Whatsmeow.Repo,
  username: System.get_env("POSTGRES_USER", "postgres"),
  password: System.get_env("POSTGRES_PASSWORD", "postgres"),
  hostname: System.get_env("POSTGRES_HOST", "localhost"),
  database: "whatsmeow_ex_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

config :logger, level: :warning
