defmodule Planner.Repo.Migrations.CreatePollFields do
  use Ecto.Migration

  def change do
    create table(:poll_fields) do
      add :field_name, :string

      timestamps()
    end

  end
end
