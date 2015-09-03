defmodule PlanningPoker.Repo.Migrations.CreateGameUser do
  use Ecto.Migration

  def change do
    create table(:game_user) do
      add :game_id, references(:games, type: :uuid), null: false
      add :user_id, references(:users, type: :uuid), null: false
      add :state, :string

      timestamps
    end
    unique_index(:game_user, [:game_id, :user_id])
  end
end
