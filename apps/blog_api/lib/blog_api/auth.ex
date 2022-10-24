defmodule BlogApi.Auth do
  import Plug.Conn
  alias BlogDomain.Accounts.User
  alias BlogDomain.Accounts

  def init(opts), do: opts

  def call(conn, _) do
    {:ok, %{"user_id" => user_id}} =
      get_req_header(conn, "authorization")
      |> hd()
      |> String.split(" ")
      |> List.last()
      |> BlogApi.Token.verify_and_validate(BlogApi.Token.token_create())

    case Accounts.get_user(user_id) do
      nil -> conn |> put_status(401) |> halt()
      %User{} = _user -> conn
    end
  end

  def login(%User{id: user_id}) do
    case BlogApi.Token.generate_and_sign(%{"user_id" => user_id}, BlogApi.Token.token_create()) do
      {:ok, token, _claims} -> token
      {:error, reason} -> {:error, reason}
    end
  end
end
