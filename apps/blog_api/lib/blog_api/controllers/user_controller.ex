defmodule BlogApi.UserController do
  use BlogApi, :controller

  def index(conn, _params) do
    # users = Accounts.user_list
    # render(conn, "index.json", users: users)
    render(conn, "index.json",
      users: [%{user_name: "1", user_email: "2"}, %{user_name: "1", user_email: "2"}]
    )
  end

  # def create(conn, params) do
  #   case Accounts.create_user(params) do
  #     {:ok, user} ->
  #       conn
  #       # |> 로그인 로직
  #       |> render("index.json")

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "index.json")
  #   end
  # end
end
