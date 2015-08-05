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
          :tickets,
          room.tickets
        )
      end

      if Ecto.Association.loaded?(room.participants) do
        hash = Dict.put(
          hash,
          :participants,
          room.participants
        )
      end

      Poison.Encoder.encode(hash, options)
    end
  end
end

