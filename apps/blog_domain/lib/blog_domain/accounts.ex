defmodule BlogDomain.Accounts do
  alias BlogDomain.Repo
  alias BlogDomain.Accounts.User

  def create_user(params \\ %{}) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user_lock(id) do
    Repo.get(User, id, [{:lock, "FOR UPDATE"}])
  end

  def update_username(id, %{user_name: user_name}) do
    fn ->
      user = get_user_lock(id)

      User.changeset(user, %{user_name: user_name})
      |> Repo.update()
    end
    |> Repo.transaction()
  end

  def delete_user(%User{} = user) do
    Repo.delete(user)
  end

  def user_list() do
    Repo.all(User)
  end
end
