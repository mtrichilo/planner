defmodule PlannerWeb.FriendshipController do
  use PlannerWeb, :controller

  alias Planner.Accounts

  action_fallback PlannerWeb.FallbackController

  def index(conn, _params) do
    friendships = Accounts.list_friendships(conn.assigns.user_id)
    render(conn, "index.json", friendships: friendships)
  end

  def create(conn, %{"friendship" => friendship_params}) do
    with {:ok, _} <- Accounts.create_friendship(friendship_params) do
      conn
      |> put_status(:created)
      |> send_resp(:no_content, "")
    end
  end

  def delete(conn, %{"id" => friend_id}) do
    with {:ok, _} <- Accounts.delete_friendship(conn.assigns.user_id, friend_id) do
      send_resp(conn, :no_content, "")
    end
  end
end
