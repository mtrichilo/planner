defmodule Planner.Messaging.Message do
  use Ecto.Schema
  import Ecto.Changeset

  alias Planner.Accounts.User
  alias Planner.Events.Event

  schema "messages" do
    field :message, :string
    field :timestamp, :utc_datetime
    belongs_to :event, Event
    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> change(timestamp: DateTime.utc_now())
    |> cast(attrs, [:timestamp, :message, :event_id, :user_id])
    |> validate_required([:timestamp, :message, :event_id, :user_id])
  end
end
