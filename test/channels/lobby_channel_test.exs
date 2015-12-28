defmodule SprintPoker.LobbyChannelTest do
  use SprintPoker.ChannelCase

  alias SprintPoker.LobbyChannel
  alias SprintPoker.User
  alias SprintPoker.Deck
  alias SprintPoker.Repo
  alias SprintPoker.Deck

  setup do
    user = Repo.insert! %User{name: "test user"}
    deck = Repo.insert! %Deck{name: "test deck"}

    {:ok, reply, socket} =
      socket("user:#{user.id}", %{user_id: user.id})
      |> subscribe_and_join(LobbyChannel, "lobby")

    {:ok, %{user: user, deck: deck, reply: reply, socket: socket}}
  end

  test "joining lobby sends user, auth_token and decks", %{user: user, reply: reply} do
    expected_response = %{"user": user, "auth_token": user.auth_token, decks: Repo.all(Deck)}

    assert reply == expected_response
  end

  test "user:update resends updated user", %{socket: socket} do
    ref = push socket, "user:update", %{"user" => %{"name" => "new name"}}

    assert_reply ref, :ok, %{user: _}
  end

  test "user:update returns validation errors", %{socket: socket} do
    ref = push socket, "user:update", %{"user" => %{"name" => ""}}

    assert_reply ref, :error, %{errors: _}
  end

  test "game:create resends new game", %{deck: deck, socket: socket} do
    ref = push socket, "game:create", %{"name" => "new game", "deck" => %{"id" => deck.id}}

    assert_reply ref, :ok, %{game: _}
  end

  test "'game:create' returns validation errors", %{deck: deck, socket: socket} do
    ref = push socket, "game:create", %{"name" => "", "deck" => %{"id" => deck.id}}

    assert_reply ref, :error, %{errors: _}
  end
end
