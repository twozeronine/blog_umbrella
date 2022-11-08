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

    assert {:ok, valid_token, _claims} = Blog.Token.generate_and_sign(%{"user_id" => user_id})

    conn =
      conn
      |> put_req_header("authorization", "Bearer " <> valid_token)
      |> get(Routes.user_path(conn, :index))

    assert %{
             "data" => [
               %{"user_email" => _user_email1, "user_name" => _user_name1},
               %{"user_email" => _user_email2, "user_name" => _user_name2},
               %{"user_email" => _user_email3, "user_name" => _user_name3},
               %{"user_email" => _user_email4, "user_name" => _user_name4},
               %{"user_email" => _user_email5, "user_name" => _user_name5}
             ]
           } = json_response(conn, 200)
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

    assert {:ok, invalid_token, _claims} =
             Blog.Token.generate_and_sign(%{"user_id" => user_id - 0})

    conn =
      conn
      |> put_req_header("authorization", "Bearer " <> invalid_token)
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
