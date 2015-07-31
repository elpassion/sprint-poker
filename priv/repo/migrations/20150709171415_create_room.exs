defmodule PlanningPoker.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def up do
    create table(:rooms, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :title, :string
      add :owner_id, references(:participants)

      timestamps
    end
  end

  def down do
    drop table(:rooms)
  end
end
