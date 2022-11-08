defmodule BlogDomain.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      BlogDomain.Repo
    ]

    opts = [strategy: :one_for_one, name: __MODULE__]
    BlogDomain.Repo.migrate()
    Supervisor.start_link(children, opts)


  end
end
