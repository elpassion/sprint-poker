defmodule SprintPoker.Ticket do
  use SprintPoker.Web, :model

  schema "tickets" do
    field :name, :string
    field :points, :string
    belongs_to :game, SprintPoker.Game, type: :binary_id

    timestamps
  end

  @required_fields ~w(name game_id)
  @optional_fields ~w(points)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> update_change(:name, &(String.slice(&1, 0..254)))
  end
end
