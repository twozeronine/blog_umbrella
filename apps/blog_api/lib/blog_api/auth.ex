defmodule BlogApi.Auth do
  import Plug.Conn
  alias BlogDomain.Accounts.User

  def init(opts), do: opts

  def call(conn, _) do
    {:ok, %{"user_id" => user_id}} =
      token =
      get_req_header(conn, "authorization")
      |> hd()
      |> String.split(" ")
      |> tl()

    case BlogApi.Token.verify_and_validate(token, BlogApi.Token.token_create()) do
      {:ok, _claims} ->
        nil
    end
  end

  def login(user) do
    {:ok, token, _claims} =
      %{user_id: user.id}
      |> BlogApi.Token.generate_and_sign(BlogApi.Token.token_create())

    token
  end
end
