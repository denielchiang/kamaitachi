defmodule KamaitachiGraphQL.LiveStream.Resolver do
  @moduledoc """
  Accounts Resolver context
  """

  alias Kamaitachi.General.Responses

  def list_all_stream(_, _, _) do
    get_mux_client()
    |> MuxWrapper.list_all_live_stream()
    |> packaging()
  end

  def complete_live_stream(_, %{live_stream_id: live_stream_id}, _) do
    get_mux_client()
    |> MuxWrapper.complete_live_stream(live_stream_id)
    |> packaging(:complete)
  end

  def delete_live_stream(_, %{live_stream_id: live_stream_id}, _) do
    get_mux_client()
    |> MuxWrapper.delete_live_stream(live_stream_id)
    |> packaging(:delete)
  end

  defp get_mux_client, do: MuxWrapper.client()

  defp packaging(:ok, :complete), do: {:ok, Responses.get(:complete_successed)}
  defp packaging(_, :complete), do: {:error, Responses.get(:complete_failed)}
  defp packaging(:ok, :delete), do: {:ok, Responses.get(:delete_stream_successed)}
  defp packaging(_, :delete), do: {:error, Responses.get(:delete_stream_failed)}
  defp packaging(list) when is_list(list), do: {:ok, list}
end
