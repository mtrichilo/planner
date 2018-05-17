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
  alias Planner.Events

  def run do
    {:ok, m} = Accounts.create_user(%{"email" => "m@planner.com", "user_name" => "m",
      "password" => "password", "first_name" => "Michael", "last_name" => "Planner"})
    {:ok, p} = Accounts.create_user(%{"email" => "p@planner.com", "user_name" => "p",
      "password" => "password", "first_name" => "Paul", "last_name" => "Planner"})
    {:ok, c} = Accounts.create_user(%{"email" => "c@planner.com", "user_name" => "c",
      "password" => "password", "first_name" => "Christina", "last_name" => "Planner"})
 
    Accounts.create_friendship(%{"user_id" => m.id, "friend_id" => p.id})
    Accounts.create_friendship(%{"user_id" => m.id, "friend_id" => c.id})

    {:ok, e1} = Events.create_event(%{"name" => "Paul's Birthday Party", "host_id" => p.id,
      "message" => "Come celebrate Paul!", "description" => "Gifts or no entry."})
    Events.create_time(%{"event_id" => e1.id, "start_date" => Date.utc_today()})
    Events.create_location(%{"event_id" => e1.id, "street" => "23 Park Street",
      "city" => "Albany", "state" => "NY", "zip_code" => "12203"})

    {:ok, e2} = Events.create_event(%{"message" => "Anyone down for tacos?", 
      "host_id" => m.id, "private" => false})
    Events.create_time(%{"event_id" => e2.id, "start_date" => Date.utc_today(),
      "start_time" => Time.utc_now()})
    Events.create_time(%{"event_id" => e2.id})
    Events.create_location(%{"event_id" => e2.id, "name" => "Amelia's Taqueria"})
    Events.create_location(%{"event_id" => e2.id, "name" => "Chipotle"})
  end
end

Seeds.run
    
