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

  setup do
    user = %User{name: "test user"} |> Repo.insert!
    deck = %Deck{name: "test deck"} |> Repo.insert!
    game = %Game{name: "test game", owner_id: user.id, deck_id: deck.id} |> Repo.insert!
    state = %State{name: "none", game_id: game.id} |> Repo.insert!
    {:ok, %{user: user, deck: deck, game: game, state: state}}
  end

  test "joining game adds record and broadcasts game with new user and pushes state", %{user: user, deck: deck, state: state, game: game} do
    {:ok, reply, socket} =
      socket("user:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(GameChannel, "game:#{game.id}")

    game = game |> Game.preload

    # TODO: Move this part of test to operation test.
    # We shouldn't test the UserOperation.connect here.
    game_user = GameUser |> Repo.get_by(game_id: game.id, user_id: user.id)

    assert game_user.state == "connected"
    assert game_user.game_id == game.id
    assert game_user.user_id == user.id
    assert user in game.users
    # Till this place.

    expected_response = %{game: game, state: state}
    assert reply == expected_response
  end

  test "leave game broadcasts game", %{user: user, deck: deck, game: game} do
    {:ok, _, socket } =
      socket("user:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(GameChannel, "game:#{game.id}")

    Process.unlink(socket.channel_pid)
    socket |> close

    game_user = GameUser |> Repo.get_by(game_id: game.id, user_id: user.id)

    # TODO: Move this part of test to operation test.
    # We shouldn't test the UserOperation.update_state here.
    assert game_user.state == "disconnected"

    game = game |> Game.preload
    assert_broadcast "game", %{game: game}
  end

  test "'ticket:create' adds ticket and broadcasts game with new ticket", %{user: user, deck: deck, game: game} do
    {:ok, _, socket} =
      socket("user:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(GameChannel, "game:#{game.id}")

    ref = push socket, "ticket:create", %{"ticket" => %{"name" => "new test ticket"}}

    game = game |> Game.preload
    assert_broadcast "game", %{game: game}
    assert_reply ref, :ok, %{game: game}
  end

  test "'ticket:delete' deletes ticket and broadcasts game without ticket", %{user: user, deck: deck, game: game} do
    ticket = %Ticket{name: "test ticket", game_id: game.id} |> Repo.insert!

    {:ok, _, socket} =
      socket("user:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(GameChannel, "game:#{game.id}")

    ref = socket |> push "ticket:delete", %{"ticket" => %{"id" => ticket.id}}

    game = game |> Game.preload
    assert_broadcast "game", %{game: game}
    assert_reply ref, :ok, %{game: game}
  end

  test "'ticket:update' updates ticket and broadcasts game with new ticket", %{user: user, deck: deck, game: game} do
    ticket = %Ticket{name: "test ticket", game_id: game.id} |> Repo.insert!

    {:ok, _, socket} =
      socket("user:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(GameChannel, "game:#{game.id}")

    ref = socket |> push "ticket:update", %{"ticket" => %{"id" => ticket.id, "name" => "new name"}}

    game = game |> Game.preload
    assert_broadcast "game", %{game: game}
    assert_reply ref, :ok, %{game: game}
  end

  test "'state:update' updates name state and broadcasts it", %{user: user, deck: deck, game: game, state: state} do
    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push "state:update", %{"state" => %{name: "voting"}}

    state_response = %{"state": %{state | name: "voting"}}
    assert_broadcast "state", ^state_response
  end

  test "'state:update' updates current_ticket_id state and broadcasts it", %{user: user, deck: deck, game: game, state: state} do
    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push "state:update", %{"state" => %{current_ticket_id: 6}}

    state_response = %{"state": %{state | current_ticket_id: 6}}
    assert_broadcast "state", ^state_response
  end

  test "'state:update:vote' updates state with vote and broadcasts it with nil", %{user: user, deck: deck, game: game, state: state} do
    _ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push "state:update:vote", %{"vote" => %{points: "XXL"}}

    state_response = %{"state": %{state | votes:  Dict.put(%{}, user.id, nil)}}
    assert_broadcast "state", ^state_response
  end

  test "'state:update:vote' updates state with vote and broadcasts it with value if owner", %{user: user, deck: deck, game: game, state: state} do
    _ticket = %Ticket{} |> Ticket.changeset(%{name: "test ticket", game_id: game.id}) |> Repo.insert!
    _game_user = %GameUser{} |> GameUser.changeset(%{user_id: user.id, game_id: game.id}) |> Repo.insert!

    {:ok, _, socket} = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(GameChannel, "game:#{game.id}")
    socket |> push "state:update:vote", %{"vote" => %{ "points" => "XXL" }}

    state_response = %{"state": %{state | votes:  Dict.put(%{}, user.id, "XXL")}}
    assert_broadcast "state", ^state_response
  end
end
