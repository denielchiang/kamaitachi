defmodule Kamaitachi.Streams do
  @moduledoc """
  Live Streaming context that provide either API or liveview corresponding functions
  """
  @topic inspect(__MODULE__)

  def subscribe do
    Phoenix.PubSub.subscribe(Kamaitachi.PubSub, @topic)
  end

  defp broadcast_change({:ok, result}, event) do
    Phoenix.PubSub.broadcast(Kamaitachi.PubSub, @topic, {__MODULE__, event, result})

    {:ok, result}
  end

  def list_all_live_streams do
    get_client()
    |> MuxWrapper.list_all_live_stream()
  end

  def create_live_stream do
    get_client()
    |> MuxWrapper.create_live_stream()
    |> packaging()
    |> broadcast_change([:streams, :created])
  end

  def complete_live_stream(live_stream_id) do
    get_client()
    |> MuxWrapper.complete_live_stream(live_stream_id)
  end

  def delete_live_stream(live_stream_id) do
    get_client()
    |> MuxWrapper.delete_live_stream(live_stream_id)
    |> packaging()
    |> broadcast_change([:streams, :deleted])
  end

  defp get_client, do: MuxWrapper.client()

  defp packaging(%MuxWrapper.EmbeddedSchema.LiveStream{} = stream), do: {:ok, stream}
  defp packaging(:ok), do: {:ok, list_all_live_streams()}
end
