defmodule Planner.Repo.Migrations.CreatePolls do
  use Ecto.Migration

  def change do
    create table(:polls) do
      add :multiple_votes, :boolean, default: true, null: false
      add :allow_others, :boolean, default: true, null: false
      add :event_id, references(:events, on_delete: :delete_all), null: false
      add :field_id, references(:poll_fields, on_delete: :restrict), null: false

      timestamps()
    end

    create index(:polls, [:event_id])
    create index(:polls, [:field_id])
  end
end
