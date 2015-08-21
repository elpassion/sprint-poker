defmodule PlanningPoker.GameChannelTest do
  use PlanningPoker.ChannelCase

  alias PlanningPoker.GameChannel
  alias PlanningPoker.User
  alias PlanningPoker.Deck
  alias PlanningPoker.Repo
  alias PlanningPoker.Game
  alias PlanningPoker.Deck
  alias PlanningPoker.GameUser
  alias PlanningPoker.Ticket

  test "joining game add record and broadcast game with new user" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!

    assert [] = Repo.all(GameUser)

    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    game = Repo.get(Game, game.id) |> Game.preload

    [game_user] = Repo.all(GameUser)
    assert game_user.game_id == game.id
    assert game_user.user_id == user.id

    game_response = %{"game": game}
    assert user in game.users
    assert_broadcast "game", ^game_response
  end

  # test "leave game broadcast game" do
  #   user = %User{name: "test user"} |> Repo.insert!
  #   deck = %Deck{name: "test deck"} |> Repo.insert!
  #   game = %Game{name: "test game", owner_id: user.id, deck_id: deck.id} |> Repo.insert!
  #
  #   assert [] = Repo.all(GameUser)
  #
  #   {:ok, _, socket } = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
  #
  #   assert [game_user] = Repo.all(GameUser)
  #
  #   socket |> leave
  #
  #   assert [] = Repo.all(GameUser)
  #
  #   game = Repo.get(Game, game.id) |> Repo.preload([:owner, :deck, :users])
  #
  #   game_response = %{"game": game}
  #   assert_broadcast "game", ^game_response
  # end

  test "create_ticket adds ticket and broadcast game with new ticket" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    assert [] = Repo.all(Ticket)

    socket |> push "create_ticket", %{"ticket" => %{"name" => "new test ticket"}}

    game = Repo.get(Game, game.id) |> Game.preload

    [ticket] = Repo.all(Ticket)
    assert ticket.name == "new test ticket"

    game_response = %{"game": game}
    assert_broadcast "game", ^game_response
  end

  test "delete_ticket delete ticket and broadcast game without ticket" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    assert [ticket] = Repo.all(Ticket)

    socket |> push "delete_ticket", %{"ticket" => %{"id" => ticket.id}}

    game = Repo.get(Game, game.id) |> Game.preload

    assert [] = Repo.all(Ticket)

    game_response = %{"game": game}
    assert_broadcast "game", ^game_response
  end

  test "update_ticket updates ticket and broadcast game with new ticket" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    assert [ticket] = Repo.all(Ticket)

    socket |> push "update_ticket", %{"ticket" => %{"id" => ticket.id, "name" => "new name"}}
    game = Repo.get(Game, game.id) |> Game.preload

    [ticket] = Repo.all(Ticket)
    assert ticket.name == "new name"

    game_response = %{"game": game}
    assert_broadcast "game", ^game_response
  end

end

