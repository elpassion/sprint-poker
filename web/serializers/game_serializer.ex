defmodule PlanningPoker.GameSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Game do
    def encode(game, options) do
      hash =  %{
        id: game.id,
        name: game.name,
        users: [],
        owner: %{},
        deck_id: game.deck_id,
        errors: %{}
      }

      if Ecto.Association.loaded?(game.owner) do
        hash = hash |> Dict.put(:owner, game.owner)
      end

      if Ecto.Association.loaded?(game.users) do
        hash = hash |> Dict.put(:users, game.users)
      end

      hash |> Poison.Encoder.encode(options)
    end
  end
end
