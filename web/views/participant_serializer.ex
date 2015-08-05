defmodule PlanningPoker.ParticipantSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Participant do
    def encode(participant, options) do
      hash = %{
        id: participant.id,
        name: participant.name,
        uuid: participant.uuid
      }

      if Ecto.Association.loaded?(participant.rooms) do
        hash = Dict.put(
          hash,
          :rooms,
          Poison.Encoder.encode(participant.rooms)
        )
      end

      Poison.Encoder.encode(hash, options)
    end
  end
end

