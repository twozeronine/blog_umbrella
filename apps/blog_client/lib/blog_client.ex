defmodule BlogClient do
  use GenServer

  @api_url "http://localhost:4000/api"
  @users_url "http://localhost:4000/api/users"
  @posts_url "http://localhost:4000/api/posts"

  def get_all_users() do
    HTTPoison.get("#{@users_url}")
    |> render_response()
  end

  def get_user(user_id) do
    HTTPoison.get("#{@users_url}/#{user_id}")
    |> render_response()
  end

  def register_user(
        %{user_name: _user_name, user_email: _user_email, password: _password} = params
      ) do
    req_body = Jason.encode!(params)

    case HTTPoison.post(
           "#{@api_url}/register",
           req_body,
           [{"Content-Type", "application/json"}]
         ) do
      {:ok, %HTTPoison.Response{body: body, headers: _headers}} ->
        IO.inspect(body)

      # 받은 토큰을 상태 서버에 저장하기 !
      # GenServer.cast(self(), {:token, token})

      {:error, %HTTPoison.Error{reason: reason}} ->
        IO.inspect(reason)
    end
  end

  def update_user(id, params \\ %{}) do
    req_body = Jason.encode!(params)

    HTTPoison.put(
      "#{@users_url}/#{id}",
      req_body,
      [{"Content-Type", "application/json"}]
    )
    |> render_response()
  end

  def get_all_posts() do
    HTTPoison.get("#{@posts_url}")
    |> render_response()
  end

  def get_post(post_id) do
    HTTPoison.get("#{@posts_url}/#{post_id}")
    |> render_response()
  end

  def create_post(%{title: _title, description: _description} = params) do
    # 현재 유저 토큰 없으므로 임시 아이디
    req_body =
      %{post: params}
      |> Map.put(:user, %{id: 1})
      |> Jason.encode!()

    HTTPoison.post("#{@posts_url}", req_body, [{"Content-Type", "application/json"}])
    |> render_response()
  end

  def update_post(post_id, params \\ %{}) do
    req_body =
      %{post: params}
      |> Jason.encode!()

    HTTPoison.put("#{@posts_url}/#{post_id}", req_body, [
      {"Content-Type", "application/json"}
    ])
    |> render_response()
  end

  def delete_post(post_id) do
    HTTPoison.delete("#{@posts_url}/#{post_id}")
    |> render_response()
  end

  def get_all_comments_in_post(post_id) do
    HTTPoison.get(comments_url(post_id))
    |> render_response()
  end

  def show_comment_in_post(post_id, comment_id) do
    HTTPoison.get("#{comments_url(post_id)}/#{comment_id}")
    |> render_response()
  end

  def create_comment_in_post(post_id, %{description: _desc} = params) do
    req_body =
      %{comment: params}
      |> Map.put(:user, %{id: 1})
      |> Jason.encode!()

    HTTPoison.post("#{comments_url(post_id)}", req_body, [
      {"Content-Type", "application/json"}
    ])
    |> render_response()
  end

  def update_comment_in_post(post_id, comment_id, %{description: _desc} = params) do
    req_body =
      %{comment: params}
      |> Map.put(:user, %{id: 1})
      |> Jason.encode!()

    HTTPoison.put("#{comments_url(post_id)}/#{comment_id}", req_body, [
      {"Content-Type", "application/json"}
    ])
    |> render_response()
  end

  def delete_comment_in_post(post_id, comment_id) do
    HTTPoison.delete("#{comments_url(post_id)}/#{comment_id}")
    |> render_response()
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

  defp comments_url(post_id), do: "#{@posts_url}/#{post_id}/comments"

  defp render_response(response) do
    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> IO.inspect(body)
      {:ok, %HTTPoison.Response{status_code: 201, body: body}} -> IO.inspect(body)
      {:ok, %HTTPoison.Response{status_code: 204, body: body}} -> IO.inspect(body)
      {:ok, %HTTPoison.Response{status_code: 404}} -> IO.inspect({:error, :not_found})
      {:error, %HTTPoison.Error{reason: reason}} -> IO.inspect(reason)
    end
  end
end
