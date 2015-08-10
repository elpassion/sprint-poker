defmodule PlanningPoker.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :uuid, :uuid
      add :name, :string

      timestamps
    end

  end
end
