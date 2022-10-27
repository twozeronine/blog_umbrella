defmodule BlogApi.Controllers.CommentControllerTest do
  use BlogApi.ConnCase, async: true

  alias BlogDomain.Repo
  alias BlogDomain.Boards.{Post, Comment}
  alias BlogDomain.Accounts.User

  @valid_user_params %{
    user_name: "User",
    user_email: "User Email",
    password: "supersecret"
  }
  @valid_post_params %{title: "title", description: "description"}
  @valid_comment_params %{description: "desc"}

  test "GET /posts/:post_id/comments", %{conn: conn} do
    owner = user_fixture(@valid_user_params)
    %Post{id: id} = post_fixture(owner, @valid_post_params)

    Enum.each(1..5, fn num ->
      comment_fixture(owner, id, %{description: @valid_comment_params.description <> "#{num}"})
    end)

    conn = get(conn, Routes.comment_path(conn, :index, id))

    assert %{
             "data" => [
               %{"description" => "desc1"},
               %{"description" => "desc2"},
               %{"description" => "desc3"},
               %{"description" => "desc4"},
               %{"description" => "desc5"}
             ]
           } = json_response(conn, 200)
  end

  test "GET /posts/:post_id/comment/:id", %{conn: conn} do
    owner = user_fixture(@valid_user_params)
    %Post{id: post_id} = post_fixture(owner, @valid_post_params)
    %Comment{id: id} = comment_fixture(owner, post_id, @valid_comment_params)

    conn = get(conn, Routes.comment_path(conn, :show, post_id, id))

    assert %{"data" => %{"description" => "desc"}} = json_response(conn, 200)
  end

  test "POST /auth/posts/:post_id/comment/", %{conn: conn} do
    %User{id: user_id} = owner = user_fixture(@valid_user_params)
    %Post{id: post_id} = post_fixture(owner, @valid_post_params)

    assert {:ok, valid_token, _claims} = Blog.Token.generate_and_sign(%{"user_id" => user_id})

    conn =
      conn
      |> put_req_header("authorization", "Bearer " <> valid_token)
      |> post(
        Routes.comment_path(conn, :create, post_id, %{
          "comment" => @valid_comment_params
        })
      )

    assert %{"data" => %{"description" => "desc"}} = json_response(conn, 201)
  end

  test "UPDATE /auth/posts/:post_id/comments/:id", %{conn: conn} do
    %User{id: owner_id} = owner = user_fixture(@valid_user_params)
    %Post{id: post_id} = post_fixture(owner, @valid_post_params)
    %Comment{id: id} = comment_fixture(owner, post_id, @valid_comment_params)

    assert {:ok, valid_token, _claims} = Blog.Token.generate_and_sign(%{"user_id" => owner_id})

    conn =
      conn
      |> put_req_header("authorization", "Bearer " <> valid_token)
      |> put(
        Routes.comment_path(conn, :update, post_id, id, %{
          "comment" => %{"description" => "new desc"}
        })
      )

    assert %{"data" => %{"description" => "new desc"}} = json_response(conn, 200)
  end

  test "DELETE /posts/:post_id/comments/:id", %{conn: conn} do
    %User{} = owner = user_fixture(@valid_user_params)
    %Post{id: post_id} = post_fixture(owner, @valid_post_params)
    %Comment{id: id} = comment_fixture(owner, post_id, @valid_comment_params)

    delete(conn, Routes.comment_path(conn, :delete, post_id, id))

    assert nil == Repo.get(Comment, id)
  end
end
