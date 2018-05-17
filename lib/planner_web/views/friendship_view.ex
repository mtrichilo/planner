defmodule PlannerWeb.FriendshipView do
  use PlannerWeb, :view
  alias PlannerWeb.FriendshipView
  alias PlannerWeb.UserView

  def render("index.json", %{friendships: friendships}) do
    %{data: render_many(friendships, FriendshipView, "friendship.json")}
  end

  def render("show.json", %{friendship: friendship}) do
    %{data: render_one(friendship, FriendshipView, "friendship.json")}
  end

  def render("friendship.json", %{friendship: friendship}) do
    %{friend: render_one(friendship.friend, UserView, "user.json")}
  end
end
