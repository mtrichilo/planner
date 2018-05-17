defmodule PlannerWeb.Router do
  use PlannerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", PlannerWeb do
    pipe_through :api
    resources "/users", UserController, except: [:new, :edit]
  end
end
