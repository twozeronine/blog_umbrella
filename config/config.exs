import Config

config :blog_web,
  generators: [context_app: false]

config :blog_web, BlogWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BlogWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Blog.PubSub,
  live_view: [signing_salt: "k7jl+RnG"]

config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../apps/blog_web/assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :blog_domain,
  ecto_repos: [BlogDomain.Repo]

config :blog_api,
  ecto_repos: [BlogDomain.Repo],
  generators: [context_app: :blog_domain]

config :blog_api, BlogApi.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: BlogApi.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Blog.PubSub,
  live_view: [signing_salt: "Og51exPx"]

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix, :json_library, Jason

import_config "#{config_env()}.exs"
