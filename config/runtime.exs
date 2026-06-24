import Config

if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_URL") ||
      raise """
      DATABASE_URL is required in production, e.g.
        ecto://USER:PASS@HOST/DATABASE
      """

  config :whatsmeow_ex, Whatsmeow.Repo,
    url: database_url,
    pool_size: String.to_integer(System.get_env("POOL_SIZE", "10")),
    ssl: System.get_env("DATABASE_SSL", "false") == "true"
end
