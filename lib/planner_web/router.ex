defmodule PlannerWeb.Router do
  use PlannerWeb, :router

  alias PlannerWeb.Plugs

  pipeline :api do
    plug :accepts, ["json"]
    # plug Plugs.AuthenticateToken
  end

  scope "/planner/api/v1", PlannerWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
    get "/friendships/:user_id", FriendshipController, :index
    post "/friendships", FriendshipController, :create
    delete "/friendships", FriendshipController, :delete
  end
end
