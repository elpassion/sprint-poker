defmodule PlanningPoker.Participant do
  use PlanningPoker.Web, :model

  before_insert :put_uuid, []

  schema "participants" do
    field :name,    :string
    field :uuid,    Ecto.UUID
    field :room_id, Ecto.UUID

    # belongs_to :room, PlanningPoker.Room

    timestamps
  end

  @required_fields ~w(name room_id)
  @optional_fields ~w()

  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def put_uuid(changeset) do
    Ecto.Changeset.put_change(changeset, :uuid, Ecto.UUID.generate())
  end
end
