defmodule PlanningPoker.LobbyChannelTest do
  use PlanningPoker.ChannelCase

  alias PlanningPoker.LobbyChannel
  alias PlanningPoker.User
  alias PlanningPoker.Deck
  alias PlanningPoker.Repo

  test "joining lobby sends auth_token" do
    user = %User{name: "test user"} |> Repo.insert!
    subscribe_and_join_with_assigns(LobbyChannel, "lobby", %{user_id: user.id})

    auth_token_response = %{"auth_token": user.auth_token}
    assert_push "auth_token", ^auth_token_response
  end

  test "joining lobby sends user" do
    user = %User{name: "test user"} |> Repo.insert!
    subscribe_and_join_with_assigns(LobbyChannel, "lobby", %{user_id: user.id})

    user_response = %{"user": user}
    assert_push "user", ^user_response
  end

  test "joining lobby sends decks" do
    user = %User{name: "test user"} |> Repo.insert!
    subscribe_and_join_with_assigns(LobbyChannel, "lobby", %{user_id: user.id})

    decks_response = %{decks: []}
    assert_push "decks", ^decks_response
  end

  test "sending change_user_name resend updated user" do
    user = %User{name: "test user"} |> Repo.insert!
    {:ok, _, socket } = subscribe_and_join_with_assigns(LobbyChannel, "lobby", %{user_id: user.id})

    socket |> push "change_user_name", %{"name" => "new name"}

    change_user_name_response = %{user: %User{user | name: "new name"}}
    assert_push "user", ^change_user_name_response
  end

  test "sending create_game resend new game" do
    user = %User{name: "test user"} |> Repo.insert!
    deck = %Deck{name: "test deck"} |> Repo.insert!
    owner_id = user.id

    {:ok, _, socket } = subscribe_and_join_with_assigns(LobbyChannel, "lobby", %{user_id: user.id})

    socket |> push "create_game", %{"name" => "new session", "deck_id" => deck.id}

    assert_push "game", %{game: %{id: _, owner_id: ^owner_id}}
  end



end
