defmodule PlannerWeb.GuestController do
  use PlannerWeb, :controller

  alias Planner.Events
  alias Planner.Events.Guest

  action_fallback PlannerWeb.FallbackController

  def create(conn, %{"guest" => guest_params}) do
    with {:ok, %Guest{} = guest} <- Events.create_guest(guest_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", guest_path(conn, :show, guest))
      |> render("show.json", guest: guest)
    end
  end

  def delete(conn, %{"id" => id}) do
    guest = Events.get_guest!(id)
    with {:ok, %Guest{}} <- Events.delete_guest(guest) do
      send_resp(conn, :no_content, "")
    end
  end
end
