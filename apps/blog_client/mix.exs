defmodule BlogClient.MixProject do
  use Mix.Project

  def project() do
    [
      app: :blog_client,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.14-rc",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
    ]
  end

  def application() do
    [
      extra_applications: [:logger, :jason],
      mod: {BlogClient.Application, []}
    ]
  end

  defp deps() do
    [
      {:httpoison, "~> 1.8"},
      {:castore, "~> 0.1.0"},
      {:mint, "~> 1.0"}
    ]
  end
end
