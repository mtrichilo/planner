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
    resources "/friendships", FriendshipController, only: [:show, :create, :delete]
    resources "/events", EventController, except: [:new, :edit]
  end
end
