defmodule PlanningPoker.Repo.Migrations.CreateTicket do
  use Ecto.Migration

  def change do
    create table(:tickets) do
      add :name, :string, null: false
      add :points, :string
      add :game_id, references(:games, type: :uuid), null: false

      timestamps
    end

  end
end
