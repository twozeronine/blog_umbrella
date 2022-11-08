defmodule Blog.PubSub do
  @topic "#{__MODULE__}"

  def child_spec() do
    [
      name: __MODULE__,
      adapter: Phoenix.PubSub.PG2,
      pool_size: System.schedulers_online()
    ]
    |> Phoenix.PubSub.child_spec()
  end

  def subscribe() do
    Phoenix.PubSub.unsubscribe(__MODULE__, @topic)
    Phoenix.PubSub.subscribe(__MODULE__, @topic)
  end

  def unsubscribe() do
    Phoenix.PubSub.unsubscribe(__MODULE__, @topic)
  end

  def broadcast({_event, _data} = message) do
    Phoenix.PubSub.broadcast(__MODULE__, @topic, message)
  end
end
