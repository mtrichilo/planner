defmodule Planner.Repo.Migrations.CreateEventLocations do
  use Ecto.Migration

  def change do
    create table(:event_locations) do
      add :name, :string
      add :street, :string
      add :city, :string
      add :state, :string
      add :zip_code, :string
      add :event_id, references(:events, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:event_locations, [:event_id])
  end
end
