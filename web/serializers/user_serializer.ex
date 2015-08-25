defmodule PlanningPoker.UserSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.User do
    def encode(user, options) do
      %{
        id: user.id,
        name: user.name,
        errors: %{}
      } |> Poison.Encoder.encode(options)
    end
  end
end

