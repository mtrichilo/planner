defmodule PlannerWeb.MessageView do
  use PlannerWeb, :view
  alias PlannerWeb.MessageView

  def render("index.json", %{messages: messages}) do
    %{data: render_many(messages, MessageView, "message.json")}
  end

  def render("show.json", %{message: message}) do
    %{data: render_one(message, MessageView, "message.json")}
  end

  def render("message.json", %{message: message}) do
    %{id: message.id,
      timestamp: message.timestamp,
      message: message.message,
      event_id: message.event_id,
      user_id: message.user_id}
  end
end
