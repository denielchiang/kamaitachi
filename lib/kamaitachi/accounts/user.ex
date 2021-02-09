defmodule Kamaitachi.Accounts.User do
  @moduledoc """
  The User table schema.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Kamaitachi.General.Responses

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string, virtual: true
    field :new_password, :string, virtual: true
    field :password_hash, :string

    timestamps(type: :utc_datetime)
  end

  @required_fields ~w( name email password )a
  @optional_fields ~w()a

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> unique_constraint(:email)
    |> validate_length(:password, min: 12)
    |> password_hash(:password)
  end

  @required_fields ~w( name email password new_password )a
  @optional_fields ~w()a

  def changeset_update(user, attrs) do
    user
    |> cast(attrs, @required_fields ++ @optional_fields)
    |> unique_constraint(:email)
    |> password_validate()
    |> validate_length(:password, min: 12)
    |> validate_length(:new_password, min: 12)
    |> password_hash(:new_password)
  end

  defp password_hash(%Changeset{valid?: true, changes: changes} = changeset, field) do
    case changes[field] do
      nil -> changeset
      password -> changeset |> change(Bcrypt.add_hash(password))
    end
  end

  defp password_hash(changeset, _), do: changeset

  defp password_validate(%Changeset{valid?: true, changes: %{password: pw}} = changeset) do
    case Bcrypt.check_pass(changeset.data, pw) do
      {:ok, _} -> changeset
      _ -> changeset |> add_error(:password, Responses.get(:user_password_invalid).code)
    end
  end

  defp password_validate(changeset), do: changeset
end
