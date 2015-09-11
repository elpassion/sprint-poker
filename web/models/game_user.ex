defmodule SprintPoker.GameUser do
  use SprintPoker.Web, :model

  schema "game_user" do
    belongs_to :user, SprintPoker.User, type: :binary_id
    belongs_to :game, SprintPoker.Game, type: :binary_id
    field :state, :string, default: "connected"
    timestamps
  end

  @required_fields ~w(game_id user_id state)
  @optional_fields ~w()
  @state_names ~w(none connected disconnected)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_inclusion(:state, @state_names)
  end
end
