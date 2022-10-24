defmodule BlogApi.Auth do
  import Plug.Conn
  alias BlogDomain.Accounts.User
  alias BlogDomain.Accounts

  def init(opts), do: opts

  def call(conn, _) do
    user_id =
      conn
      |> get_req_header("authorization")
      |> BlogApi.Token.verify_and_validate_token()

    case Accounts.get_user(user_id) do
      nil -> conn |> put_status(401) |> halt()
      %User{} = _user -> conn
    end
  end

  def login(%User{id: user_id}) do
    BlogApi.Token.generate_and_sign_token(user_id)
  end
end
