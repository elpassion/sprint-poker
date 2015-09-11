use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sprint_poker, SprintPoker.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :sprint_poker, SprintPoker.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "postgress",
  pool: Ecto.Adapters.SQL.Sandbox
