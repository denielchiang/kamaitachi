defmodule Kamaitachi.Streams do
  @moduledoc """
  Live Streaming context that provide either API or liveview corresponding functions
  """
  @topic inspect(__MODULE__)

  alias MuxWrapper.EmbeddedSchema.LiveStream

  def subscribe do
    Phoenix.PubSub.subscribe(Kamaitachi.PubSub, @topic)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Kamaitachi.PubSub, @topic, {__MODULE__, event, result})

    {:ok, result}
  end

  def all_streams, do: MuxWrapper.LiveStreams.list(get_client())

  def on_airs(params \\ %{}) do
    with {:ok, streams} <- MuxWrapper.LiveStreams.list(get_client(), params) do
      active =
        streams
        |> Enum.filter(&is_streaming_active?/1)

      {:ok, active}
    end
  end

  defp is_streaming_active?(%LiveStream{status: "active"}), do: true
  defp is_streaming_active?(_), do: false

  def ready_live_stream(live_stream_id) do
    MuxWrapper.LiveStreams.get(get_client(), live_stream_id)
    |> broadcast_change([:streams, :started])
  end

  def disable_live_stream do
    broadcast_change({:ok, []}, [:streams, :remove])
  end

  def create_live_stream do
    MuxWrapper.LiveStreams.create_public_live_stream(get_client())
    |> broadcast_change([:streams, :created])
  end

  def complete_live_stream(live_stream_id),
    do: MuxWrapper.LiveStreams.complete_live_stream(get_client(), live_stream_id)

  def delete_live_stream(live_stream_id) do
    with {:ok} <- MuxWrapper.LiveStreams.delete_live_stream(get_client(), live_stream_id) do
      {:ok, %{}}
      |> broadcast_change([:streams, :deleted])
    end
  end

  defp get_client, do: MuxWrapper.client()
end
