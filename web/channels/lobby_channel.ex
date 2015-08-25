defmodule PlanningPoker.LobbyChannel do
  use Phoenix.Channel

  alias PlanningPoker.Repo
  alias PlanningPoker.User
  alias PlanningPoker.Game
  alias PlanningPoker.Deck

  def join("lobby", message, socket) do
    send(self, {:after_join, message})
    {:ok, socket}
  end

  def handle_info({:after_join, message}, socket) do
    user = Repo.get!(User, socket.assigns.user_id)

    socket |> push "auth_token", %{auth_token: user.auth_token}
    socket |> push "user", %{user: user}
    socket |> push "decks", %{decks: Repo.all(Deck)}

    case message do
      %{"game_id" => game_id} ->
        case Game.get(game_id) do
          nil ->
            socket |> push "error", %{code: "GAME_ERR", message: "Game not exists"}
          game ->
            game = game |> Repo.preload([:owner, :deck])
            socket |> push "game", %{game: game}
        end
      _ -> # nothing
    end

    {:noreply, socket}
  end

  def handle_in("update_user", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    changeset = User.changeset(user, %{
      name: message["user"]["name"]
    })

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        user = changeset |> Repo.update!
    end

    socket |> push "user", %{user: user}
    {:noreply, socket}
  end

  def handle_in("create_game", message, socket) do
    changeset = Game.changeset(%Game{}, %{
      name: message["name"],
      owner_id: Repo.get!(User, socket.assigns.user_id).id,
      deck_id: Repo.get!(Deck, message["deck"]["id"]).id
    })

    case changeset do
      {:error, errors} ->
        raise errors
      _ ->
        game = changeset |> Repo.insert!
    end

    game = game |> Repo.preload([:owner, :deck])

    socket |> push "game", %{game: game}
    {:noreply, socket}
  end

  def handle_in("game_info", message, socket) do
    game = Repo.get!(Game, message["game_id"])

    socket |> push "game", %{game: game}

    {:noreply, socket}
  end

end
