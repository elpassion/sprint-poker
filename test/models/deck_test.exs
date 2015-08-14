defmodule PlanningPoker.DeckTest do
  use PlanningPoker.ModelCase

  alias PlanningPoker.Deck
  alias PlanningPoker.Repo

  test "don't create empty deck" do
    assert_raise Postgrex.Error, fn ->
      %Deck{} |> Repo.insert!
    end
  end

  test "don't create deck without name" do
    assert_raise Postgrex.Error, fn ->
      %Deck{
        cards: []
      } |> Repo.insert!
    end
  end

  test "create deck with name and cards" do
    deck = %Deck{
      name: "sample name",
      cards: []
    } |> Repo.insert!

    assert deck
  end
end
