defmodule BlogWeb.PostsLive do
  use BlogWeb, :live_view

  alias BlogDomain.Boards

  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(posts: Boards.post_list())

    {:ok, socket}
  end

  def handle_params(%{"id" => id}, _url, socket) do
    socket =
      socket
      |> assign(%{selected_post: Boards.get_post(id), comments: Boards.list_post_comments(id)})

    {:noreply, socket}
  end

  def handle_params(_params, _url, socket) do
    {:noreply, assign(socket, %{seleted_post: nil, comments: nil})}
  end
end
