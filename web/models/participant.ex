defmodule PlanningPoker.Participant do
  use PlanningPoker.Web, :model

  before_insert :put_uuid, []

  schema "participants" do
    field :uuid, Ecto.UUID
    field :name, :string

    has_many :room_participants, PlanningPokerApi.RoomParticipants
    has_many :rooms, through: [:room_participants, :room]

    timestamps
  end

  @required_fields ["name"]
  @optional_fields []

  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def put_uuid(changeset) do
    Ecto.Changeset.put_change(changeset, :uuid, Ecto.UUID.generate())
  end
end
