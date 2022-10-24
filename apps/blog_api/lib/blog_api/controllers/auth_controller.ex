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
        conn = BlogApi.Auth.login(conn, user)

        conn
        |> put_status(:created)
        |> render("show.json", %{user: user, token: conn.assigns[:user_token]})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn |> render("errors.json", %{errors: Utils.format_changeset_errors(changeset)})
    end
  end

  def login(conn, %{"user_email" => user_email, "password" => password}) do
    case Accounts.authenticate_by_username_and_pass(user_email, password) do
      {:ok, user} ->
        conn
        |> BlogApi.Auth.login(user)
        |> then(fn
          %Plug.Conn{halted: true} = conn ->
            conn
            |> render("errors.json", %{errors: "user already login"})

          %Plug.Conn{halted: false} = conn ->
            conn
            |> put_status(200)
            |> render("show.json", %{user: user, token: conn.assigns[:user_token]})
        end)

      {:error, _reason} ->
        conn
        |> put_status(400)
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def logout(conn, _params) do
    conn = BlogApi.Auth.logout(conn)

    conn
    |> render("show.json", %{user: conn.assigns[:user], token: nil})
  end
end
