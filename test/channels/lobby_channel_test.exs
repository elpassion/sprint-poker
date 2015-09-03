defmodule PlanningPoker.LobbyChannelTest do
  use PlanningPoker.ChannelCase

  alias PlanningPoker.LobbyChannel
  alias PlanningPoker.User
  alias PlanningPoker.Deck
  alias PlanningPoker.Repo
  alias PlanningPoker.Game
  alias PlanningPoker.Deck
  alias PlanningPoker.State

  test "joining lobby sends auth_token" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby")

    auth_token_response = %{"auth_token": user.auth_token}
    assert_push "auth_token", ^auth_token_response
  end

  test "joining lobby sends user" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby")

    user_response = %{"user": user}
    assert_push "user", ^user_response
  end

  test "joining lobby sends decks" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby")

    decks = Repo.all(Deck)

    decks_response = %{decks: decks}
    assert_push "decks", ^decks_response
  end

  test "joining lobby sends game" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!
    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    _state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby", %{"game_id" => game.id})

    game = game |> Repo.preload([:owner, :deck])

    game_response = %{"game": game}
    assert_push "game", ^game_response
  end


  test "'user:update' resends updated user" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    {:ok, _, socket } = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby")

    socket |> push "user:update", %{"user" => %{"name" => "new name"}}

    change_user_name_response = %{user: %User{user | name: "new name"}}
    assert_push "user", ^change_user_name_response
  end

  test "'game:create' resends new game with owner_id and name" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!

    {:ok, _, socket } = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby")

    socket |> push "game:create", %{"name" => "new game", "deck" => %{"id" => deck.id}}

    owner_id = user.id
    assert_push "game", %{game: %{id: _, name: "new game", owner_id: ^owner_id}}
  end
end
