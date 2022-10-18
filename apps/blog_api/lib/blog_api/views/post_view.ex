defmodule BlogApi.PostView do
  use BlogApi, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, __MODULE__, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, BlogApi.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{
      title: post.title,
      description: post.description
    }
  end
end
