defmodule PlanningPoker.GameChannelTest do
  use PlanningPoker.ChannelCase

  alias PlanningPoker.GameChannel
  alias PlanningPoker.User
  alias PlanningPoker.Deck
  alias PlanningPoker.Repo
  alias PlanningPoker.Game
  alias PlanningPoker.Deck
  alias PlanningPoker.GameUser

  test "joining game add record and broadcast game with new user" do
    user = %User{name: "test user"} |> Repo.insert!
    deck = %Deck{name: "test deck"} |> Repo.insert!
    game = %Game{name: "test game", owner_id: user.id, deck_id: deck.id} |> Repo.insert! |> Repo.preload([:owner, :deck, :users])

    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    game = Repo.get(Game, game.id) |> Repo.preload([:owner, :deck, :users, :tickets])

    game_response = %{"game": game}
    assert user in game.users
    assert_broadcast "game", ^game_response
  end

  # test "leave game broadcast game" do
  #   user = %User{name: "test user"} |> Repo.insert!
  #   deck = %Deck{name: "test deck"} |> Repo.insert!
  #   game = %Game{name: "test game", owner_id: user.id, deck_id: deck.id} |> Repo.insert!
  #
  #   {:ok, _, socket } = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
  #   socket |> leave
  #
  #   game = Repo.get(Game, game.id) |> Repo.preload([:owner, :deck, :users])
  #
  #   game_response = %{"game": game}
  #   refute user in game.users
  #   assert_broadcast "game", ^game_response
  # end
end

