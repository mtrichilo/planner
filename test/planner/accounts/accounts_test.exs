defmodule Planner.AccountsTest do
  use Planner.DataCase

  alias Planner.Accounts

  describe "users" do
    alias Planner.Accounts.User

    @valid_attrs %{email: "some email", first_name: "some first_name", image: "some image", last_name: "some last_name", password_hash: "some password_hash", user_name: "some user_name"}
    @update_attrs %{email: "some updated email", first_name: "some updated first_name", image: "some updated image", last_name: "some updated last_name", password_hash: "some updated password_hash", user_name: "some updated user_name"}
    @invalid_attrs %{email: nil, first_name: nil, image: nil, last_name: nil, password_hash: nil, user_name: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_user()

      user
    end

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Accounts.create_user(@valid_attrs)
      assert user.email == "some email"
      assert user.first_name == "some first_name"
      assert user.image == "some image"
      assert user.last_name == "some last_name"
      assert user.password_hash == "some password_hash"
      assert user.user_name == "some user_name"
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, user} = Accounts.update_user(user, @update_attrs)
      assert %User{} = user
      assert user.email == "some updated email"
      assert user.first_name == "some updated first_name"
      assert user.image == "some updated image"
      assert user.last_name == "some updated last_name"
      assert user.password_hash == "some updated password_hash"
      assert user.user_name == "some updated user_name"
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "friendships" do
    alias Planner.Accounts.Friendship

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def friendship_fixture(attrs \\ %{}) do
      {:ok, friendship} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Accounts.create_friendship()

      friendship
    end

    test "list_friendships/0 returns all friendships" do
      friendship = friendship_fixture()
      assert Accounts.list_friendships() == [friendship]
    end

    test "get_friendship!/1 returns the friendship with given id" do
      friendship = friendship_fixture()
      assert Accounts.get_friendship!(friendship.id) == friendship
    end

    test "create_friendship/1 with valid data creates a friendship" do
      assert {:ok, %Friendship{} = friendship} = Accounts.create_friendship(@valid_attrs)
    end

    test "create_friendship/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_friendship(@invalid_attrs)
    end

    test "update_friendship/2 with valid data updates the friendship" do
      friendship = friendship_fixture()
      assert {:ok, friendship} = Accounts.update_friendship(friendship, @update_attrs)
      assert %Friendship{} = friendship
    end

    test "update_friendship/2 with invalid data returns error changeset" do
      friendship = friendship_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_friendship(friendship, @invalid_attrs)
      assert friendship == Accounts.get_friendship!(friendship.id)
    end

    test "delete_friendship/1 deletes the friendship" do
      friendship = friendship_fixture()
      assert {:ok, %Friendship{}} = Accounts.delete_friendship(friendship)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_friendship!(friendship.id) end
    end

    test "change_friendship/1 returns a friendship changeset" do
      friendship = friendship_fixture()
      assert %Ecto.Changeset{} = Accounts.change_friendship(friendship)
    end
  end
end
