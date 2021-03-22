defmodule KamaitachiWeb.StreamLive do
  @moduledoc """
  Live view for streaming list page
  """
  use KamaitachiWeb, :live_view

  alias Kamaitachi.Streams

  def mount(_params, _session, socket) do
    Streams.subscribe()

    {:ok, fetch(socket)}
  end

  def handle_info({Streams, [:streams | _], _}, socket) do
    {:noreply, fetch(socket)}
  end

  defp fetch(socket) do
    {:ok, streams} = Streams.on_airs()

    assign(socket, streams: streams)
  end
end
