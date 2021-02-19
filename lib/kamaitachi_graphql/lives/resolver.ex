defmodule KamaitachiGraphQL.Lives.Resolver do
  @moduledoc """
  Lives Resolver context
  """

  def open_stream(_, _, _) do
    client = Mux.client()

    with {:ok, live_stream, _env} =
           Mux.Video.LiveStreams.create(client, %{
             playback_policy: "public",
             new_asset_settings: %{playback_policy: "public"}
           }) do
      {:ok, %{live_stream: live_stream}}
    end
  end
end
