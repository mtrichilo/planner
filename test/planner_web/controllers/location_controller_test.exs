defmodule PlannerWeb.LocationControllerTest do
  use PlannerWeb.ConnCase

  alias Planner.Events
  alias Planner.Events.Location

  @create_attrs %{city: "some city", name: "some name", state: "some state", street: "some street", zip_code: "some zip_code"}
  @update_attrs %{city: "some updated city", name: "some updated name", state: "some updated state", street: "some updated street", zip_code: "some updated zip_code"}
  @invalid_attrs %{city: nil, name: nil, state: nil, street: nil, zip_code: nil}

  def fixture(:location) do
    {:ok, location} = Events.create_location(@create_attrs)
    location
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all event_locations", %{conn: conn} do
      conn = get conn, location_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create location" do
    test "renders location when data is valid", %{conn: conn} do
      conn = post conn, location_path(conn, :create), location: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, location_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "city" => "some city",
        "name" => "some name",
        "state" => "some state",
        "street" => "some street",
        "zip_code" => "some zip_code"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, location_path(conn, :create), location: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update location" do
    setup [:create_location]

    test "renders location when data is valid", %{conn: conn, location: %Location{id: id} = location} do
      conn = put conn, location_path(conn, :update, location), location: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, location_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "city" => "some updated city",
        "name" => "some updated name",
        "state" => "some updated state",
        "street" => "some updated street",
        "zip_code" => "some updated zip_code"}
    end

    test "renders errors when data is invalid", %{conn: conn, location: location} do
      conn = put conn, location_path(conn, :update, location), location: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete location" do
    setup [:create_location]

    test "deletes chosen location", %{conn: conn, location: location} do
      conn = delete conn, location_path(conn, :delete, location)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, location_path(conn, :show, location)
      end
    end
  end

  defp create_location(_) do
    location = fixture(:location)
    {:ok, location: location}
  end
end
