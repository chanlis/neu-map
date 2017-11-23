# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :neu_map,
  ecto_repos: [NeuMap.Repo]

# Configures the endpoint
config :neu_map, NeuMapWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "58w48W4y+Fh6U/f1Mnci/y1ykp1vmWPvlu5507drbyqwcE8pkIi33thigAhJZFUS",
  render_errors: [view: NeuMapWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: NeuMap.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
