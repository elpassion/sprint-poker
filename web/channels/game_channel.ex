defmodule PlanningPoker.GameChannel do
  use Phoenix.Channel

  alias PlanningPoker.Repo
  alias PlanningPoker.User
  alias PlanningPoker.Game
  alias PlanningPoker.Ticket

  alias PlanningPoker.UserOperations
  alias PlanningPoker.SocketOperations
  alias PlanningPoker.StateOperations
  alias PlanningPoker.TicketOperations

  def join("game:" <> game_id, message, socket) do
    game = Repo.get!(Game, game_id)
    user = Repo.get!(User, socket.assigns.user_id)

    UserOperations.connect(user, game)

    send(self, {:after_join, message})
    {:ok, socket}
  end

  def terminate(_message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)

    UserOperations.disconnect(user, game)

    game = game |> Game.preload
    socket |> broadcast "game", %{game: game}
  end

  def handle_info({:after_join, _message}, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)

    game = game |> Game.preload

    socket |> broadcast "game", %{game: game}
    socket |> push "state", %{ state: StateOperations.hide_votes(game.state, user) }

    {:noreply, socket}
  end

  def handle_in("ticket:create", message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)

    if SocketOperations.is_owner?(user, game) do
      TicketOperations.create(message["ticket"], game)

      game = game |> Game.preload
      socket |> broadcast "game", %{game: game}
    end
    {:noreply, socket}
  end

  def handle_in("ticket:delete", message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)

    if SocketOperations.is_owner?(user, game) do
      TicketOperations.delete(message["ticket"])

      game = game |> Game.preload
      socket |> broadcast "game", %{game: game}
    end
    {:noreply, socket}
  end

  def handle_in("ticket:update", message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)
    ticket = Repo.get!(Ticket, message["ticket"]["id"])

    if SocketOperations.is_owner?(user, game) do
      TicketOperations.update(ticket, message["ticket"])

      game = game |> Game.preload
      socket |> broadcast "game", %{game: game}
    end
    {:noreply, socket}
  end

  def handle_in("state:update", message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)
    game = game |> Repo.preload [:state]

    if SocketOperations.is_owner?(user, game) do
      state = StateOperations.update(game.state, message["state"])
      socket |> broadcast "state", %{ state: state }
    end
    {:noreply, socket}
  end

  def handle_in("state:update:vote", message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)
    game = game |> Repo.preload [:state]

    state = StateOperations.update(game.state,
      %{ votes: Dict.put(game.state.votes, user.id, message["vote"]["points"]) })

    socket |> broadcast "state", %{ state: state }
    {:noreply, socket}
  end

  intercept ["state"]
  def handle_out("state", message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    socket |> push "state", %{ state: StateOperations.hide_votes(message.state, user) }
    {:noreply, socket}
  end

end
