use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :planning_poker, PlanningPoker.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :planning_poker, PlanningPoker.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "planning_poker_test",
  pool: Ecto.Adapters.SQL.Sandbox
