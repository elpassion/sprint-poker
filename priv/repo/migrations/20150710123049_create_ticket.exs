defmodule PlanningPoker.Repo.Migrations.CreateTicket do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :name, :string
      add :owner_id, references(:participants)
      add :room_id, references(:rooms, type: :uuid)
      add :final_estimation, :string

      timestamps
    end

  end
end
