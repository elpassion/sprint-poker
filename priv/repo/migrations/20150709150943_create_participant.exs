defmodule PlanningPoker.Repo.Migrations.CreateParticipant do
  use Ecto.Migration

  def up do

    create table(:participants) do
      add :uuid, :uuid
      add :name, :string

      timestamps
    end
  end

  def down do
    drop table(:participants)
  end
end
