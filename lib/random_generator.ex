defmodule PlanningPoker.RandomGenerator do
  def name do
    color = Faker.Commerce.color() |> String.capitalize()
    creature = Faker.Team.creature() |> String.capitalize() |> Inflex.singularize()

    "#{color} #{creature}"
  end
end
