defmodule PlanningPoker.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def up do

    create table(:rooms) do
      add :uuid, :uuid
      add :title, :string

      timestamps
    end
  end

  def down do
    drop table(:rooms)
  end
end
