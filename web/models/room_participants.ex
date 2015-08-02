defmodule PlanningPokerApi.RoomParticipants do
  use PlanningPokerApi.Web, :model

  schema "room_participants" do

    belongs_to :room,        PlanningPokerApi.Room
    belongs_to :participant, PlanningPokerApi.Participant

    timestamps
  end

  @required_fields ["room_id", "participant_id"]
  @optional_fields []

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
