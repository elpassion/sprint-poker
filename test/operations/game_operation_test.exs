defmodule SprintPoker.TestTest do
  use SprintPoker.OperationCase
  alias SprintPoker.GameOperations

  test "'create' returns {:ok, %{game: game}} with correct params" do
    deck = create(:deck)
    user = create(:user)
    game = create(:game, %{owner: user, deck: deck})

    params = %{"name" => game.name, "deck" => %{"id" => deck.id}}
    name = game.name
    assert {:ok, %{game: %{name: name, deck: deck, owner: user}}} =
      GameOperations.create(params, user)
  end

  test "'create' returns {:error, %{errors: errors} with incorrect params" do
    deck = create(:deck)
    user = create(:user)
    params = %{"deck" => %{"id" => deck.id}}
    assert {:error, %{errors: _}} = GameOperations.create(params, user)
  end
end
