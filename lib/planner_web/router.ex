defmodule PlannerWeb.Router do
  use PlannerWeb, :router

  alias PlannerWeb.Plugs

  pipeline :authorization do
    plug Plugs.AuthorizeToken
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/planner/api/v1", PlannerWeb do
    pipe_through :api
      post "/register", AuthorizationController, :register
      post "/login", AuthorizationController, :login
  end

  scope "/planner/api/v1", PlannerWeb do
    pipe_through [:authorization, :api]
      resources "/users", UserController, except: [:create, :new, :edit]   
      resources "/friendships", FriendshipController, only: [:index, :create, :delete]
      resources "/events", EventController, except: [:new, :edit]
      resources "/event_times", TimeController, only: [:create, :update, :delete]
      resources "/event_locations", LocationController, only: [:create, :update, :delete]
      resources "/event_guests", GuestController, only: [:create, :delete]
      resources "/poll_fields", FieldController, only: [:index]
      resources "/polls", PollController, except: [:new, :edit]
      resources "/poll_votes", VoteController, only: [:create, :delete]
      get "/messages/:event_id", MessageController, :index
      resources "/messages", MessageController, only: [:create, :update, :delete]
  end
end
