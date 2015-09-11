defimpl Poison.Encoder, for: SprintPoker.User do
  def encode(user, options) do
    hash = %{
      id: user.id,
      name: user.name
    }

    if user.state do
      hash = hash |> Dict.put(:state, user.state)
    end

    hash |> Poison.Encoder.encode(options)
  end
end
