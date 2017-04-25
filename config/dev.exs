use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :sprint_poker, SprintPoker.Web.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  check_origin: false

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Configure your database
config :sprint_poker, SprintPoker.Repo,
  adapter: Ecto.Adapters.Postgres,
  database: "sprint_poker_dev",
  pool_size: 10 # The amount of database connections in the pool
