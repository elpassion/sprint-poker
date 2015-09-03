defimpl Poison.Encoder, for: PlanningPoker.Deck do
  def encode(deck, options) do
    %{
      id: deck.id,
      name: deck.name,
      cards: deck.cards
    } |> Poison.Encoder.encode(options)
  end
end
