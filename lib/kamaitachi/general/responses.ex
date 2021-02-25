defmodule Kamaitachi.General.Responses do
  @moduledoc """
  List of all possible responses from the API
  """

  def get(response) when is_atom(response) do
    case get_message(response) do
      nil ->
        %{
          code: "internal-error",
          message: "Internal error"
        }

      description ->
        %{
          code: String.replace(to_string(response), "_", "-"),
          message: description
        }
    end
  end

  defp get_message(response) when is_atom(response) do
    [
      user_unauthorized: "User is not authorized",
      user_password_invalid: "User invalid password",
      user_password_weak: "User invalid password strength",
      complete_failed: "Live stream can't be completed",
      complete_successed: "Live stream has be completed",
      delete_stream_successed: "Live stream has be deleted",
      delete_stream_failed: "Live stream can't be deleted"
    ][response]
  end
end
