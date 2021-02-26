defmodule KamaitachiGraphQL.LiveStream.Resolver do
  @moduledoc """
  Accounts Resolver context
  """

  alias Kamaitachi.{General.Responses, Streams}

  def list_all_stream(_, _, _) do
    Streams.list_all_live_streams()
    |> packaging()
  end

  def complete_live_stream(_, %{live_stream_id: live_stream_id}, _) do
    Streams.complete_live_stream(live_stream_id)
    |> packaging(:complete)
  end

  def delete_live_stream(_, %{live_stream_id: live_stream_id}, _) do
    Streams.delete_live_stream(live_stream_id)
    |> packaging(:delete)
  end

  defp packaging(:ok, :complete), do: {:ok, Responses.get(:complete_successed)}
  defp packaging(_, :complete), do: {:error, Responses.get(:complete_failed)}

  defp packaging({:ok, _rest_all_streams}, :delete),
    do: {:ok, Responses.get(:delete_stream_successed)}

  defp packaging(_, :delete), do: {:error, Responses.get(:delete_stream_failed)}
  defp packaging(list) when is_list(list), do: {:ok, list}
end
