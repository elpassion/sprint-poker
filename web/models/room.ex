defmodule PlanningPoker.Room do
  use PlanningPoker.Web, :model
  alias PlanningPoker.Repo

  @primary_key {:id, :binary_id, autogenerate: true}

  schema "rooms" do
    field :title, :string

    belongs_to :owner,        PlanningPoker.Participant
    has_many   :participants, PlanningPoker.Participant
    has_many   :tickets,      PlanningPoker.Ticket

    timestamps
  end

  @required_fields ~w(title)
  @optional_fields ~w()

  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
