defmodule PlannerWeb.UserView do
  use PlannerWeb, :view
  alias PlannerWeb.UserView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      email: user.email,
      user_name: user.user_name,
      password_hash: user.password_hash,
      first_name: user.first_name,
      last_name: user.last_name,
      image: user.image}
  end
end
