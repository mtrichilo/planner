defmodule Planner.Repo.Migrations.CreatePollVotes do
  use Ecto.Migration

  def change do
    create table(:poll_votes, primary_key: false) do
      add :option_id, :integer, primary_key: true
      add :poll_id, references(:polls, on_delete: :delete_all), primary_key: true
      add :user_id, references(:users, on_delete: :delete_all), primary_key: true

      timestamps()
    end

    create index(:poll_votes, [:poll_id])
    create index(:poll_votes, [:user_id])
  end
end
