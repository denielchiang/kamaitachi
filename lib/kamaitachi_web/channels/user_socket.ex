defmodule KamaitachiWeb.UserSocket do
  @moduledoc false

  alias Kamaitachi.Accounts

  use Phoenix.Socket

  use Absinthe.Phoenix.Socket,
    schema: KamaitachiGraphQL.Schema

  ## Channels
  # channel "room:*", KamaitachiWeb.RoomChannel

  # Socket params are passed from the client and can
  # be used to verify and authenticate a user. After
  # verification, you can put default assigns into
  # the socket that will be set for all channels, ie
  #
  #     {:ok, assign(socket, :user_id, verified_user_id)}
  #
  # To deny connection, return `:error`.
  #
  # See `Phoenix.Token` documentation for examples in
  # performing token verification on connect.
  @impl true
  def connect(%{"token" => token}, socket) do
    with {:ok, user_id} <-
           Phoenix.Token.verify(
             KamaitachiWeb.Endpoint,
             "user sesion",
             token,
             max_age: 86_400
           ),
         %Accounts.User{} = current_user <- Accounts.lookup_user(user_id) do
      socket =
        Absinthe.Phoenix.Socket.put_options(socket,
          context: %{
            current_user: current_user
          }
        )

      {:ok, socket}
    else
      _ ->
        :error
    end
  end

  def connect(_, _), do: :error

  # Socket id's are topics that allow you to identify all sockets for a given user:
  #
  #     def id(socket), do: "user_socket:#{socket.assigns.user_id}"
  #
  # Would allow you to broadcast a "disconnect" event and terminate
  # all active sockets and channels for a given user:
  #
  #     KamaitachiWeb.Endpoint.broadcast("user_socket:#{user.id}", "disconnect", %{})
  #
  # Returning `nil` makes this socket anonymous.
  @impl true
  def id(_socket), do: nil
end
