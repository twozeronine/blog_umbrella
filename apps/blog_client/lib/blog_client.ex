defmodule BlogClient do
  @client Application.compile_env!(:blog_client, [BlogClient, :default_client])
  @headers Application.compile_env!(:blog_client, [BlogClient, :headers])

  def get_all_users(client \\ []) do
    "/users"
    |> get(client)
  end

  def get_user(user_id, client \\ []) do
    "/users/#{user_id}"
    |> get(client)
  end

  def register_user(user_name, user_email, password, client \\ []) do
    req_body = BlogClient.Api.register_user(user_name, user_email, password)

    "/register"
    |> post(client, req_body)
  end

  def update_user(id, params, client \\ []) do
    req_body = BlogClient.Api.update_user(params)
    update("users/#{id}", client, req_body)
  end

  def get_all_posts(client \\ []) do
    "/posts"
    |> get(client)
  end

  def get_post(post_id, client \\ []) do
    "/posts/#{post_id}"
    |> get(client)
  end

  def create_post(title, description, client \\ []) do
    req_body = BlogClient.Api.create_post(title, description)

    "/posts"
    |> post(client, req_body)
  end

  def update_post(post_id, params, client \\ []) do
    req_body = BlogClient.Api.update_post(params)

    "/posts/#{post_id}"
    |> update(client, req_body)
  end

  def delete_post(post_id, client \\ []) do
    "/posts/#{post_id}"
    |> delete(client)
  end

  def get_all_comments_in_post(post_id, client \\ []) do
    "/comments/#{post_id}"
    |> get(client)
  end

  def show_comment_in_post(post_id, comment_id, client \\ []) do
    "/comments/#{post_id}/#{comment_id}"
    |> get(client)
  end

  def create_comment_in_post(post_id, description, client \\ []) do
    req_body = BlogClient.Api.create_comment_in_post(description)

    "/comments/#{post_id}"
    |> post(client, req_body)
  end

  def update_comment_in_post(post_id, comment_id, description, client \\ []) do
    req_body = BlogClient.Api.update_comment_in_post(description)

    "/comments/#{post_id}}/#{comment_id}"
    |> update(client, req_body)
  end

  def delete_comment_in_post(post_id, comment_id, client \\ []) do
    "/comments/#{post_id}/#{comment_id}"
    |> delete(client)
  end

  defp post(url, client, req_body) do
    client = client[:client] || @client

    client
    |> apply(:post, [url, req_body, @headers])
  end

  defp get(url, client) do
    client = client[:client] || @client

    client
    |> apply(:get, [url])
  end

  defp update(url, client, req_body) do
    client = client[:client] || @client

    client
    |> apply(:update, [url, req_body, @headers])
  end

  defp delete(url, client) do
    client = client[:client] || @client

    client
    |> apply(:delete, [url])
  end
end
