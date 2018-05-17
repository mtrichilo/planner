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

  describe "polls" do
    alias Planner.Polling.Poll

    @valid_attrs %{allow_others: true, multiple_votes: true}
    @update_attrs %{allow_others: false, multiple_votes: false}
    @invalid_attrs %{allow_others: nil, multiple_votes: nil}

    def poll_fixture(attrs \\ %{}) do
      {:ok, poll} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polling.create_poll()

      poll
    end

    test "list_polls/0 returns all polls" do
      poll = poll_fixture()
      assert Polling.list_polls() == [poll]
    end

    test "get_poll!/1 returns the poll with given id" do
      poll = poll_fixture()
      assert Polling.get_poll!(poll.id) == poll
    end

    test "create_poll/1 with valid data creates a poll" do
      assert {:ok, %Poll{} = poll} = Polling.create_poll(@valid_attrs)
      assert poll.allow_others == true
      assert poll.multiple_votes == true
    end

    test "create_poll/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polling.create_poll(@invalid_attrs)
    end

    test "update_poll/2 with valid data updates the poll" do
      poll = poll_fixture()
      assert {:ok, poll} = Polling.update_poll(poll, @update_attrs)
      assert %Poll{} = poll
      assert poll.allow_others == false
      assert poll.multiple_votes == false
    end

    test "update_poll/2 with invalid data returns error changeset" do
      poll = poll_fixture()
      assert {:error, %Ecto.Changeset{}} = Polling.update_poll(poll, @invalid_attrs)
      assert poll == Polling.get_poll!(poll.id)
    end

    test "delete_poll/1 deletes the poll" do
      poll = poll_fixture()
      assert {:ok, %Poll{}} = Polling.delete_poll(poll)
      assert_raise Ecto.NoResultsError, fn -> Polling.get_poll!(poll.id) end
    end

    test "change_poll/1 returns a poll changeset" do
      poll = poll_fixture()
      assert %Ecto.Changeset{} = Polling.change_poll(poll)
    end
  end

  describe "poll_votes" do
    alias Planner.Polling.Vote

    @valid_attrs %{option_id: 42}
    @update_attrs %{option_id: 43}
    @invalid_attrs %{option_id: nil}

    def vote_fixture(attrs \\ %{}) do
      {:ok, vote} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Polling.create_vote()

      vote
    end

    test "list_poll_votes/0 returns all poll_votes" do
      vote = vote_fixture()
      assert Polling.list_poll_votes() == [vote]
    end

    test "get_vote!/1 returns the vote with given id" do
      vote = vote_fixture()
      assert Polling.get_vote!(vote.id) == vote
    end

    test "create_vote/1 with valid data creates a vote" do
      assert {:ok, %Vote{} = vote} = Polling.create_vote(@valid_attrs)
      assert vote.option_id == 42
    end

    test "create_vote/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Polling.create_vote(@invalid_attrs)
    end

    test "update_vote/2 with valid data updates the vote" do
      vote = vote_fixture()
      assert {:ok, vote} = Polling.update_vote(vote, @update_attrs)
      assert %Vote{} = vote
      assert vote.option_id == 43
    end

    test "update_vote/2 with invalid data returns error changeset" do
      vote = vote_fixture()
      assert {:error, %Ecto.Changeset{}} = Polling.update_vote(vote, @invalid_attrs)
      assert vote == Polling.get_vote!(vote.id)
    end

    test "delete_vote/1 deletes the vote" do
      vote = vote_fixture()
      assert {:ok, %Vote{}} = Polling.delete_vote(vote)
      assert_raise Ecto.NoResultsError, fn -> Polling.get_vote!(vote.id) end
    end

    test "change_vote/1 returns a vote changeset" do
      vote = vote_fixture()
      assert %Ecto.Changeset{} = Polling.change_vote(vote)
    end
  end
end
