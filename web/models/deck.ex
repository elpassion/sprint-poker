defmodule SprintPoker.Deck do
  use SprintPoker.Web, :model

  schema "decks" do
    field :name, :string
    field :cards, {:array, :string}

    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> update_change(:name, &(String.slice(&1, 0..254)))
  end
end
