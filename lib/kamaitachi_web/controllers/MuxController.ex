defmodule MuxController do
  use KamaitachiWeb, :controller

  alias Kamaitachi.Streams

  @mux_status_complete "video.asset.live_stream_completed"
  @mux_status_ready "video.asset.ready"

  @doc """
  Handle Mux webhooks(Example: https://docs.mux.com/guides/video/listen-for-webhooks)
  """
  def create(conn, params) do
    params
    |> which_status()

    conn
    |> send_resp(201, "")
  end

  defp which_status(%{"type" => @mux_status_complete}), do: broadcast_live_view(:delete)

  defp which_status(%{"type" => @mux_status_ready} = params),
    do: broadcast_live_view(:create, params)

  defp which_status(_params), do: nil

  defp broadcast_live_view(:delete), do: Streams.disable_live_stream()

  defp broadcast_live_view(:create, params) do
    params
    |> get_stream_id()
    |> Streams.ready_live_stream()
  end

  defp get_stream_id(%{"data" => %{"live_stream_id" => id}}), do: id
  defp get_stream_id(_params), do: nil
end
