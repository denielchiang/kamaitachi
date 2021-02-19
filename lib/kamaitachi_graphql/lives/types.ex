defmodule KamaitachiGraphQL.Lives.Types do
  @moduledoc """
  Live Types
  """
  use Absinthe.Schema.Notation

  alias Kamaitachi.General.Responses
  alias KamaitachiGraphQL.Lives.Resolver
  alias KamaitachiGraphQL.Middleware

  object :live_stream do
    @desc "The live stream"
    field :id, non_null(:id)
    field :new_asset_settings, non_null(:new_asset_setting)
    field :playback_ids, non_null(list_of(:playback))
    field :reconnect_window, non_null(:integer)
    field :status, non_null(:string)
    field :stream_key, non_null(:string)
    field :test, non_null(:boolean)
  end

  object :new_asset_setting do
    @desc "Asset setting"
    field :playback_policies, non_null(list_of(:playback_policy))
  end

  object :playback_policy do
    @desc "Playback policy"
    field :public, non_null(:string)
  end

  object :playback do
    @desc "Playback ids"
    field :id, non_null(:id)
    field :policy, non_null(:string)
  end

  object :live_mutations do
    field :open_stream, non_null(:live_stream) do
      middleware(Middleware.Authorize, :host)
      resolve(&Resolver.open_stream/3)
    end
  end
end
