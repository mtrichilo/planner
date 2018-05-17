defmodule Planner.Events.Time do
  use Ecto.Schema
  import Ecto.Changeset
  alias Planner.Events.Event

  schema "event_times" do
    field :end_date, :date
    field :end_time, :time
    field :generalize_start, :boolean, default: false
    field :start_date, :date
    field :start_time, :time
    belongs_to :event, Event

    timestamps()
  end

  @doc false
  def changeset(time, attrs) do
    time
    |> cast(attrs, [:start_date, :start_time, :end_date, :end_time, :generalize_start, :event_id])
    |> validate_required([:generalize_start, :event_id])
  end
end
