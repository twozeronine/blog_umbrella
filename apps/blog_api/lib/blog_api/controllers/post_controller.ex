defmodule BlogApi.PostController do
  use BlogApi, :controller

  alias BlogDomain.Boards
  alias BlogDomain.Boards.Post
  alias BlogDomain.Accounts

  def index(conn, _params) do
    posts = Boards.post_list()
    render(conn, "index.json", %{posts: posts})
  end

  def show(conn, %{"id" => id}) do
    post = Boards.get_post(id)
    render(conn, "show.json", %{post: post})
  end

  def create(conn, %{"user" => %{"id" => id}, "post" => post_params}) do
    {:ok, %Post{} = post} =
      id
      |> Accounts.get_user()
      |> Boards.create_post(post_params)

    conn
    |> put_status(:created)
    |> put_resp_header("location", Routes.post_path(conn, :show, post))
    |> render("show.json", %{post: post})
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    {:ok, {:ok, %Post{} = post}} = Boards.update_post(id, post_params)

    conn
    |> render("show.json", %{post: post})
  end

  def delete(conn, %{"id" => id}) do
    id
    |> Boards.get_post()
    |> Boards.delete_post()

    conn
    |> put_status(200)
    |> send_resp(:no_content, "")
  end
end
