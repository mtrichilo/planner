defmodule Planner.Accounts.Friendship do
  use Ecto.Schema
  import Ecto.Changeset

  alias Planner.Accounts.User

  @primary_key false
  schema "friendships" do
    belongs_to :user, User, primary_key: true
    belongs_to :friend, User, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(friendship, attrs) do
    friendship
    |> cast(attrs, [:user_id, :friend_id])
    |> validate_required([:user_id, :friend_id])
  end
end
