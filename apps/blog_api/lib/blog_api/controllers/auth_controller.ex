defmodule BlogApi.AuthController do
  use BlogApi, :controller

  alias BlogDomain.Accounts
  alias BlogDomain.Accounts.User
  alias BlogApi.Utils

  def register(
        conn,
        %{"user_name" => _user_name, "user_email" => _user_email, "password" => _password} =
          params
      ) do
    case Accounts.create_user(params) do
      {:ok, %User{} = user} ->
        token = BlogApi.Auth.login(user)

        conn
        |> put_status(:created)
        |> render("show.json", %{user: user, token: token})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn |> render("errors.json", %{errors: Utils.format_changeset_errors(changeset)})
    end
  end

  def login(conn, %{"user_email" => user_email, "password" => password}) do
    case Accounts.authenticate_by_username_and_pass(user_email, password) do
      {:ok, user} ->
        token = BlogApi.Auth.login(user)

        conn
        |> put_status(200)
        |> render("show.json", %{user: user, token: token})

      {:error, _reason} ->
        conn
        |> put_status(400)
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end
end
