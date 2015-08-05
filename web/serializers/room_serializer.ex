defmodule PlanningPoker.RoomSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Room do
    def encode(room, options) do
      hash = %{
        id: room.id,
        title: room.title,
        uuid: room.uuid
      }

      if Ecto.Association.loaded?(room.tickets) do
        hash = hash |> Dict.put(:tickets, room.tickets)
      end

      if Ecto.Association.loaded?(room.participants) do
        hash = hash |> Dict.put(:participants, room.participants)
      end

      hash |> Poison.Encoder.encode(options)
    end
  end
end

