defmodule KamaitachiGraphQL.Accounts.Resolver do
  @moduledoc """
  Accounts Resolver context
  """
  alias Kamaitachi.{Accounts, General.Responses}

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
    {status, _user} = Accounts.create_user(params)

    IO.inspect(status)

    status
    |> packaging(:created)
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
           )
       }}

  def me(_, _, _),
    do: {:ok, %{user: nil}}

  def all_users(_, _, _),
    do: {:ok, Accounts.list_users()}

  defp packaging(:ok, :created), do: {:ok, Responses.get(:user_regist_successed)}
  defp packaging(:error, :created), do: {:error, Responses.get(:user_regist_failed)}
end
