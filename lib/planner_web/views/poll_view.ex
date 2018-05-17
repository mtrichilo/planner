defmodule PlannerWeb.PollView do
  use PlannerWeb, :view
  alias PlannerWeb.PollView
  alias PlannerWeb.VoteView

  def render("index.json", %{polls: polls}) do
    %{data: render_many(polls, PollView, "poll.json")}
  end

  def render("show.json", %{poll: poll}) do
    %{data: render_one(poll, PollView, "poll.json")}
  end

  def render("poll.json", %{poll: poll}) do
    %{id: poll.id,
      multiple_votes: poll.multiple_votes,
      allow_others: poll.allow_others,
      votes: render_many(poll.votes, VoteView, "vote.json")}
  end

  def render("poll_basic.json", %{poll: poll}) do
    %{id: poll.id}
  end
end
