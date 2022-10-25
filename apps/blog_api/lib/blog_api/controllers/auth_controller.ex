defmodule BlogApi.AuthController do
  use BlogApi, :controller

  alias BlogDomain.Accounts
  alias BlogDomain.Accounts.User

  def register(
        conn,
        %{"user_name" => _user_name, "user_email" => _user_email, "password" => _password} =
          params
      ) do
    {:ok, %User{} = user} = Accounts.create_user(params)

    token = BlogApi.Auth.login(user)

    conn
    |> put_status(:created)
    |> render("show.json", %{user: user, token: token})
  end

  def login(conn, %{"user_email" => user_email, "password" => password}) do
    {:ok, user} = Accounts.authenticate_by_username_and_pass(user_email, password)

    token = BlogApi.Auth.login(user)

    conn
    |> put_status(200)
    |> render("show.json", %{user: user, token: token})
  end
end
