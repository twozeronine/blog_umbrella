defmodule BlogDomain.Boards.Comment do
  use Ecto.Schema

  import Ecto.Changeset

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
    |> cast(params, [:description])
    |> validate_required([:description])
    |> foreign_key_constraint(:post_id)
  end
end
