defmodule BlogDomain.AccountsTest do
  use BlogDomain.DataCase

  alias BlogDomain.Accounts
  alias BlogDomain.Accounts.User

  describe "CRUD test" do
    @valid_params %{
      user_name: "User",
      user_email: "User Email",
      password: "supersecret"
    }
    @invalid_params %{}

    test "create user" do
      assert {:ok, %User{id: id} = user} = Accounts.create_user(@valid_params)
      assert user.user_name == "User"
      assert user.user_email == "User Email"
      assert [%User{id: ^id}] = Accounts.user_list()
    end

    test "read user" do
      assert {:ok, %User{id: id} = user} = Accounts.create_user(@valid_params)
      assert user.id == Accounts.get_user(id).id
    end

    test "update user" do
      assert {:ok, %User{id: id, user_name: old_name, password: password} = user} =
               Accounts.create_user(@valid_params)

      new_name = "New User"

      assert {:ok, {:ok, new_user}} =
               Accounts.update_username(id, %{user_name: new_name, password: password})

      refute old_name == new_user.user_name
    end

    test "delete user" do
      assert {:ok, %User{id: id} = _user} = Accounts.create_user(@valid_params)

      assert {:ok, {:ok, %User{}}} = Accounts.delete_user(id)
      assert Accounts.user_list() == []
    end
  end
end
