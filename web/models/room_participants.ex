defmodule PlanningPoker.RoomParticipants do
  use PlanningPoker.Web, :model

  schema "room_participants" do

    belongs_to :room,        PlanningPoker.Room
    belongs_to :participant, PlanningPoker.Participant

    timestamps
  end

  @required_fields ["room_id", "participant_id"]
  @optional_fields []

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
