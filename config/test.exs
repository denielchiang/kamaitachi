use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :kamaitachi, Kamaitachi.Repo,
  username: "kamaitachi_test",
  password: "Y3u0UtjUwwt47jNH",
  database: "kamaitachi_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "private-kamaitachi-db-do-user-8786788-0.b.db.ondigitalocean.com",
  port: 25060,
  ssl: true,
  pool_size: 22,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :kamaitachi, KamaitachiWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
