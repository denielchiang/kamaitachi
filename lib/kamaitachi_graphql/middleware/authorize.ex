defmodule KamaitachiGraphQL.Middleware.Authorize do
  @moduledoc false
  @behaviour Absinthe.Middleware

  alias Kamaitachi.General.Responses

  def call(resolution, role) do
    case correct_role?("any", Atom.to_string(role) || "any") do
      true ->
        resolution

      _ ->
        resolution
        |> Absinthe.Resolution.put_result({:error, Responses.get(:user_unauthorized)})
    end
  end

  defp correct_role?(_, "any"), do: true
  defp correct_role?(role, role), do: true
  defp correct_role?(_, _), do: false
end
