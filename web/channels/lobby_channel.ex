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

  def handle_info({:after_join, _message}, socket) do
    user = Repo.get(User, socket.assigns.user_id)

    socket |> push "auth_token", %{auth_token: user.auth_token}
    socket |> push "user", %{user: user}
    socket |> push "decks", %{decks: Repo.all(Deck)}
    {:noreply, socket}
  end

  def handle_in("change_user_name", message, socket) do
    user = %{Repo.get(User, socket.assigns.user_id) | name: message["name"]} |> Repo.update!

    socket |> push "user", %{user: user}
    {:noreply, socket}
  end

  def handle_in("create_game", message, socket) do
    game = Repo.insert!(
      %Game{
        name: message["name"],
        owner_id: Repo.get(User, socket.assigns.user_id).id,
        deck_id: Repo.get(Deck, message["deck_id"]).id
      }
    ) |> Repo.preload([:owner])

    socket |> push "game", %{game: game}
    {:noreply, socket}
  end
end
