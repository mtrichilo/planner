defmodule Planner.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :timestamp, :utc_datetime, null: false
      add :message, :string, null: false
      add :event_id, references(:events, on_delete: :delete_all), null: false
      add :user_id, references(:users, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:messages, [:event_id])
    create index(:messages, [:user_id])
  end
end
