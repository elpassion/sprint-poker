defmodule PlanningPoker.BrowserCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ExUnit.Case
      use TucoTuco.DSL

      setup_all do
        port = PlanningPoker.Endpoint.config(:http)[:port]

        #{:ok, _} = TucoTuco.start_session :test_browser, :guest_session, :firefox
        {:ok, _} = TucoTuco.start_session :test_browser, :owner_session, :firefox
        TucoTuco.app_root "http://localhost:#{port}"
        TucoTuco.use_retry true
        TucoTuco.max_retry_time 3000
        TucoTuco.retry_delay 300

        on_exit fn -> TucoTuco.stop end
        :ok
      end
    end
  end

  setup tags do
    unless tags[:async] do
      Ecto.Adapters.SQL.restart_test_transaction(PlanningPoker.Repo, [])
    end
    :ok
  end
end
