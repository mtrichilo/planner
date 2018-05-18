defmodule PlannerWeb.AuthorizationController do
  use PlannerWeb, :controller

  alias Planner.Accounts
  alias Planner.Accounts.User

  def login(conn, %{"login" => %{"email" => email, "password" => password}}) do
    user = Accounts.get_user_by_email!(email)
    login(conn, user, password)
  end

  def login(conn, %{"login" => %{"user_name" => user_name, "password" => password}}) do
    user = Accounts.get_user_by_user_name!(user_name)
    login(conn, user, password)
  end

  defp login(conn, user = %User{}, password) do
    with {:ok, user} <- Comeonin.Argon2.check_pass(user, password) do
      token = Phoenix.Token.sign(conn, "authorization", user.id)
      conn
      |> put_status(:created)
      |> render("show.json", authorization: token)
    end
  end
end
