defmodule PlanningPoker.Game do
  use PlanningPoker.Web, :model

  alias PlanningPoker.Ticket
  alias PlanningPoker.User
  alias PlanningPoker.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields ~w(name owner_id deck_id)
  @optional_fields ~w()

  schema "games" do
    field :name, :string

    belongs_to :owner, PlanningPoker.User, type: :binary_id
    belongs_to :deck, PlanningPoker.Deck
    has_many :tickets, PlanningPoker.Ticket
    has_one :state, PlanningPoker.State

    has_many :game_user, PlanningPoker.GameUser
    has_many :users, through: [:game_user, :user]
    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> update_change(:name, &(String.slice(&1, 0..254)))
  end

  def preload(model) do
    Repo.preload(model, [
      :owner,
      :deck,
      :state,
      users: from(u in User, order_by: u.name),
      tickets: from(t in Ticket, order_by: t.id)
    ])
  end

  def get(id, opts \\ []) do
    case Ecto.UUID.cast(id) do
      {:ok, _} -> Repo.get(__MODULE__, id, opts)
      _ ->
    end
  end

end
