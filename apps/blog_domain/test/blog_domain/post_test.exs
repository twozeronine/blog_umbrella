defmodule BlogDomain.PostTest do
  use BlogDomain.DataCase

  alias BlogDomain.Boards.Post

  @valid_params %{title: "title", description: "description"}
  @invalid_params %{}

  test "validate test" do
    assert valid?: true == Post.changeset(%Post{}, @valid_params)
  end

  test "invalidate test" do
    assert valid?: false == Post.changeset(%Post{}, @invalid_params)
  end

  test "invalidate_required test" do
    assert %Ecto.Changeset{errors: [title: _error_reason]} = Post.changeset(%Post{})
  end
end
