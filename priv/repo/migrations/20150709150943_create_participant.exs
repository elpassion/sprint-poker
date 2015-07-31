defmodule PlanningPoker.Repo.Migrations.CreateParticipant do
  use Ecto.Migration

  def up do
    execute "CREATE EXTENSION IF NOT EXISTS \"uuid-ossp\""

    create table(:participants) do
      add :uuid, :uuid, default: fragment("uuid_generate_v4()")
      add :name, :string

      timestamps
    end
  end

  def down do
    drop table(:participants)
  end
end
