defmodule BlogApi.AuthController do
  use BlogApi, :controller

  alias BlogDomain.Accounts
  alias BlogDomain.Accounts.User

  def register(conn, params) do
    {:ok, %User{} = user} = Accounts.create_user(params)

    conn
    |> put_status(:created)
    |> render("show.json", %{user: user, token: BlogApi.Auth.get_token(user)})
  end

  def login(conn, %{"user_email" => user_email, "password" => password}) do
    {:ok, user} = Accounts.authenticate_by_username_and_pass(user_email, password)

    conn
    |> put_status(200)
    |> render("show.json", %{user: user, token: BlogApi.Auth.get_token(user)})
  end
end
