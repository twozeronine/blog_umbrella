defmodule BlogApi.UserController do
  use BlogApi, :controller

  # alias BlogDomain.Accounts
  # alias BlogDomain.Accounts.User

  # def index(conn, _params) do
  #   users = Accounts.user_list()
  #   render(conn, "index.json", users)
  # end

  # def show(conn, %{"id" => id}) do
  #   user = Accounts.get_user(id)
  #   render(conn, "show.json", %{user: user})
  # end

  # def create(conn, %{"user" => user_params}) do
  #   case Accounts.create_user(user_params) do
  #     {:ok, %User{} = user} ->
  #       conn
  #       # |> 로그인 로직
  #       # |> put_status(:created)
  #       # |> put_resp_header("location", Routes.user_path(conn, :show, user))
  #       # |> render("show.json", user)

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       render(conn, "index.json")
  #   end
  # end

  # def update(conn, %{"id" => user_id, "user" => user_params}) do
  #   case Accounts.update_username(user_id, params) do
  #     {:ok, {:ok, %User{} = user}} ->
  #       render(conn, "show.json", %{user: user})

  #     {:ok, {:error, %Ecto.Changeset{} = changeset}} ->
  #       :error

  #     {:error, _} ->
  #       :error
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   # 현재 세션에서 user 가져오는 로직
  #   # 또는 아이디로 유저를 가져와서 삭제 ??
  #   case Accounts.delete_user(user) do
  #     {:ok, %User{}} -> send_resp(conn, :no_content, "")
  #     _ -> :error
  #   end
  # end
end
