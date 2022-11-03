defmodule BlogWeb.PostFormComponent do
  use BlogWeb, :live_component

  alias BlogDomain.Boards
  alias BlogDomain.Accounts.User

  @impl true
  def mount(socket) do
    {:ok, assign(socket, %{post_changeset: Boards.change_post()})}
  end

  @impl true
  def handle_event("validate_check", %{"post" => post_params}, socket) do
    {:noreply, assign(socket, %{post_changeset: Boards.change_post(post_params)})}
  end

  def handle_event("write", %{"post" => post_params}, socket) do
    {:ok, _post} = Boards.create_post(%User{id: socket.assigns.user_id}, post_params)
    {:noreply, socket}
  end
end
