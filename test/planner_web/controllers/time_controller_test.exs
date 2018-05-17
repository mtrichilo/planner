defmodule PlannerWeb.TimeControllerTest do
  use PlannerWeb.ConnCase

  alias Planner.Events
  alias Planner.Events.Time

  @create_attrs %{end_date: ~D[2010-04-17], end_time: ~T[14:00:00.000000], generalize_start: true, start_date: ~D[2010-04-17], start_time: ~T[14:00:00.000000]}
  @update_attrs %{end_date: ~D[2011-05-18], end_time: ~T[15:01:01.000000], generalize_start: false, start_date: ~D[2011-05-18], start_time: ~T[15:01:01.000000]}
  @invalid_attrs %{end_date: nil, end_time: nil, generalize_start: nil, start_date: nil, start_time: nil}

  def fixture(:time) do
    {:ok, time} = Events.create_time(@create_attrs)
    time
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all event_times", %{conn: conn} do
      conn = get conn, time_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create time" do
    test "renders time when data is valid", %{conn: conn} do
      conn = post conn, time_path(conn, :create), time: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, time_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_date" => ~D[2010-04-17],
        "end_time" => ~T[14:00:00.000000],
        "generalize_start" => true,
        "start_date" => ~D[2010-04-17],
        "start_time" => ~T[14:00:00.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, time_path(conn, :create), time: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update time" do
    setup [:create_time]

    test "renders time when data is valid", %{conn: conn, time: %Time{id: id} = time} do
      conn = put conn, time_path(conn, :update, time), time: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, time_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "end_date" => ~D[2011-05-18],
        "end_time" => ~T[15:01:01.000000],
        "generalize_start" => false,
        "start_date" => ~D[2011-05-18],
        "start_time" => ~T[15:01:01.000000]}
    end

    test "renders errors when data is invalid", %{conn: conn, time: time} do
      conn = put conn, time_path(conn, :update, time), time: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete time" do
    setup [:create_time]

    test "deletes chosen time", %{conn: conn, time: time} do
      conn = delete conn, time_path(conn, :delete, time)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, time_path(conn, :show, time)
      end
    end
  end

  defp create_time(_) do
    time = fixture(:time)
    {:ok, time: time}
  end
end
