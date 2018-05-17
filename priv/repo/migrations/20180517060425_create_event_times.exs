defmodule Planner.Repo.Migrations.CreateEventTimes do
  use Ecto.Migration

  def change do
    create table(:event_times) do
      add :start_date, :date
      add :start_time, :time
      add :end_date, :date
      add :end_time, :time
      add :generalize_start, :boolean, default: false, null: false
      add :event_id, references(:events, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:event_times, [:event_id])
  end
end
