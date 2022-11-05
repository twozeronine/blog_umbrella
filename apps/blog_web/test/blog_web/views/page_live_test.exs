defmodule BlogWeb.PageLiveTest do
  use BlogWeb.ConnCase, async: true

  import Phoenix.LiveViewTest

  test "renders", %{conn: conn} do
    {:ok, view, html} = live(conn, "/")

    assert html =~ "Welcome to Blog!"
    assert render(view) =~ "Welcome to Blog!"
  end

  test "renders posts component", %{conn: _conn} do
    user = user_fixture()
    posts = Enum.map(1..5, fn _ -> post_fixture(user) end)

    assigns = [
      posts: posts,
      user_id: user.id
    ]

    html = render_component(BlogWeb.PostsComponent, assigns)

    assert html =~ "Listing Posts"
    assert html =~ "title"
  end
end
