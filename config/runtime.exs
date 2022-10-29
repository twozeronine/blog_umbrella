import Config

config :blog_api, BlogApi.Endpoint, secret_key_base: System.get_env("SECRET_KEY_BASE")

config :joken, default_signer: System.get_env("JOKEN_KEY_BASE")
