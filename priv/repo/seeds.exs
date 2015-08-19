# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     PlanningPoker.Repo.insert!(%SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias PlanningPoker.Repo
alias PlanningPoker.Deck

Repo.insert!(%Deck{name: "Fibonacci", cards: ["1","2","3","5","8","13","40","100"]})
Repo.insert!(%Deck{name: "T-Shirts", cards: ["S","M","L","XXL"]})
Repo.insert!(%Deck{name: "Powers of 2", cards: ["1","2","4","8","16","32","64","128"]})
Repo.insert!(%Deck{name: "No Bullsh*t", cards: ["1","TFB","NFC"]})
