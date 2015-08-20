defmodule PlanningPoker.Ticket do
  use PlanningPoker.Web, :model

  schema "tickets" do
    field :name, :string
    field :points, :string
    belongs_to :game, PlanningPoker.Game, type: :binary_id

    timestamps
  end

  @required_fields ~w(name game_id)
  @optional_fields ~w(points)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
