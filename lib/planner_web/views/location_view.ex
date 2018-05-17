defmodule PlannerWeb.LocationView do
  use PlannerWeb, :view
  alias PlannerWeb.LocationView

  def render("index.json", %{event_locations: event_locations}) do
    %{data: render_many(event_locations, LocationView, "location.json")}
  end

  def render("show.json", %{location: location}) do
    %{data: render_one(location, LocationView, "location.json")}
  end

  def render("location.json", %{location: location}) do
    %{id: location.id,
      name: location.name,
      street: location.street,
      city: location.city,
      state: location.state,
      zip_code: location.zip_code}
  end
end
