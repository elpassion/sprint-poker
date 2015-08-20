defmodule PlanningPoker.Game do
  use PlanningPoker.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields ~w(name, owner_id deck_id)
  @optional_fields ~w()

  schema "games" do
    field :name, :string

    belongs_to :owner, PlanningPoker.User, type: :binary_id
    belongs_to :deck, PlanningPoker.Deck
    has_many :tickets, PlanningPoker.Ticket

    has_many :game_user, PlanningPoker.GameUser
    has_many :users, through: [:game_user, :user]

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
