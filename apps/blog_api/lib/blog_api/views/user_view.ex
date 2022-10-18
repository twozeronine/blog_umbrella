defmodule BlogApi.UserView do
  use BlogApi, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, __MODULE__, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, BlogApi.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{
      user_name: user.user_name,
      user_email: user.user_email
    }
  end
end
