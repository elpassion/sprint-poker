defmodule SprintPoker.Repo.Migrations.CreateGame do
  use Ecto.Migration

  def change do
    create table(:games, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :owner_id, references(:users, type: :uuid), null: false
      add :deck_id, references(:decks), null: false
      add :name, :string, null: false

      timestamps
    end

  end
end
