import Config

config :blog_web, BlogWeb.Endpoint,
  url: [scheme: "https", host: "twozeronine.com", port: 443],
  http: [
    port: 8080,
    transport_options: [
      socket_opts: [:inet6],
      num_acceptors: 1_000,
      max_connections: 1_048_576
    ]
  ],
  server: true,
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  check_origin: false

config :blog_domain, BlogDomain.Repo,
  database: "blog_prod",
  pool_size: 10,
  port: 5432,
  priv: "priv/repo",
  ssl: false,
  socket_options: [:inet6]

config :blog_api, BlogApi.Endpoint,
  url: [scheme: "https", host: "twozeronine.com", port: 443],
  http: [
    port: 8080,
    transport_options: [
      socket_opts: [:inet6],
      num_acceptors: 1_000,
      max_connections: 1_048_576
    ]
  ],
  server: true,
  check_origin: false,
  force_ssl: [rewrite_on: [:x_forwarded_proto]]

config :logger, level: :info
