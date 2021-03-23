defmodule KamaitachiGraphQL.LiveStream.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias KamaitachiGraphQL.{LiveStream.Resolver, Middleware}

  object :live_stream do
    field :created_at, :naive_datetime
    field :id, :id
    field :new_asset_settings, :asset_setting
    field :playback_ids, list_of(:playback_id)
    field :reconnect_window, :integer
    field :status, :string
    field :stream_key, :string
  end

  object :asset_setting do
    field :playback_policies, list_of(:string)
  end

  object :playback_id do
    field :id, :id
    field :policy, :string
  end

  object :live_stream_queries do
    field :list_on_airs, list_of(:live_stream) do
      arg(:limit, :integer)
      arg(:page, :integer)

      middleware(Middleware.Authorize, :any)
      resolve(&Resolver.list_on_airs/2)
    end

    field :one_idle_stream, :live_stream do
      resolve(&Resolver.take_one_idle/3)
    end
  end

  object :live_strem_mutations do
    field :complete_live_stream, :response do
      arg(:live_stream_id, non_null(:string))
      resolve(&Resolver.complete_live_stream/3)
    end

    field :delete_live_stream, :response do
      arg(:live_stream_id, non_null(:string))
      resolve(&Resolver.delete_live_stream/3)
    end
  end
end
