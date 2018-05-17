defmodule Planner.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset


  schema "users" do
    field :email, :string
    field :first_name, :string
    field :image, :string
    field :last_name, :string
    field :password_hash, :string
    field :user_name, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :user_name, :password_hash, :first_name, :last_name, :image])
    |> validate_required([:email, :user_name, :password_hash, :first_name, :last_name, :image])
    |> unique_constraint(:email)
    |> unique_constraint(:user_name)
  end
end
