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

    unless Repo.get_by(GameUser, game_id: game.id, user_id: user.id) do
      changeset = GameUser.changeset(%GameUser{}, %{
        game_id: game.id,
        user_id: user.id
      })

      case changeset do
        {:error, errors} ->
          raise errors
        _ ->
          changeset |> Repo.insert!
      end
    end

    send(self, {:after_join, message})
    {:ok, socket}
  end

  def terminate(_message, socket) do
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)
    user = Repo.get!(User, socket.assigns.user_id)

    Repo.get_by(GameUser, game_id: game.id, user_id: user.id) |> Repo.delete!

    game = game |> Game.preload
    socket |> broadcast "game", %{game: game}
  end

  def handle_info({:after_join, _message}, socket) do
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id) |> Game.preload

    socket |> broadcast "game", %{game: game}
    {:noreply, socket}
  end

  def handle_in("create_ticket", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)

    if game.owner_id == user.id do
      changeset = Ticket.changeset(%Ticket{}, %{
        name: message["ticket"]["name"],
        game_id: game.id
      })

      case changeset do
        {:error, errors} ->
          raise errors
        _ ->
          changeset |> Repo.insert!
      end

      game = game |> Game.preload
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

      game = game |> Game.preload
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
      changeset = Ticket.changeset(ticket, %{
        name: "skdjfnskjdfhsjdfg sjdgfjshgdf ksjdhfksjhdfksjdhfkajshdgfajdfhlasdjkfhlksdjfhgksjdhfg kjsdhf gkjsdhfgkjshdfkgjhsd fkjghs dkfjghs dkfjhg sdkjhg skdjfhg ksdjhg ksjdhfkasjdhfka jshf kajsdhf kajsdhf kajsdhfkajsdhfkajsdhfkajsdhfaksjdhfa ksdjfha ksdjfh aksjdhf aksjdhf kasjdhf kj3h4kjh3k4j5h3k4j5h3k45h3k4j5h34k534534534k5j3h4k5jh3 4kj5h34k5jh3k45j345jh3k45jh345j3h45k3j45hk3j4h53kj45h3k4j5h3k4j5h345345345 345345 34534 345345345345" #message["ticket"]["name"]
      })

      case changeset do
        {:error, errors} ->
          raise errors
        _ ->
          changeset |> Repo.update!
      end

      game = game |> Game.preload
      socket |> broadcast "game", %{game: game}
    end
    {:noreply, socket}
  end
end
