defmodule BlogApi.UserControllerTest do
  use BlogApi.ConnCase, async: true

  alias BlogDomain.Accounts.User

  @valid_params %{
    user_name: "User",
    user_email: "User Email",
    password: "supersecret"
  }

  test "GET /users", %{conn: conn} do
    %User{id: user_id} =
      Enum.map(1..5, fn num ->
        user_fixture(%{
          user_name: @valid_params.user_name <> "#{num}",
          user_email: @valid_params.user_email <> "#{num}",
          password: @valid_params.password <> "#{num}"
        })
      end)
      |> hd()

    assert token = BlogApi.Token.generate_and_sign_token(user_id)

    conn =
      conn
      |> put_req_header("authorization", token)
      |> get(Routes.user_path(conn, :index))

    assert %{
             "data" => [
               %{"user_email" => "User Email1", "user_name" => "User1"},
               %{"user_email" => "User Email2", "user_name" => "User2"},
               %{"user_email" => "User Email3", "user_name" => "User3"},
               %{"user_email" => "User Email4", "user_name" => "User4"},
               %{"user_email" => "User Email5", "user_name" => "User5"}
             ]
           } == json_response(conn, 200)
  end

  test "GET /users  invalid authentication", %{conn: conn} do
    %User{id: user_id} =
      Enum.map(1..5, fn num ->
        user_fixture(%{
          user_name: @valid_params.user_name <> "#{num}",
          user_email: @valid_params.user_email <> "#{num}",
          password: @valid_params.password <> "#{num}"
        })
      end)
      |> hd()

    assert invalid_token = BlogApi.Token.generate_and_sign_token(user_id - 0)

    conn =
      conn
      |> put_req_header("authorization", invalid_token)
      |> get(Routes.user_path(conn, :index))

    refute conn.halted
  end

  test "GET /users/:id", %{conn: conn} do
    %User{id: user_id} = user_fixture(@valid_params)

    conn = get(conn, Routes.user_path(conn, :show, user_id))

    assert %{"data" => %{"user_email" => "User Email", "user_name" => "User"}} =
             json_response(conn, 200)
  end

  test "UPDATE /users/:id", %{conn: conn} do
    %User{id: id} = user_fixture(@valid_params)

    conn =
      put(
        conn,
        Routes.user_path(conn, :update, id, %{
          "user_email" => "New Email",
          "user_name" => "New User",
          "password" => "New Password"
        })
      )

    assert %{
             "data" => %{
               "user_email" => "New Email",
               "user_name" => "New User"
             }
           } ==
             json_response(conn, 200)
  end
end
