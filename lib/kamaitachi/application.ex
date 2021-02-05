defmodule Kamaitachi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Kamaitachi.Repo,
      # Start the Telemetry supervisor
      KamaitachiWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, [name: Kamaitachi.PubSub, adapter: Phoenix.PubSub.PG2]},
      # Start the Endpoint (http/https)
      KamaitachiWeb.Endpoint,
      # Absinthe Pubsub
      {Absinthe.Subscription, KamaitachiWeb.Endpoint}
      # Start a worker by calling: Kamaitachi.Worker.start_link(arg)
      # {Kamaitachi.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kamaitachi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    KamaitachiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
