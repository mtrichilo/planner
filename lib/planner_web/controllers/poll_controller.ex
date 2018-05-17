defmodule PlannerWeb.PollController do
  use PlannerWeb, :controller

  alias Planner.Polling
  alias Planner.Polling.Poll

  action_fallback PlannerWeb.FallbackController

  def index(conn, _params) do
    polls = Polling.list_polls()
    render(conn, "index.json", polls: polls)
  end

  def create(conn, %{"poll" => poll_params}) do
    with {:ok, %Poll{} = poll} <- Polling.create_poll(poll_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", poll_path(conn, :show, poll))
      |> render("show.json", poll: poll)
    end
  end

  def show(conn, %{"id" => id}) do
    poll = Polling.get_poll!(id)
    render(conn, "show.json", poll: poll)
  end

  def update(conn, %{"id" => id, "poll" => poll_params}) do
    poll = Polling.get_poll!(id)

    with {:ok, %Poll{} = poll} <- Polling.update_poll(poll, poll_params) do
      render(conn, "show.json", poll: poll)
    end
  end

  def delete(conn, %{"id" => id}) do
    poll = Polling.get_poll!(id)
    with {:ok, %Poll{}} <- Polling.delete_poll(poll) do
      send_resp(conn, :no_content, "")
    end
  end
end
