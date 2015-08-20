defmodule PlanningPoker.GameSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Game do
    def encode(game, options) do
      hash =  %{
        id: game.id,
        name: game.name,
        users: [],
        tickets: [],
        owner: %{},
        errors: %{}
      }

      if Ecto.Association.loaded?(game.owner) do
        hash = hash |> Dict.put(:owner, game.owner)
      end

      if Ecto.Association.loaded?(game.users) do
        hash = hash |> Dict.put(:users, Enum.sort(game.users, &(&1.name < &2.name)))
      end

      if Ecto.Association.loaded?(game.tickets) do
        hash = hash |> Dict.put(:tickets, Enum.sort(game.tickets, &(&1.id < &2.id)))
      end

      if Ecto.Association.loaded?(game.deck) do
        hash = hash |> Dict.put(:deck, game.deck)
      end

      hash |> Poison.Encoder.encode(options)
    end
  end
end
