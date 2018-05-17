defmodule PlannerWeb.GuestView do
  use PlannerWeb, :view
  alias PlannerWeb.GuestView
  alias PlannerWeb.UserView

  def render("index.json", %{event_guests: event_guests}) do
    %{data: render_many(event_guests, GuestView, "guest.json")}
  end

  def render("show.json", %{guest: guest}) do
    %{data: render_one(guest, GuestView, "guest.json")}
  end

  def render("guest.json", %{guest: guest}) do
    %{user: render_one(guest.user, UserView, "user.json")}
  end
end
