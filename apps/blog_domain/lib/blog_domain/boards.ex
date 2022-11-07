defmodule BlogDomain.Boards do
  alias BlogDomain.Repo

  alias BlogDomain.Accounts.User
  alias BlogDomain.Boards.{Post, Comment}
  alias Blog.PubSub

  def create_post(%User{id: user_id}, params \\ %{}) do
    result =
      %Post{user_id: user_id}
      |> Post.changeset(params)
      |> Repo.insert()

    PubSub.broadcast(result, :post_created)
    result
  end

  def get_post(id), do: Repo.get(Post, id)

  def get_post_preload(id) do
    Post
    |> Post.preload_comment_post_query()
    |> Repo.get(id)
  end

  def get_post_lock(post_id) do
    Post
    |> Post.post_lock_query()
    |> Repo.get(post_id)
  end

  def get_user_post(user_id) do
    Post
    |> User.user_id_query(user_id)
    |> Repo.all()
  end

  def post_list() do
    Post
    |> Repo.all()
  end

  def update_post(post_id, params \\ %{}) do
    {:ok, result} =
      fn ->
        case get_post_lock(post_id) do
          %Post{} = post -> Post.changeset(post, params) |> Repo.update()
          nil -> {:error, :not_found}
        end
      end
      |> Repo.transaction()

    PubSub.broadcast(result, :post_updated)

    {:ok, result}
  end

  def delete_post(%Post{} = post), do: Repo.delete(post)

  def write_comment(%User{id: user_id}, post_id, params \\ %{}) do
    result =
      %Comment{user_id: user_id, post_id: post_id}
      |> Comment.changeset(params)
      |> Repo.insert()

    PubSub.broadcast(result, :comment_created)

    result
  end

  def get_post_comment(post_id, comment_id) do
    Post
    |> Post.get_comment_in_post_query(post_id, comment_id)
    |> Repo.one()
  end

  def list_post_comments(post_id) do
    Comment
    |> Post.post_id_query(post_id)
    |> Repo.all()
  end

  def update_post_comment(%User{} = user, post_id, comment_id, params \\ %{}) do
    {:ok, result} =
      fn ->
        case get_user_post_comment_lock(user, post_id, comment_id) do
          %Comment{} = comment -> Comment.changeset(comment, params) |> Repo.update()
          nil -> {:error, :not_found}
        end
      end
      |> Repo.transaction()

    PubSub.broadcast(result, :comment_updated)

    {:ok, result}
  end

  def delete_comment(%Comment{} = comment), do: Repo.delete(comment)

  def change_post(params \\ %{}) do
    %Post{}
    |> Post.changeset(params)
  end

  def change_comment(params \\ %{}) do
    %Comment{}
    |> Comment.changeset(params)
  end

  defp get_user_post_comment_lock(%User{id: user_id}, post_id, comment_id) do
    Comment
    |> User.user_id_query(user_id)
    |> Post.post_id_query(post_id)
    |> Comment.comment_lock_query()
    |> Repo.get(comment_id)
  end
end
