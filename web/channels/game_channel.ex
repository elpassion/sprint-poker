defmodule SprintPoker.GameChannel do
  use Phoenix.Channel

  alias SprintPoker.Repo
  alias SprintPoker.User
  alias SprintPoker.Game
  alias SprintPoker.Ticket

  alias SprintPoker.UserOperations
  alias SprintPoker.GameUserOperations
  alias SprintPoker.SocketOperations
  alias SprintPoker.StateOperations
  alias SprintPoker.TicketOperations

  def join("game:" <> game_id, message, socket) do
    user = Repo.get!(User, socket.assigns.user_id)
    game = Repo.get!(Game, game_id)

    UserOperations.connect(user, game)

    game = game |> Game.preload
    state = StateOperations.hide_votes(game.state, user)

    response = %{"game": game, "state": state}
    {:ok, response, socket}
  end

  def terminate(_message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)

    UserOperations.disconnect(user, game)

    game = game |> Game.preload
    socket |> broadcast "game", %{game: game}
  end

  def handle_in("ticket:create", message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)

    if GameUserOperations.is_owner?(game, user) do
      case TicketOperations.create(message["ticket"], game) do
        {:ok, _} ->
          game = game |> Game.preload
          result = {:ok, %{game: game}}
          socket |> broadcast "game", %{game: game}
        {:error, errors} ->
          result = {:error, errors}
      end
    else
      result = {:error, %{errors: ["Unauthorized"]}}
    end

    {:reply, result, socket}
  end

  def handle_in("ticket:delete", message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)

    if GameUserOperations.is_owner?(game, user) do
      TicketOperations.delete(message["ticket"])
      game = game |> Game.preload
      result = {:ok, %{game: game}}
      socket |> broadcast "game", %{game: game}
    else
      result = {:error, %{errors: ["Unauthorized"]}}
    end

    {:reply, result, socket}
  end

  def handle_in("ticket:update", message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)
    ticket = Repo.get!(Ticket, message["ticket"]["id"])

    if GameUserOperations.is_owner?(game, user) do
      case TicketOperations.update(ticket, message["ticket"]) do
        {:ok, _} ->
          game = game |> Game.preload
          result = {:ok, %{game: game}}
          socket |> broadcast "game", %{game: game}
        {:error, errors} ->
          result = {:error, errors}
      end
    else
      result = {:error, %{errors: ["Unauthorized"]}}
    end

    {:reply, result, socket}
  end

  def handle_in("state:update", message, socket) do
    {game, user} = SocketOperations.get_game_and_user(socket)
    game = game |> Repo.preload [:state]

    if GameUserOperations.is_owner?(game, user) do
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
