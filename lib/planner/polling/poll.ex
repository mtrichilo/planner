defmodule Planner.Polling.Poll do
  use Ecto.Schema
  import Ecto.Changeset

  alias Planner.Events.Event
  alias Planner.Polling.Field

  schema "polls" do
    field :allow_others, :boolean, default: true
    field :multiple_votes, :boolean, default: true
    belongs_to :event, Event
    belongs_to :field, Field

    timestamps()
  end

  @doc false
  def changeset(poll, attrs) do
    poll
    |> cast(attrs, [:multiple_votes, :allow_others, :event_id, :field_id])
    |> validate_required([:event_id, :field_id])
  end
end
