defmodule SprintPoker.LobbyChannel do
  use Phoenix.Channel

  alias SprintPoker.Repo
  alias SprintPoker.User
  alias SprintPoker.Deck

  alias SprintPoker.GameOperations
  alias SprintPoker.UserOperations

  def join("lobby", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    {:ok, %{"user": user, "auth_token": user.auth_token, decks: Repo.all(Deck)}, socket}
  end

  def handle_info({:after_join, message}, socket) do
    user = Repo.get!(User, socket.assigns.user_id)

    case GameOperations.find(message["game_id"]) do
      :no_id ->
        :nothing
      :error ->
        socket |> push "error", %{code: "GAME_ERR", message: "Game not exists"}
      game ->
        socket |> push "game", %{game: game}
    end

    {:noreply, socket}
  end

  def handle_in("user:update", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    user = UserOperations.update(user, message["user"])

    socket |> push "user", %{user: user}
    {:noreply, socket}
  end

  def handle_in("game:create", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    game = GameOperations.create(message, user) |> Repo.preload([:owner, :deck])

    socket |> push "game", %{game: game}
    {:noreply, socket}
  end
end
