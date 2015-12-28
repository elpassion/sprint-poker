defmodule SprintPoker.LobbyChannelTest do
  use SprintPoker.ChannelCase

  alias SprintPoker.LobbyChannel
  alias SprintPoker.User
  alias SprintPoker.Deck
  alias SprintPoker.Repo
  alias SprintPoker.Game
  alias SprintPoker.Deck
  alias SprintPoker.State

  test "joining lobby sends user, auth_token and decks" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    {:ok, reply, socket} =
      socket("user:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(LobbyChannel, "lobby")
    lobby_response = %{"user": user, "auth_token": user.auth_token, decks: Repo.all(Deck)}
    assert reply == lobby_response
  end

  test "'user:update' resends updated user" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    {:ok, _, socket } = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby")

    ref = push socket, "user:update", %{"user" => %{"name" => "new name"}}

    change_user_name_response = %{user: %User{user | name: "new name"}}
    assert_reply ref, :ok, ^change_user_name_response
  end

  test "'user:update' returns validation errors" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    {:ok, _, socket } = socket("user:#{user.id}", %{user_id: user.id}) |> subscribe_and_join(LobbyChannel, "lobby")

    ref = push socket, "user:update", %{"user" => %{"name" => ""}}

    assert_reply ref, :error, %{errors: [error]}
  end

  test "'game:create' resends new game with owner_id and name" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!

    {:ok, _, socket } =
      socket("user:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(LobbyChannel, "lobby")

    ref = push socket, "game:create", %{"name" => "new game", "deck" => %{"id" => deck.id}}

    owner_id = user.id
    assert_reply ref, :ok, %{game: %{id: _, name: "new game", owner_id: ^owner_id}}
  end

  test "'game:create' returns validation errors" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    deck = %Deck{} |> Deck.changeset(%{name: "test deck"}) |> Repo.insert!

    {:ok, _, socket } =
      socket("user:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(LobbyChannel, "lobby")

    ref = push socket, "game:create", %{"name" => "", "deck" => %{"id" => deck.id}}

    assert_reply ref, :error, %{errors: [error]}
  end
end
