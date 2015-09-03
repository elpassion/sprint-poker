ExUnit.start

Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
Mix.Task.run "run", ["priv/repo/seeds.exs", "--quiet"]
Ecto.Adapters.SQL.begin_test_transaction(PlanningPoker.Repo)

