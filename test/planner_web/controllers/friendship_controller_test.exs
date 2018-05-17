defmodule PlannerWeb.FriendshipControllerTest do
  use PlannerWeb.ConnCase

  alias Planner.Accounts
  alias Planner.Accounts.Friendship

  @create_attrs %{}
  @update_attrs %{}
  @invalid_attrs %{}

  def fixture(:friendship) do
    {:ok, friendship} = Accounts.create_friendship(@create_attrs)
    friendship
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all friendships", %{conn: conn} do
      conn = get conn, friendship_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create friendship" do
    test "renders friendship when data is valid", %{conn: conn} do
      conn = post conn, friendship_path(conn, :create), friendship: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, friendship_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, friendship_path(conn, :create), friendship: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update friendship" do
    setup [:create_friendship]

    test "renders friendship when data is valid", %{conn: conn, friendship: %Friendship{id: id} = friendship} do
      conn = put conn, friendship_path(conn, :update, friendship), friendship: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, friendship_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id}
    end

    test "renders errors when data is invalid", %{conn: conn, friendship: friendship} do
      conn = put conn, friendship_path(conn, :update, friendship), friendship: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete friendship" do
    setup [:create_friendship]

    test "deletes chosen friendship", %{conn: conn, friendship: friendship} do
      conn = delete conn, friendship_path(conn, :delete, friendship)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, friendship_path(conn, :show, friendship)
      end
    end
  end

  defp create_friendship(_) do
    friendship = fixture(:friendship)
    {:ok, friendship: friendship}
  end
end
