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
  alias PlanningPoker.State

  test "joining game adds record and broadcasts game with new user and pushes state" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    assert [] = Repo.all(GameUser)

    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    game = Repo.get(Game, game.id) |> Game.preload

    [game_user] = Repo.all(GameUser)

    assert game_user.state == "connected"
    assert game_user.game_id == game.id
    assert game_user.user_id == user.id

    assert user in game.users

    game_response = %{"game": game}
    assert_broadcast "game", ^game_response

    state_response = %{"state": state}
    assert_push "state", ^state_response
  end

  test "leave game broadcasts game" do
    user = %User{name: "test user"} |> Repo.insert!
    deck = %Deck{name: "test deck"} |> Repo.insert!
    game = %Game{name: "test game", owner_id: user.id, deck_id: deck.id} |> Repo.insert!
    _state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    [] = Repo.all(GameUser)

    {:ok, _, socket } = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    Process.unlink(socket.channel_pid)

    [game_user] = Repo.all(GameUser)

    assert game_user.state == "connected"
    assert game_user.game_id == game.id
    assert game_user.user_id == user.id

    socket |> close

    [game_user] = Repo.all(GameUser)

    assert game_user.state == "disconnected"
    assert game_user.game_id == game.id
    assert game_user.user_id == user.id

    game = Repo.get(Game, game.id) |> Game.preload

    game_response = %{"game": game}
    assert_broadcast "game", ^game_response
  end

  test "'ticket:create' adds ticket and broadcasts game with new ticket" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    _state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    assert [] = Repo.all(Ticket)

    socket |> push "ticket:create", %{"ticket" => %{"name" => "new test ticket"}}

    game = Repo.get(Game, game.id) |> Game.preload

    [ticket] = Repo.all(Ticket)
    assert ticket.name == "new test ticket"

    game_response = %{"game": game}
    assert_broadcast "game", ^game_response
  end

  test "'ticket:delete' deletes ticket and broadcasts game without ticket" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    _state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!
    ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    assert [ticket] = Repo.all(Ticket)

    socket |> push "ticket:delete", %{"ticket" => %{"id" => ticket.id}}

    game = Repo.get(Game, game.id) |> Game.preload

    assert [] = Repo.all(Ticket)

    game_response = %{"game": game}
    assert_broadcast "game", ^game_response
  end

  test "'ticket:update' updates ticket and broadcasts game with new ticket" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    _state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!
    ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    assert [ticket] = Repo.all(Ticket)

    socket |> push "ticket:update", %{"ticket" => %{"id" => ticket.id, "name" => "new name"}}
    game = Repo.get(Game, game.id) |> Game.preload

    [ticket] = Repo.all(Ticket)
    assert ticket.name == "new name"

    game_response = %{"game": game}
    assert_broadcast "game", ^game_response
  end

  test "'state:update' updates name state and broadcasts it" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push "state:update", %{"state" => %{name: "voting"}}

    state_response = %{"state": %{state | name: "voting"}}
    assert_broadcast "state", ^state_response
  end

  test "'state:update' updates current_ticket_id state and broadcasts it" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push "state:update", %{"state" => %{current_ticket_id: 6}}

    state_response = %{"state": %{state | current_ticket_id: 6}}
    assert_broadcast "state", ^state_response
  end

  test "'state:update:vote' updates state with vote and broadcasts it with nil" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!
    _ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push "state:update:vote", %{"vote" => %{points: "XXL"}}

    state_response = %{"state": %{state | votes:  Dict.put(%{}, user.id, nil)}}
    assert_broadcast "state", ^state_response
  end

  test "'state:update:vote' updates state with vote and broadcasts it with value if owner" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!
    _ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!
    _game_user = %GameUser{} |> GameUser.changeset(%{user_id: user.id, game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push "state:update:vote", %{"vote" => %{ "points" => "XXL" }}

    state_response = %{"state": %{state | votes:  Dict.put(%{}, user.id, "XXL")}}
    assert_broadcast "state", ^state_response
  end
end

