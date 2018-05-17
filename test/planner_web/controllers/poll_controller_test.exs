defmodule PlannerWeb.PollControllerTest do
  use PlannerWeb.ConnCase

  alias Planner.Polling
  alias Planner.Polling.Poll

  @create_attrs %{allow_others: true, multiple_votes: true}
  @update_attrs %{allow_others: false, multiple_votes: false}
  @invalid_attrs %{allow_others: nil, multiple_votes: nil}

  def fixture(:poll) do
    {:ok, poll} = Polling.create_poll(@create_attrs)
    poll
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all polls", %{conn: conn} do
      conn = get conn, poll_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create poll" do
    test "renders poll when data is valid", %{conn: conn} do
      conn = post conn, poll_path(conn, :create), poll: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, poll_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "allow_others" => true,
        "multiple_votes" => true}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, poll_path(conn, :create), poll: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update poll" do
    setup [:create_poll]

    test "renders poll when data is valid", %{conn: conn, poll: %Poll{id: id} = poll} do
      conn = put conn, poll_path(conn, :update, poll), poll: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, poll_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "allow_others" => false,
        "multiple_votes" => false}
    end

    test "renders errors when data is invalid", %{conn: conn, poll: poll} do
      conn = put conn, poll_path(conn, :update, poll), poll: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete poll" do
    setup [:create_poll]

    test "deletes chosen poll", %{conn: conn, poll: poll} do
      conn = delete conn, poll_path(conn, :delete, poll)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, poll_path(conn, :show, poll)
      end
    end
  end

  defp create_poll(_) do
    poll = fixture(:poll)
    {:ok, poll: poll}
  end
end
