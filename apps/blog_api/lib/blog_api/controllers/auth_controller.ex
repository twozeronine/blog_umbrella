defmodule BlogApi.AuthController do
  use BlogApi, :controller

  alias BlogDomain.Accounts
  alias BlogDomain.Accounts.User

  def register(conn, params) do
    {:ok, %User{id: user_id} = user} = Accounts.create_user(params)

    {:ok, invalid_token, _claims} = Blog.Token.generate_and_sign(%{"user_id" => user_id})

    conn
    |> put_status(:created)
    |> render("show.json", %{user: user, token: invalid_token})
  end

  def login(conn, %{"user_email" => user_email, "password" => password}) do
    {:ok, %User{id: user_id} = user} =
      Accounts.authenticate_by_username_and_pass(user_email, password)

    {:ok, invalid_token, _claims} = Blog.Token.generate_and_sign(%{"user_id" => user_id})

    conn
    |> put_status(200)
    |> render("show.json", %{user: user, token: invalid_token})
  end
end
