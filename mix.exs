defmodule WhatsmeowEx.MixProject do
  use Mix.Project

  @version "0.1.0"
  @source_url "https://github.com/nagieeb/whatsmeow_ex"

  def project do
    [
      app: :whatsmeow_ex,
      version: @version,
      elixir: "~> 1.19",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases(),
      dialyzer: dialyzer(),
      test_coverage: [tool: ExCoveralls],
      package: package(),
      description: description(),
      docs: docs(),
      name: "Whatsmeow",
      source_url: @source_url
    ]
  end

  def application do
    [
      extra_applications: [:logger, :crypto, :public_key, :ssl, :inets],
      mod: {Whatsmeow.Application, []}
    ]
  end

  def cli do
    [
      preferred_envs: [
        "test.all": :test,
        "test.unit": :test,
        "test.integration": :test,
        check: :test
      ]
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp deps do
    [
      # --- Transport ---
      {:mint, "~> 1.7"},
      {:mint_web_socket, "~> 1.0"},
      {:castore, "~> 1.0"},
      {:finch, "~> 0.20"},

      # --- Protocol + state machines ---
      {:protobuf, "~> 0.13"},
      {:gen_state_machine, "~> 3.0"},

      # --- Persistence ---
      {:ecto_sql, "~> 3.12"},
      {:postgrex, "~> 0.20"},

      # --- Eventing ---
      {:phoenix_pubsub, "~> 2.1"},
      {:telemetry, "~> 1.3"},

      # --- Options validation ---
      {:nimble_options, "~> 1.1"},

      # --- JSON ---
      {:jason, "~> 1.4"},

      # --- QR rendering (pure Elixir, by github.com/dannote/qqr) ---
      {:qqr, "~> 0.2"},

      # --- Dev / test ---
      {:stream_data, "~> 1.2", only: [:dev, :test]},
      {:mox, "~> 1.2", only: :test},
      {:bypass, "~> 2.1", only: :test},
      {:excoveralls, "~> 0.18", only: :test},
      {:benchee, "~> 1.4", only: :dev},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.40", only: :dev, runtime: false}
    ]
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      "test.all": ["test --include integration"],
      "test.unit": ["test --exclude integration"],
      "test.integration": ["test --only integration"],
      check: ["format --check-formatted", "credo --strict", "dialyzer", "test"]
    ]
  end

  defp dialyzer do
    [
      plt_add_apps: [:ex_unit, :mix],
      plt_file: {:no_warn, "priv/plts/dialyzer.plt"},
      flags: [:error_handling, :missing_return, :extra_return, :underspecs]
    ]
  end

  defp description do
    "Pure-Elixir port of the whatsmeow Go library — WhatsApp Web multi-device client."
  end

  defp package do
    [
      maintainers: ["nagieeb"],
      licenses: ["MPL-2.0"],
      links: %{"GitHub" => @source_url, "Upstream (Go)" => "https://github.com/tulir/whatsmeow"},
      files: ~w(lib priv .formatter.exs mix.exs README.md LICENSE plan.md examples)
    ]
  end

  defp docs do
    [
      main: "Whatsmeow",
      source_ref: "v#{@version}",
      source_url: @source_url,
      extras: ["README.md", "plan.md"],
      groups_for_modules: [
        "Public API": [Whatsmeow, Whatsmeow.Notifications],
        Session: [Whatsmeow.Session, Whatsmeow.Sessions.Supervisor],
        Pairing: [Whatsmeow.Pair, Whatsmeow.PairCode, Whatsmeow.QRChannel],
        Messaging: [Whatsmeow.Send, Whatsmeow.Receipt, Whatsmeow.Retry, Whatsmeow.MsgSecret],
        Transport: ~r/^Whatsmeow\.Transport/,
        Binary: ~r/^Whatsmeow\.Binary/,
        Signal: ~r/^Whatsmeow\.Signal/,
        Crypto: ~r/^Whatsmeow\.Crypto/,
        Types: ~r/^Whatsmeow\.Types/,
        Store: ~r/^Whatsmeow\.Store/,
        AppState: ~r/^Whatsmeow\.AppState/,
        Argo: ~r/^Whatsmeow\.Argo/,
        Armadillo: [Whatsmeow.Armadillo, Whatsmeow.Armadillo.Envelope],
        Media: ~r/^Whatsmeow\.Media/,
        Groups: [Whatsmeow.Group, Whatsmeow.Presence, Whatsmeow.Call, Whatsmeow.Newsletter],
        Proto: ~r/^Whatsmeow\.Proto/
      ]
    ]
  end
end
