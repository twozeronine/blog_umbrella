defmodule BlogWeb.PostEditComponent do
  use BlogWeb, :live_component

  alias BlogDomain.Boards

  @impl true
  def mount(socket) do
    {:ok, assign(socket, %{post_changeset: Boards.change_post()})}
  end

  @impl true
  def handle_event("validate_check", %{"post" => post_params}, socket) do
    {:noreply, assign(socket, %{post_changet: Boards.change_post(post_params)})}
  end

  def handle_event("edit", %{"post" => post_params}, socket) do
    {:ok, _post} = Boards.update_post(socket.assigns.post_id, post_params)
    {:noreply, socket}
  end
end
