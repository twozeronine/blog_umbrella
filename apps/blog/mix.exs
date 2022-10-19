defmodule Blog.MixProject do
  use Mix.Project

  def project() do
    [
      app: :blog,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      aliases: aliases()
    ]
  end

  def application() do
    [
      mod: {Blog.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  defp deps() do
    [
      {:phoenix_pubsub, "~> 2.0"},
      {:argon2_elixir, "~> 3.0"}
    ]
  end

  defp aliases() do
    [
      setup: ["deps.get"]
    ]
  end
end
