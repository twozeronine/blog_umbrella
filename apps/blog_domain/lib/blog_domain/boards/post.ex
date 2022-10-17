defmodule BlogDomain.Boards.Post do
  use Ecto.Schema
  import Ecto.Changeset

  @table "posts"

  schema @table do
    field(:title, :string)
    field(:description, :string)

    belongs_to(:user, BlogDomain.Accounts.User)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:title, :description])
    |> validate_required([:title])
  end
end
