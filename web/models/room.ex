defmodule PlanningPoker.Room do
  use PlanningPoker.Web, :model
  alias PlanningPoker.Repo

  before_insert :put_uuid, []

  schema "rooms" do
    field :uuid,  Ecto.UUID
    field :title, :string

    has_many :room_participants, PlanningPoker.RoomParticipants
    has_many :participants, through: [:room_participants, :participant]
    has_many :tickets, PlanningPoker.Ticket

    timestamps
  end

  @required_fields ["title"]
  @optional_fields []

  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def put_uuid(changeset) do
    Ecto.Changeset.put_change(changeset, :uuid, Ecto.UUID.generate())
  end
end
