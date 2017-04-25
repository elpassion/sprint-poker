defmodule SprintPoker.Repo.Game do
  @moduledoc """
  Game database schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias SprintPoker.Repo.User
  alias SprintPoker.Repo.Deck
  alias SprintPoker.Repo.Ticket
  alias SprintPoker.Repo.State
  alias SprintPoker.Repo.GameUser

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields ~w(name owner_id deck_id)a
  @optional_fields ~w()a

  schema "games" do
    field :name, :string

    belongs_to :owner, User, type: :binary_id
    belongs_to :deck, Deck
    has_many :tickets, Ticket
    has_one :state, State

    has_many :game_user, GameUser
    has_many :users, through: [:game_user, :user]
    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> update_change(:name, &(String.slice(&1, 0..254)))
  end
end
