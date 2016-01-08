defmodule SprintPoker.Factory do
  alias SprintPoker.User
  alias SprintPoker.Deck
  alias SprintPoker.Game
  use ExMachina.Ecto, repo: SprintPoker.Repo

  def factory(:user) do
    %User{
      name: "test name",
    }
  end

  def factory(:deck) do
    %Deck{
      name: "test deck",
    }
  end

  def factory(:game) do
    %Game{
      name: "test game",
      owner: build(:user),
      deck: build(:deck)
    }
  end
end
