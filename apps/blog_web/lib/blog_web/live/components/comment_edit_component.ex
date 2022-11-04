defmodule BlogWeb.CommentEditComponent do
  use BlogWeb, :live_component

  alias BlogDomain.Boards
  alias BlogDomain.Accounts

  @impl true
  def mount(socket) do
    {:ok, assign(socket, %{comment_changeset: Boards.change_comment()})}
  end

  @impl true
  def handle_event("validate_check", %{"comment" => comment_params}, socket) do
    {:noreply, assign(socket, %{comment_changeset: Boards.change_comment(comment_params)})}
  end

  def handle_event("edit", %{"comment" => comment_params}, socket) do
    user = Accounts.get_user(socket.assigns.user_id)

    case Boards.update_post_comment(
           user,
           socket.assigns.post_id,
           socket.assigns.comment_id,
           comment_params
         ) do
      {:ok, {:ok, _comment}} ->
        {:noreply, socket}

      {:ok, {:error, _changeset}} ->
        {:noreply, assign(socket, %{comment_changeset: Boards.change_comment()})}
    end
  end
end
