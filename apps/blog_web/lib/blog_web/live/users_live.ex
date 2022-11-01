defmodule BlogWeb.UsersLive do
  use BlogWeb, :live_view

  alias BlogDomain.Boards
  alias BlogDomain.Accounts
  alias BlogDomain.Accounts.User

  def mount(_params, _session, socket) do
    changeset = Accounts.change_user()

    if connected?(socket) do
      user_id = socket.assigns[:user_id] || nil
      {:ok, assign(socket, %{user_id: user_id, changeset: changeset})}
    end

    {:ok, assign(socket, %{user_id: nil, changeset: changeset})}
  end

  def handle_params(%{"user_id" => user_id}, _url, socket) do
    case socket.assigns[:user_id] do
      nil ->
        {:noreply,
         socket
         |> redirect(to: "/")}

      _user_id ->
        {:noreply, assign(socket, %{posts: Boards.get_user_post(user_id)})}
    end
  end

  def handle_params(_, _, socket) do
    {:noreply, socket}
  end

  def handle_event("validate_check", %{"user" => user_params}, socket) do
    {:noreply, assign(socket, %{changeset: Accounts.change_user(user_params)})}
  end

  def handle_event("register", %{"user" => user_params}, socket) do
    case Accounts.create_user(user_params) do
      {:ok, %User{id: user_id}} ->
        {:noreply,
         socket
         |> put_flash(:info, "User Register Successful!")
         |> assign(%{user_id: user_id})
         |> push_patch(to: Routes.users_path(socket, :show, id: user_id))}

      {:error, _reason} ->
        {:noreply,
         socket
         |> put_flash(:danger, "User Login Falied!")
         |> assign(%{changeset: Accounts.change_user()})}
    end
  end

  def handle_event(
        "login",
        %{"user" => %{"user_email" => user_email, "password" => password}},
        socket
      ) do
    user_login(user_email, password, socket)
  end

  def handle_event(
        "show",
        %{"user" => %{"user_email" => user_email, "password" => password}},
        socket
      ) do
    user_login(user_email, password, socket)
  end

  defp user_login(user_email, password, socket) do
    case Accounts.authenticate_by_username_and_pass(user_email, password) do
      {:ok, %User{id: user_id}} ->
        {:noreply,
         socket
         |> put_flash(:info, "User Login Successful!")
         |> assign(%{user_id: user_id})
         |> push_patch(to: Routes.users_path(socket, :show, user_id))}

      {:error, _reason} ->
        {:noreply,
         socket
         |> put_flash(:danger, "User Login Falied!")
         |> assign(%{changeset: Accounts.change_user()})}
    end
  end
end
