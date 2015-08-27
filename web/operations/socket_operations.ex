defmodule PlanningPoker.SocketOperations do
  alias PlanningPoker.Repo
  alias PlanningPoker.Game
  alias PlanningPoker.User

  def game_and_user(socket) do
    "game:" <> game_id = socket.topic
    game = Repo.get!(Game, game_id)
    user = Repo.get!(User, socket.assigns.user_id)
    {game, user}
  end
end
