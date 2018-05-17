defmodule PlannerWeb.VoteController do
  use PlannerWeb, :controller

  alias Planner.Polling
  alias Planner.Polling.Vote

  action_fallback PlannerWeb.FallbackController

  def create(conn, %{"vote" => vote_params}) do
    with {:ok, %Vote{} = vote} <- Polling.create_vote(vote_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", vote_path(conn, :show, vote))
      |> render("show.json", vote: vote)
    end
  end

  def delete(conn, %{"poll_id" => poll_id, "user_id" => user_id, "option_id" => option_id}) do
    with {:ok, %Vote{}} <- Polling.delete_vote(poll_id, user_id, option_id) do
      send_resp(conn, :no_content, "")
    end
  end
end
