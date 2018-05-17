defmodule PlannerWeb.FriendshipController do
  use PlannerWeb, :controller

  alias Planner.Accounts
  alias Planner.Accounts.Friendship

  action_fallback PlannerWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    friendships = Accounts.list_friendships(user_id)
    render(conn, "index.json", friendships: friendships)
  end

  def create(conn, %{"friendship" => friendship_params}) do
    with {:ok, %Friendship{} = friendship} <- Accounts.create_friendship(friendship_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", friendship_path(conn, :show, friendship))
      |> render("show.json", friendship: friendship)
    end
  end

  def delete(conn, %{"user_id" => user_id, "friend_id" => friend_id}) do
    with {:ok, %Friendship{}} <- Accounts.delete_friendship(user_id, friend_id) do
      send_resp(conn, :no_content, "")
    end
  end
end
