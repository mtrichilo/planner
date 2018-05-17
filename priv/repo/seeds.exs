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
  alias Planner.Polling

  def run do
    # Add test users.
    {:ok, m} = Accounts.create_user(%{"email" => "m@planner.com", "user_name" => "m",
      "password" => "password", "first_name" => "Michael", "last_name" => "Planner"})
    {:ok, p} = Accounts.create_user(%{"email" => "p@planner.com", "user_name" => "p",
      "password" => "password", "first_name" => "Paul", "last_name" => "Planner"})
    {:ok, c} = Accounts.create_user(%{"email" => "c@planner.com", "user_name" => "c",
      "password" => "password", "first_name" => "Christina", "last_name" => "Planner"})
 
    # Add test friendships.
    Accounts.create_friendship(%{"user_id" => m.id, "friend_id" => p.id})
    Accounts.create_friendship(%{"user_id" => m.id, "friend_id" => c.id})

    # Add a test event.
    {:ok, e1} = Events.create_event(%{"name" => "Paul's Birthday Party", "host_id" => p.id,
      "message" => "Come celebrate Paul!", "description" => "Gifts or no entry."})
    {:ok, t1} = Events.create_time(%{"event_id" => e1.id, "start_date" => Date.utc_today()})
    {:ok, l1} = Events.create_location(%{"event_id" => e1.id, "street" => "23 Park Street",
      "city" => "Albany", "state" => "NY", "zip_code" => "12203"})
    Events.create_guest(%{"event_id" => e1.id, "user_id" => m.id})
    Events.create_guest(%{"event_id" => e1.id, "user_id" => c.id})

    # Add a second test event.
    {:ok, e2} = Events.create_event(%{"message" => "Anyone down for tacos?", 
      "host_id" => m.id, "private" => false})
    {:ok, t2} = Events.create_time(%{"event_id" => e2.id, "start_date" => Date.utc_today(),
      "start_time" => Time.utc_now()})
    {:ok, t3} = Events.create_time(%{"event_id" => e2.id})
    {:ok, l2} = Events.create_location(%{"event_id" => e2.id, "name" => "Amelia's Taqueria"})
    {:ok, l3} = Events.create_location(%{"event_id" => e2.id, "name" => "Chipotle"})

    # Add polling fields.
    {:ok, time} = Polling.create_field(%{"field_name" => "event_time"})
    {:ok, loc} = Polling.create_field(%{"field_name" => "event_location"})

    # Add a poll to the first event.
    {:ok, p1} = Polling.create_poll(%{"event_id" => e1.id, "field_id" => time.id})
    Polling.create_vote(%{"poll_id" => p1.id, "user_id" => c.id, "option_id" => t1.id})
    
    # Add polls to the second event.
    {:ok, p2} = Polling.create_poll(%{"event_id" => e2.id, "field_id" => time.id, 
      "multiple_votes" => false})
    {:ok, p3} = Polling.create_poll(%{"event_id" => e2.id, "field_id" => loc.id,
      "multiple_votes" => false, "allow_others" => false})
    Polling.create_vote(%{"poll_id" => p2.id, "user_id" => m.id, "option_id" => t2.id})
    Polling.create_vote(%{"poll_id" => p3.id, "user_id" => m.id, "option_id" => l3.id})
  end
end

Seeds.run
    
