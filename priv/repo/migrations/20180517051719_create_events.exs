defmodule Planner.Repo.Migrations.CreateEvents do
  use Ecto.Migration

  def change do
    create table(:events) do
      add :name, :string, default: "", null: false
      add :message, :string, default: "", null: false
      add :description, :string, default: "", null: false
      add :image, :string, default: "/planner/events/default.jpg", null: false
      add :private, :boolean, default: true, null: false
      add :host_id, references(:users, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:events, [:host_id])
  end
end
