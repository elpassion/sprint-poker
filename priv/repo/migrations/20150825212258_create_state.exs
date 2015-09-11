defmodule SprintPoker.Repo.Migrations.CreateState do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :game_id, references(:games, type: :uuid), null: false
      add :current_ticket_id, :integer
      add :votes, :map
      add :name, :string

      timestamps
    end

  end
end
