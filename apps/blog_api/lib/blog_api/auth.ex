defmodule BlogApi.Auth do
  import Plug.Conn
  alias BlogDomain.Accounts.User
  alias BlogDomain.Accounts

  def init(opts), do: opts

  def call(conn, _) do
    case conn.assigns[:user_token] do
      nil ->
        conn
        |> check_user_token_validate()
        |> check_user_validate()

      token ->
        conn
        |> put_user_token(token)
    end
  end

  def login(conn, %User{id: user_id}) do
    case get_session(conn, :user_id) do
      nil ->
        token = BlogApi.Token.generate_token(user_id)

        conn
        |> put_session(:user_id, user_id)
        |> put_user_token(token)

      _user_id ->
        conn
        |> put_status(400)
        |> halt()
    end
  end

  def logout(conn) do
    user =
      conn
      |> get_session(:user_id)
      |> Accounts.get_user()

    conn
    |> clear_session()
    |> assign(:user, user)
    |> put_status(200)
  end

  defp check_user_token_validate(conn) do
    validate_token =
      conn
      |> get_joken_from_header()
      |> BlogApi.Token.verify_token()
      |> BlogApi.Token.validate_token()

    conn
    |> put_user_token(validate_token)
  end

  defp check_user_validate(conn) do
    %{"user_id" => user_id} = conn.assigns[:user_token]

    case Accounts.get_user(user_id) do
      nil ->
        conn
        |> put_status(401)
        |> halt()

      %User{} ->
        conn
    end
  end

  defp get_joken_from_header(conn) do
    conn
    |> get_req_header("authorization")
    |> List.first()
    |> String.split(" ")
    |> List.last()
  end

  defp put_user_token(conn, token) do
    conn
    |> assign(:user_token, token)
  end
end
