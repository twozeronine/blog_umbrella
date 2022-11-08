defmodule Blog.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      Blog.PubSub.child_spec()
    ]

    options = [
      {:name, __MODULE__},
      {:strategy, :one_for_one}
    ]

    Supervisor.start_link(children, options)
  end
end
