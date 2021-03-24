# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

db_host =
  System.get_env("DATABASE_HOST") ||
    raise """
    environment variable DATABASE_HOST is missing.
    """

db_database = System.get_env("DATABASE") || "kamaiatchi_dev"
db_username = System.get_env("DATABASE_USER") || "postgres"
db_password = System.get_env("DATABASE_PASSWORD") || "postgres"
db_port = System.get_env("DATABASE_PORT") || "5432"

db_url =
  "ecto://#{db_username}:#{db_password}@#{db_host}:#{db_port}/#{db_database}?sslmode=require"

# Mux development token
config :mux,
  access_token_id: "d95f4229-9df8-4166-91ab-c95fd97e545e",
  access_token_secret:
    "hAeFs4AgMRJngUNeN8nJlnLGzKO4e56W6ktxTpFryWyBwLklLN+oZQpgmcmojcPKuhhIgxulSCX"

config :kamaitachi,
  app_domain: "http://#{System.get_env("HOSTNAME")}:3000"

config :kamaitachi, Kamaitachi.Repo,
  url: db_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :kamaitachi, KamaitachiWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :kamaitachi, KamaitachiWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
config :kamaitachi, KamaitachiWeb.Endpoint, server: true
