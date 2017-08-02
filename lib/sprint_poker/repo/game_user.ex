defmodule SprintPoker.Repo.GameUser do
  @moduledoc """
  Game - User database relation schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias SprintPoker.Repo.User
  alias SprintPoker.Repo.Game

  schema "game_user" do
    belongs_to :user, User, type: :binary_id
    belongs_to :game, Game, type: :binary_id
    field :state, :string, default: "connected"
    timestamps()
  end

  @required_fields ~w(game_id user_id state)a
  @optional_fields ~w()a
  @state_names ~w(none connected disconnected)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> validate_inclusion(:state, @state_names)
  end
end
