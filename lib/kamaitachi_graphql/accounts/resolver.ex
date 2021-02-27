defmodule KamaitachiGraphQL.Accounts.Resolver do
  @moduledoc """
  Accounts Resolver context
  """
  alias Kamaitachi.{Accounts, General.Responses, Streams}

  def login(_, %{email: email, password: password}, _) do
    with {:ok, user} <- Accounts.authenticate_user(email, password) do
      {:ok, %{user: user}}
    end
  end

  def logout(_, _, %{context: %{current_user: user}}) do
    {:ok, %{user: user}}
  end

  def logout(_, _, _) do
    {:error, Responses.get(:user_unauthorized)}
  end

  def register(_, params, _) do
    with {:ok, user} <- Accounts.create_user(params) do
      {:ok, %{user: user}}
    end
  end

  def me(_, _, %{context: %{current_user: user}}),
    do:
      {:ok,
       %{
         user: user,
         token:
           Phoenix.Token.sign(
             KamaitachiWeb.Endpoint,
             "user sesion",
             user.id
           ),
         live_stream: create_live_stream()
       }}

  defp create_live_stream do
    {:ok, stream} = Streams.create_live_stream()

    stream
  end

  def me(_, _, _),
    do: {:ok, %{user: nil}}

  def all_users(_, _, _),
    do: {:ok, Accounts.list_users()}
end
