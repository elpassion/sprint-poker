defmodule PlanningPoker.GameSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Game do
    def encode(game, options) do
      hash =  %{
        id: game.id,
        name: game.name
      }

      if Ecto.Association.loaded?(game.owner) do
        hash = hash |> Dict.put(:owner, game.owner)
      end

      hash |> Poison.Encoder.encode(options)
    end
  end
end
