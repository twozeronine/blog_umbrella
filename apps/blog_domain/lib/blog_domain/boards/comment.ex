defmodule BlogDomain.Boards.Comment do
  use Ecto.Schema

  import Ecto.Changeset
  import Ecto.Query

  @table "comments"

  schema @table do
    field(:description, :string)
    field(:user_name, :string, [{:virtual, true}])

    belongs_to(:user, BlogDomain.Accounts.User)
    belongs_to(:post, BlogDomain.Boards.Post)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:description, :user_id, :post_id])
    |> cast_assoc(:user)
    |> cast_assoc(:post)
    |> validate_required([:description])
    |> foreign_key_constraint(:post_id)
    |> foreign_key_constraint(:user_id)
  end

  def comment_user_id_query(query, user_id) do
    from(q in query, [{:where, q.user_id == ^user_id}])
  end

  def comment_lock_query(query) do
    from(q in query, [{:lock, "FOR UPDATE"}])
  end

  def get_comment_user_name(id) do
    from q in __MODULE__,
      where: q.id == ^id,
      join: u in assoc(q, :user),
      select: %{user_name: u.user_name}
  end
end
