defmodule BlogDomain.Boards.Post do
  use Ecto.Schema
  import Ecto.Changeset

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
    |> validate_required([:title])
    |> foreign_key_constraint(:post_id)
  end
end
