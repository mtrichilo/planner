defmodule Planner.Polling.Vote do
  use Ecto.Schema
  import Ecto.Changeset

  alias Planner.Accounts.User
  alias Planner.Polling.Poll

  @primary_key false
  schema "poll_votes" do
    field :option_id, :integer, primary_key: true
    belongs_to :poll, Poll, primary_key: true
    belongs_to :user, User, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(vote, attrs) do
    vote
    |> cast(attrs, [:option_id, :poll_id, :user_id])
    |> validate_required([:option_id, :poll_id, :user_id])
  end
end
