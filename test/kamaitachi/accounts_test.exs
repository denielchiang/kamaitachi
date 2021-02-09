defmodule Kamaitachi.AccountsTest do
  use Kamaitachi.DataCase

  alias Kamaitachi.Accounts

  describe "users" do
    alias Kamaitachi.Accounts.User

    @valid_attrs %{
      email: "some email",
      name: "some name",
      password: "A123b222kkKKjj"
    }
    @update_attrs %{
      email: "some updated email",
      name: "some updated name",
      password: "A123b222kkKKjj",
      new_password: "B23aJAfi8829Vk"
    }
    @invalid_attrs %{email: nil, name: nil, password: nil, new_password: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "lookup_user/1 returns the user with given id" do
      user = user_fixture()
      data_user = Accounts.lookup_user(user.id)
      assert data_user.email == user.email
      assert data_user.name == user.name
      assert data_user.password_hash == user.password_hash
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.name == "some name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Accounts.update_user(user, @update_attrs)
      assert user.email == "some updated email"
      assert user.name == "some updated name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)

      data_user = Accounts.lookup_user(user.id)
      assert user.name == data_user.name
      assert user.email == data_user.email
      assert user.password_hash == data_user.password_hash
    end
  end
end
