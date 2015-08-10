defmodule PlanningPoker.SessionSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Session do
    def encode(session, options) do
      hash =  %{
        id: session.id,
        name: session.name
      }

      if Ecto.Association.loaded?(session.owner) do
        hash = hash |> Dict.put(:owner, session.owner)
      end

      hash |> Poison.Encoder.encode(options)
    end
  end
end
