defmodule SprintPoker.Repo.User do
  @moduledoc """
  User database schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias SprintPoker.Repo.GameUser

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields ~w(name)a
  @optional_fields ~w(auth_token)a

  schema "users" do
    field :name, :string
    field :auth_token, Ecto.UUID, autogenerate: true
    field :state, :string, virtual: true

    has_many :game_user, GameUser
    has_many :games, through: [:game_user, :game]
    timestamps()
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields ++ @optional_fields)
    |> validate_required(@required_fields)
    |> update_change(:name, &(String.slice(&1, 0..254)))
  end
end
