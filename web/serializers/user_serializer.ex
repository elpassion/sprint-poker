defmodule PlanningPoker.UserSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.User do
    def encode(user, options) do
      %{
        name: user.name,
        uuid: user.uuid
      } |> Poison.Encoder.encode(options)
    end
  end
end

