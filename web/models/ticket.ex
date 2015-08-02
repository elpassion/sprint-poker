defmodule PlanningPoker.Ticket do
  use PlanningPoker.Web, :model

  schema "tickets" do
    field :name,             :string
    field :final_estimation, :string

    belongs_to :room,  PlanningPokerApi.Room
    belongs_to :owner, PlanningPokerApi.Participant

    timestamps
  end

  @required_fields ["name", "room_id", "owner_id"]
  @optional_fields ["final_estimation"]

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
