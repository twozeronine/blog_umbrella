defmodule BlogApi.Auth do
  import Plug.Conn
  alias BlogDomain.Accounts.User
  alias BlogDomain.Accounts

  def init(opts), do: opts

  def call(conn, _) do
    valid_token =
      conn
      |> get_valid_user_token_()

    conn
    |> check_user_validate(valid_token)
  end

  def login(conn, %User{id: user_id}) do
    case get_session(conn, :user_id) do
      nil ->
        token = BlogApi.Token.generate_token(user_id)

        conn
        |> put_session(:user_id, user_id)
        |> assign(:user_token, token)

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

  defp get_valid_user_token_(conn) do
    valid_token =
      conn
      |> get_joken_from_header()
      |> BlogApi.Token.verify_token()
      |> BlogApi.Token.validate_token()

    valid_token
  end

  defp check_user_validate(conn, %{"user_id" => user_id}) do
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
end
