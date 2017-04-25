defimpl Poison.Encoder, for: SprintPoker.State do
  def encode(state, options) do
    current_ticket_id = case state.current_ticket_id do
      nil -> nil
      id -> Integer.to_string(id)
    end
    %{
      name: state.name,
      current_ticket_id: current_ticket_id,
      votes: state.votes
    } |> Poison.Encoder.encode(options)
  end
end
