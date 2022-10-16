defmodule BlogDomain.UserTest do
  use ExUnit.Case, async: true

  alias BlogDomain.Accounts.User

  @valid_params %{
    user_name: "User",
    user_email: "User Email",
    password: "supersecret"
  }
  @invalid_params %{}

  test "validate test" do
    assert valid?: true == User.changeset(%User{}, @valid_params)
  end

  test "invalidate test" do
    assert valid?: false == User.changeset(%User{}, @invalid_params)
  end

  test "invalidate_required test" do
    assert errors:
             [
               user_email: {"can't be blank", [validation: :required]},
               user_name: {"can't be blank", [validation: :required]},
               password: {"can't be blank", [validation: :required]}
             ] ==
               User.changeset(%User{})
  end

  test "invalidate_length test" do
    assert errors:
             [
               password:
                 {"should be at least %{count} character(s)",
                  [count: 8, validation: :length, kind: :min, type: :string]},
               user_name:
                 {"should be at least %{count} character(s)",
                  [count: 3, validation: :length, kind: :min, type: :string]}
             ] ==
               User.changeset(%User{}, %{
                 user_email: "example@example.com",
                 user_name: "a",
                 password: "1"
               })
  end

  test "hash_password test" do
    %Ecto.Changeset{changes: %{password_hash: password_hash}} =
      User.changeset(%User{}, @valid_params)

    # password만 파라미터로 넣었는데 password_hash 필드가 정상적으로 값이 넣어졌다면 성공인셈
    assert password_hash
  end
end
