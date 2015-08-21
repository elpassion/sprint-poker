defmodule PlanningPoker.GameChannel do
  use Phoenix.Channel

  alias PlanningPoker.Repo
  alias PlanningPoker.User
  alias PlanningPoker.Game
  alias PlanningPoker.GameUser
  alias PlanningPoker.Ticket

  def join("game:" <> game_id, message, socket) do
    game = Repo.get!(Game, game_id)
    user = Repo.get!(User, socket.assigns.user_id)

    Repo.get_by(GameUser, game_id: game.id, user_id: user.id) || Repo.insert!(
      %GameUser{
        game_id: game.id,
        user_id: user.id
      }
    )
    send(self, {:after_join, message})
    {:ok, socket}
  end

  def terminate(_message, socket) do
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)
    user = Repo.get!(User, socket.assigns.user_id)

    Repo.get_by(GameUser, game_id: game.id, user_id: user.id)
    |> Repo.delete!

    game = game |> Repo.preload([:owner, :deck, :users, :tickets])
    socket |> broadcast "game", %{game: game}
  end

  def handle_info({:after_join, _message}, socket) do
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)
    |> Repo.preload([:owner, :deck, :users, :tickets])

    socket |> broadcast "game", %{game: game}
    {:noreply, socket}
  end

  def handle_in("create_ticket", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)

    if game.owner_id == user.id do
      %Ticket{
        name: message["ticket"]["name"],
        game_id: game.id
      } |> Repo.insert!

      game = game |> Repo.preload([:owner, :deck, :users, :tickets])
      socket |> broadcast "game", %{game: game}
    end
    {:noreply, socket}
  end

  def handle_in("delete_ticket", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)

    if game.owner_id == user.id do
      Repo.get!(Ticket, message["ticket"]["id"]) |> Repo.delete!

      game = game |> Repo.preload([:owner, :deck, :users, :tickets])
      socket |> broadcast "game", %{game: game}
    end
    {:noreply, socket}
  end

  def handle_in("update_ticket", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)
    ticket = Repo.get!(Ticket, message["ticket"]["id"])
    if game.owner_id == user.id && ticket.name != message["ticket"]["name"] do
      %{ticket | name: String.slice(message["ticket"]["name"], 0..254)} |> Repo.update!

      game = game |> Repo.preload([:owner, :deck, :users, :tickets])
      socket |> broadcast "game", %{game: game}
    end
    {:noreply, socket}
  end
end
