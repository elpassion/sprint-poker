defmodule PlanningPoker.Repo.Migrations.AddRoomIdToParticipant do
  use Ecto.Migration

  def change do
    alter table(:participants) do
      add :room_id, references(:rooms, type: :uuid)
    end
  end
end
