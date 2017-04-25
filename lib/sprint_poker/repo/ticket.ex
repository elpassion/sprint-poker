defmodule SprintPoker.Repo.Ticket do
  @moduledoc """
  Ticker database schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias SprintPoker.Repo.Game

  schema "tickets" do
    field :name, :string
    field :points, :string
    belongs_to :game, Game, type: :binary_id

    timestamps()
  end

  @required_fields ~w(name game_id)a
  @optional_fields ~w(points)a

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> update_change(:name, &(String.slice(&1, 0..254)))
  end
end
