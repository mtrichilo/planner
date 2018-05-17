defmodule Planner.Polling.Field do
  use Ecto.Schema
  import Ecto.Changeset


  schema "poll_fields" do
    field :field_name, :string

    timestamps()
  end

  @doc false
  def changeset(field, attrs) do
    field
    |> cast(attrs, [:field_name])
    |> validate_required([:field_name])
  end
end
