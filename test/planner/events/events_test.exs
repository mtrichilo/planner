defmodule Planner.EventsTest do
  use Planner.DataCase

  alias Planner.Events

  describe "events" do
    alias Planner.Events.Event

    @valid_attrs %{description: "some description", image: "some image", message: "some message", name: "some name", private: true}
    @update_attrs %{description: "some updated description", image: "some updated image", message: "some updated message", name: "some updated name", private: false}
    @invalid_attrs %{description: nil, image: nil, message: nil, name: nil, private: nil}

    def event_fixture(attrs \\ %{}) do
      {:ok, event} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_event()

      event
    end

    test "list_events/0 returns all events" do
      event = event_fixture()
      assert Events.list_events() == [event]
    end

    test "get_event!/1 returns the event with given id" do
      event = event_fixture()
      assert Events.get_event!(event.id) == event
    end

    test "create_event/1 with valid data creates a event" do
      assert {:ok, %Event{} = event} = Events.create_event(@valid_attrs)
      assert event.description == "some description"
      assert event.image == "some image"
      assert event.message == "some message"
      assert event.name == "some name"
      assert event.private == true
    end

    test "create_event/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_event(@invalid_attrs)
    end

    test "update_event/2 with valid data updates the event" do
      event = event_fixture()
      assert {:ok, event} = Events.update_event(event, @update_attrs)
      assert %Event{} = event
      assert event.description == "some updated description"
      assert event.image == "some updated image"
      assert event.message == "some updated message"
      assert event.name == "some updated name"
      assert event.private == false
    end

    test "update_event/2 with invalid data returns error changeset" do
      event = event_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_event(event, @invalid_attrs)
      assert event == Events.get_event!(event.id)
    end

    test "delete_event/1 deletes the event" do
      event = event_fixture()
      assert {:ok, %Event{}} = Events.delete_event(event)
      assert_raise Ecto.NoResultsError, fn -> Events.get_event!(event.id) end
    end

    test "change_event/1 returns a event changeset" do
      event = event_fixture()
      assert %Ecto.Changeset{} = Events.change_event(event)
    end
  end

  describe "event_times" do
    alias Planner.Events.Time

    @valid_attrs %{end_date: ~D[2010-04-17], end_time: ~T[14:00:00.000000], generalize_start: true, start_date: ~D[2010-04-17], start_time: ~T[14:00:00.000000]}
    @update_attrs %{end_date: ~D[2011-05-18], end_time: ~T[15:01:01.000000], generalize_start: false, start_date: ~D[2011-05-18], start_time: ~T[15:01:01.000000]}
    @invalid_attrs %{end_date: nil, end_time: nil, generalize_start: nil, start_date: nil, start_time: nil}

    def time_fixture(attrs \\ %{}) do
      {:ok, time} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_time()

      time
    end

    test "list_event_times/0 returns all event_times" do
      time = time_fixture()
      assert Events.list_event_times() == [time]
    end

    test "get_time!/1 returns the time with given id" do
      time = time_fixture()
      assert Events.get_time!(time.id) == time
    end

    test "create_time/1 with valid data creates a time" do
      assert {:ok, %Time{} = time} = Events.create_time(@valid_attrs)
      assert time.end_date == ~D[2010-04-17]
      assert time.end_time == ~T[14:00:00.000000]
      assert time.generalize_start == true
      assert time.start_date == ~D[2010-04-17]
      assert time.start_time == ~T[14:00:00.000000]
    end

    test "create_time/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_time(@invalid_attrs)
    end

    test "update_time/2 with valid data updates the time" do
      time = time_fixture()
      assert {:ok, time} = Events.update_time(time, @update_attrs)
      assert %Time{} = time
      assert time.end_date == ~D[2011-05-18]
      assert time.end_time == ~T[15:01:01.000000]
      assert time.generalize_start == false
      assert time.start_date == ~D[2011-05-18]
      assert time.start_time == ~T[15:01:01.000000]
    end

    test "update_time/2 with invalid data returns error changeset" do
      time = time_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_time(time, @invalid_attrs)
      assert time == Events.get_time!(time.id)
    end

    test "delete_time/1 deletes the time" do
      time = time_fixture()
      assert {:ok, %Time{}} = Events.delete_time(time)
      assert_raise Ecto.NoResultsError, fn -> Events.get_time!(time.id) end
    end

    test "change_time/1 returns a time changeset" do
      time = time_fixture()
      assert %Ecto.Changeset{} = Events.change_time(time)
    end
  end

  describe "event_locations" do
    alias Planner.Events.Location

    @valid_attrs %{city: "some city", name: "some name", state: "some state", street: "some street", zip_code: "some zip_code"}
    @update_attrs %{city: "some updated city", name: "some updated name", state: "some updated state", street: "some updated street", zip_code: "some updated zip_code"}
    @invalid_attrs %{city: nil, name: nil, state: nil, street: nil, zip_code: nil}

    def location_fixture(attrs \\ %{}) do
      {:ok, location} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_location()

      location
    end

    test "list_event_locations/0 returns all event_locations" do
      location = location_fixture()
      assert Events.list_event_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      location = location_fixture()
      assert Events.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      assert {:ok, %Location{} = location} = Events.create_location(@valid_attrs)
      assert location.city == "some city"
      assert location.name == "some name"
      assert location.state == "some state"
      assert location.street == "some street"
      assert location.zip_code == "some zip_code"
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      location = location_fixture()
      assert {:ok, location} = Events.update_location(location, @update_attrs)
      assert %Location{} = location
      assert location.city == "some updated city"
      assert location.name == "some updated name"
      assert location.state == "some updated state"
      assert location.street == "some updated street"
      assert location.zip_code == "some updated zip_code"
    end

    test "update_location/2 with invalid data returns error changeset" do
      location = location_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_location(location, @invalid_attrs)
      assert location == Events.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      location = location_fixture()
      assert {:ok, %Location{}} = Events.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Events.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      location = location_fixture()
      assert %Ecto.Changeset{} = Events.change_location(location)
    end
  end

  describe "event_guests" do
    alias Planner.Events.Guest

    @valid_attrs %{}
    @update_attrs %{}
    @invalid_attrs %{}

    def guest_fixture(attrs \\ %{}) do
      {:ok, guest} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Events.create_guest()

      guest
    end

    test "list_event_guests/0 returns all event_guests" do
      guest = guest_fixture()
      assert Events.list_event_guests() == [guest]
    end

    test "get_guest!/1 returns the guest with given id" do
      guest = guest_fixture()
      assert Events.get_guest!(guest.id) == guest
    end

    test "create_guest/1 with valid data creates a guest" do
      assert {:ok, %Guest{} = guest} = Events.create_guest(@valid_attrs)
    end

    test "create_guest/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Events.create_guest(@invalid_attrs)
    end

    test "update_guest/2 with valid data updates the guest" do
      guest = guest_fixture()
      assert {:ok, guest} = Events.update_guest(guest, @update_attrs)
      assert %Guest{} = guest
    end

    test "update_guest/2 with invalid data returns error changeset" do
      guest = guest_fixture()
      assert {:error, %Ecto.Changeset{}} = Events.update_guest(guest, @invalid_attrs)
      assert guest == Events.get_guest!(guest.id)
    end

    test "delete_guest/1 deletes the guest" do
      guest = guest_fixture()
      assert {:ok, %Guest{}} = Events.delete_guest(guest)
      assert_raise Ecto.NoResultsError, fn -> Events.get_guest!(guest.id) end
    end

    test "change_guest/1 returns a guest changeset" do
      guest = guest_fixture()
      assert %Ecto.Changeset{} = Events.change_guest(guest)
    end
  end
end
