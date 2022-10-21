defmodule BlogClient.Api do
  def register_user(user_name, user_email, password) do
    %{user_name: user_name, user_email: user_email, password: password}
    |> Jason.encode!()
  end

  def update_user(params) do
    Jason.encode!(params)
  end

  def create_post(title, description) do
    # 현재 유저 토큰 없으므로 임시 아이디
    %{post: %{title: title, description: description}, user: %{id: 1}}
    |> Jason.encode!()
  end

  def update_post(params) do
    %{post: params}
    |> Jason.encode!()
  end

  def create_comment_in_post(description) do
    # 현재 유저 토큰 없으므로 임시 아이디
    %{comment: %{description: description}, user: %{id: 1}}
    |> Jason.encode!()
  end

  def update_comment_in_post(description) do
    # 현재 유저 토큰 없으므로 임시 아이디
    %{comment: %{description: description}, user: %{id: 1}}
    |> Jason.encode!()
  end
end
