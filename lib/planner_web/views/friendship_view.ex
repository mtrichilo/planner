defmodule PlannerWeb.FriendshipView do
  use PlannerWeb, :view
  alias PlannerWeb.FriendshipView

  def render("index.json", %{friendships: friendships}) do
    %{data: render_many(friendships, FriendshipView, "friendship.json")}
  end

  def render("show.json", %{friendship: friendship}) do
    %{data: render_one(friendship, FriendshipView, "friendship.json")}
  end

  def render("friendship.json", %{friendship: friendship}) do
    %{user_id: friendship.user_id,
      friend_id: friendship.friend_id}
  end
end