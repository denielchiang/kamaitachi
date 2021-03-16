defmodule KamaitachiWeb.Router do
  use KamaitachiWeb, :router

  pipeline :graphql do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :put_secure_browser_headers
    plug KamaitachiGraphQL.Context
  end

  scope "/v1" do
    pipe_through :graphql

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: KamaitachiGraphQL.Schema,
      socket: KamaitachiWeb.UserSocket

    forward "/graphql", Absinthe.Plug,
      schema: KamaitachiGraphQL.Schema,
      before_send: {KamaitachiGraphQL.Context, :before_send}

    post "/mux", KamaitachiWeb.MuxController, :create
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {KamaitachiWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/", KamaitachiWeb do
    pipe_through :browser

    live "/", StreamLive, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", KamaitachiWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: KamaitachiWeb.Telemetry
    end
  end
end
