defmodule PlanningPoker.GameChannel do
  use Phoenix.Channel

  alias PlanningPoker.Repo
  alias PlanningPoker.User
  alias PlanningPoker.Game
  alias PlanningPoker.GameUser
  alias PlanningPoker.Ticket
  alias PlanningPoker.State

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

    if game.state do
      state = Repo.get_by(State, game_id: game.id)
      IO.inspect state
      socket |> push "state", %{state: state}
    else
      # state = %State{} |> State.changeset(%{name: "none", game_id: game.id}) |> Repo.insert!
      #socket |> push "state", %{state: state}
    end

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
        name: message["ticket"]["name"]
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

  def handle_in("voting_ticket_index", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)

    if game.owner_id == user.id do
      socket |> broadcast "voting_ticket_index", message
    end
    {:noreply, socket}
  end

  def handle_in("voting_voted", _message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    socket |> broadcast "voting_voted", %{user_id: user.id}
    {:noreply, socket}
  end

  def handle_in("voting_finish", _message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)

    if game.owner_id == user.id do
      socket |> broadcast "voting_finish", %{}
    end
    {:noreply, socket}
  end

  def handle_in("voting_points", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    socket |> broadcast "voting_points", %{user_id: user.id, points: message["points"]}
    {:noreply, socket}
  end

  def handle_in("update_state", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)

    if game.owner_id == user.id do
      state = Repo.get!(State, message["state"]["id"])
      changeset = State.changeset(state, message["state"])

      case changeset do
        {:error, errors} ->
          raise errors
        _ ->
          changeset |> Repo.update!
      end

      socket |> broadcast "state", state
    end
    {:noreply, socket}
  end

end
