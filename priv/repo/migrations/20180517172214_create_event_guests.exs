defmodule Planner.Repo.Migrations.CreateEventGuests do
  use Ecto.Migration

  def change do
    create table(:event_guests, primary_key: false) do
      add :event_id, references(:events, on_delete: :delete_all), primary_key: true
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true

      timestamps()
    end

    create index(:event_guests, [:event_id])
    create index(:event_guests, [:user_id])
  end
end
