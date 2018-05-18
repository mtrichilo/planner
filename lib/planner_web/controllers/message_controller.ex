defmodule PlannerWeb.MessageController do
  use PlannerWeb, :controller

  alias Planner.Messaging
  alias Planner.Messaging.Message

  action_fallback PlannerWeb.FallbackController

  def index(conn, %{"event_id" => event_id}) do
    messages = Messaging.list_messages(event_id)
    render(conn, "index.json", messages: messages)
  end

  def create(conn, %{"message" => message_params}) do
    with {:ok, %Message{}} <- Messaging.create_message(message_params) do
      conn
      |> put_status(:created)
      |> send_resp(:no_content, "")
    end
  end

  def update(conn, %{"id" => id, "message" => message_params}) do
    message = Messaging.get_message!(id)

    with {:ok, %Message{} = message} <- Messaging.update_message(message, message_params) do
      render(conn, "show.json", message: message)
    end
  end

  def delete(conn, %{"id" => id}) do
    message = Messaging.get_message!(id)
    with {:ok, %Message{}} <- Messaging.delete_message(message) do
      send_resp(conn, :no_content, "")
    end
  end
end
