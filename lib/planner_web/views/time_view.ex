defmodule PlannerWeb.TimeView do
  use PlannerWeb, :view
  alias PlannerWeb.TimeView

  def render("index.json", %{event_times: event_times}) do
    %{data: render_many(event_times, TimeView, "time.json")}
  end

  def render("show.json", %{time: time}) do
    %{data: render_one(time, TimeView, "time.json")}
  end

  def render("time.json", %{time: time}) do
    %{id: time.id,
      start_date: time.start_date,
      start_time: time.start_time,
      end_date: time.end_date,
      end_time: time.end_time,
      generalize_start: time.generalize_start}
  end
end
