defmodule SprintPoker.Web.Endpoint do
  use Phoenix.Endpoint, otp_app: :sprint_poker

  socket "/ws", SprintPoker.Web.UserSocket

  plug Plug.RequestId
  plug Plug.Logger

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison
end
