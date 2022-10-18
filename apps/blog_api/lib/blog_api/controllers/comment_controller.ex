defmodule BlogApi.CommentController do
  use BlogApi, :controller

  # alias BlogDomain.Boards
  # alias BlogDomain.Boards.Comment

  # def index(conn, _params) do
  #   comments = Boards.comment_list()
  #   render(conn, "index.json", comments)
  # end

  # def show(conn, %{"id" => id}) do
  #   comment = Accounts.get_comment(id)
  #   render(conn, "show.json", %{comment: comment})
  # end

  # def create(conn, %{"user" => user, "post_id" => post_id, "comment" => comment_param}) do
  #   case Comment.write_comment(user, post_id, comment_param) do
  #     {:ok, %Comment{} = comment} ->
  #       conn

  #     # |> put_status(:created)
  #     # |> put_resp_header("location", Routes.post_path(conn, :show, comment))
  #     # |> render("show.json", comment)

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       :error
  #   end
  # end

  # def update(conn, %{"user" => user, "comment" => comment}) do
  #   case Boards.update_post_comment(user, comment.id, comment) do
  #     {:ok, {:ok, %Comment{} = comment}} ->
  #       render(conn, "show.json", %{comment: comment})

  #     {:ok, {:error, %Ecto.Changeset{} = changeset}} ->
  #       :error

  #     {:error, _} ->
  #       :error
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   case Boards.delete_comment(comment) do
  #     {:ok, %Comment{}} -> send_resp(conn, :no_content, "")
  #     _ -> :error
  #   end
  # end
end
