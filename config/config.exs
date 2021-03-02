# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Mux development token
config :mux,
  access_token_id: "42852dc7-db15-47d2-84f1-12b9db64f59d",
  access_token_secret:
    "8iRjy1lSAuDfqBANiPn6yI27PRsUN8Id2aeQq+Ky4mUgFed1IlXSpor1n7IFSXBlY6OSoEFZOKQ"

config :kamaitachi,
  ecto_repos: [Kamaitachi.Repo],
  app_domain: "http://kamaitachi.site:3000",
  cookie_domain: "kamaitachi.site",
  cookie_secure: false,
  cookie_key: "_kamaitachi_key_localhost"

# Configures the endpoint
config :kamaitachi, KamaitachiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "vmGtEKKai9XBoFhC7bmIs8XrA0xOGUrbF5cTqQl8zWTaQQsBD0/RlSeYENilqESw",
  render_errors: [view: KamaitachiWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Kamaitachi.PubSub,
  live_view: [signing_salt: "ItOreYk1"]

# CORS
config :cors_plug,
  origin: "*",
  max_age: 86400,
  methods: ["GET", "POST", "PUT", "DELETE"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
