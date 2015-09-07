defmodule PlanningPoker.Repo do
  use Ecto.Repo, otp_app: :planning_poker

  def log(log_entry) do
    Metrix.sample "ecto.query.exec_time", "#{log_entry.query_time + log_entry.queue_time || 0}µs"
    Metrix.sample "ecto.query.queue_time", "#{log_entry.queue_time || 0}µs"
    Metrix.count "ecto.query.count"

    super log_entry
  end
end
