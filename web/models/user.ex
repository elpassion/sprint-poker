defmodule PlanningPoker.User do
  use PlanningPoker.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @required_fields ~w(name auth_token)
  @optional_fields ~w()

  schema "users" do
    field :name, :string
    field :auth_token, Ecto.UUID, autogenerate: true

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
