import Config

config :blog_web, BlogWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "svlAM181wfCBDbhEd/RP1mtDjG6v1wMn258IXKloLDgNu9u7LRq/Knu0uJg8O2mW",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]}
  ]

config :blog_web, BlogWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/blog_web/(live|views)/.*(ex)$",
      ~r"lib/blog_web/templates/.*(eex)$"
    ]
  ]

config :blog_domain, BlogDomain.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "blog_dev",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10,
  port: 25432,
  priv: "priv/repo"

config :blog_api, BlogApi.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4040],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "wj68pGVLMdwOol2JD6cReya05KJ0/roNunUGNFTChjDEDEb/v22Sdhjidt0KQR3w",
  watchers: [],
  server: true

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :plug_init_mode, :runtime

config :phoenix, :stacktrace_depth, 20

config :blog_client, BlogClient,
  host: "localhost",
  port: 4000,
  scheme: :http,
  api_url: "http://localhost:4000/api",
  default_client: BlogClient.HttpoisonClient,
  headers: [{"Content-Type", "application/json"}]

config :joken, default_signer: "WyXp6HJItNZqkSvkPUHsQWKnChlLQQ+J8f3dMYCrQCKCfNpFiw8bjsd2+LOmGJOA"
