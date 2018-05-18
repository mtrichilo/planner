defmodule Planner.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias Planner.Repo

  alias Planner.Accounts.User

  @doc """
  Returns the list of users.

  ## Examples

      iex> list_users()
      [%User{}, ...]

  """
  def list_users do
    Repo.all(User)
  end

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_user!(456)
      ** (Ecto.NoResultsError)

  """
  def get_user!(id), do: Repo.get!(User, id)

  @doc """
  Gets a single user by the given email.

  """
  def get_user_by_email!(email) do
    Repo.get_by!(User, email: email)
  end

  @doc """
  Gets a single user by the given username.

  """
  def get_user_by_user_name!(user_name) do
    Repo.get_by!(User, user_name: user_name)
  end

  @doc """
  Creates a user.

  ## Examples

      iex> create_user(%{field: value})
      {:ok, %User{}}

      iex> create_user(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user.

  ## Examples

      iex> update_user(user, %{field: new_value})
      {:ok, %User{}}

      iex> update_user(user, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a User.

  ## Examples

      iex> delete_user(user)
      {:ok, %User{}}

      iex> delete_user(user)
      {:error, %Ecto.Changeset{}}

  """
  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking user changes.

  ## Examples

      iex> change_user(user)
      %Ecto.Changeset{source: %User{}}

  """
  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  alias Planner.Accounts.Friendship

  @doc """
  Returns the list of friendships.

  ## Examples

      iex> list_friendships()
      [%Friendship{}, ...]

  """
  def list_friendships do
    Repo.all(Friendship)
    |> Repo.preload(:friend)
  end

  @doc """
  Returns a list of friendships for the given user.

  """
  def list_friendships(user_id) do
    Repo.all(from f in Friendship, where: f.user_id == ^user_id)
    |> Repo.preload(:friend)
  end

  @doc """
  Gets a single friendship.

  Raises `Ecto.NoResultsError` if the Friendship does not exist.

  ## Examples

      iex> get_friendship!(123, 231)
      %Friendship{}

      iex> get_friendship!(456, 564)
      ** (Ecto.NoResultsError)

  """
  def get_friendship!(user_id, friend_id) do 
    Repo.get_by!(Friendship, user_id: user_id, friend_id: friend_id)
    |> Repo.preload(:friend)
  end

  @doc """
  Creates a friendship.

  ## Examples

      iex> create_friendship(%{field: value})
      {:ok, %Friendship{}}

      iex> create_friendship(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_friendship(attrs) do
    Repo.transaction(fn ->
      with %{"user_id" => user_id, "friend_id" => friend_id} <- attrs do
        %Friendship{}
        |> Friendship.changeset(attrs)
        |> Repo.insert()

        %Friendship{}
        |> Friendship.changeset(%{"user_id" => friend_id, "friend_id" => user_id})
        |> Repo.insert()
      end
    end)
  end

  @doc """
  Deletes a Friendship.

  ## Examples

      iex> delete_friendship(user_id, friend_id)
      {:ok, %Friendship{}}

      iex> delete_friendship(user_id, friend_id)
      {:error, %Ecto.Changeset{}}

  """
  def delete_friendship(user_id, friend_id) do
    Repo.transaction(fn ->
      get_friendship!(user_id, friend_id)
      |> Repo.delete()
      
      get_friendship!(friend_id, user_id)
      |> Repo.delete()
    end)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking friendship changes.

  ## Examples

      iex> change_friendship(friendship)
      %Ecto.Changeset{source: %Friendship{}}

  """
  def change_friendship(%Friendship{} = friendship) do
    Friendship.changeset(friendship, %{})
  end
end
