defmodule PlanningPoker.User do
  use PlanningPoker.Web, :model

  schema "users" do
    field :uuid, Ecto.UUID
    field :name, :string

    timestamps
  end

  before_insert :put_uuid, []

  @required_fields ~w(uuid name)
  @optional_fields ~w()

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def put_uuid(changeset) do
    changeset
    |> Ecto.Changeset.put_change(:uuid, Ecto.UUID.generate())
  end
end
