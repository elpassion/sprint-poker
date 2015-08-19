# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :planning_poker, PlanningPoker.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "ZxLhVLGlxT/2YhQE0pIthf8utPtLgxAwMnGRZNW3kCqpszn4yNJnZqpwXSAOW9Pj",
  render_errors: [accepts: "json"],
  pubsub: [name: PlanningPoker.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :rollbax,
  access_token: System.get_env("ROLLBAR_ACCESS_TOKEN") || "",
  environment: Mix.env

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
