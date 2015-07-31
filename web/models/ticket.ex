defmodule PlanningPoker.Ticket do
  use PlanningPoker.Web, :model

  schema "tickets" do
    field :name,             :string
    field :final_estimation, :string
    field :room_id,          Ecto.UUID

    # belongs_to :room,  PlanningPoker.Room
    belongs_to :owner, PlanningPoker.Participant

    timestamps
  end

  @required_fields ~w(name room_id owner_id)
  @optional_fields ~w(final_estimation)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
