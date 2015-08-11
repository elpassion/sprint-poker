defmodule PlanningPoker.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :auth_token, :uuid
      add :name, :string

      timestamps
    end

  end
end
