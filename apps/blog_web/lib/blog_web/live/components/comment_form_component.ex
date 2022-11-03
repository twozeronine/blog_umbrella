defmodule BlogWeb.CommentFormComponent do
  use BlogWeb, :live_component

  alias BlogDomain.Accounts.User
  alias BlogDomain.Boards

  @impl true
  def mount(socket) do
    {:ok, assign(socket, %{comment_changeset: Boards.change_comment()})}
  end

  @impl true
  def handle_event("validate_check", %{"comment" => comment_params}, socket) do
    {:noreply, assign(socket, %{comment_changeset: Boards.change_comment(comment_params)})}
  end

  def handle_event("write", %{"comment" => comment_params}, socket) do
    {:ok, _comment} =
      Boards.write_comment(
        %User{id: socket.assigns.user_id},
        socket.assigns.post_id,
        comment_params
      )

    {:noreply, socket}
  end
end
