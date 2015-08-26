defimpl Poison.Encoder, for: PlanningPoker.State do
  def encode(state, options) do
    %{
      name: state.name,
      current_ticket_index: state.current_ticket_index,
      votes: state.votes
    } |> Poison.Encoder.encode(options)
  end
end
