defmodule PlanningPoker.Repo.Migrations.CreateGameUser do
  use Ecto.Migration

  def change do
    create table(:game_user) do
      add :game_id, references(:games, type: :uuid)
      add :user_id, references(:users, type: :uuid)

      timestamps
    end

  end
end
