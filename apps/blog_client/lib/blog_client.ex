defmodule BlogClient do
  @client Application.compile_env(:blog_client, [BlogClient, :default_client])
  @headers Application.compile_env(:blog_client, [BlogClient, :headers])

  def get_all_users(opts \\ []) do
    "/auth/users"
    |> get(opts)
  end

  def get_user(user_id, opts \\ []) do
    "/users/#{user_id}"
    |> get(opts)
  end

  def register_user(user_name, user_email, password, opts \\ []) do
    req_body = BlogClient.Api.register_user(user_name, user_email, password)

    "/register"
    |> post(opts, req_body)
  end

  def update_user(id, params, opts \\ []) do
    req_body = BlogClient.Api.update_user(params)
    update("/users/#{id}", opts, req_body)
  end

  def get_all_posts(opts \\ []) do
    "/posts"
    |> get(opts)
  end

  def get_post(post_id, opts \\ []) do
    "/posts/#{post_id}"
    |> get(opts)
  end

  def create_post(title, description, opts \\ []) do
    req_body = BlogClient.Api.create_post(title, description)

    "/auth/posts"
    |> post(opts, req_body)
  end

  def update_post(post_id, params, opts \\ []) do
    req_body = BlogClient.Api.update_post(params)

    "/posts/#{post_id}"
    |> update(opts, req_body)
  end

  def delete_post(post_id, opts \\ []) do
    "/posts/#{post_id}"
    |> delete(opts)
  end

  def get_all_comments_in_post(post_id, opts \\ []) do
    "/posts/#{post_id}/comments"
    |> get(opts)
  end

  def show_comment_in_post(post_id, comment_id, opts \\ []) do
    "/posts/#{post_id}/comments/#{comment_id}"
    |> get(opts)
  end

  def create_comment_in_post(post_id, description, opts \\ []) do
    req_body = BlogClient.Api.create_comment_in_post(description)

    "/auth/posts/#{post_id}/comments"
    |> post(opts, req_body)
  end

  def update_comment_in_post(post_id, comment_id, description, opts \\ []) do
    req_body = BlogClient.Api.update_comment_in_post(description)

    "/auth/posts/#{post_id}/comments/#{comment_id}"
    |> update(opts, req_body)
  end

  def delete_comment_in_post(post_id, comment_id, opts \\ []) do
    "/posts/#{post_id}/comments/#{comment_id}"
    |> delete(opts)
  end

  defp post(url, opts, req_body) do
    client = opts[:client] || @client

    client
    |> apply(:post, [url, req_body, [{"authorization", "Bearer #{opts[:token]}"} | @headers]])
  end

  defp get(url, opts) do
    client = opts[:client] || @client

    client
    |> apply(:get, [url, [{"authorization", "Bearer #{opts[:token]}"}]])
  end

  defp update(url, opts, req_body) do
    client = opts[:client] || @client

    client
    |> apply(:update, [url, req_body, [{"authorization", "Bearer #{opts[:token]}"} | @headers]])
  end

  defp delete(url, client) do
    client = client[:client] || @client

    client
    |> apply(:delete, [url])
  end
end
