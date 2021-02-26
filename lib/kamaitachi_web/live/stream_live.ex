defmodule KamaitachiWeb.StreamLive do
  use KamaitachiWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, assign(socket, streams: all_streams())}
  end

  def render(assigns) do
    ~L"Rendering LiveView"
  end

  defp all_streams do
    MuxWrapper.client()
    |> MuxWrapper.list_all_live_stream()
  end
end
