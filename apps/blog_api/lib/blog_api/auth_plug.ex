defmodule BlogApi.AuthPlug do
  import Plug.Conn
  alias BlogDomain.Accounts.User
  alias BlogDomain.Accounts

  def init(opts), do: opts

  def call(conn, _) do
    ["Bearer " <> token] = get_req_header(conn, "authorization")
    {:ok, %{"user_id" => user_id}} = Blog.Token.verify_and_validate(token)

    # 인증이 있어야만 접근할 수 있게 case문 사용
    case Accounts.get_user(user_id) do
      nil ->
        conn
        |> put_status(401)
        |> halt()

      %User{} ->
        conn
    end
  end
end
