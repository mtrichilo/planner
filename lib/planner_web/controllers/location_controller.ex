defmodule PlannerWeb.LocationController do
  use PlannerWeb, :controller

  alias Planner.Events
  alias Planner.Events.Location

  action_fallback PlannerWeb.FallbackController

  def create(conn, %{"location" => location_params}) do
    with {:ok, %Location{} = location} <- Events.create_location(location_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", location_path(conn, :show, location))
      |> render("show.json", location: location)
    end
  end

  def update(conn, %{"id" => id, "location" => location_params}) do
    location = Events.get_location!(id)

    with {:ok, %Location{} = location} <- Events.update_location(location, location_params) do
      render(conn, "show.json", location: location)
    end
  end

  def delete(conn, %{"id" => id}) do
    location = Events.get_location!(id)
    with {:ok, %Location{}} <- Events.delete_location(location) do
      send_resp(conn, :no_content, "")
    end
  end
end
