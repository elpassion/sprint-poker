defmodule PlanningPoker.Session do
  use PlanningPoker.Web, :model

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  @required_fields ~w(name, owner_id)
  @optional_fields ~w()

  schema "sessions" do
    field :name, :string

    belongs_to :owner, PlanningPoker.User
    has_many :session_user, PlanningPoker.SessionUser
    has_many :users, through: [:session_user, :user]

    timestamps
  end

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
