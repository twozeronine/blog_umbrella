defmodule BlogWeb.PostEditComponent do
  use BlogWeb, :live_component

  alias BlogDomain.Boards

  @impl true
  def mount(socket) do
    {:ok, assign(socket, %{post_changeset: Boards.change_post()})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.form let={f} for={@post_changeset}
              phx-change="validate_check"
              phx-submit="edit"
              phx-target={@myself}>

        <%= label f, :title %>
        <%= text_input f, :title %>
        <%= error_tag f, :title %>

        <%= label f, :description %>
        <%= text_input f, :description %>
        <%= error_tag f, :description %>

        <%= submit "Edit" %>
      </.form>
    </div>
    """
  end

  @impl true
  def handle_event("validate_check", %{"post" => post_params}, socket) do
    {:noreply, assign(socket, %{post_changeset: Boards.change_post(post_params)})}
  end

  def handle_event("edit", %{"post" => post_params}, socket) do
    case Boards.update_post(socket.assigns.post_id, post_params) do
      {:ok, {:ok, _post}} ->
        {:noreply, socket}

      {:ok, {:error, _changeset}} ->
        {:noreply, assign(socket, %{post_changeset: Boards.change_post()})}
    end
  end
end
