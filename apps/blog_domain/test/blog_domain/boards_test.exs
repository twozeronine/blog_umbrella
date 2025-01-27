defmodule BlogDomain.BoardsTest do
  use BlogDomain.DataCase

  alias BlogDomain.Boards
  alias BlogDomain.Boards.{Post, Comment}

  describe "Post CRUD test" do
    @valid_params %{
      title: "title",
      description: "desc"
    }

    test "create_post" do
      owner = user_fixture()

      assert {:ok, %Post{} = post} = Boards.create_post(owner, @valid_params)

      assert post.title == "title"
      assert post.description == "desc"
    end

    test "get_post" do
      assert {:ok, %Post{title: title, description: desc, id: id}} =
               Boards.create_post(user_fixture(), @valid_params)

      assert %Post{title: ^title, description: ^desc} = Boards.get_post(id)
    end

    test "post_list" do
      owner = user_fixture()

      assert {:ok, %Post{title: title1, description: desc1}} =
               Boards.create_post(owner, %{title: "title1", description: "desc1"})

      assert {:ok, %Post{title: title2, description: desc2}} =
               Boards.create_post(owner, %{title: "title2", description: "desc2"})

      assert [
               %Post{title: ^title1, description: ^desc1},
               %Post{title: ^title2, description: ^desc2}
             ] = Boards.post_list()
    end

    test "update_post" do
      owner = user_fixture()

      assert {:ok, %Post{title: title, id: id}} = Boards.create_post(owner, @valid_params)

      tasks = [
        Task.async(fn -> Boards.update_post(id, %{title: "new title first"}) end),
        Task.async(fn -> Boards.update_post(id, %{title: "new title second"}) end),
        Task.async(fn -> Boards.update_post(id, %{title: "new title third"}) end),
        Task.async(fn -> Boards.update_post(id, %{title: "new title 4th"}) end),
        Task.async(fn -> Boards.update_post(id, %{title: "new title 5th"}) end)
      ]

      Task.await_many(tasks)

      assert %Post{title: title} != Boards.get_post(id)
    end

    test "delete user" do
      owner = user_fixture()

      assert {:ok, %Post{} = post} = Boards.create_post(owner, @valid_params)

      assert {:ok, _post} = Boards.delete_post(post)
    end
  end

  describe "Comment CRUD test" do
    @valid_params %{
      description: "desc"
    }

    test "write comment" do
      owner = user_fixture()
      post = post_fixtrue(owner)

      assert {:ok, %Comment{} = comment} = Boards.write_comment(owner, post.id, @valid_params)

      assert comment.description == "desc"
    end

    test "get comment" do
      owner = user_fixture()
      post = post_fixtrue(owner)

      assert {:ok, %Comment{id: id, description: desc}} =
               Boards.write_comment(owner, post.id, @valid_params)

      assert %Comment{description: ^desc} = Repo.get(Comment, id)
    end

    test "list_post_comments" do
      owner1 = user_fixture()
      post = post_fixtrue(owner1)
      owner2 = user_fixture()

      assert {:ok, %Comment{id: id1, description: desc1}} =
               Boards.write_comment(owner1, post.id, %{
                 description: "1번 오너"
               })

      assert {:ok, %Comment{id: id2, description: desc2}} =
               Boards.write_comment(owner1, post.id, %{
                 description: "1번 오너"
               })

      assert {:ok, %Comment{id: id3, description: desc3}} =
               Boards.write_comment(owner2, post.id, %{
                 description: "2번 오너"
               })

      assert [
               %Comment{id: ^id1, description: ^desc1},
               %Comment{id: ^id2, description: ^desc2},
               %Comment{id: ^id3, description: ^desc3}
             ] = Boards.list_post_comments(post.id)
    end

    test "update_post_comment" do
      owner = user_fixture()
      %Post{id: post_id} = post_fixtrue(owner)

      assert {:ok, %Comment{id: id, description: desc}} =
               Boards.write_comment(owner, post_id, @valid_params)

      tasks = [
        Task.async(fn ->
          Boards.update_post_comment(owner, post_id, id, %{description: "new desc first"})
        end),
        Task.async(fn ->
          Boards.update_post_comment(owner, post_id, id, %{description: "new desc second"})
        end),
        Task.async(fn ->
          Boards.update_post_comment(owner, post_id, id, %{description: "new desc third"})
        end),
        Task.async(fn ->
          Boards.update_post_comment(owner, post_id, id, %{description: "new desc 4th"})
        end),
        Task.async(fn ->
          Boards.update_post_comment(owner, post_id, id, %{description: "new desc 5th"})
        end)
      ]

      Task.await_many(tasks)

      assert %Comment{description: desc} != Repo.get(Comment, id)
    end

    test "delete_comment" do
      owner = user_fixture()
      post = post_fixtrue(owner)

      assert {:ok, %Comment{id: id} = comment} =
               Boards.write_comment(owner, post.id, @valid_params)

      assert {:ok, _comment} = Boards.delete_comment(comment)
      assert nil == Repo.get(Comment, id)
    end

    test "get_post_comment" do
      owner1 = user_fixture()
      post = post_fixtrue(owner1)
      owner2 = user_fixture()

      assert {:ok, %Comment{id: id1}} =
               Boards.write_comment(owner1, post.id, %{
                 description: "1번 오너"
               })

      assert {:ok, %Comment{}} =
               Boards.write_comment(owner2, post.id, %{
                 description: "2번 오너"
               })

      assert %Comment{id: ^id1} = Boards.get_post_comment(post.id, id1)
    end

    test "comment_list" do
    end
  end
end
