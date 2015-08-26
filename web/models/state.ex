defmodule PlanningPoker.State do
  use PlanningPoker.Web, :model

  schema "states" do
    belongs_to :game, PlanningPoker.Game, type: :binary_id
    field :current_ticket_index, :integer
    field :votes, :map, default: %{}
    field :name, :string
    timestamps
  end

  @required_fields ~w(game_id name)
  @optional_fields ~w(current_ticket_index votes)
  @state_names ~w(none voting finished)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_inclusion(:name, @state_names)
  end

  def hide_votes(state, current_user) do
    unless state.name == "finished" do
      new_votes = for {key, value} <- state.votes, into: %{} do
        if key == current_user.id do
          {key,  value}
        else
          {key, "voted"}
        end
      end

      state = %{state | votes: new_votes}
    end
    state
  end
end
