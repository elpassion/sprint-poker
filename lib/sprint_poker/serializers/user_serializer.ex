defimpl Poison.Encoder, for: SprintPoker.Repo.User do
  def encode(user, options) do
    hash = %{
      id: user.id,
      name: user.name
    }

    hash = if user.state do
      hash |> Map.put(:state, user.state)
    else
      hash
    end

    hash |> Poison.Encoder.encode(options)
  end
end
