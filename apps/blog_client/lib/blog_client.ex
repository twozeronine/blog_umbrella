defmodule BlogClient do
  use GenServer

  def get_user(user_id) do
    case HTTPoison.get("http://localhost:4000/api/users/#{user_id}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> IO.puts(body)
      {:ok, %HTTPoison.Response{status_code: 400}} -> IO.puts("Not found")
      {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect(reason)
    end
  end

  def register_user({user_name, user_email, password}) do
    req_body = Jason.encode!(%{user_name: user_name, user_email: user_email, password: password})

    case HTTPoison.post(
           "http://localhost:4000/api/users/",
           req_body,
           [{"Content-Type", "application/json"}]
         ) do
      {:ok, %HTTPoison.Response{body: body, token: token}} ->
        GenServer.cast(self(), {:token, token})

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def start_link(_init_arg) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  @impl true
  def init(init_arg) do
    HTTPoison.start()

    {:ok, init_arg}
  end

  @impl true
  def handle_cast({:token, token}, state) do
    {:noreply, Map.put(state, :token, token)}
  end
end
