defmodule BlogWeb.PostWriteComponent do
  use BlogWeb, :live_component

  alias BlogDomain.Boards
  alias BlogDomain.Accounts.User

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
             phx-submit="write"
             phx-target={@myself} >

             <%= label f, :title %>
             <%= text_input f, :title %>
             <%= error_tag f, :title %>

             <%= label f, :description %>
             <%= text_input f, :description %>
             <%= error_tag f, :description %>

          <%= submit "Write" %>
      </.form>
    </div>
    """
  end

  @impl true
  def handle_event("validate_check", %{"post" => post_params}, socket) do
    {:noreply, assign(socket, %{post_changeset: Boards.change_post(post_params)})}
  end

  def handle_event("write", %{"post" => post_params}, socket) do
    case Boards.create_post(%User{id: socket.assigns.user_id}, post_params) do
      {:ok, _post} -> {:noreply, socket}
      {:error, _changeset} -> {:noreply, assign(socket, %{post_changeset: Boards.change_post()})}
    end
  end
end
