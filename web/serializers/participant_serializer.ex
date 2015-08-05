defmodule PlanningPoker.ParticipantSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Participant do
    def encode(participant, options) do
      hash = %{
        id: participant.id,
        name: participant.name,
        uuid: participant.uuid
      }

      if Ecto.Association.loaded?(participant.rooms) do
        hash = hash |> Dict.put(:rooms, participant.rooms)
      end

      hash |> Poison.Encoder.encode(options)
    end
  end
end

