defmodule Planner.PollingTest do
  use Planner.DataCase

  alias Planner.Polling

  describe "poll_fields" do
    alias Planner.Polling.Field

    @valid_attrs %{field_name: "some field_name"}
    @update_attrs %{field_name: "some updated field_name"}
    @invalid_attrs %{field_name: nil}

    def field_fixture(attrs \\ %{}) do
      {:ok, field} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polling.create_field()

      field
    end

    test "list_poll_fields/0 returns all poll_fields" do
      field = field_fixture()
      assert Polling.list_poll_fields() == [field]
    end

    test "get_field!/1 returns the field with given id" do
      field = field_fixture()
      assert Polling.get_field!(field.id) == field
    end

    test "create_field/1 with valid data creates a field" do
      assert {:ok, %Field{} = field} = Polling.create_field(@valid_attrs)
      assert field.field_name == "some field_name"
    end

    test "create_field/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polling.create_field(@invalid_attrs)
    end

    test "update_field/2 with valid data updates the field" do
      field = field_fixture()
      assert {:ok, field} = Polling.update_field(field, @update_attrs)
      assert %Field{} = field
      assert field.field_name == "some updated field_name"
    end

    test "update_field/2 with invalid data returns error changeset" do
      field = field_fixture()
      assert {:error, %Ecto.Changeset{}} = Polling.update_field(field, @invalid_attrs)
      assert field == Polling.get_field!(field.id)
    end

    test "delete_field/1 deletes the field" do
      field = field_fixture()
      assert {:ok, %Field{}} = Polling.delete_field(field)
      assert_raise Ecto.NoResultsError, fn -> Polling.get_field!(field.id) end
    end

    test "change_field/1 returns a field changeset" do
      field = field_fixture()
      assert %Ecto.Changeset{} = Polling.change_field(field)
    end
  end
end
