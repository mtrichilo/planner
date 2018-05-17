defmodule Planner.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, null: false
      add :user_name, :string, null: false
      add :password_hash, :string, null: false
      add :first_name, :string, null: false
      add :last_name, :string, null: false
      add :image, :string, null: false, default: "/planner/images/default.jpg"

      timestamps()
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:user_name])
  end
end
