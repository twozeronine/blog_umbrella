defmodule BlogClient do
  @api_url "http://localhost:4000/api"
  @users_url "http://localhost:4000/api/users"
  @posts_url "http://localhost:4000/api/posts"

  def get_all_users() do
    "#{@users_url}"
    |> HTTPoison.get()
    |> render_response()
  end

  def get_user(user_id) do
    "#{@users_url}/#{user_id}"
    |> HTTPoison.get()
    |> render_response()
  end

  def register_user(
        %{user_name: _user_name, user_email: _user_email, password: _password} = params
      ) do
    req_body = Jason.encode!(params)

    "#{@api_url}/register"
    |> HTTPoison.post(req_body, [{"Content-Type", "application/json"}])
    |> render_response()
  end

  def update_user(id, params \\ %{}) do
    req_body = Jason.encode!(params)

    "#{@users_url}/#{id}"
    |> HTTPoison.put(req_body, [{"Content-Type", "application/json"}])
    |> render_response()
  end

  def get_all_posts() do
    "#{@posts_url}"
    |> HTTPoison.get()
    |> render_response()
  end

  def get_post(post_id) do
    "#{@posts_url}/#{post_id}"
    |> HTTPoison.get()
    |> render_response()
  end

  def create_post(%{title: _title, description: _description} = params) do
    # 현재 유저 토큰 없으므로 임시 아이디
    req_body =
      %{post: params}
      |> Map.put(:user, %{id: 1})
      |> Jason.encode!()

    "#{@posts_url}"
    |> HTTPoison.post(req_body, [{"Content-Type", "application/json"}])
    |> render_response()
  end

  def update_post(post_id, params \\ %{}) do
    req_body =
      %{post: params}
      |> Jason.encode!()

    "#{@posts_url}/#{post_id}"
    |> HTTPoison.put(req_body, [{"Content-Type", "application/json"}])
    |> render_response()
  end

  def delete_post(post_id) do
    "#{@posts_url}/#{post_id}"
    |> HTTPoison.delete()
    |> render_response()
  end

  def get_all_comments_in_post(post_id) do
    comments_url(post_id)
    |> HTTPoison.get()
    |> render_response()
  end

  def show_comment_in_post(post_id, comment_id) do
    "#{comments_url(post_id)}/#{comment_id}"
    |> HTTPoison.get()
    |> render_response()
  end

  def create_comment_in_post(post_id, %{description: _desc} = params) do
    req_body =
      %{comment: params}
      |> Map.put(:user, %{id: 1})
      |> Jason.encode!()

    "#{comments_url(post_id)}"
    |> HTTPoison.post(req_body, [{"Content-Type", "application/json"}])
    |> render_response()
  end

  def update_comment_in_post(post_id, comment_id, %{description: _desc} = params) do
    req_body =
      %{comment: params}
      |> Map.put(:user, %{id: 1})
      |> Jason.encode!()

    "#{comments_url(post_id)}/#{comment_id}"
    |> HTTPoison.put(req_body, [{"Content-Type", "application/json"}])
    |> render_response()
  end

  def delete_comment_in_post(post_id, comment_id) do
    "#{comments_url(post_id)}/#{comment_id}"
    |> HTTPoison.delete()
    |> render_response()
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
