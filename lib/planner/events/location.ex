defmodule Planner.Events.Location do
  use Ecto.Schema
  import Ecto.Changeset

  alias Planner.Events.Event

  schema "event_locations" do
    field :city, :string
    field :name, :string
    field :state, :string
    field :street, :string
    field :zip_code, :string
    belongs_to :event, Event

    timestamps()
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:name, :street, :city, :state, :zip_code, :event_id])
    |> validate_required([:event_id])
  end
end
