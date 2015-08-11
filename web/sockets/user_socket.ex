defmodule PlanningPoker.UserSocket do
  use Phoenix.Socket
  alias PlanningPoker.RandomGenerator
  alias PlanningPoker.Repo
  alias PlanningPoker.User

  ## Channels
  channel "lobby", PlanningPoker.LobbyChannel
  channel "planning:*", PlanningPoker.PlanningChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  def connect(params, socket) do
    IO.inspect(params)
    {:ok, assign(socket, :user_id, get_or_create_user(params).id)}
  end

  def id(socket), do: nil #"users:#{socket.assigns.user_id}"

  defp get_or_create_user(%{"id" => id}) do
    Repo.get(User, id) || get_or_create_user(nil)
  end

  defp get_or_create_user(_) do
    Repo.insert!(
      %User{
        name: RandomGenerator.name()
      }
    )
  end

end
