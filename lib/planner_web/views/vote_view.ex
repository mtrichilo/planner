defmodule PlannerWeb.VoteView do
  use PlannerWeb, :view
  alias PlannerWeb.VoteView

  def render("index.json", %{poll_votes: poll_votes}) do
    %{data: render_many(poll_votes, VoteView, "vote.json")}
  end

  def render("show.json", %{vote: vote}) do
    %{data: render_one(vote, VoteView, "vote.json")}
  end

  def render("vote.json", %{vote: vote}) do
    %{poll_id: vote.poll_id,
      user_id: vote.user_id,
      option_id: vote.option_id}
  end
end
