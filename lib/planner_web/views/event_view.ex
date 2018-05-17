defmodule PlannerWeb.EventView do
  use PlannerWeb, :view
  alias PlannerWeb.EventView
  alias PlannerWeb.UserView

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
      host: render_one(event.host, UserView, "user.json")}
  end
end