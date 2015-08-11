defmodule PlanningPoker.Repo.Migrations.CreateSessionUser do
  use Ecto.Migration

  def change do
    create table(:session_user) do
      add :session_id, references(:sessions, type: :uuid)
      add :user_id, references(:users, type: :uuid)

      timestamps
    end

  end
end
