defmodule PlanningPoker.DeckSerializer do
  defimpl Poison.Encoder, for: PlanningPoker.Deck do
    def encode(deck, options) do
      %{
        name: deck.name,
        cards: deck.cards
      } |> Poison.Encoder.encode(options)
    end
  end
end


