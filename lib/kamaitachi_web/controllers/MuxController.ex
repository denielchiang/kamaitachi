defmodule KamaitachiWeb.MuxController do
  require Logger

  use KamaitachiWeb, :controller

  alias Kamaitachi.Streams

  @mux_status_complete "video.asset.live_stream_completed"
  @mux_status_ready "video.asset.ready"

  @no_handle_event "Skiped this status..."
  @handle_ready "Video asset is avaliable to play and handled..."
  @handle_completed "Video asset is unavabliable from now and handled..."
  @handle_failed "It our server issues cause this handling is failed..."

  @doc """
  Handle Mux webhooks(Example: https://docs.mux.com/guides/video/listen-for-webhooks)
  """
  def create(conn, params) do
    case which_status(params) do
      {:ok, msg} ->
        Logger.notice(msg)

        conn
        |> send_resp(201, msg)

      _ ->
        Logger.error("Mux pass in params: " <> inspect(params))

        send_resp(conn, 500, @handle_failed)
    end
  end

  defp which_status(%{"type" => @mux_status_complete}) do
    broadcast_live_view(:delete)

    {:ok, @handle_completed}
  end

  defp which_status(%{"type" => @mux_status_ready} = params) do
    broadcast_live_view(:create, params)

    {:ok, @handle_ready}
  end

  defp which_status(_params), do: {:ok, @no_handle_event}

  defp broadcast_live_view(:delete), do: Streams.disable_live_stream()

  defp broadcast_live_view(:create, params) do
    params
    |> get_stream_id()
    |> Streams.ready_live_stream()
  end

  defp get_stream_id(%{"data" => %{"live_stream_id" => id}}), do: id
  defp get_stream_id(_params), do: nil
end
