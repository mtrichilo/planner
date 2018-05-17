defmodule PlannerWeb.FieldController do
  use PlannerWeb, :controller

  alias Planner.Polling

  action_fallback PlannerWeb.FallbackController

  def index(conn, _params) do
    poll_fields = Polling.list_poll_fields()
    render(conn, "index.json", poll_fields: poll_fields)
  end
end
