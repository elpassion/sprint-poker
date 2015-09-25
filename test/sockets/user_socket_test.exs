defmodule SprintPoker.UserSocketTest do
  use SprintPoker.ChannelCase

  alias SprintPoker.UserSocket
  alias SprintPoker.User

  test "connecting to socket creates a new user" do
    {:ok, socket} = UserSocket.connect(%{}, socket())

    assert [user] = Repo.all(User)
    assert socket.assigns.user_id == user.id
  end

  test "connecting to socket with auth_token assings this user" do
    user = %User{} |> User.changeset(%{name: "test user"}) |> Repo.insert!
    {:ok, socket} = UserSocket.connect(%{"auth_token" => user.auth_token}, socket())

    assert socket.assigns.user_id == user.id
  end

  test "connecting to socket with bad uid creates a new user" do
    {:ok, socket} = UserSocket.connect(%{"auth_token" => "bad"}, socket())

    assert [user] = Repo.all(User)
    assert socket.assigns.user_id == user.id
  end
end
