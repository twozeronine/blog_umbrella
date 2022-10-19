defmodule BlogApi.UserController do
  use BlogApi, :controller

  alias BlogApi.Utils
  alias BlogDomain.Accounts
  alias BlogDomain.Accounts.User

  def index(conn, _params) do
    users = Accounts.user_list()
    render(conn, "index.json", %{users: users})
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user(id)
    render(conn, "show.json", %{user: user})
  end

  def register(conn, params) do
    case Accounts.create_user(params) do
      {:ok, %User{} = user} ->
        conn

        # |> 로그인 로직
        |> put_status(:created)
        |> put_resp_header("location", Routes.user_path(conn, :show, user))
        |> render("show.json", %{user: user})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn |> render("errors.json", %{errors: Utils.format_changeset_errors(changeset)})
    end
  end

  def update(conn, params) do
    case Accounts.update_user(%User{id: params["id"]}, params) do
      {:ok, {:ok, %User{} = user}} ->
        render(conn, "show.json", %{user: user})

      {:ok, {:error, %Ecto.Changeset{} = changeset}} ->
        conn |> render("errors.json", %{errors: Utils.format_changeset_errors(changeset)})

      {:error, _} ->
        conn |> render("errors.json", %{errors: "Internal Server Error"})
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user(id)

    case Accounts.delete_user(user) do
      {:ok, %User{}} -> send_resp(conn, :no_content, "")
      _ -> conn |> render("errors.json", %{errors: "Internal Server Error"})
    end
  end
end
