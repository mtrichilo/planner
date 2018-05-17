defmodule Planner.Polling do
  @moduledoc """
  The Polling context.
  """

  import Ecto.Query, warn: false
  alias Planner.Repo

  alias Planner.Polling.Field

  @doc """
  Returns the list of poll_fields.

  ## Examples

      iex> list_poll_fields()
      [%Field{}, ...]

  """
  def list_poll_fields do
    Repo.all(Field)
  end

  @doc """
  Gets a single field.

  Raises `Ecto.NoResultsError` if the Field does not exist.

  ## Examples

      iex> get_field!(123)
      %Field{}

      iex> get_field!(456)
      ** (Ecto.NoResultsError)

  """
  def get_field!(id), do: Repo.get!(Field, id)

  @doc """
  Creates a field.

  ## Examples

      iex> create_field(%{field: value})
      {:ok, %Field{}}

      iex> create_field(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_field(attrs \\ %{}) do
    %Field{}
    |> Field.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a field.

  ## Examples

      iex> update_field(field, %{field: new_value})
      {:ok, %Field{}}

      iex> update_field(field, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_field(%Field{} = field, attrs) do
    field
    |> Field.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Field.

  ## Examples

      iex> delete_field(field)
      {:ok, %Field{}}

      iex> delete_field(field)
      {:error, %Ecto.Changeset{}}

  """
  def delete_field(%Field{} = field) do
    Repo.delete(field)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking field changes.

  ## Examples

      iex> change_field(field)
      %Ecto.Changeset{source: %Field{}}

  """
  def change_field(%Field{} = field) do
    Field.changeset(field, %{})
  end

  alias Planner.Polling.Poll

  @doc """
  Returns the list of polls.

  ## Examples

      iex> list_polls()
      [%Poll{}, ...]

  """
  def list_polls do
    Repo.all(Poll)
    |> Repo.preload(:votes)
  end

  @doc """
  Gets a single poll.

  Raises `Ecto.NoResultsError` if the Poll does not exist.

  ## Examples

      iex> get_poll!(123)
      %Poll{}

      iex> get_poll!(456)
      ** (Ecto.NoResultsError)

  """
  def get_poll!(id) do 
    Repo.get!(Poll, id)
    |> Repo.preload(:votes)
  end

  @doc """
  Creates a poll.

  ## Examples

      iex> create_poll(%{field: value})
      {:ok, %Poll{}}

      iex> create_poll(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_poll(attrs \\ %{}) do
    %Poll{}
    |> Poll.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a poll.

  ## Examples

      iex> update_poll(poll, %{field: new_value})
      {:ok, %Poll{}}

      iex> update_poll(poll, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_poll(%Poll{} = poll, attrs) do
    poll
    |> Poll.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Poll.

  ## Examples

      iex> delete_poll(poll)
      {:ok, %Poll{}}

      iex> delete_poll(poll)
      {:error, %Ecto.Changeset{}}

  """
  def delete_poll(%Poll{} = poll) do
    Repo.delete(poll)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking poll changes.

  ## Examples

      iex> change_poll(poll)
      %Ecto.Changeset{source: %Poll{}}

  """
  def change_poll(%Poll{} = poll) do
    Poll.changeset(poll, %{})
  end

  alias Planner.Polling.Vote

  @doc """
  Returns the list of poll_votes.

  ## Examples

      iex> list_poll_votes()
      [%Vote{}, ...]

  """
  def list_poll_votes do
    Repo.all(Vote)
  end

  @doc """
  Returns a list of poll_votes for the given poll.

  """
  def list_poll_votes(poll_id) do
    Repo.all(from v in Vote, where: v.poll_id == ^poll_id)
  end

  @doc """
  Gets a single vote.

  Raises `Ecto.NoResultsError` if the Vote does not exist.

  ## Examples

      iex> get_vote!(123, 231, 312)
      %Vote{}

      iex> get_vote!(456, 564, 645)
      ** (Ecto.NoResultsError)

  """
  def get_vote!(poll_id, user_id, option_id) do
    Repo.get_by!(Vote, poll_id: poll_id, user_id: user_id, option_id: option_id)
  end

  @doc """
  Creates a vote.

  ## Examples

      iex> create_vote(%{field: value})
      {:ok, %Vote{}}

      iex> create_vote(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_vote(attrs \\ %{}) do
    %Vote{}
    |> Vote.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a vote.

  ## Examples

      iex> update_vote(vote, %{field: new_value})
      {:ok, %Vote{}}

      iex> update_vote(vote, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_vote(%Vote{} = vote, attrs) do
    vote
    |> Vote.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Vote.

  ## Examples

      iex> delete_vote(poll_id, user_id, option_id)
      {:ok, %Vote{}}

      iex> delete_vote(poll_id, user_id, option_id)
      {:error, %Ecto.Changeset{}}

  """
  def delete_vote(poll_id, user_id, option_id) do
    get_vote!(poll_id, user_id, option_id)
    |> Repo.delete()
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking vote changes.

  ## Examples

      iex> change_vote(vote)
      %Ecto.Changeset{source: %Vote{}}

  """
  def change_vote(%Vote{} = vote) do
    Vote.changeset(vote, %{})
  end
end
