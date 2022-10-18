defmodule BlogApi.PostController do
  use BlogApi, :controller

  # alias BlogDomain.Boards
  # alias BlogDomain.Boards.Post

  # def index(conn, _params) do
  #   posts = Boards.post_list()
  #   render(conn, "index.json", posts)
  # end

  # def show(conn, %{"id" => id}) do
  #   post = Boards.get_post(id)
  #   render(conn, "show.json", %{post: post})
  # end

  # def create(conn, %{"user" => user, "post" => post_params}) do
  #   case Post.create_post(user, post_params) do
  #     {:ok, %Post{} = post} ->
  #       conn

  #     # |> put_status(:created)
  #     # |> put_resp_header("location", Routes.post_path(conn, :show, post))
  #     # |> render("show.json", post)

  #     {:error, %Ecto.Changeset{} = changeset} ->
  #       :error
  #   end
  # end

  # def update(conn, %{"user" => user, "post" => post_params}) do
  #   case Boards.update_user_post(user, post_params.post_id, params) do
  #     {:ok, {:ok, %Post{} = post}} ->
  #       render(conn, "show.json", %{post: post})

  #     {:ok, {:error, %Ecto.Changeset{} = changeset}} ->
  #       :error

  #     {:error, _} ->
  #       :error
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   case Boards.delete_post(post) do
  #     {:ok, %Post{}} -> send_resp(conn, :no_content, "")
  #     _ -> :error
  #   end
  # end
end
