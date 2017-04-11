defmodule SprintPoker.GameChannelTest do
  use SprintPoker.ChannelCase

  alias SprintPoker.GameChannel
  alias SprintPoker.User
  alias SprintPoker.Deck
  alias SprintPoker.Repo
  alias SprintPoker.Game
  alias SprintPoker.Deck
  alias SprintPoker.GameUser
  alias SprintPoker.Ticket
  alias SprintPoker.State

  @test_user %User{}
  @test_deck %Deck{name: "test deck", cards: []}

  test "joining game adds record and broadcasts game with new user and pushes state" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

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

    assert_broadcast "game", %{game: ^game}
    assert_push "state", %{state: ^state}
  end

  test "leave game broadcasts game" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

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

    assert_broadcast "game", %{game: game_response}

    assert game_response.id == game.id
    assert game_response.name == game.name
    assert game_response.owner_id == game.owner_id
    assert game_response.deck_id == deck.id
  end

  test "'ticket:create' adds ticket and broadcasts game with new ticket" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    _state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    assert [] = Repo.all(Ticket)

    socket |> push("ticket:create", %{"ticket" => %{"name" => "new test ticket"}})

    game = Repo.get(Game, game.id) |> Game.preload

    [ticket] = Repo.all(Ticket)
    assert ticket.name == "new test ticket"

    assert_broadcast "game", %{game: game_response = %{tickets: [response_ticket]}}

    assert response_ticket.id == ticket.id
    assert game_response.id == game.id
    assert game_response.name == game.name
    assert game_response.owner_id == game.owner_id
    assert game_response.deck_id == deck.id
  end

  test "'ticket:delete' deletes ticket and broadcasts game without ticket" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    _state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!
    ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    assert [^ticket] = Repo.all(Ticket)

    socket |> push("ticket:delete", %{"ticket" => %{"id" => ticket.id}})
    assert_broadcast "game", %{game: game_response = %{tickets: []}}

    assert [] = Repo.all(Ticket)

    game = Repo.get(Game, game.id) |> Game.preload

    assert game_response.id == game.id
    assert game_response.name == game.name
    assert game_response.owner_id == game.owner_id
    assert game_response.deck_id == deck.id
  end

  test "'ticket:update' updates ticket and broadcasts game with new ticket" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    _state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!
    ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")

    assert [^ticket] = Repo.all(Ticket)

    socket |> push("ticket:update", %{ticket: %{"id" => ticket.id, "name" => "new name"}})
    assert_broadcast "game", %{game: game_response = %{tickets: [%{name: "new name"}]}}

    [ticket] = Repo.all(Ticket)

    game = Repo.get(Game, game.id) |> Game.preload

    assert ticket.name == "new name"

    assert game_response.id == game.id
    assert game_response.name == game.name
    assert game_response.owner_id == game.owner_id
    assert game_response.deck_id == deck.id
  end

  test "'state:update' updates name state and broadcasts it" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push("state:update", %{"state" => %{name: "voting"}})

    assert_broadcast "state", %{state: state_response}

    assert state_response.id == state.id
    assert state_response.game_id == game.id
    assert state_response.name == "voting"
  end

  test "'state:update' updates current_ticket_id state and broadcasts it" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push("state:update", %{"state" => %{current_ticket_id: 6}})

    assert_broadcast "state", %{state: state_response}

    assert state_response.id == state.id
    assert state_response.game_id == game.id
    assert state_response.current_ticket_id == 6
  end

  test "'state:update:vote' updates state with vote and broadcasts it with nil" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!
    _ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push("state:update:vote", %{"vote" => %{points: "XXL"}})

    assert_broadcast "state", %{state: state_response}

    assert state_response.id == state.id
    assert state_response.game_id == game.id
    assert state_response.votes == %{ user.id => "XXL" }
  end

  test "'state:update:vote' updates state with vote and broadcasts it with value if owner" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!
    _ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!
    _game_user = %GameUser{} |> GameUser.changeset(%{user_id: user.id, game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push("state:update:vote", %{"vote" => %{ "points" => "XXL" }})

    assert_broadcast "state", %{state: state_response}

    assert state_response.id == state.id
    assert state_response.game_id == game.id
    assert state_response.votes == %{ user.id => "XXL" }
  end
end
