defmodule BlogApi.CommentController do
  use BlogApi, :controller

  alias BlogDomain.Boards
  alias BlogDomain.Boards.Comment
  alias BlogDomain.Accounts

  def index(conn, %{"post_id" => post_id}) do
    comments = Boards.list_post_comments(post_id)
    render(conn, "index.json", %{comments: comments})
  end

  def show(conn, %{"post_id" => post_id, "id" => id}) do
    comment = Boards.get_post_comment(post_id, id)
    render(conn, "show.json", %{comment: comment})
  end

  def create(conn, %{"user" => %{"id" => id}, "post_id" => post_id, "comment" => comment_param}) do
    {post_id, _} = Integer.parse(post_id)

    {:ok, %Comment{} = comment} =
      id
      |> Accounts.get_user()
      |> Boards.write_comment(post_id, comment_param)

    conn
    |> put_status(:created)
    |> put_resp_header("location", Routes.post_path(conn, :show, comment))
    |> render("show.json", %{comment: comment})
  end

  def update(conn, %{
        "user" => %{"id" => id},
        "post_id" => post_id,
        "id" => comment_id,
        "comment" => comment
      }) do
    {:ok, {:ok, %Comment{} = comment}} =
      id
      |> Accounts.get_user()
      |> Boards.update_post_comment(post_id, comment_id, comment)

    render(conn, "show.json", %{comment: comment})
  end

  def delete(conn, %{"post_id" => post_id, "id" => id}) do
    post_id
    |> Boards.get_post_comment(id)
    |> Boards.delete_comment()

    conn
    |> send_resp(:no_content, "")
  end
end
