# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Planner.Repo.insert!(%Planner.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
defmodule Seeds do
  alias Planner.Accounts

  def run do
    {:ok, m} = Accounts.create_user(%{"email" => "m@planner.com", "user_name" => "m",
      "password" => "password", "first_name" => "Michael", "last_name" => "Planner"})
    {:ok, p} = Accounts.create_user(%{"email" => "p@planner.com", "user_name" => "p",
      "password" => "password", "first_name" => "Paul", "last_name" => "Planner"})
    {:ok, c} = Accounts.create_user(%{"email" => "c@planner.com", "user_name" => "c",
      "password" => "password", "first_name" => "Christina", "last_name" => "Planner"})

    IO.puts m.id
    Accounts.create_friendship(%{"user_id" => m.id, "friend_id" => p.id})
    Accounts.create_friendship(%{"user_id" => m.id, "friend_id" => c.id})
  end
end

Seeds.run
    
