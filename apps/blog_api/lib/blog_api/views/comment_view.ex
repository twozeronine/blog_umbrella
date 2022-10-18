defmodule BlogApi.CommentView do
  use BlogApi, :view

  def render("index.json", %{comments: comments}) do
    %{data: render_many(comments, __MODULE__, "comment.json")}
  end

  def render("show.json", %{comment: comment}) do
    %{data: render_one(comment, BlogApi.CommentView, "comment.json")}
  end

  def render("comment.json", %{comment: comment}) do
    %{
      description: comment.description
    }
  end
end
