defmodule SprintPoker.Web.UserSocket do
  use Phoenix.Socket

  alias Phoenix.Transports.WebSocket
  alias Phoenix.Transports.LongPoll

  alias SprintPoker.Web.LobbyChannel
  alias SprintPoker.Web.GameChannel

  alias SprintPoker.UserOperations

  ## Channels
  channel "lobby", LobbyChannel
  channel "game:*", GameChannel

  ## Transports
  transport :websocket, WebSocket
  transport :longpoll, LongPoll

  def connect(params, socket) do
    {
      :ok,
      assign(
        socket,
        :user_id,
        UserOperations.get_or_create(params["auth_token"]).id
      )
    }
  end

  def id(socket), do: "user:#{socket.assigns.user_id}"
end
