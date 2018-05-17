defmodule PlannerWeb.EventView do
  use PlannerWeb, :view
  alias PlannerWeb.EventView
  alias PlannerWeb.UserView
  alias PlannerWeb.TimeView
  alias PlannerWeb.LocationView
  alias PlannerWeb.GuestView
  alias PlannerWeb.PollView

  def render("index.json", %{events: events}) do
    %{data: render_many(events, EventView, "event.json")}
  end

  def render("show.json", %{event: event}) do
    %{data: render_one(event, EventView, "event.json")}
  end

  def render("event.json", %{event: event}) do
    %{id: event.id,
      name: event.name,
      message: event.message,
      description: event.description,
      image: event.image,
      private: event.private,
      host: render_one(event.host, UserView, "user.json"),
      times: render_many(event.times, TimeView, "time.json"),
      locations: render_many(event.locations, LocationView, "location.json"),
      guests: render_many(event.guests, GuestView, "guest.json"),
      polls: render_many(event.polls, PollView, "poll.json")}
  end
end
