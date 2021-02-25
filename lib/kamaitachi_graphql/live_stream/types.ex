defmodule KamaitachiGraphQL.LiveStream.Types do
  @moduledoc false
  use Absinthe.Schema.Notation

  alias KamaitachiGraphQL.LiveStream.Resolver

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
