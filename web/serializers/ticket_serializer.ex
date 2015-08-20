defmodule PlanningPoker.TicketSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Ticket do
    def encode(ticket, options) do
      %{
        id: ticket.id,
        name: ticket.name,
        points: ticket.points,
        errors: %{}
      } |> Poison.Encoder.encode(options)
    end
  end
end

