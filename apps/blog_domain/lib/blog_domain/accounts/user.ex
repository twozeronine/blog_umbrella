defmodule BlogDomain.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

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
    |> validate_required([:user_email, :user_name, :password])
    |> validate_length(:user_name, [{:min, 3}, {:max, 64}])
    |> validate_length(:password, [{:min, 8}, {:max, 128}])
    |> put_password_hash()
    |> unique_constraint([:user_email])
  end

  defp put_password_hash(changeset) do
    IO.inspect(changeset)

    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password_hash, Argon2.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end

  def user_id_query(query, %__MODULE__{id: user_id}) do
    from(q in query, where: q.user_id == ^user_id)
  end
end
