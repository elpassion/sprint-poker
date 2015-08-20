defmodule PlanningPoker.GameSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Game do
    def encode(game, options) do
      hash =  %{
        id: game.id,
        name: game.name,
        users: [],
        owner: %{},
        errors: %{}
      }

      if Ecto.Association.loaded?(game.owner) do
        hash = hash |> Dict.put(:owner, game.owner)
      end

      if Ecto.Association.loaded?(game.users) do
        hash = hash |> Dict.put(:users, game.users)
      end

      if Ecto.Association.loaded?(game.deck) do
        hash = hash |> Dict.put(:deck, game.deck)
      end

      hash |> Poison.Encoder.encode(options)
    end
  end
end
