defmodule Planner.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :user_name, :string
      add :password_hash, :string
      add :first_name, :string
      add :last_name, :string
      add :image, :string

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:user_name])
  end
end
