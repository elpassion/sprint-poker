defmodule PlanningPoker.RoomSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Room do
    def encode(room, options) do
      hash = %{
        id: room.id,
        title: room.title,
        uuid: room.uuid
      }

      if Ecto.Association.loaded?(room.tickets) do
        hash = Dict.put(
          hash,
          :puttickets,
          Poison.Encoder.encode(room.tickets, options)
        )
      end

      if Ecto.Association.loaded?(room.participants) do
        hash = Dict.put(
          hash,
          :participants,
          Poison.Encoder.encode(room.participants, options)
        )
      end

      Poison.Encoder.encode(hash, options)
    end
  end
end

