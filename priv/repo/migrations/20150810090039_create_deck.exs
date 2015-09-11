defmodule SprintPoker.Repo.Migrations.CreateDeck do
  use Ecto.Migration

  def change do
    create table(:decks) do
      add :name, :string, null: false
      add :cards, {:array, :string}, null: false

      timestamps
    end

  end
end
