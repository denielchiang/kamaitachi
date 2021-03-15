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

  def list_all_live_streams do
    get_client()
    |> MuxWrapper.list_all_live_stream()
    |> Enum.filter(&is_streaming_active?/1)
  end

  defp is_streaming_active?(%LiveStream{status: "active"}), do: true
  defp is_streaming_active?(_), do: false

  def ready_live_stream(live_stream_id) do
    get_client()
    |> MuxWrapper.get_live_stream(live_stream_id)
    |> take_one()
    |> packaging()
    |> broadcast_change([:streams, :started])
  end

  defp take_one([head | _tail]), do: head
  defp take_one(live_stream), do: live_stream

  def disable_live_stream do
    packaging(:ok)
    |> broadcast_change([:streams, :remove])
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
