defmodule BlogDomain.User do
  use Ecto.Schema
  import Ecto.Changeset

  @table "users"

  schema @table do
    field(:user_email, :string)
    field(:user_name, :string)
    field(:password, :string, [{:virtual, true}])
    field(:password_hash, :string)

    timestamps()
  end

  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_email, :user_name, :password, :password_hash])
    |> validate_required([:user_email, :user_name, :password_hash])
    |> validate_length(:user_name, [{:min, 3}, {:max, 64}])
    |> validate_length(:password, [{:min, 8}, {:max, 128}])
    |> unique_constraint([:user_email])
  end
end
