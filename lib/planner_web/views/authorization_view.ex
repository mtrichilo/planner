defmodule PlannerWeb.AuthorizationView do
  use PlannerWeb, :view
  alias PlannerWeb.AuthorizationView

  def render("show.json", %{authorization: token}) do
    %{data: render_one(token, AuthorizationView, "authorization.json")}
  end

  def render("authorization.json", %{authorization: token}) do
    %{authorization: token}
  end
end
