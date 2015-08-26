defmodule PlanningPoker.State do
  use PlanningPoker.Web, :model

  schema "states" do
    belongs_to :game, PlanningPoker.Game, type: :binary_id
    field :current_ticket_index, :integer
    field :votes, :map
    field :name, :string
    timestamps
  end

  @required_fields ~w(game_id name)
  @optional_fields ~w(current_ticket_index votes)
  @state_names ~w(none voting finished)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_inclusion(:name, @state_names)
  end
end
