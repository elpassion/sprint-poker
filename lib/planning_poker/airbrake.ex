defmodule PlanningPoker.Airbrake do
  def start_link do
    Airbrake.start
    {:ok, self}
  end
end
