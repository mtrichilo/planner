defmodule PlannerWeb.TimeController do
  use PlannerWeb, :controller

  alias Planner.Events
  alias Planner.Events.Time

  action_fallback PlannerWeb.FallbackController

  def create(conn, %{"time" => time_params}) do
    with {:ok, %Time{} = time} <- Events.create_time(time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", time_path(conn, :show, time))
      |> render("show.json", time: time)
    end
  end

  def update(conn, %{"id" => id, "time" => time_params}) do
    time = Events.get_time!(id)

    with {:ok, %Time{} = time} <- Events.update_time(time, time_params) do
      render(conn, "show.json", time: time)
    end
  end

  def delete(conn, %{"id" => id}) do
    time = Events.get_time!(id)
    with {:ok, %Time{}} <- Events.delete_time(time) do
      send_resp(conn, :no_content, "")
    end
  end
end
