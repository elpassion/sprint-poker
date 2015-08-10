defmodule PlanningPoker.User do
  use PlanningPoker.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields ~w(name)
  @optional_fields ~w()

  schema "users" do
    field :name, :string

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
