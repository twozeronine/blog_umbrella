defmodule BlogClient.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = []

    opts = [
      {:name, __MODULE__},
      {:strategy, :one_for_one},
      {:max_seconds, 1},
      {:max_restarts, 1_000}
    ]

    Supervisor.start_link(children, opts)
  end
end
