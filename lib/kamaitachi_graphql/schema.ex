defmodule KamaitachiGraphQL.Schema do
  @moduledoc """
  GraphQL Schema
  """
  use Absinthe.Schema

  alias KamaitachiGraphQL.Middleware

  import_types(Absinthe.Plug.Types)

  import_types(KamaitachiGraphQL.Application.Types)

  import_types(KamaitachiGraphQL.General.Types)

  import_types(KamaitachiGraphQL.Accounts.Types)

  import_types(KamaitachiGraphQL.LiveStream.Types)

  def middleware(middleware, _field, %{identifier: :mutation}),
    do: middleware ++ [Middleware.Errors]

  def middleware(middleware, _, _), do: middleware

  query do
    import_fields(:application_queries)
    import_fields(:accounts_queries)
    import_fields(:live_stream_queries)
  end

  mutation do
    import_fields(:accounts_mutations)
    import_fields(:live_strem_mutations)
  end

  subscription do
    import_fields(:accounts_subscriptions)
  end
end
