defmodule Kamaitachi.MixProject do
  use Mix.Project

  def project do
    [
      app: :kamaitachi,
      version: "0.1.0",
      elixir: "~> 1.7",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Kamaitachi.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_), do: ["lib", "web"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix
      {:phoenix, "~> 1.5.7"},
      {:phoenix_ecto, "~> 4.1"},
      {:phoenix_html, "~> 2.11"},
      {:phoenix_live_view, "~> 0.15.0"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_dashboard, "~> 0.4"},

      # Phoenix Metrics
      {:telemetry_metrics, "~> 0.4"},
      {:telemetry_poller, "~> 0.4"},

      # Server
      {:plug_cowboy, "~> 2.0"},
      {:cors_plug, "~> 2.0"},

      # Database
      {:ecto_sql, "~> 3.4"},
      {:postgrex, ">= 0.0.0"},

      # Translations
      {:gettext, "~> 0.11"},

      # Parser
      {:floki, ">= 0.27.0", only: :test},
      {:jason, "~> 1.0"},

      # GraphQL
      {:absinthe, "~> 1.5"},
      {:absinthe_plug, "~> 1.5"},
      {:absinthe_phoenix, "~> 2.0"},

      # Encryption
      {:bcrypt_elixir, "~> 2.3"},

      # Linting 
      {:credo, "~> 1.5", only: [:dev, :test], override: true},
      {:credo_envvar, "~> 0.1.4", only: [:dev, :test], runtime: false},
      {:credo_naming, "~> 1.0", only: [:dev, :test], runtime: false},

      # Security check
      {:sobelow, "~> 0.11.0", only: [:dev, :test], runtime: true},

      # Test factories
      {:ex_machina, "~> 2.5", only: :test},
      {:faker, "~> 0.16.0", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup", "cmd npm install --prefix assets"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
