defmodule Planner.Events.Event do
  use Ecto.Schema
  import Ecto.Changeset
  alias Planner.Accounts.User
  alias Planner.Events.Time

  schema "events" do
    field :description, :string
    field :image, :string
    field :message, :string
    field :name, :string
    field :private, :boolean, default: true
    belongs_to :host, User
    has_many :times, Time

    timestamps()
  end

  @doc false
  def changeset(event, attrs) do
    event
    |> cast(attrs, [:name, :message, :description, :image, :private, :host_id])
    |> validate_required([:host_id])
  end
end
