defmodule SprintPoker.Endpoint do
  use Phoenix.Endpoint, otp_app: :sprint_poker

  socket "/ws", SprintPoker.UserSocket

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
end
