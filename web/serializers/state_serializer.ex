defimpl Poison.Encoder, for: PlanningPoker.State do
  def encode(state, options) do
    hash = %{
      name: state.name,
      current_ticket_index: nil,
      votes: %{}
    }

    if state.votes do
      if state.name == "finished" do
        hash = hash |> Dict.put(:votes, state.votes)
      else
        hash = hash |> Dict.put(:votes, Enum.map(state.votes, fn {k, _v} -> {k, nil} end))
      end
    end
    hash |> Poison.Encoder.encode(options)
  end
end
