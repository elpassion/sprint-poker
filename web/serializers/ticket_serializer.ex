defimpl Poison.Encoder, for: SprintPoker.Ticket do
  def encode(ticket, options) do
    %{
      id: ticket.id,
      name: ticket.name,
      points: ticket.points
    } |> Poison.Encoder.encode(options)
  end
end
