defimpl Poison.Encoder, for: SprintPoker.Repo.Ticket do
  def encode(ticket, options) do
    %{
      id: ticket.id,
      name: ticket.name,
      points: ticket.points
    } |> Poison.Encoder.encode(options)
  end
end
