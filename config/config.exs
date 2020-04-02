# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gat_chat,
  ecto_repos: [GatChat.Repo]

# Configures the endpoint
config :gat_chat, GatChatWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "57dPEgrbp835N/HDw33PvxPpXJuk9LIHkuIb8q67uS0N4jLXsvYPBVe3pM33WVvb",
  render_errors: [view: GatChatWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: GatChat.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
