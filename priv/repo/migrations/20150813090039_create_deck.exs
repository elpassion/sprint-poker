defmodule PlanningPoker.Repo.Migrations.CreateDeck do
  use Ecto.Migration

  def change do
    create table(:decks) do
      add :name, :string
      add :cards, {:array, :string}

      timestamps
    end

  end
end
