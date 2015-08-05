defmodule PlanningPoker.TicketSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Ticket do
    def encode(ticket, options) do
      hash = %{
        id: ticket.id,
        name: ticket.name,
        final_estimation: ticket.final_estimation
      }

      if Ecto.Association.loaded?(ticket.owner) do
        hash = Dict.put(
          hash,
          :owner,
          ticket.owner
        )
      end

      if Ecto.Association.loaded?(ticket.room) do
        hash = Dict.put(
          hash,
          :room,
          ticket.room
        )
      end

      Poison.Encoder.encode(hash, options)
    end
  end
end

