defmodule BlogDomain.Accounts do
  @moduledoc """
    Accounts context
  """

  alias BlogDomain.Repo
  alias BlogDomain.Accounts.User

  def create_user(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert()
  end

  def create_user!(params) do
    %User{}
    |> User.changeset(params)
    |> Repo.insert!()
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get(User, id)
  end

  def get_user_lock(id) do
    Repo.get(User, id, [{:lock, "FOR UPDATE"}])
  end

  def update_user(id, params) do
    fn ->
      case get_user_lock(id) do
        %User{} = user -> User.changeset(user, params) |> Repo.update()
        nil -> {:error, nil}
      end
    end
    |> Repo.transaction()
  end

  def delete_user(id) do
    Repo.delete(id)
  end
end
