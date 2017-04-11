defmodule SprintPoker.LobbyChannelTest do
  use SprintPoker.ChannelCase

  alias SprintPoker.LobbyChannel
  alias SprintPoker.User
  alias SprintPoker.Deck
  alias SprintPoker.Repo
  alias SprintPoker.Game
  alias SprintPoker.Deck
  alias SprintPoker.State

  @test_user %User{}
  @test_deck %Deck{name: "test deck", cards: []}

  test "joining lobby sends auth_token" do
    user = @test_user |> Repo.insert!
    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby", %{"game_id" => nil})

    auth_token_response = %{"auth_token": user.auth_token}
    assert_push "auth_token", ^auth_token_response
  end

  test "joining lobby sends user" do
    user = @test_user |> Repo.insert!
    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby", %{"game_id" => nil})

    user_response = %{"user": user}
    assert_push "user", ^user_response
  end

  test "joining lobby sends decks" do
    user = @test_user |> Repo.insert!
    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby", %{"game_id" => nil})

    decks = Repo.all(Deck)

    decks_response = %{decks: decks}
    assert_push "decks", ^decks_response
  end

  test "joining lobby sends game" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    game = %Game{} |> Game.changeset(%{name: "test game", owner_id: user.id, deck_id: deck.id}) |> Repo.insert!
    _state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!

    socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby", %{"game_id" => game.id})

    game = game |> Repo.preload([:owner, :deck])

    game_response = %{"game": game}
    assert_push "game", ^game_response
  end


  test "'user:update' resends updated user" do
    user = @test_user |> Repo.insert!
    {:ok, _, socket } = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby", %{"game_id" => nil})

    socket |> push("user:update", %{"user" => %{"name" => "new name"}})

    change_user_name_response = %{user: user}
    assert_push "user", ^change_user_name_response
  end

  test "'game:create' resends new game with owner_id and name" do
    user = @test_user |> Repo.insert!
    deck = @test_deck |> Repo.insert!

    {:ok, _, socket } = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby", %{"game_id" => nil})

    socket |> push("game:create", %{"game" => %{"name" => "new game", "deck" => %{"id" => deck.id}}})

    owner_id = user.id
    assert_push "game", %{game: %{id: _, name: "new game", owner_id: ^owner_id}}
  end
end
