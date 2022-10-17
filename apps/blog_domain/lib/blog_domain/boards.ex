defmodule BlogDomain.Boards do
  @moduledoc """
    Boards context
  """

  import Ecto.Query
  alias BlogDomain.Repo

  alias BlogDomain.Accounts
  alias BlogDomain.Accounts.User
  alias BlogDomain.Boards.Post

  def create_post(%User{} = user, params \\ %{}) do
    %Post{}
    |> Post.changeset(params)
    |> Ecto.Changeset.put_assoc(:user, user)
    |> Repo.insert()
  end

  def get_post(id), do: Repo.get(Post, id)
  def get_post!(id), do: Repo.get!(Post, id)

  def get_user_post(%User{} = user, post_id, opts \\ []) do
    Post
    |> user_posts_query(user)
    |> Repo.get(post_id, opts)
  end

  def get_user_post_lock(%User{} = user, post_id) do
    get_user_post(user, post_id, lock: "FOR UPDATE")
  end

  def list_user_posts(%User{} = user) do
    Post
    |> user_posts_query(user)
    |> Repo.all()
  end

  def update_user_post(%User{} = user, post_id, params \\ %{}) do
    fn ->
      case get_user_post_lock(user, post_id) do
        %Post{} = post -> Post.changeset(post, params) |> Repo.update()
        nil -> {:error, :not_found}
      end
    end
    |> Repo.transaction()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  defp user_posts_query(query, %Accounts.User{id: user_id}) do
    from(p in query, where: p.user_id == ^user_id)
  end
end
