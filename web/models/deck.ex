defmodule PlanningPoker.Deck do
  use PlanningPoker.Web, :model

  schema "decks" do
    field :name, :string
    field :cards, {:array, :string}

    timestamps
  end

  @required_fields ~w(name cards)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
