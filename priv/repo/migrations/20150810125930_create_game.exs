defmodule PlanningPoker.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :owner_id, references(:users, type: :uuid)
      add :name, :string

      timestamps
    end

  end
end
