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
    with {:ok, on_airs} <- Streams.on_airs(),
         {:ok, all_streams} <- Streams.all_streams() do
      assign(socket, streams: all_streams, on_airs: on_airs)
    end
  end

  def handle_event("delete_stream", %{"id" => id}, socket) do
    Streams.delete_live_stream(id)

    {:noreply, socket}
  end

  def handle_event("create_stream", _, socket) do
    Streams.create_live_stream()

    {:noreply, socket}
  end
end
