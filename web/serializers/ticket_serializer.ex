defmodule PlanningPoker.TicketSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Ticket do
    def encode(ticket, options) do
      hash = %{
        id: ticket.id,
        name: ticket.name,
        final_estimation: ticket.final_estimation
      }

      if Ecto.Association.loaded?(ticket.owner) do
        hash = hash |> Dict.put(:owner, ticket.owner)
      end

      if Ecto.Association.loaded?(ticket.room) do
        hash = hash |> Dict.put(:room, ticket.room)
      end

      hash |> Poison.Encoder.encode(options)
    end
  end
end

