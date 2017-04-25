defmodule SprintPoker.Repo.State do
  @moduledoc """
  Game state database schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias SprintPoker.Repo.Game

  schema "states" do
    belongs_to :game, Game, type: :binary_id
    field :current_ticket_id, :integer
    field :votes, :map, default: %{}
    field :name, :string
    timestamps()
  end

  @required_fields ~w(game_id name)a
  @optional_fields ~w(current_ticket_id votes)a
  @state_names ~w(none voting review)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:name, @state_names)
  end
end
