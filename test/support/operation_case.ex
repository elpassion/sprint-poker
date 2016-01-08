defmodule SprintPoker.OperationCase do
  use ExUnit.CaseTemplate
  using do
    quote do
      alias SprintPoker.Repo
      import SprintPoker.Factory
    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(SprintPoker.Repo, [])
    end
    :ok
  end
end
