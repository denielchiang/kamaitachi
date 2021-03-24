# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :kamaitachi,
  cookie_domain: "kamaitachi.site",
  cookie_key: "_kamaitachi_key_",
  cookie_secure: false,
  ecto_repos: [Kamaitachi.Repo]

# Configures the endpoint
config :kamaitachi, KamaitachiWeb.Endpoint,
  url: [host: System.get_env("HOSTNAME")],
  secret_key_base: "vmGtEKKai9XBoFhC7bmIs8XrA0xOGUrbF5cTqQl8zWTaQQsBD0/RlSeYENilqESw",
  render_errors: [view: KamaitachiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Kamaitachi.PubSub,
  check_origin: ["http://kamaitachi.site", "//*.kamaitachi.site"],
  live_view: [signing_salt: "ItOreYk1"]

# CORS
config :cors_plug,
  origin: ["http://localhost", "http://stage.kamaitachi.site", ~r/https?.*kamaitachi\d?\.site$/],
  max_age: 86400,
  methods: ["GET", "POST", "PUT", "DELETE"]

# Configures Elixir's Logger
config :logger,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id],
  backends: [:console],
  compile_time_purge_matching: [
    [level_lower_than: :info]
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
