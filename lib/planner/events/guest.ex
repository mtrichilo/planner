defmodule Planner.Events.Guest do
  use Ecto.Schema
  import Ecto.Changeset

  alias Planner.Accounts.User
  alias Planner.Events.Event

  @primary_key false
  schema "event_guests" do
    belongs_to :event, Event, primary_key: true
    belongs_to :user, User, primary_key: true

    timestamps()
  end

  @doc false
  def changeset(guest, attrs) do
    guest
    |> cast(attrs, [:event_id, :user_id])
    |> validate_required([:event_id, :user_id])
  end
end
