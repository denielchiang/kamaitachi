defmodule KamaitachiGraphQL.Middleware.Authorize do
  @moduledoc false
  @behaviour Absinthe.Middleware

  alias Kamaitachi.General.Responses

  def call(%{context: %{current_user: %Kamaitachi.Accounts.User{}}} = resolution, _role),
    do: resolution

  def call(resolution, _role) do
    resolution
    |> Absinthe.Resolution.put_result({:error, Responses.get(:user_unauthorized)})
  end
end
