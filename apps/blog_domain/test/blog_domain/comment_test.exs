defmodule BlogDomain.CommentTest do
  use BlogDomain.DataCase

  alias BlogDomain.Boards.Comment

  @valid_params %{description: "description"}
  @invalid_params %{}

  test "validate test" do
    assert valid?: true == Comment.changeset(%Comment{}, @valid_params)
  end

  test "invalidate test" do
    assert valid?: false == Comment.changeset(%Comment{}, @invalid_params)
  end

  test "invalidate_required test" do
    assert %Ecto.Changeset{errors: [description: _error_reason]} = Comment.changeset(%Comment{})
  end
end
