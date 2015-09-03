defmodule PlanningPoker.UserSocket do
  use Phoenix.Socket
  alias PlanningPoker.UserOperations

  ## Channels
  channel "lobby", PlanningPoker.LobbyChannel
  channel "game:*", PlanningPoker.GameChannel

  ## Transports
  transport :websocket, Phoenix.Transports.WebSocket
  transport :longpoll, Phoenix.Transports.LongPoll

  def connect(params, socket) do
    {:ok, assign(socket, :user_id, UserOperations.get_or_create(params["auth_token"]).id)}
  end

  def id(socket), do: "user:#{socket.assigns.user_id}"
end
