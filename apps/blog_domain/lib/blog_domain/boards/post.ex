defmodule BlogDomain.Boards.Post do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @table "posts"

  schema @table do
    field(:title, :string)
    field(:description, :string)

    belongs_to(:user, BlogDomain.Accounts.User)
    has_many(:comments, BlogDomain.Boards.Comment)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description])
    |> cast_assoc(:user)
    |> cast_assoc(:comments)
    |> validate_required([:title])
    |> foreign_key_constraint(:post_id)
  end

  def post_id_query(query, post_id) do
    from(q in query, where: q.post_id == ^post_id)
  end
end
