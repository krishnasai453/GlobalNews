# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :news_app,
  ecto_repos: [NewsApp.Repo]

# Configures the endpoint
config :news_app, NewsApp.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "6WQoZ7z434lnuK6IGfSPJyXVDepy0pwtCx9KE0d4Mwb3DsBOeNryXTI63uXoCd99",
  render_errors: [view: NewsApp.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NewsApp.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configure phoenix generators
config :phoenix, :generators,
  binary_id: true,
  migration: false,
  sample_binary_id: "111111111111111111111111"

config :quantum, :news_app,
cron: [
   # Every 15 minutes "*/15 * * * *"
   # Every 1 minute "* * * * *"
    "*/15 * * * *": {NewsApp.CronJobHandler, :cron_job}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
