defmodule Kamaitachi.Repo do
  use Ecto.Repo,
    otp_app: :kamaitachi,
    adapter: Ecto.Adapters.Postgres
end
