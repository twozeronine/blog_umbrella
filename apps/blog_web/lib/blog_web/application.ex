defmodule BlogWeb.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BlogWeb.Telemetry,
      BlogWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: BlogWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    BlogWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
