defmodule PlanningPoker.SessionUser do
  use PlanningPoker.Web, :model

  @foreign_key_type :binary_id

  schema "session_user" do
    belongs_to :session, PlanningPoker.Session
    belongs_to :user,    PlanningPoker.User

    timestamps
  end

  @required_fields ~w(session_id user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
