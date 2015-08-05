defmodule PlanningPoker.Repo.Migrations.CreateRoomParticipants do
  use Ecto.Migration

  def change do
    create table(:room_participants) do
      add :participant_id, references(:participants)
      add :room_id, references(:rooms)
      add :is_owner, :boolean, default: false, null: false

      timestamps
    end
  end
end
