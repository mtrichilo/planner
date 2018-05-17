defmodule PlannerWeb.FieldControllerTest do
  use PlannerWeb.ConnCase

  alias Planner.Polling
  alias Planner.Polling.Field

  @create_attrs %{field_name: "some field_name"}
  @update_attrs %{field_name: "some updated field_name"}
  @invalid_attrs %{field_name: nil}

  def fixture(:field) do
    {:ok, field} = Polling.create_field(@create_attrs)
    field
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all poll_fields", %{conn: conn} do
      conn = get conn, field_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create field" do
    test "renders field when data is valid", %{conn: conn} do
      conn = post conn, field_path(conn, :create), field: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, field_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "field_name" => "some field_name"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, field_path(conn, :create), field: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update field" do
    setup [:create_field]

    test "renders field when data is valid", %{conn: conn, field: %Field{id: id} = field} do
      conn = put conn, field_path(conn, :update, field), field: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, field_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "field_name" => "some updated field_name"}
    end

    test "renders errors when data is invalid", %{conn: conn, field: field} do
      conn = put conn, field_path(conn, :update, field), field: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete field" do
    setup [:create_field]

    test "deletes chosen field", %{conn: conn, field: field} do
      conn = delete conn, field_path(conn, :delete, field)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, field_path(conn, :show, field)
      end
    end
  end

  defp create_field(_) do
    field = fixture(:field)
    {:ok, field: field}
  end
end
