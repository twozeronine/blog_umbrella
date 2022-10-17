defmodule BlogDomain.BoardsTest do
  use BlogDomain.DataCase

  alias BlogDomain.Boards
  alias BlogDomain.Boards.Post

  describe "CRUD test" do
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

    test "get_post!" do
      assert {:ok, %Post{title: title, description: desc, id: id}} =
               Boards.create_post(user_fixture(), @valid_params)

      assert %Post{title: ^title, description: ^desc} = Boards.get_post(id)
    end

    test "get_user_post" do
      owner = user_fixture()

      assert {:ok, %Post{title: title, description: desc, id: id}} =
               Boards.create_post(owner, @valid_params)

      assert %Post{title: ^title, description: ^desc} = Boards.get_user_post(owner, id)
    end

    test "list_user_posts" do
      owner = user_fixture()

      assert {:ok, %Post{title: title1, description: desc1}} =
               Boards.create_post(owner, %{title: "title1", description: "desc1"})

      assert {:ok, %Post{title: title2, description: desc2}} =
               Boards.create_post(owner, %{title: "title2", description: "desc2"})

      assert [
               %Post{title: ^title1, description: ^desc1},
               %Post{title: ^title2, description: ^desc2}
             ] = Boards.list_user_posts(owner)
    end

    test "update_user_post" do
      owner = user_fixture()

      assert {:ok, %Post{title: title, id: id}} = Boards.create_post(owner, @valid_params)

      tasks = [
        Task.async(fn -> Boards.update_user_post(owner, id, %{title: "new title first"}) end),
        Task.async(fn -> Boards.update_user_post(owner, id, %{title: "new title second"}) end),
        Task.async(fn -> Boards.update_user_post(owner, id, %{title: "new title third"}) end),
        Task.async(fn -> Boards.update_user_post(owner, id, %{title: "new title 4th"}) end),
        Task.async(fn -> Boards.update_user_post(owner, id, %{title: "new title 5th"}) end)
      ]

      Task.await_many(tasks)

      assert %Post{title: title} != Boards.get_post(id)
    end

    test "delete user" do
      owner = user_fixture()

      assert {:ok, %Post{} = post} = Boards.create_post(owner, @valid_params)

      assert {:ok, _post} = Boards.delete_post(post)
      assert Boards.list_user_posts(owner) == []
    end
  end
end
