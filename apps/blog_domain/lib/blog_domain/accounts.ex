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

  def update_username(id, %{user_name: user_name, password: password}) do
    fn ->
      user = get_user_lock(id)

      cond do
        user && Argon2.verify_pass(password, user.password_hash) ->
          User.changeset(user, %{user_name: user_name, password: password}) |> Repo.update()

        user ->
          {:error, :invalid_password}

        true ->
          Argon2.no_user_verify()
          {:error, :not_found}
      end
    end
    |> Repo.transaction()
  end

  def delete_user(id) do
    Repo.delete(id)
  end
end
